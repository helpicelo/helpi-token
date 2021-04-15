const CeloHelpi = artifacts.require("CeloHelpi")

module.exports = async function(deployer, network, accounts) {
    // Deploy Helpi
    // console.log(accounts)

    // throw new Error('Required'); // generates an error object with the message of Required
    await deployer.deploy(CeloHelpi, ...accounts.slice(1))
        // const helpi = await CeloHelpi.deployed()
}