// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.16 <0.9.0;  // pragma solidity ^0.5.12; //Hashlips prefers ^0.8.0 (this version & up) https://youtu.be/sngKPYfUgkc?t=1350
    // Error: Truffle is currently using solc 0.5.16, but one or more of your contracts specify "pragma solidity >=0.7.0 <0.9.0".
    //Please update your truffle config or pragma statement(s).
    //(See https://trufflesuite.com/docs/truffle/reference/configuration#compiler-configuration for information on
    //configuring Truffle to use a specific solc compiler version.)

import "./IERC721.sol"; 
// import ownable contract
import "./Ownable.sol";     /* (2:05): https://academy.moralis.io/lessons/solution-new-get-kitty-assignment */

import "./IERC721Receiver.sol"; //IERC721Receiver

contract Kittycontract is IERC721, Ownable {

    uint256 public constant CREATION_LIMIT_GEN0 = 10; 
    string public constant name = "DegenKitties";
    string public constant symbol = "DK";
    bytes4 internal constant MAGIC_ERC721_RECEIVED = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)")); // bytes4 constant (8:10) https://academy.moralis.io/lessons/assignment-safetransfer-implementation
// bytes4 internal constant = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)")); 

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


//Safe Transfer from: https://academy.moralis.io/lessons/assignment-erc721-fulfillment-transferfrom
// DOUBLE safeTransferFrom (public and internal) solution: https://academy.moralis.io/lessons/safetransferfrom-assignment-solution
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
        safeTransferFrom(_from, _to, _tokenId, ""); 
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public {
    // function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external {
        require( _isApprovedOrOwner(msg.sender, _from, _to, _tokenId) ); 
        _safeTransfer(_from, _to, _tokenId, _data); 
    }



//internal _safeTransfer in https://academy.moralis.io/lessons/assignment-safetransfer-implementation
                    // data is optional parameter we can send data to whoever we transfer to (1:05)
    function _safeTransfer(address _from, address _to, uint256 _tokenId, bytes memory _data) internal {
        _transfer(_from, _to, _tokenId);
        require( _checkERC721Support(_from, _to, _tokenId, _data) ); 

    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public { 
    // function transferFrom(address _from, address _to, uint256 _tokenId) external {

        require( _isApprovedOrOwner(msg.sender, _from, _to, _tokenId)); 
 //EXTRACTED our four require statements into one internal _isApprovedOrOwner at bottom of contract. 
 // (00:34): https://academy.moralis.io/lessons/safetransferfrom-assignment-solution     
        // require(_to != address(0)); //check to address is not addy zero.
            // check sender is owner    or sender has approval for tokenId   or msg.sender is an operator for from  (1:05)
        // require(msg.sender == _from || _approvedFor(msg.sender, _tokenId) || isApprovedForAll(_from, msg.sender)); 
        // require(_owns(_from, _tokenId)); 
        // require(_tokenId < kitties.length);

         _transfer(_from, _to, _tokenId);
    }



// Approval function solutions from: https://academy.moralis.io/lessons/erc721-fulfillment-approval-solution
    function approve(address _to, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId)); //sender owns token

        _approve(_tokenId, _to); //our own internal _approve function below
        // approve(_tokenId, _to);
        emit Approval(msg.sender, _to, _tokenId);  
    }

    function setApprovalForAll(address operator, bool approved) public {
        require(operator != msg.sender);

        _operatorApprovals[msg.sender][operator] = approved; //internal fn below
        emit ApprovalForAll(msg.sender, operator, approved); 
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        require(tokenId < kitties.length); //Token must exist

        return kittyIndexToApproved[tokenId]; 
    }

// _CHANGE isApprovedForAll from external to PUBLIC removed this error(?)
//VS error: Undeclared identifier. "isApprovedForAll" is not (or not yet) visible at this point. [63, 78]
// https://ethereum.stackexchange.com/questions/66138/declarationerror-undeclared-identifier-value-is-not-or-not-yet-visible-at
    // function isApprovedForAll(address _owner, address _operator) external view returns (bool) { //make external to public
    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return _operatorApprovals[_owner][_operator]; //his removed underscore
    }



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

//Internal function to handle the approval process (1:35): https://academy.moralis.io/lessons/erc721-fulfillment-approval-solution
    function _approve(uint256 _tokenId, address _approved) internal {
        kittyIndexToApproved[_tokenId] = _approved;
    }

// _approvedFor solution at (2:02): https://academy.moralis.io/lessons/erc721-fulfillment-transferfrom-assignment-solution
    function _approvedFor(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return kittyIndexToApproved[_tokenId] == _claimant;
    }


// At (16:27) we remove `address _from` parameter throwing error in the `truffle compile`: https://academy.moralis.io/lessons/assignment-safetransfer-implementation
    function _checkERC721Support(address _from, address _to, uint256 _tokenId, bytes memory _data) internal returns (bool){
        if(_isContract(_to)){
            //if NOT a smart contract (code size > 0), return true
            return true; //exits fn here (4:20) https://academy.moralis.io/lessons/assignment-safetransfer-implementation
        }

                        
                        //execute onERC721Received function
                        //How call external contract only know (1) addy and (2) one of its functions
                        // 6th min: https://academy.moralis.io/lessons/assignment-safetransfer-implementation
        // FORMAT: Contract(_to).onERC721Received()  //define the function header we need (onERC721Received())    
// MAKE THE Call onERC721Received                             
        // bytes4 returnData = IERC721Receiver(_to).onERC721Received(msg.sender, _to, _tokenId, _data); fixed (16:27): https://academy.moralis.io/lessons/assignment-safetransfer-implementation
        bytes4 returnData = IERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
// CHECK THE RETURN VALUE
        return returnData == MAGIC_ERC721_RECEIVED; // (10:48) if not, throws error: https://academy.moralis.io/lessons/assignment-safetransfer-implementation

    }


//  (11:34) https://academy.moralis.io/lessons/assignment-safetransfer-implementation  
    function _isContract(address _to) view internal returns (bool) {
        //if smart contract, code size greater zero.  Wallet zero? 
        uint32 size; 
        //Assembly code: 
        assembly{
            size := extcodesize(_to) //gets size and saves to our uint32 var
        }
        return size > 0; //true if bigger, false if not, meaning not a smart contract.
    }

// (00:34): https://academy.moralis.io/lessons/safetransferfrom-assignment-solution
    function _isApprovedOrOwner(address _spender, address _from, address _to, uint256 _tokenId) internal view returns (bool){
        require(_tokenId < kitties.length); //Token must exist
        require(_to != address(0)); //check TO address is not zero address.
        require(_owns(_from, _tokenId)); //From owns the token
            
//(00:57): https://academy.moralis.io/lessons/safetransferfrom-assignment-solution
        // _spender is from OR _spender is apperoved for tokenId OR _spender is operator for _from
        require(_spender == _from || _approvedFor(msg.sender, _tokenId) || isApprovedForAll(_from, msg.sender)); 
//ORIGINAL version in old transferFrom function:         
        // check sender is owner    or sender has approval for tokenId   or msg.sender is an operator for from  (1:05)
        // require(msg.sender == _from || _approvedFor(msg.sender, _tokenId) || isApprovedForAll(_from, msg.sender)); 
        
        
    }


} /*end of Kittycontract */ 