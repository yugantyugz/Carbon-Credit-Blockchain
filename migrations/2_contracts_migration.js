const erc20Token = artifacts.require("./erc20Token.sol");
const CarbonCredit = artifacts.require("./CarbonCredit.sol");

module.exports = function(deployer) {
    deployer.deploy(erc20Token, 10000, "TotalSem Token", 18, "TotalSem");
    deployer.deploy(CarbonCredit);
};