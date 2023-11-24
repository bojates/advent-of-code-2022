const fs = require('fs').promises;

const maxCalories = async (filename) => {
    let max = 0;
    let currentSum = 0;

    const data = await fs.readFile(filename, 'utf8');
    const lines = data.split('\n');

    for (const line of lines) {
        if (line === '') {
            if (currentSum > max) {
                max = currentSum;
            }
            currentSum = 0;
        } else {
            currentSum += Number(line);
        }
    }

    if (currentSum > max) {
        max = currentSum;
    }

    return max;
}

const test = (filename, expectedAnswer) => {
    maxCalories(filename).then(answer => {
        if (answer === expectedAnswer) {
            console.log("Success: " + expectedAnswer);
        } else {
            console.log("=== nope! Got: " + answer + ' but expected: ' + expectedAnswer);
        }
    }).catch(err => {
        console.error(err);
    });
}

test('calories_test.txt', 24000);
test('calories_test2.txt', 24000);
test("calories.txt", 71502);