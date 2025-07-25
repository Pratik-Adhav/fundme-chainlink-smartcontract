//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
contract FundMe{
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18; // 5 dollars converted into wei format

    address [] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;
    constructor(){
        i_owner = msg.sender;
    }
    function fund() public payable{
        require(msg.value.getConversionRate() > MINIMUM_USD, "didn't send enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    function withdraw() public onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0);

        //transfer
        //transer automatically reverts the transaction if it fails.
        payable(msg.sender).transfer(address(this).balance);
        
        //send
        //send does not automatically reverts. We need to add manual check and require statement for reverting the transaction.
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");

        //call
        (bool callSuccess, )= payable(msg.sender).call{value: address(this).balance}("");
        require (callSuccess, "Call failed");
    }

    modifier onlyOwner(){
        // require(msg.sender == i_owner, "Sender is not owner!");
        if(msg.sender != i_owner)
        {
            revert NotOwner();
        }
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}