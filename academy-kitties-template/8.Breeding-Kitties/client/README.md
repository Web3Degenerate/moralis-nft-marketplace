

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



## Web3 Create Kitty Solution + Event Assignment

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

Ethereum [EIP-721 standards on github](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md).


