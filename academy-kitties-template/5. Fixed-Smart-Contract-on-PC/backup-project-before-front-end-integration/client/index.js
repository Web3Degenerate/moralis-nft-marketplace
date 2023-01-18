// alert('hello from index.js'); // confirm connection. Run 'Live Server' in VS code from index.html

// Added: https://academy.moralis.io/lessons/web3-js-start-coding
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
        

    })

})