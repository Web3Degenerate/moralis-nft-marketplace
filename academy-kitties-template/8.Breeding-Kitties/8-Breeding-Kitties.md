## Breeding Kitties 

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


