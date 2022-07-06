const ERC20 = artifacts.require("ERC20")

module.exports = function (deployer, accounts) {
  const tokenName = 'Montana'
  const tokenSymbol = 'MON'
  const tokenDecimals = 1

  // deployment steps
  deployer.deploy(
    ERC20, 
    1000, 
    tokenName, 
    tokenDecimals, 
    tokenSymbol,
    { gasPrice: 3000000000 }
  )
}
