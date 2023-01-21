// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.16 <0.9.0;  // pragma solidity ^0.5.12; //Hashlips prefers ^0.8.0 (this version & up) https://youtu.be/sngKPYfUgkc?t=1350
    // Error: Truffle is currently using solc 0.5.16, but one or more of your contracts specify "pragma solidity >=0.7.0 <0.9.0".
    //Please update your truffle config or pragma statement(s).
    //(See https://trufflesuite.com/docs/truffle/reference/configuration#compiler-configuration for information on
    //configuring Truffle to use a specific solc compiler version.)

import "./IERC721.sol";
// import ownable contract
import "./Ownable.sol";     /* (2:05): https://academy.moralis.io/lessons/solution-new-get-kitty-assignment */


contract Kittycontract is IERC721, Ownable {

    uint256 public constant CREATION_LIMIT_GEN0 = 10; 
    string public constant name = "DegenKitties";
    string public constant symbol = "DK";

     /*Added event (7:10): https://academy.moralis.io/lessons/create-kitty-function */
     event Birth(address owner, uint256 kittenId, uint256 mumId, uint256 dadId, uint256 genes);

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
    mapping (uint256 => address) public kittyIndexToApproved; // (1:35): https://academy.moralis.io/lessons/erc721-fulfillment-approval
    //(4:15): https://academy.moralis.io/lessons/erc721-fulfillment-approval
    //My Address => Operator Address => TRUE/FALSE
    //check with _operatorApprovals[MYADDR][OPERATORADDR] = true/false; 
    mapping (address => mapping (address => bool)) private _operatorApprovals; 

 /*createKittyGen0 function: https://academy.moralis.io/lessons/solution-new-get-kitty-assignment */
    /* uint256 public constant CREATION_LIMIT_GEN0 = 10; */
    uint256 public gen0Counter;


/*GetKitty Solution added getKitty: https://academy.moralis.io/lessons/getkitty-solution  */
    function getKitty(uint256 _id) external view returns (
        uint256 genes,
        uint256 birthTime,
        uint256 mumId,
        uint256 dadId,
        uint256 generation
        // address owner  // owner NOT in the Kitty Struct defined above.
    )
     {
         Kitty storage kitty = kitties[_id]; // saved as a pointer. Use storage instead memory (less space) (1:36): https://academy.moralis.io/lessons/getkitty-solution

         birthTime = uint256(kitty.birthTime);
         mumId = uint256(kitty.mumId);
         dadId = uint256(kitty.dadId); 
         generation = uint256(kitty.generation);
         genes = kitty.genes;  

        //  return (genes, birthTime, mumId, dadId, generation); //Alternate solution (00:58): https://academy.moralis.io/lessons/getkitty-solution
     }

    function createKittyGen0(uint256 _genes) public onlyOwner returns (uint256) {
           //receives genes from front end. 
           require(gen0Counter < CREATION_LIMIT_GEN0); /*Created constant above, set to 10 max gen0's */

            gen0Counter++; 

            //Gen0 have no owners, they are owned by contract
            return _createKitty(0, 0, 0, _genes, msg.sender);  //address(this) the contract?
    }

            /*Added: https://academy.moralis.io/lessons/create-kitty-function 
             _createKitty internal fn. Used to create kitty 0 as well as subsequent breeds. Returns Kat ID  */  
    function _createKitty(
        uint256 _mumId, 
        uint256 _dadId,
        uint256 _generation,
        uint256 _genes,
        address _owner
    ) private returns (uint256) {   /*Internal, can be private since no inheritence */
        /*Added Kitty from struct (3:13): https://academy.moralis.io/lessons/create-kitty-function */
        Kitty memory _kitty = Kitty({   
            genes: _genes,
            // birthTime: uint64(now),  // Per Mac VS Code Error Message
            birthTime: uint64(block.timestamp),
            mumId: uint32(_mumId),
            dadId: uint32(_dadId),
            generation: uint16(_generation)
        });

        // uint256 newKittenId = kitties.push(_kitty) -1; //Per: https://ethereum.stackexchange.com/questions/89792/typeerror-different-number-of-components-either-side-of-equation
        kitties.push(_kitty);
        uint256 newKittenId = kitties.length - 1;


        emit Birth(_owner, newKittenId, _mumId, _dadId, _genes); /*Added event (8:22): https://academy.moralis.io/lessons/create-kitty-function */

        /*Added internal _transfer (5:53): https://academy.moralis.io/lessons/create-kitty-function */
        _transfer(address(0), _owner, newKittenId);

        return newKittenId; 

    }


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