<?php
header('Content-Type: application/json');
session_start();

// Database configuration
$db_host = 'localhost:3306';
$db_name = 'zooriddle';
$db_user = 'root';
$db_pass = 'cobeo123';

try {
    $pdo = new PDO("mysql:host=localhost:3306;dbname=zooriddle;charset=utf8", "root", "cobeo123");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $difficulty = isset($_GET['difficulty']) ? $_GET['difficulty'] : null;

    $query = "
        SELECT 
            a.id, 
            a.name, 
            a.scientific_name, 
            a.weight, 
            a.description, 
            a.image_path, 
            at.name as type,
            a.difficulty,
            cs.status as conservation_status,
            GROUP_CONCAT(DISTINCT h.name SEPARATOR ', ') as habitats
        FROM animals a
        JOIN animal_types at ON a.type_id = at.id
        LEFT JOIN animal_habitats ah ON a.id = ah.animal_id
        LEFT JOIN habitats h ON ah.habitat_id = h.id
        LEFT JOIN conservation_statuses cs ON a.conservation_status_id = cs.id
    ";

    if ($difficulty) {
        $query .= " WHERE a.difficulty = :difficulty";
    }

    $query .= " GROUP BY a.id ORDER BY RAND() LIMIT 1";

    $stmt = $pdo->prepare($query);

    if ($difficulty) {
        $stmt->bindParam(':difficulty', $difficulty);
    }

    $stmt->execute();
    $animal = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$animal) {
        throw new Exception('No animal found');
    }

    $animal['hint1'] = "I am a " . $animal['type'];
    $animal['hint2'] = "I weigh about " . $animal['weight'];
    $animal['hint3'] = "I live in: " . $animal['habitats'];
    $animal['hint4'] = "Scientific name: " . $animal['scientific_name'];
    
    // Store the correct answer in session
    $_SESSION['correct_answer'] = $animal['name'];

    echo json_encode($animal);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
} catch (Exception $e) {
    http_response_code(404);
    echo json_encode(['error' => $e->getMessage()]);
}
?>