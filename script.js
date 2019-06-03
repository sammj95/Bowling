var game1 = ["X", "X", "X", "X", "X", "X", "X", "X", "X", "XXX"]; //300
var game2 = ["45", "54", "36", "27", "09", "63", "81", "18", "90", "72"]; //90
var game3 = ["5/", "5/", "5/", "5/", "5/", "5/", "5/", "5/", "5/", "5/", "5"]; //150
var game4 = ["X", "X", "6/", "32", "8/", "X", "63", "80", "X", "X62"]; //164

function calculateScore(game) {
    var i, arr;
	var totalScore   = 0;
	var currentFrame = 0;
    var throwsArr    = [];

    //get test game
	if (game === 1) {
		arr = game1;
	} else if (game === 2) {
		arr = game2;
	} else if (game === 3) {
		arr = game3;
	} else {
        arr = game4;
    }

    //expand into array of throws
    for (let frame of arr) {
        for (let ball of frame.split("")) {
            throwsArr.push(ball);
        }
    }

    //calculate score
    for (i = 0; i < throwsArr.length; i++) {
        if (currentFrame === 10) break;

        if (throwsArr[i] === "X") {
            totalScore += 10 + numberOfPinsGet(throwsArr, i+1) + numberOfPinsGet(throwsArr, i+2);
            currentFrame += 1;
        } else if (throwsArr[i] === "/") {
            totalScore += 10 - parseInt(throwsArr[i-1]) + numberOfPinsGet(throwsArr, i+1);
            currentFrame += .5;
        } else {
            totalScore += parseInt(throwsArr[i], 10);
            currentFrame += .5;
        }
    }

	document.getElementById('score'+game).innerHTML = totalScore;
}

function numberOfPinsGet(throwsArr, i) {
    if (i >= throwsArr.length) return 0;

    if (throwsArr[i] === "X") {
        return 10;
    } else if (throwsArr[i] === "/") {
        return 10 - parseInt(throwsArr[i-1]);
    }
    return parseInt(throwsArr[i], 10);
}
