<?php
header('Content-Type: application/json');
session_start();

// Include config for DB credentials
require_once 'config.php';

try {
    // Connect to the database using PDO
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8", DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if (!isset($_SESSION['correct_answer'])) {
        echo json_encode(['correct' => false, 'message' => 'No active game']);
        exit;
    }

    // Get and sanitize user guess
    $userGuess = strtolower(trim($_POST['guess'] ?? ''));
    $correctAnswer = strtolower($_SESSION['correct_answer']);

    // Basic direct match
    $isCorrect = false;
    if ($userGuess === $correctAnswer) {
        $isCorrect = true;
    } else {
        // Flexible match: allow for partial word match
        $correctWords = explode(' ', $correctAnswer);
        $guessWords = explode(' ', $userGuess);

        $matchingWords = array_intersect($correctWords, $guessWords);
        if (count($matchingWords) > 0 && count($matchingWords) >= count($correctWords) / 2) {
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