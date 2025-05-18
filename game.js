document.addEventListener('DOMContentLoaded', () => {
    // DOM elements
    const animalImage = document.getElementById('animal-image');
    const hint1 = document.getElementById('hint1');
    const hint2 = document.getElementById('hint2');
    const hint3 = document.getElementById('hint3');
    const hint4 = document.getElementById('hint4');
    const guessInput = document.getElementById('guess-input');
    const submitGuess = document.getElementById('submit-guess');
    const newGameBtn = document.getElementById('new-game');
    const revealBtn = document.getElementById('reveal');
    const resultMessage = document.getElementById('result');
    const difficultyBtns = document.querySelectorAll('.difficulty-btn');
    const animalInfo = document.getElementById('animal-info');

    // Game state
    let currentDifficulty = '';
    let revealedHints = 0;
    let currentAnimal = null;

    // Initialize game
    loadNewAnimal();

    // Event listeners
    difficultyBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            difficultyBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentDifficulty = btn.dataset.difficulty;
            loadNewAnimal();
        });
    });

    hint1.addEventListener('click', () => revealHint(hint1));
    hint2.addEventListener('click', () => revealHint(hint2));
    hint3.addEventListener('click', () => revealHint(hint3));
    hint4.addEventListener('click', () => revealHint(hint4));
    
    submitGuess.addEventListener('click', checkGuess);
    guessInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') checkGuess();
    });
    
    newGameBtn.addEventListener('click', loadNewAnimal);
    revealBtn.addEventListener('click', revealAnswer);

    // Functions
    async function loadNewAnimal() {
        try {
            const url = currentDifficulty ? 
                `get_animal.php?difficulty=${currentDifficulty}` : 'get_animal.php';
            
            const response = await fetch(url);
            currentAnimal = await response.json();
            
            if (currentAnimal.error) {
                throw new Error(currentAnimal.error);
            }
            
            // Reset game state
            animalImage.src = currentAnimal.image_path;
            animalImage.style.filter = 'blur(20px)';
            
            // Reset hints
            hint1.textContent = 'Hint 1: Click to reveal';
            hint2.textContent = 'Hint 2: Click to reveal';
            hint3.textContent = 'Hint 3: Click to reveal';
            hint4.textContent = 'Hint 4: Click to reveal';
            
            hint1.dataset.revealed = false;
            hint2.dataset.revealed = false;
            hint3.dataset.revealed = false;
            hint4.dataset.revealed = false;
            
            resultMessage.textContent = '';
            resultMessage.style.color = '';
            guessInput.value = '';
            revealedHints = 0;
            animalInfo.style.display = 'none';
            
        } catch (error) {
            console.error('Error loading animal:', error);
            resultMessage.textContent = 'Error loading animal. Please try again.';
            resultMessage.style.color = 'red';
        }
    }

    async function checkGuess() {
        const guess = guessInput.value.trim();
        if (!guess) return;

        try {
            const response = await fetch('check_answer.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `guess=${encodeURIComponent(guess)}`
            });
            const result = await response.json();
            
            if (result.error) {
                throw new Error(result.error);
            }
            
            if (result.correct) {
                resultMessage.textContent = result.message;
                resultMessage.style.color = 'green';
                animalImage.style.filter = 'blur(0)';
                showAnimalInfo();
            } else {
                resultMessage.textContent = result.message;
                resultMessage.style.color = 'red';
            }
        } catch (error) {
            console.error('Error checking answer:', error);
            resultMessage.textContent = 'Error checking answer. Please try again.';
            resultMessage.style.color = 'red';
        }
    }

    function revealHint(hintElement) {
        if (!hintElement.dataset.revealed && currentAnimal) {
            switch(hintElement.id) {
                case 'hint1':
                    hintElement.textContent = currentAnimal.hint1;
                    break;
                case 'hint2':
                    hintElement.textContent = currentAnimal.hint2;
                    break;
                case 'hint3':
                    hintElement.textContent = currentAnimal.hint3;
                    break;
                case 'hint4':
                    hintElement.textContent = currentAnimal.hint4;
                    break;
            }
            hintElement.dataset.revealed = 'true';
            revealedHints++;
            // Reduce blur with each hint revealed
            const currentBlur = 20 - (revealedHints * 5);
            animalImage.style.filter = `blur(${Math.max(currentBlur, 0)}px)`;
        }
    }

    function revealAnswer() {
        if (currentAnimal) {
            resultMessage.textContent = `The answer was: ${currentAnimal.name}`;
            resultMessage.style.color = 'blue';
            animalImage.style.filter = 'blur(0)';
            showAnimalInfo();
        }
    }

    function showAnimalInfo() {
        if (currentAnimal) {
            document.getElementById('animal-name').textContent = currentAnimal.name;
            document.getElementById('animal-scientific').textContent = `Scientific name: ${currentAnimal.scientific_name}`;
            document.getElementById('animal-weight').textContent = `Weight: ${currentAnimal.weight}`;
            document.getElementById('animal-description').textContent = currentAnimal.description;
            document.getElementById('animal-type').textContent = `Type: ${currentAnimal.type}`;
            document.getElementById('animal-conservation').textContent = `Conservation status: ${currentAnimal.conservation_status}`;
            document.getElementById('animal-habitats').textContent = `Habitats: ${currentAnimal.habitats}`;
            animalInfo.style.display = 'block';
        }
    }
});