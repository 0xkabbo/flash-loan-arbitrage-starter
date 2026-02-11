// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

/**
 * @title SimpleFlashLoan
 * @dev Professional template for Aave V3 Flash Loans.
 */
contract SimpleFlashLoan is FlashLoanSimpleReceiverBase {
    address payable public owner;

    constructor(address _addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)) {
        owner = payable(msg.sender);
    }

    /**
     * @dev Trigger the flash loan.
     */
    function requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    /**
     * @dev Aave calls this function after sending the funds.
     */
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        // ARBITRAGE / LIQUIDATION LOGIC GOES HERE
        // Example: Swap asset on Uniswap for profit
        
        uint256 amountToReturn = amount + premium;
        require(IERC20(asset).balanceOf(address(this)) >= amountToReturn, "Inadequate funds to repay");
        
        IERC20(asset).approve(address(POOL), amountToReturn);
        
        return true;
    }

    receive() external payable {}
}
