pragma solidity ^0.5.12; 

import "./IERC721.sol"; 

contract MacKittyContract is IERC721 {

// STEP 2: (00:56): https://academy.moralis.io/lessons/erc721-help
// STATE VARIABLES  and STRUCT VARIABLES needed for assignment.
    string public constant name = "FilipKitties"; 
    string public constant symbol = "FK"; 

/* Same fields real Crypto Kitties has in their struct */
    struct Kitty {          
        uint256 genes; 
        uint64 birthTime; 
        uint32 mumId; 
        uint32 dadId; 
        uint16 generation;
    }

/* Array store the instance of this struct. Actual Object. They will be the actual Tokens */ 
    Kitty[] kitties;  

    mapping (uint256 => address) public kittyIndexToOwner; 
                        // STEP 1: (8:14) https://academy.moralis.io/lessons/erc721-intro-assignment  - One Getter Function
                        mapping (address => uint256) ownershipTokenCount; 

                        function balanceOf(address owner) external view returns (uint256 balance) {
                            // return balance[owner]; - we're not going to call it balance
                            return ownershipTokenCount[owner]; 
                        }


} // end of MacKittyContract
