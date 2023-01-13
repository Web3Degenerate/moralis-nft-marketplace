pragma solidity ^0.5.12;

// From: https://studygroup.moralis.io/t/assignment-get-kitty/35343/15
contract Ownable {

    address contractOwner;

    constructor() public {
        contractOwner = msg.sender;
    }

    modifier onlyOwner{
        require(contractOwner == msg.sender, "Custom You Not Owner Message Here.");
        _;
    }

}

