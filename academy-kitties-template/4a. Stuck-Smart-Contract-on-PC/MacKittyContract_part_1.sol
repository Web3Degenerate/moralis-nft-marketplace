pragma solidity ^0.5.12; 

import "./IERC721.sol"; 

contract MacKittyContract is IERC721 {

    // STEP 1: (8:14) https://academy.moralis.io/lessons/erc721-intro-assignment
    // One Getter Function
    mapping(address => uint256) ownershipTokenCount; 

    function balanceOf(address owner) external view returns (uint256 balance) {
        // return balance[owner]; - we're not going to call it balance
        return ownershipTokenCount[owner]; 
    }






} // end of MacKittyContract
