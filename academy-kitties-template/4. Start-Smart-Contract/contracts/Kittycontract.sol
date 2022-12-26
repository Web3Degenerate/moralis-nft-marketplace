pragma solidity ^0.5.12;

import "./IERC721.sol";




contract Kittycontract is IERC721 {


    string public constant name = "DegenKitties";
    string public constant symbol = "DK";

    struct Kitty {          /* Same fields real Crypto Kitties has in their struct */
        uint256 genes; 
        uint64 birthTime; 
        uint32 mumId; 
        uint32 dadId; 
        uint16 generation;
    }

    Kitty[] kitties; /* Array store the instance of this struct. Actual Object. They will be the actual Tokens */

    
    mapping (uint256 => address) public kittyIndexToOwner; /* Takes kitty ID; returns owner of that NFT Kat */ 
    mapping (address => uint256) ownershipTokenCount; /* Kitties Owned By Address: balanceOf function needs balance mapping to return balance of owner */


    function balanceOf(address owner) external view returns (uint256 balance){
         /* return balance[owner]; */
         return ownershipTokenCount[owner];
    }


/*Explained: https://academy.moralis.io/lessons/token-code-migration-walkthrough */

    /* function totalSupply() external view returns (uint256 total){ */
    function totalSupply() public view returns (uint){    
         return kitties.length; 
    }

    /* function ownerOf(uint256 tokenId) external view returns (address owner){ */
    function ownerOf(uint256 _tokenId) external view returns (address){      /* less gas call external fn. not from within this k. */
         return kittyIndexToOwner[_tokenId]; 
    } 

/* Break transfer fn into two. (1) external, (2) _transfer internal */
   /* function transfer(address to, uint256 tokenId) external{ */
    function transfer(address _to,uint256 _tokenId) external{
        require(_to != address(0));     
        require(_to != address(this)); 
        require(_owns(msg.sender, _tokenId));  /* see custom _owns function below true/false */

        _transfer(msg.sender, _to, _tokenId); 
    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        ownershipTokenCount[_to]++; 

        kittyIndexToOwner[_tokenId] = _to;

        if(_from != address(0)){
            ownershipTokenCount[_from]--;
        }

        // Emit the transfer event.
        emit Transfer(_from, _to, _tokenId);
    }


    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return kittyIndexToOwner[_tokenId] == _claimant; 
    }


} /*end of Kittycontract */