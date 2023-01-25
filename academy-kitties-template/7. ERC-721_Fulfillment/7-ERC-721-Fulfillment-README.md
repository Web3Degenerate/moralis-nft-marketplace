## IERC721 Fulfillment

[ERC721 Fulfillment - Approval](https://academy.moralis.io/lessons/erc721-fulfillment-approval).


(1:35) Added this **mapping** to `Kittycontract.sol`:

**Operator Approval or Approval for All** - 
where we give permission to 
some entity/contract to get the approval to manage all of our tokens. 
All tokens owned by my address. 
Give them access to entire account. 
You are allowed to handle this token for me. 

```js

 mapping (uint256 => address) public kittyIndexToApproved;

//operator
//My Address => Operator Address => True/False
    //check with _operatorApprovals[MYADDR][OPERATORADDR] = true/false; 
    mapping (address => mapping (address => bool)) private _operatorApprovals; 
```

Next Step: Implement the functions required for the two mappings above.

`Download the new IERC721 interface from this page (on the right), and replace the IERC721.sol in your project with this new interface. Then implement the functions approve, setApprovalForAll, getApproved and isApprovedForAll.`

The IERC-721 interface we [downloaded from Ethereum's github](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md) added these four functions to our previous `IERC721.sol` interface. 

```js
    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve
    function approve(address _approved, uint256 _tokenId) external;

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param _operator Address to add to the set of authorized operators
    /// @param _approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address _operator, bool _approved) external;

    /// @notice Get the approved address for a single NFT
    /// @dev Throws if `_tokenId` is not a valid NFT.
    /// @param _tokenId The NFT to find the approved address for
    /// @return The approved address for this NFT, or the zero address if there is none
    function getApproved(uint256 _tokenId) external view returns (address);

    /// @notice Query if an address is an authorized operator for another address
    /// @param _owner The address that owns the NFTs
    /// @param _operator The address that acts on behalf of the owner
    /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);

```

The `operatorApprovals[MyAddr][OperatorAddr]` can be used multiple times: 
```js
_operatorApprovals[MYADDR][BOB_ADDR] = true;
_operatorApprovals[MYADDR][ALICE_ADDR] = false;
_operatorApprovals[MYADDR][LISA_ADDR] = true;
```

**VS Code Editor Solidity Error** "_Contract "Kittycontract" should be marked as abstract._"
This just means you are [inheriting from a contract and you have not implemented all of the functions required per this Stack article](https://ethereum.stackexchange.com/questions/83267/contract-should-be-marked-as-abstract).




## Fulfillment Solution

[ERC721 Fulfillment Approval Solution](https://academy.moralis.io/lessons/erc721-fulfillment-approval-solution).

Four Approval Functions: 
```js
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

    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
        return _operatorApprovals[_owner][_operator]; //his removed underscore
    }

```


Add our own **internal function** to handle the **_approve** functionality: 
(Down at bottom of contract with our other internal functions)
```js
    function _approve(uint256 _tokenId, address _approved) internal {
        kittyIndexToApproved[_tokenId] = _approved;
    }

```

**TO DO**: Need to create the internal `_approvedFor` function in _Kittycontract.sol_ 

`-approvedFor` at (2:02)[https://academy.moralis.io/lessons/erc721-fulfillment-transferfrom-assignment-solution].
```js
// _approvedFor solution at (2:02): https://academy.moralis.io/lessons/erc721-fulfillment-transferfrom-assignment-solution
    function _approvedFor(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return kittyIndexToApproved[_tokenId] == _claimant;
    }

```

[git pull origin](https://teamtreehouse.com/library/introduction-to-git/pulling-changes).


## Add three more solidity functions (1) transferFrom, (2) safeTransfer and (3) safeTransferFrom

[Assignment - ERC721 Fulfillment transferFrom](https://academy.moralis.io/lessons/assignment-erc721-fulfillment-transferfrom).

Added these three functions to the interface and Kittycontract.sol: 

```js
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external {
        
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external {

    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external {

    }

```

### transferFrom

[ERC721 Fulfillment - transferFrom Assignment solution](https://academy.moralis.io/lessons/assignment-erc721-fulfillment-transferfrom).



### safeTransfer

[safeTransfer Explained (chalkboard only)](https://academy.moralis.io/lessons/safetransfer-explained).
- (8:22) - function `onERC721Received()` standard required to confirm 721 compliance and receive 721 tokens.
    - Must return specific value `0x150b7a02`

[OpenZeppelin github on ERC721.sol and onERC721Received() function](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol).

`bytes4 private constant _ERC721_RECEIVED = ox150b7a02;` - _on his version (??)_



[Assignment - safeTransfer Implementation](https://academy.moralis.io/lessons/assignment-safetransfer-implementation).


Two functions called safeTransferFrom which both use internal `_safeTransfer`.


**Steps Followed**

1. create internal `_safeTransfer` function
2. create internal `_checkERC721Support` function (bottom)
    - checkERC721Support will use new internal function
3. create internal `_isContract(_to)`
4. Create `IERC721Receiver.sol`


Pick up at (13:56)

