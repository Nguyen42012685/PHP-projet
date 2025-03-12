<?php
// List of animals and image URLs (replace URLs with real ones)
$animals = [
    ['name' => 'lion', 'image' => 'https://example.com/lion.jpg'],
    ['name' => 'elephant', 'image' => 'https://example.com/elephant.jpg'],
    ['name' => 'giraffe', 'image' => 'https://example.com/giraffe.jpg']
];

// Choose a random animal for the game
$randomIndex = rand(0, count($animals) - 1);
$currentAnimal = $animals[$randomIndex];

// Check the answer
$correct = false;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userGuess = strtolower(trim($_POST['user-input']));
    if ($userGuess === strtolower($currentAnimal['name'])) {
        $correct = true;
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zoo Riddle Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 20px;
        }

        h1 {
            color: #333;
        }

        #game-container {
            background: rgb(16, 134, 42);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0,0,0,0.1);
            max-width: 500px;
            margin: auto;
            display: block;
        }

        #animal-image {
            max-width: 100%;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        input {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
        }

        button {
            background: #218838;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background: #1a6e2b;
        }

        #result {
            font-size: 18px;
            font-weight: bold;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <h1><img src="your-logo.png" alt="Logo" style="height: 50px;"> Zoo Riddle Game</h1>

    <!-- Game Content -->
    <h1>Zoo Riddle</h1>
    <div id="game-container">
        <img id="animal-image" src="<?php echo $currentAnimal['image']; ?>" alt="Animal">
        <form method="POST">
            <input type="text" name="user-input" placeholder="Enter animal name...">
            <button type="submit">Submit</button>
        </form>
        <?php if ($_SERVER['REQUEST_METHOD'] === 'POST'): ?>
            <p id="result">
                <?php if ($correct): ?>
                    🎉 Correct!
                <?php else: ?>
                    ❌ Try again!
                <?php endif; ?>
            </p>
        <?php endif; ?>
    </div>
</body>
</html>
