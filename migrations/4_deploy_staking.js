const HelpiStaking = artifacts.require("HelpiStaking")

module.exports = async function(deployer, network, accounts) {
    // Deploy Helpi
    // console.log(accounts)

    // throw new Error('Required'); // generates an error object with the message of Required
    await deployer.deploy(HelpiStaking) /// marking account
        // const helpi = await CeloHelpi.deployed()
}