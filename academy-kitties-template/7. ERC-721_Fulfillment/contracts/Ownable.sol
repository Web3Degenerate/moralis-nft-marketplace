// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.16 <0.9.0; // pragma solidity ^0.5.12;

// From: https://studygroup.moralis.io/t/assignment-get-kitty/35343/15
contract Ownable {

    address contractOwner;

    constructor() public {  //version 0.5.16 compile error: SyntaxError: No visibility specified. Did you intend to add "public"?
        contractOwner = msg.sender;
    }

    modifier onlyOwner{
        require(contractOwner == msg.sender, "Custom You Not Owner Message Here.");
        _;
    }

}

