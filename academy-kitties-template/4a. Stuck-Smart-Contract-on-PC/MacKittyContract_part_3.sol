// SPDX-License-Identifier: MIT
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

// STEP 3 Token Code & Migration Walkthrough: https://academy.moralis.io/lessons/token-code-migration-walkthrough
    /*Explained: https://academy.moralis.io/lessons/token-code-migration-walkthrough */

    /* function totalSupply() external view returns (uint256 total){ */
    function totalSupply() public view returns (uint){    
         return kitties.length; 
    }

    /* function ownerOf(uint256 tokenId) external view returns (address owner){ */
    function ownerOf(uint256 _tokenId) external view returns (address) {      /* less gas call external fn. not from within this k. */
         return kittyIndexToOwner[_tokenId]; 
    } 

/* Break transfer fn into two. (1) external, (2) _transfer internal */
   /* function transfer(address to, uint256 tokenId) external{ */

//******* EXTERNAL TRANSFER FUNCTION AVAILABLE FOR OUTSIDE CALLS ********************************** */
    function transfer(address _to,uint256 _tokenId) external {
        require(_to != address(0));     
        require(_to != address(this)); 
        require(_owns(msg.sender, _tokenId));  /* see custom _owns function below true/false */

        _transfer(msg.sender, _to, _tokenId); 
    }
//************************************************************************************************** */


//******* INTERNAL TRANSFER FUNCTION IS CALLED by EXTERNAL function above. [MEAT OF TRANSFER] ********************************** */
    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        ownershipTokenCount[_to]++; // increase token ownership of recepient

        kittyIndexToOwner[_tokenId] = _to; // set ownership to new  owner addy

        if (_from != address(0)) {        //As long as from addy NOT the ZERO addy, then we decrease ownership count of sender  
            ownershipTokenCount[_from]--;
        }

        // Emit the transfer event.
        emit Transfer(_from, _to, _tokenId); 
    }
//************************************************************************************************** */



//******* INTERNAL OWNS FUNCTION IS CALLED by EXTERNAL transfer function above ********************************** */
    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return kittyIndexToOwner[_tokenId] == _claimant; 
    }
//************************************************************************************************** */



} // end of MacKittyContract
