// alert('hello from index.js'); // confirm connection. Run 'Live Server' in VS code from index.html

// Added: https://academy.moralis.io/lessons/web3-js-start-coding
var web3 = new Web3(Web3.givenProvider);  //givenProvider picks up current network, for us Ganache (Local)  

var instance; 
var user; 
// var contractAddress = "0xe5a7067dbd50c0312d43Ad57a3dfF2e767FA0493"; Reset after fired up computer on 1/18/23
var contractAddress = "0xAeD846e16C88A3E93119609E1cB4Ce80755621BB";
//Account 1? = 0xA9CF05998971de7032406373C195d796F7b063Be


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

        // 11th min(https://academy.moralis.io/lessons/web3-js-start-coding)
        //Unless solidity function has `view` on it, it is a setter function which we can call (jquery) .send() on it (modify K state)
        // async - working with callbacks, because need response from the ethereum node
        // {} options object, we don't have any so leave empty object
        // instance.methods.createKittyGen0(dnaStr).send({}, function(error, txHash){
        //     if(error){
        //         console.log(error);
        //     }else{
        //         console.log(txHash);
        //     }
        // }) 

        // instance.methods.createKittyGen0(dnaStr).send({}, function(error, txHash){
        //     if(error)
        //         console.log(err);
        //     else
        //         console.log(txHash);          
        // })

// Solution (00:47): https://academy.moralis.io/lessons/web3-createkitty-solution-event-assignment
function createKitty(){
    var dnaStr = getDna(); //calls getDna() in catSettings.js
    instance.methods.createKittyGen0(dnaStr).send({}, function(error, txHash){
        if(error){
            console.log(error);
        }else{
            console.log(txHash);
        }
    }) 
}

//Original Create Kitty (O) button:
    $('#createCatButton').click(() =>{
        // createKitty(getDna());
        createKitty();
      })
        