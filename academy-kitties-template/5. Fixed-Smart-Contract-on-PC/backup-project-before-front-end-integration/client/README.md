

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

[GetKitty Solution]().

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


