# Mainnet Addresses
```
MainAddress: 0xd2428348876B1F3D743751f79BD7453ccB8fB3aF
```

# Production Migration Output
```
Starting migrations...
======================
> Network name:    'mainnet'
> Network id:      42220
> Block gas limit: 0 (0x0)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x64d71cf1c9ff7e8b44c17afd26dce7493ac35dc69f5c9d0e777ba7db64459c67
   > Blocks: 0            Seconds: 0
   > contract address:    0xa4dadDf25d1Af0069b97E3BB2Cd265308E7A0cE5
   > block number:        6201031
   > block timestamp:     1618581508
   > account:             0xd2428348876B1F3D743751f79BD7453ccB8fB3aF
   > balance:             1.99507392
   > gas used:            246304 (0x3c220)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00492608 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00492608 ETH


2_deploy_Tokens.js
==================

   Deploying 'CeloHelpi'
   ---------------------
   > transaction hash:    0x24f6300f9e99fca70555dda3b6cbf80f1b38841d1544f5ed3c86be7821a14019
   > Blocks: 1            Seconds: 4
   > contract address:    0xcEb11054e2E96680B9ea0a6Dde99cA220B42ea1C
   > block number:        6201033
   > block timestamp:     1618581518
   > account:             0xd2428348876B1F3D743751f79BD7453ccB8fB3aF
   > balance:             1.90862188
   > gas used:            4280689 (0x415171)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.08561378 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.08561378 ETH


3_deploy_locker.js
==================

   Deploying 'HelpiLocker'
   -----------------------
   > transaction hash:    0x97ac49a979a760de7b727a1dab3ae698ac2b6427a978c640bc47fbfc6a9910d6
   > Blocks: 0            Seconds: 4
   > contract address:    0x8d79BFff5Dc6536f2778D0dfa8CEFaE954FEddC9
   > block number:        6201035
   > block timestamp:     1618581528
   > account:             0xd2428348876B1F3D743751f79BD7453ccB8fB3aF
   > balance:             1.85243392
   > gas used:            2782485 (0x2a7515)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0556497 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.0556497 ETH


4_deploy_staking.js
===================

   Deploying 'HelpiStaking'
   ------------------------
   > transaction hash:    0xeaec00a5b865acf631add76b92c79a2835cb9b46ae9abb4fed6c496b14d1216a
   > Blocks: 1            Seconds: 4
   > contract address:    0x30fA847EB56901b2377af034Bf8953bA5cde3Fc4
   > block number:        6201037
   > block timestamp:     1618581538
   > account:             0xd2428348876B1F3D743751f79BD7453ccB8fB3aF
   > balance:             1.8030439
   > gas used:            2442588 (0x25455c)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.04885176 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.04885176 ETH


Summary
=======
> Total deployments:   4
> Final cost:          0.19504132 ETH
```

# Transactions OUT
```
{
  blockHash: '0xc69a062bb016913b607ccaa0d2dba51145f4ba094cec964f46f2bfad94fd24b9',
  blockNumber: 6201715,
  contractAddress: null,
  cumulativeGasUsed: 198650,
  from: '0xd2428348876b1f3d743751f79bd7453ccb8fb3af',
  gasUsed: 83618,
  logsBloom: '0x00000000000000000000000000000100000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000100000008000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000008004000000000000000000000000004000000000000000100000000000000000000000000',    
  status: true,
  to: '0xceb11054e2e96680b9ea0a6dde99ca220b42ea1c',
  transactionHash: '0x928d257e9b2c921a51182f7d6abc915171d7623559c514596d22d5eac10cfb15',
  transactionIndex: 3,
  events: {
    Transfer: {
      address: '0xcEb11054e2E96680B9ea0a6Dde99cA220B42ea1C',
      blockNumber: 6201715,
      transactionHash: '0x928d257e9b2c921a51182f7d6abc915171d7623559c514596d22d5eac10cfb15',
      transactionIndex: 3,
      blockHash: '0xc69a062bb016913b607ccaa0d2dba51145f4ba094cec964f46f2bfad94fd24b9',
      logIndex: 3,
      removed: false,
      id: 'log_4b4f8450',
      returnValues: [Result],
      event: 'Transfer',
      signature: '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
      raw: [Object]
    }
  }
}
```