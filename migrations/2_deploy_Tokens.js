const CeloHelpi = artifacts.require("CeloHelpi")

module.exports = async function(deployer, network, accounts) {
    // Deploy MyToken
    await deployer.deploy(CeloHelpi)
    const myToken = await CeloHelpi.deployed()

    // // Deploy Farm Token
    // await deployer.deploy(FarmToken, myToken.address)
    // const farmToken = await FarmToken.deployed()
}