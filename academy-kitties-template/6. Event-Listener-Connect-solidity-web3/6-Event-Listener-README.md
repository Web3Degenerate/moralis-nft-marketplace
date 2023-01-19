# 6-Event-Listener-Readme.md

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