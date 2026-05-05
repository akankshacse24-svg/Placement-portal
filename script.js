// Welcome message on dashboard

window.onload = function() {
    console.log("Placement Portal Loaded");
}


// Login form validation

function validateLogin() {

    let email = document.getElementById("email").value;
    let password = document.getElementById("password").value;

    if(email == "" || password == ""){
        alert("Please fill all fields");
        return false;
    }

    return true;
}



// Register form validation

function validateRegister(){

    let name = document.getElementById("name").value;
    let email = document.getElementById("email").value;
    let password = document.getElementById("password").value;

    if(name == "" || email == "" || password == ""){
        alert("All fields are required");
        return false;
    }

    if(password.length < 6){
        alert("Password must be at least 6 characters");
        return false;
    }

    return true;
}



// Quiz Score Calculation

function calculateScore(){

    let score = 0;

    let answers = document.querySelectorAll("input[type='radio']:checked");

    answers.forEach(function(ans){

        if(ans.value == "correct"){
            score++;
        }

    });

    alert("Your Score is: " + score);

}

// Simple AI Recommendation

function recommendation(score){

    if(score < 2){
        alert("AI Suggestion: Practice more aptitude questions");
    }
    else{
        alert("AI Suggestion: You are doing well. Try company interview questions");
    }

}

function toggleMenu() {
    document.getElementById("menuDropdown").classList.toggle("show");
}

function toggleProfile() {
    document.getElementById("profileDropdown").classList.toggle("show");
}