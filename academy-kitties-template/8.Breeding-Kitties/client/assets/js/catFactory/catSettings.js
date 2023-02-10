
var colors = Object.values(allColors())

var defaultDNA = {
    "headcolor" : 10,
    "mouthColor" : 13,
    "eyesColor" : 34,  //96
    "earsColor" : 10,
    //Cattributes
    "eyesShape" : 1,
    "decorationPattern" : 1,
    "decorationMidcolor" : 13,
    "decorationSidescolor" : 13,
    "animation" :  1,
    "lastNum" :  1
    }
 
// when page load
$( document ).ready(function() {
  $('#dnabody').html(defaultDNA.headColor);
  $('#dnamouth').html(defaultDNA.mouthColor);
  $('#dnaeyes').html(defaultDNA.eyesColor);
  $('#dnaears').html(defaultDNA.earsColor);
  // Uncommented in 'Building Frontend => Cattributes Introduction'
  $('#dnashape').html(defaultDNA.eyesShape)
  $('#dnadecoration').html(defaultDNA.decorationPattern)
  $('#dnadecorationMid').html(defaultDNA.decorationMidcolor)
  $('#dnadecorationSides').html(defaultDNA.decorationSidescolor)
  $('#dnaanimation').html(defaultDNA.animation)
  $('#dnaspecial').html(defaultDNA.lastNum)
    // END OF Uncommented in 'Building Frontend => Cattributes Introduction'
  renderCat(defaultDNA)
});

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

function renderCat(dna){
    headColor(colors[dna.headcolor],dna.headcolor) //headColor function in catFactory.js
    $('#bodycolor').val(dna.headcolor)

    //Mouth and Tail
    mouthAndBelly(colors[dna.mouthColor],dna.mouthColor) //mouthColor 
    // mouthAndBelly(colors[dna.headcolor],dna.headcolor)
    $('#mouthcolor').val(dna.mouthColor)

    // Eye
    eyeColor(colors[dna.eyesColor],dna.eyesColor) //eyesColor
    $('#eyecolor').val(dna.eyesColor)   

    // Ear
    earsAndPaw(colors[dna.earsColor],dna.earsColor) //earsColor
    $('#earcolor').val(dna.earsColor)   

    // Eye Shape
    eyeVariation(dna.eyesShape) 
    $('#eyeshape').val(dna.eyesShape)

    // Decoration Style
    decorationVariation(dna.decorationPattern)
    $('#decoration').val(dna.decorationPattern)

    midColor(colors[dna.decorationMidcolor],dna.decorationMidcolor)
    $('#decorationmiddle').val(dna.decorationMidcolor)

    sidesColor(colors[dna.decorationSidescolor],dna.decorationSidescolor)
    $('#decorationsides').val(dna.decorationSidescolor)

    animationVariation(dna.animation)   
    $('#animation').val(dna.animation) //initial value of Animation slider

}

// Changing cat colors
$('#bodycolor').change(()=>{
    var bodyColorCode = $('#bodycolor').val()
    console.log(bodyColorCode)

    var colorVal = $('#bodycolor').val()
    headColor(colors[colorVal],colorVal)
})

// Add three more listeners

// 1. Mouth and Tail 
$('#mouthcolor').change(()=>{
    var mouthTailColorCode = $('#mouthcolor').val()
    console.log(mouthTailColorCode)

    var colorVal = $('#mouthcolor').val()
    // mouthTailColor(colors[colorVal],colorVal)
    mouthAndBelly(colors[colorVal],colorVal)
})

// 2. Eye Color
$('#eyecolor').change(()=>{
  var eyeColorCode = $('#eyecolor').val()
  console.log(eyeColorCode)

  var colorVal = $('#eyecolor').val()
  eyeColor(colors[colorVal],colorVal)
})


// 3. Ear Color
$('#earcolor').change(()=>{
  var earColorCode = $('#earcolor').val()
  console.log(earColorCode)

  var colorVal = $('#earcolor').val()
  // earColor(colors[colorVal],colorVal)
  earsAndPaw(colors[colorVal],colorVal)
})

// Eye Shape Event Listener:
$('#eyeshape').change(()=>{
  var eyeShapeValue = $('#eyeshape').val()
  console.log(eyeShapeValue)

  var shape = parseInt($('#eyeshape').val()) // between 1 and 7
  // earColor(colors[colorVal],colorVal)
  eyeVariation(shape)
})

// Decoration Event Listener:
$('#decoration').change(()=>{
  var decorationValue = $('#decoration').val()
  console.log(decorationValue)

  var shape = parseInt($('#decoration').val()) // between 1 and 7
  // earColor(colors[colorVal],colorVal)
  decorationVariation(shape)
})


$('#decorationmiddle').change(()=>{
  var colorVal = $('#decorationmiddle').val()
  midColor(colors[colorVal],colorVal)
})

$('#decorationsides').change(()=>{
  var colorVal = $('#decorationsides').val()
  sidesColor(colors[colorVal],colorVal)
})

// Animation Slider
$('#animation').change(()=>{
  var animationValTracker = $('#animation').val()
  console.log(animationValTracker)

  var animationVal = parseInt($('#animation').val()) //.val() returns string. Convert to num ("2" => 2)
  animationVariation(animationVal)
})


// Display Buttons Settings

  // show-colors
      $('#show-colors').click(() =>{
        console.log("Show Colors Clicked")
          $("#catColors").css('display', 'block');
          $("#catAttributes").css('display', 'none');
          // // remove active and show from other tab and active from nav li
          //     $("#catColorsTab").removeClass("active");
          //     $("#catColorsTab").removeClass("show");
          //     $("#catColorsTabButton").removeClass("active");
          // // add active to catColorTab
          //     $("#catAtrributesTab").addClass("active");
          //     $("#catAtrributesTab").addClass("show");
          //     $("#catAttributesTabButton").addClass("active");
      })

  // show-attributes
        $('#show-attributes').click(() =>{
          console.log("Show Attributes Clicked")
            $("#catColors").css('display', 'none');
            $("#catAttributes").css('display', 'block');
        })