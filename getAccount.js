const Web3 = require('web3')
const fs = require('fs')
const path = require('path')
var web3 = new Web3()


const objectMap = (obj, fn) =>
    Object.fromEntries(
        Object.entries(obj).map(
            ([k, v], i) => [k, fn(v, k, i)]
        )
    )

const filePath = path.join(__dirname, './secrets.json')

function getAccount() {
    return new Promise(resolve => {
        if (fs.existsSync(filePath)) {
            fs.readFile(filePath, { encoding: 'utf-8' }, (err, data) => {
                const keys = JSON.parse(data)

                const accounts = objectMap(keys, key => web3.eth.accounts.privateKeyToAccount(key))

                resolve(accounts)
            })
        } else {

            const accounts = {
                "main": web3.eth.accounts.create(),
                "liquidity": web3.eth.accounts.create(),
                "staking": web3.eth.accounts.create(),
                "marketing": web3.eth.accounts.create(),
                "factory": web3.eth.accounts.create(),
                "weth": web3.eth.accounts.create(),
            }

            const data = JSON.stringify(objectMap(accounts, v => v.privateKey))

            fs.writeFile(filePath, data, (err) => {
                if (err) {
                    return console.log(err);
                }
            })

            resolve(accounts)
        }
    })
}

module.exports = {
    getAccount
}