

**DNA can't start with zero**
The solidity compiler will igore a leading zero. 
_Example:_ 01 would ignore the zero and process just 1. 

So in our slider, we have to start at 10. 
Bootstrap slider only goes to 98. 

![DNA Code](https://i.imgur.com/QaT8K57.png)

10 13 96 10
* 10 = Body Color
* 13 = Mouth/Body/Tail Color
* 96 = Eye Color
* 10 = Ear Color



- [Assignment - Template and Color](https://studygroup.moralis.io/t/assignment-template-and-color/35338/9). 
    - [Template & Color](https://academy.moralis.io/lessons/assignment-template-and-color).

- [Assignment - Buttons](https://studygroup.moralis.io/t/assignment-buttons/35341). 


- [Assignment ERC721](https://studygroup.moralis.io/t/assignment-erc721/35342).


## Truffle

Initial **Kittycontract.sol** and truffle commands below are from [Token Code & Migration Walkthrough ](https://academy.moralis.io/lessons/token-code-migration-walkthrough).

1. run **truffle init** to create the basic files we'll need. 

2. In the newly created _contracts_ file, create **Kittycontracts.sol** and implement the functions recommended in the **IERC721.sol** contract which we downloaded from Filip. 

3. Open tuffle in **Quick Start** mode. 

4. run **truffle compile**. 
    - If there are any errors, the error message should identify the issue(s): 
![Typo uinit256](https://i.imgur.com/GZJx1JC.png)

    - Successful compile: 
![Truffle Compile Success](https://imgur.com/S4YeiKc.png)

5. copy migrations file in **migrations/1_initial_migration.js** and name it **2_token_migration.js**

6. Make the following changes to **2_token_migration.js** renaming const to Token and require file to Kittycontract which references the _Kittycontract.json_ in our **build/contracts** file.  This comes from the name of our contract in **contracts/Kittycontract.sol** which is the name of our class **Kittycontract**. 

In our original **migrations/1_initial_migration.js**:

    ```js
    const Migrations = artifacts.require("Migrations");

    module.exports = function (deployer) {
    deployer.deploy(Migrations);
    };

    ```

In our new **migrations/2_token_migration.js**:

    ```js
    const Token = artifacts.require("Kittycontract");

    module.exports = function (deployer) {
    deployer.deploy(Token);
    };

    ```

7. run **truffle migrate**
    - To force migration (when no changes) use flag **--reset**
    - "_truffle migrate --reset_"

Example of a [successful migration](https://i.imgur.com/GRXvV6k.png). 
![Truffle Compile Success](https://i.imgur.com/GRXvV6k.png)
    
    


8. run **truffle console** to interact with our contract:

>truffle console
>truffle(ganache)>

```
$ truffle console
truffle(ganache)> var instance = await Kittycontract.deployed()
undefined

truffle(ganache)> instance.name()
'DegenKitties'

truffle(ganache)> instance.symbol()
'DK'

truffle(ganache)> instance.totalSupply()
BN { negative: 0, words: [ 0, <1 empty item> ], length: 1, red: null }
truffle(ganache)>
```

(end of [Token Code & Migration Walkthrough ](https://academy.moralis.io/lessons/token-code-migration-walkthrough).)



## Create Kitty Function (And Ownable.sol contract)

[From Create Kitty Function ](https://academy.moralis.io/lessons/create-kitty-function).

[MOSTLY from Solution + New Get Kitty Assnmt](https://academy.moralis.io/lessons/solution-new-get-kitty-assignment).

address(0) creates an address with all zeros
_transfer(address(0), _owner, newKittenId)

*To exit* **Truffle Console** use **.exit** (add .)

After making modifications to our **Kittycontract.sol**, and adding **Ownable.sol** (while making Kittycontract inherit from Ownable)
We had to run
1. truffle combile (fix errors as identified)
2. truffle migrate
    - may need to force with **truffle migrate --reset**
3. truffle console as shown below



## Truffle Commands

1. `truffle init` -  [ERC721 Intro + Assignment](https://academy.moralis.io/lessons/erc721-intro-assignment).
2. `truffle compile` -  [ERC721 Intro + Assignment](https://academy.moralis.io/lessons/erc721-intro-assignment).

_After implementing all functions of the **interface file IERC721.sol** we can then migrate_
_may run truffle compile again **if** more changes are made_
3. `truffle migrate` - [Token Code & Migration Walkthrough](https://academy.moralis.io/lessons/token-code-migration-walkthrough).
    - if you need to force migration run `truffle migrate --reset` 
4. `truffle console` - You can hop into the console and run commands like: 
    - `var instance = await Kittycontract.deployed()`
    - `instance.name()`



**getKitty** function

```js
/*GetKitty Solution added getKitty: https://academy.moralis.io/lessons/getkitty-solution  */
    function getKitty(uint256 _id) external view returns (
        uint256 genes,
        uint256 birthTime,
        uint256 mumId,
        uint256 dadId,
        uint256 generation
        // address owner owner NOT in the struct
    )
     {
         Kitty storage kitty = kitties[_id]; // saved as a pointer. Use storage instead memory (less space)

         birthTime = uint256(kitty.birthTime);
         mumId = uint256(kitty.mumId);
         dadId = uint256(kitty.dadId); 
         generation = uint256(kitty.generation);
         genes = kitty.genes;  
     }

```


On PC, we were in the wrong directory and had duplicate files from running `truffle init` twice. 
Cleaned that up, and then found out the PC was running 0.5.16 solidity version, so we updated our pragma statements

Ran `truffle compile` and `truffle migrate --reset` with the results shown below: 

```js
$ truffle compile

Compiling your contracts...
===========================
> Compiling .\contracts\IERC721.sol
> Compiling .\contracts\Kittycontract.sol
> Compiling .\contracts\Migrations.sol
> Compiling .\contracts\Ownable.sol
> Compiling .\contracts\IERC721.sol
> Compiling .\contracts\Ownable.sol

/C/Users/IanBates/Documents/BlockChain Dev/0a_Moralis_2022_CM/nft-marketplace/academy-kitties-template/academy-kitties-template/contracts/Ownable.sol:10:5: SyntaxError: No visibility specified. Did you intend to add "public"?
    constructor() {
    ^ (Relevant source part starts here and spans across multiple lines).

Compilation failed. See above.
Truffle v5.3.4 (core: 5.3.4)
Node v14.16.1

AzureAD+IanBates@DESKTOP-OT0TGDK MINGW64 ~/Documents/BlockChain Dev/0a_Moralis_2022_CM/nft-marketplace/academy-kitties-template/academy-kitties-template (master)
$ truffle compile

Compiling your contracts...
===========================
> Compiling .\contracts\IERC721.sol
> Compiling .\contracts\Kittycontract.sol
> Compiling .\contracts\Migrations.sol
> Compiling .\contracts\Ownable.sol
> Compiling .\contracts\IERC721.sol
> Compiling .\contracts\Ownable.sol
> Artifacts written to C:\Users\IanBates\Documents\BlockChain Dev\0a_Moralis_2022_CM\nft-marketplace\academy-kitties-template\academy-kitties-template\build\contracts
> Compiled successfully using:
   - solc: 0.5.16+commit.9c3226ce.Emscripten.clang


AzureAD+IanBates@DESKTOP-OT0TGDK MINGW64 ~/Documents/BlockChain Dev/0a_Moralis_2022_CM/nft-marketplace/academy-kitties-template/academy-kitties-template (master)
$ truffle migrate --reset

Compiling your contracts...
===========================
> Compiling .\contracts\IERC721.sol
> Compiling .\contracts\Ownable.sol
> Artifacts written to C:\Users\IanBates\Documents\BlockChain Dev\0a_Moralis_2022_CM\nft-marketplace\academy-kitties-template\academy-kitties-template\build\contracts
> Compiled successfully using:
   - solc: 0.5.16+commit.9c3226ce.Emscripten.clang



Starting migrations...
======================
> Network name:    'ganache'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0xe317ef41efa0938d7acbb924027a438923f56914d41341197f3e5689dddb2319
   > Blocks: 0            Seconds: 0
   > contract address:    0x500Da122189ff64ff669cb375FE084e840f5FF16
   > block number:        1
   > block timestamp:     1673915676
   > account:             0x12c33B2474E0eE1d14317F2410d59E3c636CF189
   > balance:             99.99616114
   > gas used:            191943 (0x2edc7)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00383886 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00383886 ETH


2_token_migration.js
====================

   Replacing 'Kittycontract'
   -------------------------
   > transaction hash:    0x67169235643e109c23af5a6b9cc65d3e181c79d2bf5a4eee22731d611d7b9c71
   > Blocks: 0            Seconds: 0
   > contract address:    0x0A49E9868875770555C101A2B7276E699915bb1F
   > block number:        3
   > block timestamp:     1673915678
   > account:             0x12c33B2474E0eE1d14317F2410d59E3c636CF189
   > balance:             99.98060384
   > gas used:            735527 (0xb3927)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01471054 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.01471054 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.0185494 ETH

```

## We can then run through the basic commands in *truffle console* to test out our contract:

```js
$ truffle console
truffle(ganache)> var instance = await Kittycontract.deployed()
undefined
truffle(ganache)> instance.name
[Function (anonymous)] {
  call: [Function (anonymous)],
  sendTransaction: [Function (anonymous)],
  estimateGas: [Function (anonymous)],
  request: [Function (anonymous)]
}
truffle(ganache)> instance.name()
'DegenKitties'
truffle(ganache)> instance.symbol()
'DK'
truffle(ganache)> instance.createKittyGen0(1001)
{
  tx: '0xb1f6d8d7041151a0231bf7cba3159ae6320c584adb34de8cf3f22bbb7957ba32',
  receipt: {
    transactionHash: '0xb1f6d8d7041151a0231bf7cba3159ae6320c584adb34de8cf3f22bbb7957ba32',
    transactionIndex: 0,
    blockHash: '0x513d690b40de25f58f4924e357283258167f9af79090df31fa4023ff952a15ad',
    blockNumber: 5,
    from: '0x12c33b2474e0ee1d14317f2410d59e3c636cf189',
    to: '0x0a49e9868875770555c101a2b7276e699915bb1f',
    gasUsed: 158405,
    cumulativeGasUsed: 158405,
    contractAddress: null,
    logs: [ [Object], [Object] ],
    status: true,
    logsBloom: '0x00000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000020000000000400000000800000000000000000000000010000020000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000010080000000000000000000200000000000000000020000000000100000000000000000000000000000000000000400000000000000000',
    rawLogs: [ [Object], [Object] ]
  },
  logs: [
    {
      logIndex: 0,
      transactionIndex: 0,
      transactionHash: '0xb1f6d8d7041151a0231bf7cba3159ae6320c584adb34de8cf3f22bbb7957ba32',
      blockHash: '0x513d690b40de25f58f4924e357283258167f9af79090df31fa4023ff952a15ad',
      blockNumber: 5,
      address: '0x0A49E9868875770555C101A2B7276E699915bb1F',
      type: 'mined',
      id: 'log_509e4b6a',
      event: 'Birth',
      args: [Result]
    },
    {
      logIndex: 1,
      transactionIndex: 0,
      transactionHash: '0xb1f6d8d7041151a0231bf7cba3159ae6320c584adb34de8cf3f22bbb7957ba32',
      blockHash: '0x513d690b40de25f58f4924e357283258167f9af79090df31fa4023ff952a15ad',
      blockNumber: 5,
      address: '0x0A49E9868875770555C101A2B7276E699915bb1F',
      type: 'mined',
      id: 'log_debf5ed0',
      event: 'Transfer',
      args: [Result]
    }
  ]
}

```

We can then check out the **totalSupply()** and the **balanceOf()** our first Truffle address `accounts[0]` or view a list of all addresses
available to us in Truffle with the `accounts` command in truffle console. 

```js
truffle(ganache)> instance.totalSupply()
BN { negative: 0, words: [ 1, <1 empty item> ], length: 1, red: null }
truffle(ganache)> instance.balanceOf(accounts[0])
BN { negative: 0, words: [ 1, <1 empty item> ], length: 1, red: null }
truffle(ganache)> accounts
[
  '0x12c33B2474E0eE1d14317F2410d59E3c636CF189',
  '0xA95Ad048d9550d90f044707acf1B955cEF32a3Aa',
  '0x66801e4a0a9a8edC6b308f23C79cf7bE530C7B0b',
  '0xEFF9E00B98D1aE9456271fb79Bf9f0e6525b23CF',
  '0xc98e23fF03e89e59e4cc32904D267A0e44af653E',
  '0xF38c58c8B0a433e9C7f8336B4278Ba11Ab91F3bD',
  '0xF10D8eCc8c17703Bc4071Cb71F77bf215d7Df8B9',
  '0x98ACD0032c856883684c96Fb4249adCD3f637969',
  '0x28E6C8B1b70Fa98474561e6761E8795414eA6a77',
  '0x6A0E1c4765AEf5E5af359e3f4c623efF1C399EE1'
]

```

The first address was used when we used the **createKittyGen0(1001)** function above:

```js
truffle(ganache)> instance.ownerOf(0)
'0x12c33B2474E0eE1d14317F2410d59E3c636CF189'
```


## GetKitty Function

[GetKitty Solution](https://academy.moralis.io/lessons/getkitty-solution).

Run `instance.getKitty(0)`

```js
truffle(ganache)> instance.ownerOf(0)
'0x12c33B2474E0eE1d14317F2410d59E3c636CF189'
truffle(ganache)> instance.getKitty(0)
Result {
  '0': BN {
    negative: 0,
    words: [ 1001, <1 empty item> ],
    length: 1,
    red: null
  },
  '1': BN {
    negative: 0,
    words: [ 63303186, 24, <1 empty item> ],
    length: 2,
    red: null
  },
  '2': BN {
    negative: 0,
    words: [ 0, <1 empty item> ],
    length: 1,
    red: null
  },
  '3': BN {
    negative: 0,
    words: [ 0, <1 empty item> ],
    length: 1,
    red: null
  },
  '4': BN {
    negative: 0,
    words: [ 0, <1 empty item> ],
    length: 1,
    red: null
  },
  genes: BN {
    negative: 0,
    words: [ 1001, <1 empty item> ],
    length: 1,
    red: null
  },
  birthTime: BN {
    negative: 0,
    words: [ 63303186, 24, <1 empty item> ],
    length: 2,
    red: null
  },
  mumId: BN {
    negative: 0,
    words: [ 0, <1 empty item> ],
    length: 1,
    red: null
  },
  dadId: BN {
    negative: 0,
    words: [ 0, <1 empty item> ],
    length: 1,
    red: null
  },
  generation: BN {
    negative: 0,
    words: [ 0, <1 empty item> ],
    length: 1,
    red: null
  }
}

```

To set the results of our **getKitty(0)** function to a variable in _truffle console_ we **must use keyword AWAIT**

```js
truffle(ganache)> var result = await instance.getKitty(0)
undefined
truffle(ganache)> result["genes"].toNumber()
1001

//without .toNumber()
truffle(ganache)> result["genes"]
BN {
  negative: 0,
  words: [ 1001, <1 empty item> ],
  length: 1,
  red: null
}

```


## Metamask & Web3 Setup

[Metamask & Web3 Setup](https://academy.moralis.io/lessons/metamask-web3-setup).

Download [web3.js file from this link](https://academy.moralis.io/wp-content/uploads/2021/04/web3.zip).

Place file in our **client/assets/js/** directory and link to it in our index.html: 

`<script src="assets/js/web3.min.js"></script>` [3:45](https://academy.moralis.io/lessons/metamask-web3-setup).

Outside of our assets folder, we created **index.js**, so just in the **client/** directory and link it into **index.html**
Use `./` to reference _index.js_ in the same folder as _index.html_. 
`<script src="./index.js"></script>`

Our **index.js** file is where we will write our js code that controls the button presses, so it actualy makes a call to the blockchain _using web3.min.js_.





## Web3.js Start Coding

Video [Web3.js Coding](https://academy.moralis.io/lessons/web3-js-start-coding).

Update **index.js** as follows: 

```js
//index.js
var web3 = new Web3(Web3.givenProvider);  //givenProvider picks up current network, for us Ganache (Local)  

var instance; 
var user; 
var contractAddress = "0xe5a7067dbd50c0312d43Ad57a3dfF2e767FA0493"; 

// Check page completed loading (jQuery)
$(document).ready(function(){
    // Call MetaMasks's enable function (2:05): https://academy.moralis.io/lessons/web3-js-start-coding
    window.ethereum.enable().then(function(accounts){
            // abi - specification of what our contract does
            // contract
            // which account we want to use as standard. Set of options passed into object {}
        instance = new web3.eth.Contract(abi, contractAddress, {from: accounts[0]})  //like truffle console, call contract instance
        user = accounts[0]; //returns array, you always want first

        console.log(instance);
    })

})

```


**GET THE CONTRACT ADDRESS FROM TRUFFLE**
### Get the ContractAddress

In terminal, run `truffle migrate --reset` (which **automatically does a truffle compile!**)

```js

$ truffle migrate --reset

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.

//runs our 1_initial_migration.js file in our migrations directory
1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0xf226148ebf5b4ac09549d21693eb10ca38eb34115f26f09a532834c08beb3037
   > Blocks: 0            Seconds: 0
   > contract address:    0x9B10f09f25675093f5e59586A63093C6f9b4FFA3
   > block number:        6

//SKIP down to when it runs OUR 2_token_migration.js file: 
2_token_migration.js
====================

   Replacing 'Kittycontract'
   -------------------------
   > transaction hash:    0xdb2574630efd38090b6cfbf077476b3d7cef61ec141e31b3bc493b9631b360b1
   > Blocks: 0            Seconds: 0
   > contract address:    0xe5a7067dbd50c0312d43Ad57a3dfF2e767FA0493
   > block number:        8
   > block timestamp:     1673926243
   > account:             0x12c33B2474E0eE1d14317F2410d59E3c636CF189
   > balance:             99.95749282
   > gas used:            735527 (0xb3927)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01471054 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.01471054 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.0185494 ETH

```


So, in our **index.js** we need to enter the contract address given to us in the `2_token_migration.js`

   > contract address:    0xe5a7067dbd50c0312d43Ad57a3dfF2e767FA0493
```js 
var contractAddress = "0xe5a7067dbd50c0312d43Ad57a3dfF2e767FA0493";  
```


**GET THE ABI**
### Get the ABI - Application Binary Interface

[5:58](https://academy.moralis.io/lessons/web3-js-start-coding).

ABI is a specification we pass into Web3 / MetaMask so it knows what functions to expect, what arguments, type of arguments expect. 
_Summary of everything the contract does_

We get the *ABI* from our **build folder**

1. Copy the **abi** array [] from `build\Kittycontract.json` 

In **Kittycontract.json**
```js
{
  "contractName": "Kittycontract",
  "abi": [
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "owner",
          "type": "address"
        },
//REDACTED
      "name": "transfer",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ], //CUT JUST BEFORE metadata
  "metadata": 

```

2. Create file **abi.js** in the client directory on the same level as **index.html**
    - reference **abi.js** in the header of **index.html** with: 
    `<script src="./abi.js"></script>`


In **index.js** create a function which listens for the `Create Kitty` button and then runs a function like this: 
```js
        // 11th min(https://academy.moralis.io/lessons/web3-js-start-coding)
        //Unless solidity function has `view` on it, it is a setter function which we can call (jquery) .send() on it (modify K state)
        // async - working with callbacks, because need response from the ethereum node
                                                   // {} options object, we don't have any so leave empty object
        instance.methods.createKittyGen0(dnaStr).send({}, function(error, txHash){
            if(error){
                console.log(error);
            }else{
                console.log(txHash);
            }
        }) 

```

---
End of Folder 5

---

## Web3 Create Kitty Solution + Event Assignment (_See Folder 6. Event-Listener-Connect-solidity-web3)

> [See Section 6-Event-Listener-README.md here](https://github.com/Hostnomics/moralis-nft-marketplace/blob/main/academy-kitties-template/6.%20Event-Listener-Connect-solidity-web3/6-Event-Listener-README.md).

---

[Solution: Event listener on Create Kitty Button triggers createKittyGen0 solidity function](https://academy.moralis.io/lessons/web3-createkitty-solution-event-assignment).

[Solutions page for Web3 Create Kitty Solution](https://studygroup.moralis.io/t/assignment-event/35344).

[Web3 docs on Event Listeners](https://web3js.readthedocs.io/en/v1.2.9/web3-eth-contract.html#contract-events).



In **index.html** add the onclick listener to load `createKitty()` function. 

[html]

  <div class=" group-btn float-right">
      <button class="btn btn-success mr-5 tsp-1 m-1 light-b-shadow" onclick="createKitty()"> Create Kitty</button>                  
  </div>

[/html]


In **index.js** create the `createKitty()` function (which uses the **getDna() function in catSettings.js**): 

```js

//in index.js
function createKitty(){
    var dnaStr = getDna();  //calls getDna() in catSettings.js
    instance.methods.createKittyGen0(dnaStr).send({}, function(error, txHash){
        if(error){
            console.log(error);
        }else{
            console.log(txHash);
        }
    }) 
}

// PREVIOUSLY CREATED in catSettings.js:
function getDna(){
    var dna = ''
    dna += $('#dnabody').html()
    dna += $('#dnamouth').html()
    dna += $('#dnaeyes').html()
    dna += $('#dnaears').html()
    dna += $('#dnashape').html()
    dna += $('#dnadecoration').html()
    dna += $('#dnadecorationMid').html()
    dna += $('#dnadecorationSides').html()
    dna += $('#dnaanimation').html()
    dna += $('#dnaspecial').html()

    return parseInt(dna)
}

```



## Contract Event Listener Solution

[Event Assignment Solution](https://academy.moralis.io/lessons/event-assignment-solution).

[Contract Event Listeners Docs](https://web3js.readthedocs.io/en/v1.2.9/web3-eth-contract.html#contract-events).

**Basic Format**

`myContract.events.MyEvent([options][, callback])`



### Update `contractAddress` in `index.js` if you restart local machine. 

When restart computer, to **jump back into truffle** (in our case made changes) run `truffle migrate --reset` and grab the updated contract address in **2_token_migration.js**

(Also may need to delete old ganache account and add new one when reopen _Truffle_)

```js
// new migration contract address to update in index.js
2_token_migration.js
====================
   Replacing 'Kittycontract'
   -------------------------
   > transaction hash:    0x1760b0c7ff660d8ef17cc368e441b37b38f4c8caa8e214c159636b8bd9bd027a
   > Blocks: 0            Seconds: 0
   > contract address:    0xAeD846e16C88A3E93119609E1cB4Ce80755621BB

//index.js 
  // var contractAddress = "0xe5a7067dbd50c0312d43Ad57a3dfF2e767FA0493"; Reset after fired up computer on 1/18/23. Old contract addy
  var contractAddress = "0xAeD846e16C88A3E93119609E1cB4Ce80755621BB";

//New truffle account: 0x1bcc054D7042a2687aabd8b5508754c2346c4F44 (whatever it generates as first addy)

```

Connection issues Resolved:
![Wallet Connection Issues After Starting Up Truffle Again](https://i.imgur.com/99EgsTx.png)


**Event Listener Solution**

```js

//The Fields Defined for our Birth event in Kittycontract.sol: 
     /*Added event (7:10): https://academy.moralis.io/lessons/create-kitty-function */
     event Birth(address owner, uint256 kittenId, uint256 mumId, uint256 dadId, uint256 genes);

//index.js:
$(document).ready(function(){
    // Call MetaMasks's enable function (2:05): https://academy.moralis.io/lessons/web3-js-start-coding
    window.ethereum.enable().then(function(accounts){
            // abi - specification of what our contract does
            // contract
            // which account we want to use as standard. Set of options passed into object {}
        instance = new web3.eth.Contract(abi, contractAddress, {from: accounts[0]})  //like truffle console, call contract instance
        user = accounts[0]; //returns array, you always want first

        console.log(instance);    
        
// From Event Assignment Solution (1:09): [Event Assignment Solution](https://academy.moralis.io/lessons/event-assignment-solution).
        // Using Web3js Docs: https://web3js.readthedocs.io/en/v1.2.9/web3-eth-contract.html#contract-events
        // Using "data" in the Returns section ""data" returns Object: Fires on each incoming event with the event object as argument."
        //MUST ADD EVENT (Birth) LISTENER HERE, WHERE `instance` variable lives! (1:36)
        instance.events.Birth().on('data', function(event){
            console.log(event); 
            let owner = event.returnValues.owner; 
            let kittyId = event.returnValues.kittenId; 
            let mumId = event.returnValues.mumId;
            let dadId = event.returnValues.dadId;
            let genes = event.returnValues.genes;
            $('#kittyCreation').css("display", "block"); 
            $('#kittyCreation').text("owner:" + owner
                                    + " kittyId:" + kittyId
                                    + " mumId:" + mumId
                                    + " dadId:" + dadId
                                    + " genes:" + genes);
        }).on('error', console.error); 

    })

})


```




**Successful Response**
![Success Response](https://i.imgur.com/9i13MZp.png)

**returnValues**

returnValues: `l {0: '0x1bcc054D7042a2687aabd8b5508754c2346c4F44', 1: '2', 2: '0', 3: '0', 4: '60692136111313', owner: '0x1bcc054D7042a2687aabd8b5508754c2346c4F44', kittenId: '2', mumId: '0', dadId: '0', genes: '60692136111313'}`

```js

returnValues: l {0: '0x1bcc054D7042a2687aabd8b5508754c2346c4F44', 1: '2', 2: '0', 3: '0', 4: '60692136111313', owner: '0x1bcc054D7042a2687aabd8b5508754c2346c4F44', kittenId: '2', mumId: '0', dadId: '0', genes: '60692136111313'}
```




## ERC721 Fulfillment Indroduction 
_(End of Folder 6. Event-Listener-Connect-solidity-web3)_

[End of Section 6-Event-Listener-README.md](https://github.com/Hostnomics/moralis-nft-marketplace/blob/main/academy-kitties-template/6.%20Event-Listener-Connect-solidity-web3/6-Event-Listener-README.md). 

Ethereum [EIP-721 standards on github](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md).


From Mac on R Jan 19th 2023 at 6:32 pm from UBSB:
git clone https://github.com/Hostnomics/moralis-nft-marketplace.git

---
---




## IERC721 Fulfillment (Start of Section 7. ERC-721_Fulfillment Folder)

[See Section 7-ERC-721-Fulfillment-README.md Here](https://github.com/Hostnomics/moralis-nft-marketplace/blob/main/academy-kitties-template/7.%20ERC-721_Fulfillment/7-ERC-721-Fulfillment-README.md). 

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

We have to **truffle compile** our changes to see if we have any errors and move on. 

MAC required [install truffle in cmd line with npm](https://trufflesuite.com/docs/truffle/how-to/install/).

**ISSUE WITH IMPORTING NEW IERC721Receiver.sol**

```js
truffle compile

Compiling your contracts...
===========================
> Compiling ./contracts/IERC721.sol
> Compiling ./contracts/Kittycontract.sol
> Compiling ./contracts/Migrations.sol
> Compiling ./contracts/Ownable.sol

project:/contracts/Kittycontract.sol:13:1: ParserError: Source "project:/contracts/IERC721Receiver.sol" not found
import "./IERC721Receiver.sol"; //IERC721Receiver
^-----------------------------^

Compilation failed. See above.
Truffle v5.7.3 (core: 5.7.3)
Node v19.4.0

```

**ERROR SOLUTION** - we saved the IERC721Receiver.sol as a `.sol` file and not `solidity` when creating it at BGBH waiting room on 1.24.23.



**Compile Error**

[Resolved at (16:27)](https://academy.moralis.io/lessons/assignment-safetransfer-implementation).

**Compiler recommends we Remove the unused** `address _from` parameter from **_checkERC721Support** function. 

However the _real issue was with our misuse of the from parameter_

```js
Compiling ./contracts/IERC721Receiver.sol
> Compiling ./contracts/Kittycontract.sol
> Compiling ./contracts/Migrations.sol
> Compiling ./contracts/Ownable.sol
> Compilation warnings encountered:

    project:/contracts/Kittycontract.sol:240:34: Warning: Unused function parameter. Remove or comment out the variable name to silence this warning.
    function _checkERC721Support(address _from, address _to, uint256 _tokenId, bytes memory _data) internal returns (bool){
                                 ^-----------^

> Artifacts written to /Users/web3dev/Documents/blockchain-dev-projects/filip-nft-marketplace/crypto-kitties-github/moralis-nft-marketplace/academy-kitties-template/7. ERC-721_Fulfillment/build/contracts
> Compiled successfully using:
   - solc: 0.5.16+commit.9c3226ce.Emscripten.clang

```


So our NEW `_checkERC721Support` function becomes: 

```js
// At (16:27) we remove `address _from` parameter throwing error in the `truffle compile`: 
// https://academy.moralis.io/lessons/assignment-safetransfer-implementation
    function _checkERC721Support(address _from, address _to, uint256 _tokenId, bytes memory _data) internal returns (bool){
        if(_isContract(_to)){
            //if NOT a smart contract (code size > 0), return true
            return true; //exits fn here (4:20) https://academy.moralis.io/lessons/assignment-safetransfer-implementation
        }

        //Actually use the _from paramter now
        // bytes4 returnData = IERC721Receiver(_to).onERC721Received(msg.sender, _to, _tokenId, _data);
        bytes4 returnData = IERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
// CHECK THE RETURN VALUE
        // (10:48) if not, throws error: https://academy.moralis.io/lessons/assignment-safetransfer-implementation
        return returnData == MAGIC_ERC721_RECEIVED; 

    }


```

**AND NOW OUR TRUFFLE COMPILE IS SUCCESSFUL**

```js
truffle compile

Compiling your contracts...
===========================
> Compiling ./contracts/Kittycontract.sol
> Artifacts written to /Users/web3dev/Documents/blockchain-dev-projects/filip-nft-marketplace/crypto-kitties-github/moralis-nft-marketplace/academy-kitties-template/7. ERC-721_Fulfillment/build/contracts
> Compiled successfully using:
   - solc: 0.5.16+commit.9c3226ce.Emscripten.clang

```



**NEXT STEPS**: Implement our public functions specificed in our interface: 

[safeTransferFrom Solution](https://academy.moralis.io/lessons/safetransferfrom-assignment-solution).


[00:34 - makes _isApprovedOrOwner function](https://academy.moralis.io/lessons/safetransferfrom-assignment-solution).

We pull out the previous four require statements in our `transferFrom` function and put them in our new `_isApprovedOrOwner` function since multiple functions will need the same four `require()` statements. 
(_See transferFrom and 2nd safeTransferFrom functions_)


new `_isApprovedOrOwner` function: 

```js

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

```


### FINAL Step to be ERC721 Compliant - The ERC165

https://academy.moralis.io/lessons/erc165-implementation

[ERC165 Implementation](https://academy.moralis.io/lessons/erc165-implementation).


Implemented two constants and a function `supportsInterface` to check if the `interfaceId` matches either the 165 or 761. 

```js
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

// (3:08): supportsInterface: https://academy.moralis.io/lessons/erc165-implementation
//VS code recommended `pure` instead of view but need clarification: 
    // function supportsInterface(bytes4 _interfaceId) external pure returns (bool) {
    function supportsInterface(bytes4 _interfaceId) external view returns (bool) {  
        //Returns false if _interfaceId not one of the two constants defined above.
        return ( _interfaceId == _INTERFACE_ID_ERC721 ||  _interfaceId == _INTERFACE_ID_ERC165); 
    }

```

---
---
_End of Section 7 Folder_


## Breeding Kitties (Start Folder 8.Breeding-Kitties)

[See Section 8-Breeding-Kitties.md Here](https://github.com/Hostnomics/moralis-nft-marketplace/blob/main/academy-kitties-template/8.Breeding-Kitties/8-Breeding-Kitties.md). 

[See the main project repo at](https://github.com/Ivan-on-Tech-Academy/academy-cryptokitties).

[Start by Adding Breeding function to Kittycontract.sol](https://academy.moralis.io/lessons/dna-mixing-assignment). 


We can [test out our functions in remix as shown here 9:50](https://academy.moralis.io/lessons/dna-mixing-assignment).



[DNA Mixing function solution](https://academy.moralis.io/lessons/dna-mixing-assignment-solution).


Changed getKitty function from external to public: [00:51](https://academy.moralis.io/lessons/dna-mixing-assignment-solution).

Updated `breed` function: 

```js

    function breed(uint256 _dadId, uint256 _mumId) public returns (uint256) {  //Added: https://academy.moralis.io/lessons/dna-mixing-assignment
        //Check ownership
        require(_owns(msg.sender, _dadId), "The user doesn't own the token"); 
        require(_owns(msg.sender, _mumId), "The user doesn't own the token"); 
        
        //You got the DNA
        // Use empty commas here for the fields we don't need (1:09) https://academy.moralis.io/lessons/dna-mixing-assignment-solution
        // reduces memory use
        ( uint256 dadDna,,,,uint256 DadGeneration ) = getKitty(_dadId);
        ( uint256 mumDna,,,,uint256 DadGeneration ) = getKitty(_mumId);

        uint256 newDna = _mixDna(dadDna, mumDna); 
        
        //Figure out the Generation
        // if (DadGeneration < MumGeneration){

        // }
        uint256 kidGen = 0; 
        if (DadGeneration < MumGeneration) {
            kidGen = MumGeneration + 1;
            kidGen /= 2;
        } else if (DadGeneration > MumGeneration) {
            kidGen = DadGeneration + 1;
            kidGen /= 2;
        } else {
            kidGen = MumGeneration + 1;
        }
        
        //Create a new cat with the new properties, give it to the msg.sender
        _createKitty(_mumId, _dadId, kidGen, newDna, msg.sender);
    }

```


To save memory, we pass essentially empty arguments with just commas when calling `getKitty()` function for _dadId and _mumId: 
```js
        //You got the DNA
        // Use empty commas here for the fields we don't need (1:09) https://academy.moralis.io/lessons/dna-mixing-assignment-solution
        // reduces memory use
        ( uint256 dadDna,,,,uint256 DadGeneration ) = getKitty(_dadId);
        ( uint256 mumDna,,,,uint256 DadGeneration ) = getKitty(_mumId);

//Could pass parameters if desired  ????
        ( uint256 dadDna,uint256 genes,uint256 birthTime,uint256 mumId,uint256 DadGeneration ) = getKitty(_dadId);
        ( uint256 mumDna,,,,uint256 DadGeneration ) = getKitty(_mumId);

```

The `getKitty` function has up to **five parameters**: 
```js
/*GetKitty Solution added getKitty: https://academy.moralis.io/lessons/getkitty-solution  */
// Change from external to public (00:51) in: https://academy.moralis.io/lessons/dna-mixing-assignment-solution
    function getKitty(uint256 _id) public view returns (
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

```




## Breeding Frontend _See_ [See the main project repo at](https://github.com/Ivan-on-Tech-Academy/academy-cryptokitties).


**SKIP THIS LINK** (_Just background_)
[Assignment - Breeding Frontend (Discussion outside our scope)](https://academy.moralis.io/lessons/assignment-breeding-frontend).

Create a third page for `breeding` 


Initial Catalogue Page with Breeding Button Mockup: 
![catalogue page mockup](https://i.imgur.com/rmU728s.png)

`catalogue.html` page breed buttons loads `factory.html` 


## Frontend Buttons

Starts at [3:03](https://academy.moralis.io/lessons/cleanup-buttons-assignment).

**RANDOM BUTTON**
create random number with `Math.random()`


Missing files for the front end [mentioned here](https://studygroup.moralis.io/t/missing-video-s-for-catalogue-and-k-factory/46261/2). and references [tutorial github here](https://github.com/Ivan-on-Tech-Academy/academy-cryptokitties).


Command line - move file from current directory to a subdirectory
Ran command: `mv buildCats.js catalogue` [From IBM blog](https://www.ibm.com/docs/en/aix/7.2?topic=m-mv-command).