
//Random color
function getColor() {
    // Math.floor(Math.random() * 100) + 1 ==> would give us numbers 1 - 100
    var randomColor = Math.floor(Math.random() * 16777215).toString(16);
    return randomColor
}

function genColors(){
    var colors = []
    for(var i = 10; i < 99; i ++){
      var color = getColor()
      colors[i] = color
    }
    return colors
}



//###################################################
// Color Changing Functions
//###################################################


//This function code needs to modified so that it works with Your cat code.
function headColor(color,code) {
    $('.cat__head, .cat__chest').css('background', '#' + color)  //This changes the color of the cat
    $('#headcode').html('code: '+ code) //This updates text of the badge next to the slider
    $('#dnabody').html(code) //This updates the body color part of the DNA that is displayed below the cat
}


// Three more color functions: 
// 1. Mouth and Tail
function mouthAndBelly(color,code) {
    $('.cat__tail, .cat__mouth-contour, .cat__chest_inner').css('background', '#' + color)  //This changes the color of the cat
    // $('.cat__tail, .cat__mouth-contour, .cat__mouth-left, .cat__mouth-right, .cat__chest_inner').css('background', '#' + color)
    $('#mouthcode').html('code: '+ code) //This updates text of the badge next to the slider
    $('#dnamouth').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

// Eye
function eyeColor(color,code) {
     $('.pupil-left, .pupil-right').css('background', '#' + color) //This changes the color of the cat  
    // $('.cat__eye').css('background', '#' + color) // Grabbing parent element div didn't work for me: https://i.imgur.com/mExT873.png
    $('#eyecode').html('code: '+ code) //This updates text of the badge next to the slider
    $('#dnaeyes').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

// Ears
function earsAndPaw(color,code) {
    $('.cat__ear--left, .cat__ear--right, .cat__paw-left, .cat__paw-right, .cat__paw-left_inner, .cat__paw-right_inner').css('background', '#' + color)  //This changes the color of the cat
    $('#earcode').html('code: '+ code) //This updates text of the badge next to the slider
    $('#dnaears').html(code) //This updates the body color part of the DNA that is displayed below the cat
}


// Mid Color Decoration Change
// Ears
function midColor(color,code) {
    $('#midDot').css('background', '#' + color)  //This changes the color of the cat
    $('#middleCode').html('code: '+ code) //This updates text of the badge next to the slider
    $('#dnadecorationMid').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

// sidesColor
function sidesColor(color,code) {
    $('#leftDot, #rightDot').css('background', '#' + color)  //This changes the color of the cat
    $('#sidesCode').html('code: '+ code) //This updates text of the badge next to the slider
    $('#dnadecorationSides').html(code) //This updates the body color part of the DNA that is displayed below the cat
}


//###################################################
//Functions below will be used later on in the project
//###################################################
function eyeVariation(num) {

    $('#dnashape').html(num)

        switch (num) {
            case 1:
                normalEyes()
                $('#eyeName').html('Basic') // Set the badge to basic
                break
            case 2:
                normalEyes() //reset (border none)
                $('#eyeName').html('Chill')
                // return eyesType1()
                eyesType1() // set border to change the shape of the eye (border)
                break
            case 3:
                    normalEyes() //reset (border none)
                    $('#eyeName').html('Up')
                    // return eyesType1()
                    eyesType2() // set border to change the shape of the eye (border)
                    break   
            case 4:
                    normalEyes() //reset (border none)
                    $('#eyeName').html('Left')
                    // return eyesType1()
                    eyesType3() // set border to change the shape of the eye (border)
                    break   
            case 5:
                    normalEyes() //reset (border none)
                    $('#eyeName').html('Right')
                    // return eyesType1()
                    eyesType4() // set border to change the shape of the eye (border)
                    break    
            case 6:
                    normalEyes() //reset (border none)
                    $('#eyeName').html('Center')
                    // return eyesType1()
                    eyesType5() // set border to change the shape of the eye (border)
                    break
            case 7:
                    normalEyes() //reset (border none)
                    $('#eyeName').html('Sleepy')
                    // return eyesType1()
                    eyesType6() // set border to change the shape of the eye (border)
                    break                   
            default: 
                $('#eyeName').html('Default')
                console.log("Not 1 or 2")
                // break
        }
}

async function normalEyes() {
    await $('.cat__eye').find('span').css('border', 'none')
}

async function eyesType1() {
    await $('.cat__eye').find('span').css('border-top', '15px solid')
}

async function eyesType2() {
    await $('.cat__eye').find('span').css('border-bottom', '15px solid')
}

async function eyesType3() {
    await $('.cat__eye').find('span').css('border-left', '15px solid')
}

async function eyesType4() {
    await $('.cat__eye').find('span').css('border-right', '15px solid')
}

async function eyesType5() {
    await $('.cat__eye').find('span').css('border', '15px solid')
}

async function eyesType6() {
    //background: #fff;
    //border-top: 3px solid rgba(255, 255, 255, 0);
    await $('.cat__eye').find('span').css('border-top', '30px solid #fff')
    // await $('.cat__eye').find('span').css('background', '#fff')
}

// function normalEyes() {
//     // Find all of the span elements within class 'cat__eye'
//     $('.cat__eye').find('span').css('border', 'none')
// }



//###################################################
// Decoration on Cat Forehead
//###################################################

function decorationVariation(num) {
    $('#dnadecoration').html(num)
    switch (num) {
        case 1:
            $('#decorationName').html('Basic')
            normaldecoration()
            break        
        case 2:
            $('#decorationName').html('45 Degrees')
            normaldecoration2()
            break
        default: 
            $('#decorationName').html('Default')
            console.log("Not 1 or 2")
    }
}



async function normaldecoration() {
    //Remove all style from other decorations
    //In this way we can also use normalDecoration() to reset the decoration style
    $('.cat__head-dots').css({ "transform": "rotate(0deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(0deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(0deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}

async function normaldecoration2() {
    //Remove all style from other decorations
    //In this way we can also use normalDecoration() to reset the decoration style
    $('.cat__head-dots').css({ "transform": "rotate(0deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(45deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(-45deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}



//###################################################
// Animation Slider Function Logic
//###################################################

function animationVariation(num){
        
    $('#dnadanimation').html(num)
    switch (num) {
        case 1:
            $('#animationName').html('Move Head')
            headAnimation() //animationType1()
            break        
        case 2:
            $('#animationName').html('Move Tail')
            tailAnimation() //animationType2()
            break
        case 3:
            $('#animationName').html('Move Ears')
            earAnimation()
            break       
        default: 
            $('#animationName').html('Default')
            console.log("Not 1 or 2")
    }  
}

async function headAnimation() {
    resetTailAnimation()
    resetEarAnimation()
    // resetTailAnimation()
    // await $('#head').find('div').css('movingHead')
    await $('#head').addClass('movingHead')
}

async function tailAnimation() {
    resetHeadAnimation()
    resetEarAnimation()
    // resetTailAnimation()
    await $('#tail').addClass('movingTail')
}

async function earAnimation() {
    resetHeadAnimation()
    resetTailAnimation()
    // resetTailAnimation()
    await $('#leftEar').addClass('moveLeftEar')
    await $('#rightEar').addClass('moveRightEar')
}

//HEAD reset
async function resetHeadAnimation(){    //resetAnimation
    await $('#head').removeClass('movingHead')
    // await $('#tail').removeClass('movingTail')
}

//TAIL reset
async function resetTailAnimation(){
    await $('#tail').removeClass('movingTail')
}

//EAR reset
async function resetEarAnimation(){
    // await $('#leftEar, #rightEar').removeClass('movingEars')
    await $('#leftEar').removeClass('moveLeftEar')
    await $('#rightEar').removeClass('moveRightEar')
}