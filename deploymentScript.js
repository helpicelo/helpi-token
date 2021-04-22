const Web3 = require('web3')
const ContractKit = require('@celo/contractkit')
const web3 = new Web3('https://forno.celo.org')
const kit = ContractKit.newKitFromWeb3(web3)
// const getAccount = require('./getAccount').getAccount
const CeloHelpi = require('./build/contracts/CeloHelpi.json')

async function awaitWrapper() {
    // let accounts = await getAccount()
    // console.log(accounts)
    // web3.eth.getChainId().then(console.log)
    // // Get timestamp
    // let lastBlock = await web3.eth.getBlockNumber()
    // let {timestamp} = await web3.eth.getBlock(lastBlock)
    // var timestampObj = new Date(timestamp * 1000)
    // var unlockTime = timestampObj.setMinutes(timestampObj.getMinutes() + 10) / 1000
    // console.log(unlockTime)
    // const allowance = kit.web3.utils.toWei('100000', 'ether')
    // // var t = new Date();
    // // t.setSeconds(t.getSeconds() + 10);
    // // let account = await getAccount()
    // // console.log(account)
    // const contractAddress = "0x681f97aF12C7a8209444C41A4c24DE0585Fb9206"
    // const privateKey = ""
    const privateKey = "0x2e15b781c1d41f8e0b1608d4f21a0c8f181f8aa528a66361372d615a1ce9901d"
    const contractAddress = "0xcEb11054e2E96680B9ea0a6Dde99cA220B42ea1C"
    const accountObj = web3.eth.accounts.privateKeyToAccount(privateKey)
    let connectAccount = kit.addAccount(privateKey)
    let gasEstimate = kit.gasEstimate
    let instance = new web3.eth.Contract(CeloHelpi.abi, contractAddress)
    let transferAmoount = web3.utils.toWei('100', 'ether')
    let txo = await instance.methods.transfer("0x8cDB17Ded70701227E36cFeB7ab32aF7EDEf4d85", transferAmoount)
    let tx = await kit.sendTransactionObject(txo, {from: accountObj.address, gasPrice: gasEstimate})
    
    const hash = await tx.getHash()
    const receipt = await tx.waitReceipt()

    console.log(hash)
    console.log(receipt)

    // kit.connection.defaultAccount = accountObject.address
    // const accountObject = web3.eth.accounts.sec
    // console.log(accountObject.address)
    // 

    // const goldtoken = await kit.contracts.getGoldToken()

    // const oneGold = kit.web3.utils.toWei('1', 'ether')
    // console.log(kit.defaultAccount)
    
    // const tx = kit.sendTransaction({
    //     from: myAddress,
    //     to: someAddress,
    //     value: oneGold,
    // })

    // const approveTx = await goldtoken.approve("0x681f97aF12C7a8209444C41A4c24DE0585Fb9206", allowance)

    // let txapprove = await kit.sendTransactionObject(approveTx, {from: accountObject.address, gasPrice: gasEstimate})
    
    // const approveReceipt = await approveTx.waitReceipt()

    // let instance = new web3.eth.Contract(HelpiLocker.abi, contractAddress)

    // miau = await instance.methods.lockedToken(4).call()
    // console.log(miau)

    // let txo = await instance.methods.lockTokens(goldtoken.address, accountObject.address, oneGold, unlockTime)

    // let tx = await kit.sendTransactionObject(txo, {from: accountObject.address, gasPrice: gasEstimate})

    // const hash = await tx.getHash()
    // const receipt = await tx.waitReceipt()

    // console.log(hash)
    // console.log(receipt)

    // let txo = await instance.methods.withdrawTokens(2)

    // let tx = await kit.sendTransactionObject(txo, {from: accountObject.address, gasPrice: gasEstimate})

    // const hash = await tx.getHash()
    // const receipt = await tx.waitReceipt()

    // console.log(hash)
    // console.log(receipt)

    // console.log(web3.utils.fromWei(totalBalance.CELO.toString()))
    // console.log(web3.utils.fromWei(totalBalance.cUSD.toString()))

    // console.log(totalEvents)
}

awaitWrapper()