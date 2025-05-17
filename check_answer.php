<?php
header('Content-Type: application/json');
session_start();

// Database configuration
$db_host = 'localhost:3306';
$db_name = 'zooriddle';
$db_user = 'root'; 
$db_pass = 'cobeo123';    

try {
    // Create PDO connection
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name;charset=utf8", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if (!isset($_SESSION['correct_answer'])) {
        echo json_encode(['correct' => false, 'message' => 'No active game']);
        exit;
    }

    $userGuess = strtolower(trim($_POST['guess']));
    $correctAnswer = strtolower($_SESSION['correct_answer']);

    // Allow for some flexibility in answers
    $isCorrect = false;
    if ($userGuess === $correctAnswer) {
        $isCorrect = true;
    } else {
        // Check if the guess is close enough (e.g., "african elephant" vs "elephant")
        $correctWords = explode(' ', $correctAnswer);
        $guessWords = explode(' ', $userGuess);
        
        $matchingWords = array_intersect($correctWords, $guessWords);
        if (count($matchingWords) > 0 && count($matchingWords) >= count($correctWords)/2) {
            $isCorrect = true;
        }
    }

    if ($isCorrect) {
        $response = ['correct' => true, 'message' => 'Correct! Well done!'];
        unset($_SESSION['correct_answer']);
    } else {
        $response = ['correct' => false, 'message' => 'Incorrect. Try again!'];
    }

    echo json_encode($response);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>