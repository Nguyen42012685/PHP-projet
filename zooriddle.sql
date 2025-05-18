CREATE DATABASE IF NOT EXISTS zooriddle;
USE zooriddle;

-- DROP EXISTING TABLES IF THEY EXIST (in dependency order)
DROP TABLE IF EXISTS animal_habitats;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS habitats;
DROP TABLE IF EXISTS animal_types;
DROP TABLE IF EXISTS conservation_statuses;

-- 1. animal_types
CREATE TABLE animal_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO animal_types (name) VALUES
('Mammal'),
('Bird'),
('Reptile'),
('Amphibian'),
('Fish');

-- 2. conservation_statuses
CREATE TABLE conservation_statuses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(100) NOT NULL
);

INSERT INTO conservation_statuses (status) VALUES
('Least Concern'),
('Near Threatened'),
('Vulnerable'),
('Endangered'),
('Critically Endangered'),
('Extinct in the Wild');

-- 3. habitats
CREATE TABLE habitats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO habitats (name) VALUES
('Savanna'),
('Jungle'),
('Rainforest'),
('Desert'),
('Ocean'),
('Mountain'),
('Arctic'),
('Grassland'),
('Wetlands'),
('River'),
('Forest'),
('Plains'),
('Freshwater'),
('Coastal'),
('Urban');

-- 4. animals
CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    weight VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    type_id INT NOT NULL,
    difficulty VARCHAR(10) NOT NULL,
    conservation_status_id INT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES animal_types(id),
    FOREIGN KEY (conservation_status_id) REFERENCES conservation_statuses(id)
);

-- 5. animal_habitats
CREATE TABLE animal_habitats (
    animal_id INT NOT NULL,
    habitat_id INT NOT NULL,
    PRIMARY KEY (animal_id, habitat_id),
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (habitat_id) REFERENCES habitats(id)
);

-- 6. Insert 20 animals with easy, medium, and hard difficulty levels

INSERT INTO animals (name, scientific_name, weight, description, image_path, type_id, difficulty, conservation_status_id) VALUES
-- Easy (6)
('African Elephant', 'Loxodonta africana', '6000 kg', 'The largest land animal, known for its trunk and tusks.', 'images/elephant.jpg', 1, 'easy', 1),
('Bald Eagle', 'Haliaeetus leucocephalus', '6.3 kg', 'A powerful bird of prey and national symbol of the USA.', 'images/bald_eagle.jpg', 2, 'easy', 1),
('Red Kangaroo', 'Macropus rufus', '85 kg', 'The largest of all kangaroos, native to Australia.', 'images/red_kangaroo.jpg', 1, 'easy', 1),
('Giraffe', 'Giraffa camelopardalis', '1200 kg', 'The tallest land animal, easily recognized by its long neck.', 'images/giraffe.jpg', 1, 'easy', 1),
('African Lion', 'Panthera leo', '190 kg', 'A large carnivorous feline known as the king of the savanna.', 'images/african_lion.jpg', 1, 'easy', 3),
('Emperor Penguin', 'Aptenodytes forsteri', '30 kg', 'The largest penguin species, native to Antarctica.', 'images/emperor_penguin.jpg', 2, 'easy', 1),

-- Medium (8)
('Giant Panda', 'Ailuropoda melanoleuca', '100 kg', 'A bear native to China, known for its black and white fur and love for bamboo.', 'images/panda.jpg', 1, 'medium', 4),
('Great White Shark', 'Carcharodon carcharias', '1100 kg', 'A large predatory fish known for its size and sharp teeth.', 'images/great_white_shark.jpg', 5, 'medium', 2),
('Blue Whale', 'Balaenoptera musculus', '150,000 kg', 'The largest animal ever known to have lived on Earth.', 'images/blue_whale.jpg', 1, 'medium', 2),
('Polar Bear', 'Ursus maritimus', '450 kg', 'The largest bear species, found in the Arctic.', 'images/polar_bear.jpg', 1, 'medium', 2),
('Green Sea Turtle', 'Chelonia mydas', '200 kg', 'A large sea turtle found in tropical and subtropical seas.', 'images/green_sea_turtle.jpg', 3, 'medium', 3),
('Orangutan', 'Pongo pygmaeus', '75 kg', 'A great ape native to Indonesia and Malaysia, known for its intelligence.', 'images/orangutan.jpg', 1, 'medium', 3),
('Cheetah', 'Acinonyx jubatus', '72 kg', 'The fastest land animal, capable of running up to 112 km/h.', 'images/cheetah.jpg', 1, 'medium', 3),
('Saltwater Crocodile', 'Crocodylus porosus', '1000 kg', 'The largest living reptile, found in Southeast Asia and Australia.', 'images/saltwater_crocodile.jpg', 3, 'medium', 2),

-- Hard (6)
('King Cobra', 'Ophiophagus hannah', '6 kg', 'The world’s longest venomous snake, found in forests and jungles.', 'images/king_cobra.jpg', 3, 'hard', 3),
('Komodo Dragon', 'Varanus komodoensis', '70 kg', 'The largest living lizard, found on Indonesian islands.', 'images/komodo_dragon.jpg', 3, 'hard', 3),
('Snow Leopard', 'Panthera uncia', '55 kg', 'A solitary big cat native to the mountain ranges of Central and South Asia.', 'images/snow_leopard.jpg', 1, 'hard', 4),
('Poison Dart Frog', 'Dendrobates tinctorius', '30 g', 'A small, brightly colored frog, some species are highly toxic.', 'images/poison_dart_frog.jpg', 4, 'hard', 3),
('African Grey Parrot', 'Psittacus erithacus', '0.4 kg', 'Highly intelligent parrot, famous for its ability to mimic sounds.', 'images/african_grey_parrot.jpg', 2, 'hard', 2),
('Axolotl', 'Ambystoma mexicanum', '0.25 kg', 'A critically endangered amphibian with regenerative abilities.', 'images/axolotl.jpg', 4, 'hard', 5);

-- 7. Insert animal habitats
-- You must insert in the same order as animal IDs above (IDs 1-20)
INSERT INTO animal_habitats (animal_id, habitat_id) VALUES
(1,1), (1,8),      -- African Elephant: Savanna, Grassland
(2,10), (2,11),    -- Bald Eagle: River, Forest
(3,12), (3,8),     -- Red Kangaroo: Plains, Grassland
(4,1), (4,8),      -- Giraffe: Savanna, Grassland
(5,1), (5,8),      -- African Lion: Savanna, Grassland
(6,7),             -- Emperor Penguin: Arctic

(7,3), (7,11),     -- Giant Panda: Rainforest, Forest
(8,5), (8,14),     -- Great White Shark: Ocean, Coastal
(9,5),             -- Blue Whale: Ocean
(10,7), (10,5),    -- Polar Bear: Arctic, Ocean
(11,5), (11,14),   -- Green Sea Turtle: Ocean, Coastal
(12,3), (12,11),   -- Orangutan: Rainforest, Forest
(13,8), (13,12),   -- Cheetah: Grassland, Plains
(14,5), (14,14),   -- Saltwater Crocodile: Ocean, Coastal

(15,2), (15,11),   -- King Cobra: Jungle, Forest
(16,2), (16,11),   -- Komodo Dragon: Jungle, Forest
(17,6), (17,11),   -- Snow Leopard: Mountain, Forest
(18,9), (18,13),   -- Poison Dart Frog: Wetlands, Freshwater
(19,11), (19,15),  -- African Grey Parrot: Forest, Urban
(20,13);           -- Axolotl: Freshwater