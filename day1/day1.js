const fs = require('fs').promises;

const maxCalories = async (filename, numElves = 1) => {
    let currentSum = 0;
    const sums = [];

    const data = await fs.readFile(filename, 'utf8');
    const lines = data.split('\n');

    for (const line of lines) {
        if (line === '' && currentSum !== 0) {
            sums.push(currentSum);
            currentSum = 0;
        } else {
            currentSum += Number(line);
        }
    }
    sums.push(currentSum);
    sums.sort((a, b) => { return a - b });

    let retValue = 0;
    for (i = 0; i < numElves; i++) { retValue += sums.pop(); }
    return retValue;
}

const test = (filename, elves, expectedAnswer) => {
    maxCalories(filename, elves).then(answer => {
        if (answer === expectedAnswer) {
            console.log("Success: " + expectedAnswer);
        } else {
            console.log("=== nope! Got: " + answer + ' but expected: ' + expectedAnswer);
        }
    }).catch(err => {
        console.error(err);
    });
}

test('calories_test.txt', 1, 24000);
test('calories_test2.txt', 1, 24000);
test("calories.txt", 1, 71502);
test("calories_test.txt", 3, 45000)
test("calories_test2.txt", 3, 45000)
test("calories.txt", 3)
