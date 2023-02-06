## Breeding Kitties 


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