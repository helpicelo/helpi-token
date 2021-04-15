const HelpiLocker = artifacts.require("HelpiLocker")

module.exports = async function(deployer, network, accounts) {
    // Deploy Helpi
    // console.log(accounts)

    // throw new Error('Required'); // generates an error object with the message of Required
    await deployer.deploy(HelpiLocker, accounts[3]) /// marking account
        // const helpi = await CeloHelpi.deployed()
}