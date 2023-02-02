// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.16 <0.9.0; // pragma solidity ^0.5.12; 

interface IERC721Receiver { 

    // function onERC721Received(address operator, address from, uint tokenId, bytes calldata data) external returns (bytes);

    // (8:30) bytes4: https://academy.moralis.io/lessons/assignment-safetransfer-implementation

//filip: function onERC721Received(address operator, address from, uint tokenId, bytes calldata data) external return (bytes);
    function onERC721Received(address operator, address from, uint tokenId, bytes calldata data) external returns (bytes4);
    


}