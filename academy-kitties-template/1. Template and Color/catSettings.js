
var colors = Object.values(allColors())

var defaultDNA = {
    "headcolor" : 10,
    "mouthColor" : 13,
    "eyesColor" : 96,
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
    
//   $('#dnashape').html(defaultDNA.eyesShape)
//   $('#dnadecoration').html(defaultDNA.decorationPattern)
//   $('#dnadecorationMid').html(defaultDNA.decorationMidcolor)
//   $('#dnadecorationSides').html(defaultDNA.decorationSidescolor)
//   $('#dnaanimation').html(defaultDNA.animation)
//   $('#dnaspecial').html(defaultDNA.lastNum)

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
    mouthTailColor(colors[dna.headcolor],dna.headcolor) //headColor function in catFactory.js
    $('#mouthtailcolor').val(dna.headcolor)

    // Eye
    eyeColor(colors[dna.headcolor],dna.headcolor) //headColor function in catFactory.js
    $('#eyecolor').val(dna.headcolor)   

    // Ear
    earColor(colors[dna.headcolor],dna.headcolor) //headColor function in catFactory.js
    $('#earcolor').val(dna.headcolor)   

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
$('#mouthtailcolor').change(()=>{
    var mouthTailColorCode = $('#mouthtailcolor').val()
    console.log(mouthTailColorCode)

    var colorVal = $('#mouthtailcolor').val()
    mouthTailColor(colors[colorVal],colorVal)
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
  earColor(colors[colorVal],colorVal)
})