// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HelpiStaking is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    struct UserInfo {
        uint256 amount;
        uint256 rewardDebt;
        uint256 pendingRewards;
        uint256 lastClaim;
    }

    struct PoolInfo {
        uint256 allocPoint;
        uint256 lastRewardBlock;
        uint256 accHelpiPerShare;
        uint256 depositedAmount;
        uint256 rewardsAmount;
        uint256 lockupDuration;
    }

    IERC20 public helpi;
    uint256 public helpiPerBlock = uint256(8 ether).div(10);

    PoolInfo[] public poolInfo;
    mapping(uint256 => mapping(address => UserInfo)) public userInfo;
    uint256 public totalAllocPoint = 10;

    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event Claim(address indexed user, uint256 indexed pid, uint256 amount);
    event ClaimAndStake(address indexed user, uint256 indexed pid, uint256 amount);

    function addPool(uint256 _allocPoint, uint256 _lockupDuration) internal {
        poolInfo.push(
            PoolInfo({
                allocPoint: _allocPoint,
                lastRewardBlock: 0,
                accHelpiPerShare: 0,
                depositedAmount: 0,
                rewardsAmount: 0,
                lockupDuration: _lockupDuration
            })
        );
    }
    
    function setHelpiToken(IERC20 _helpi) external onlyOwner {
        require(address(helpi) == address(0), 'Token already set!');
        helpi = _helpi;
        addPool(1, 0); //10% staking pool
        addPool(3, 7 days); //30% staking pool
        addPool(6, 14 days); //60% staking pool
    }
    
    function startStaking(uint256 startBlock) external onlyOwner {
        require(poolInfo[0].lastRewardBlock == 0 && poolInfo[1].lastRewardBlock == 0 && poolInfo[2].lastRewardBlock == 0, 'Staking already started');
        poolInfo[0].lastRewardBlock = startBlock;
        poolInfo[1].lastRewardBlock = startBlock;
        poolInfo[2].lastRewardBlock = startBlock;
        
    }

    function pendingRewards(uint256 pid, address _user) external view returns (uint256) {
        require(poolInfo[pid].lastRewardBlock > 0 && block.number >= poolInfo[pid].lastRewardBlock, 'Staking not yet started');
        PoolInfo storage pool = poolInfo[pid];
        UserInfo storage user = userInfo[pid][_user];
        uint256 accHelpiPerShare = pool.accHelpiPerShare;
        uint256 depositedAmount = pool.depositedAmount;
        if (block.number > pool.lastRewardBlock && depositedAmount != 0) {
            uint256 multiplier = block.number.sub(pool.lastRewardBlock);
            uint256 helpiReward = multiplier.mul(helpiPerBlock).mul(pool.allocPoint).div(totalAllocPoint);
            accHelpiPerShare = accHelpiPerShare.add(helpiReward.mul(1e12).div(depositedAmount));
        }
        return user.amount.mul(accHelpiPerShare).div(1e12).sub(user.rewardDebt).add(user.pendingRewards);
    }

    function updatePool(uint256 pid) internal {
        require(poolInfo[pid].lastRewardBlock > 0 && block.number >= poolInfo[pid].lastRewardBlock, 'Staking not yet started');
        PoolInfo storage pool = poolInfo[pid];
        if (block.number <= pool.lastRewardBlock) {
            return;
        }
        uint256 depositedAmount = pool.depositedAmount;
        if (pool.depositedAmount == 0) {
            pool.lastRewardBlock = block.number;
            return;
        }
        uint256 multiplier = block.number.sub(pool.lastRewardBlock);
        uint256 helpiReward = multiplier.mul(helpiPerBlock).mul(pool.allocPoint).div(totalAllocPoint);
        pool.rewardsAmount = pool.rewardsAmount.add(helpiReward);
        pool.accHelpiPerShare = pool.accHelpiPerShare.add(helpiReward.mul(1e12).div(depositedAmount));
        pool.lastRewardBlock = block.number;
    }

    function deposit(uint256 pid, uint256 amount) external {
        PoolInfo storage pool = poolInfo[pid];
        UserInfo storage user = userInfo[pid][msg.sender];
        updatePool(pid);
        if (user.amount > 0) {
            uint256 pending = user.amount.mul(pool.accHelpiPerShare).div(1e12).sub(user.rewardDebt);
            if (pending > 0) {
                user.pendingRewards = user.pendingRewards.add(pending);
            }
        }
        if (amount > 0) {
            helpi.safeTransferFrom(address(msg.sender), address(this), amount);
            user.amount = user.amount.add(amount);
            pool.depositedAmount = pool.depositedAmount.add(amount);
        }
        user.rewardDebt = user.amount.mul(pool.accHelpiPerShare).div(1e12);
        user.lastClaim = block.timestamp;
        emit Deposit(msg.sender, pid, amount);
    }

    function withdraw(uint256 pid, uint256 amount) external {
        PoolInfo storage pool = poolInfo[pid];
        UserInfo storage user = userInfo[pid][msg.sender];
        require(block.timestamp > user.lastClaim + pool.lockupDuration, "You cannot withdraw yet!");
        require(user.amount >= amount, "Withdrawing more than you have!");
        updatePool(pid);
        uint256 pending = user.amount.mul(pool.accHelpiPerShare).div(1e12).sub(user.rewardDebt);
        if (pending > 0) {
            user.pendingRewards = user.pendingRewards.add(pending);
        }
        if (amount > 0) {
            helpi.safeTransfer(address(msg.sender), amount);
            user.amount = user.amount.sub(amount);
            pool.depositedAmount = pool.depositedAmount.sub(amount);
        }
        user.rewardDebt = user.amount.mul(pool.accHelpiPerShare).div(1e12);
        user.lastClaim = block.timestamp;
        emit Withdraw(msg.sender, pid, amount);
    }

    function claim(uint256 pid) public {
        PoolInfo storage pool = poolInfo[pid];
        UserInfo storage user = userInfo[pid][msg.sender];
        updatePool(pid);
        uint256 pending = user.amount.mul(pool.accHelpiPerShare).div(1e12).sub(user.rewardDebt);
        if (pending > 0 || user.pendingRewards > 0) {
            user.pendingRewards = user.pendingRewards.add(pending);
            uint256 claimedAmount = safeHelpiTransfer(msg.sender, user.pendingRewards, pid);
            emit Claim(msg.sender, pid, claimedAmount);
            user.pendingRewards = user.pendingRewards.sub(claimedAmount);
            user.lastClaim = block.timestamp;
            pool.rewardsAmount = pool.rewardsAmount.sub(claimedAmount);
        }
        user.rewardDebt = user.amount.mul(pool.accHelpiPerShare).div(1e12);
    }
    
    function safeHelpiTransfer(address to, uint256 amount, uint256 pid) internal returns (uint256) {
        PoolInfo memory pool = poolInfo[pid];
        if (amount > pool.rewardsAmount) {
            helpi.transfer(to, pool.rewardsAmount);
            return pool.rewardsAmount;
        } else {
            helpi.transfer(to, amount);
            return amount;
        }
    }
    
    function setHelpiPerBlock(uint256 _helpiPerBlock) external onlyOwner {
        require(_helpiPerBlock > 0, "HELPI per block should be greater than 0!");
        helpiPerBlock = _helpiPerBlock;
    }
}
