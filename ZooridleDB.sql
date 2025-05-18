-- Create the database
CREATE DATABASE IF NOT EXISTS ZooRiddle;
USE ZooRiddle;

-- CENTRAL ANIMALS TABLE (without scientific_name)
CREATE TABLE animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    description TEXT,
    weight_min DECIMAL(10,2),
    weight_max DECIMAL(10,2),
    image_url VARCHAR(255),
    is_daily_animal BOOLEAN DEFAULT FALSE,
    UNIQUE KEY (common_name)
) ENGINE=InnoDB;

-- SUPPORTING TABLES

-- Animal categories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    UNIQUE KEY (name)
) ENGINE=InnoDB;

-- Habitats
CREATE TABLE habitats (
    habitat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    UNIQUE KEY (name)
) ENGINE=InnoDB;

-- Diets
CREATE TABLE diets (
    diet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    UNIQUE KEY (name)
) ENGINE=InnoDB;

-- Characteristics for clues
CREATE TABLE characteristics (
    characteristic_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    UNIQUE KEY (name)
) ENGINE=InnoDB;

-- Taxonomy classification
CREATE TABLE taxonomies (
    taxonomy_id INT AUTO_INCREMENT PRIMARY KEY,
    taxonomic_rank VARCHAR(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    UNIQUE KEY (taxonomic_rank, name)
) ENGINE=InnoDB;

-- JUNCTION TABLES (MANY-TO-MANY RELATIONSHIPS)

-- Animals to Categories
CREATE TABLE animal_categories (
    animal_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (animal_id, category_id),
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Animals to Habitats
CREATE TABLE animal_habitats (
    animal_id INT NOT NULL,
    habitat_id INT NOT NULL,
    PRIMARY KEY (animal_id, habitat_id),
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id) ON DELETE CASCADE,
    FOREIGN KEY (habitat_id) REFERENCES habitats(habitat_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Animals to Diets
CREATE TABLE animal_diets (
    animal_id INT NOT NULL,
    diet_id INT NOT NULL,
    PRIMARY KEY (animal_id, diet_id),
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id) ON DELETE CASCADE,
    FOREIGN KEY (diet_id) REFERENCES diets(diet_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Animals to Characteristics
CREATE TABLE animal_characteristics (
    animal_id INT NOT NULL,
    characteristic_id INT NOT NULL,
    PRIMARY KEY (animal_id, characteristic_id),
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id) ON DELETE CASCADE,
    FOREIGN KEY (characteristic_id) REFERENCES characteristics(characteristic_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Animals to Taxonomies
CREATE TABLE animal_taxonomies (
    animal_id INT NOT NULL,
    taxonomy_id INT NOT NULL,
    taxonomic_rank VARCHAR(20) NOT NULL,
    PRIMARY KEY (animal_id, taxonomy_id),
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id) ON DELETE CASCADE,
    FOREIGN KEY (taxonomy_id) REFERENCES taxonomies(taxonomy_id) ON DELETE CASCADE
) ENGINE=InnoDB;


-- Insert all animals from the document
INSERT INTO animals (common_name, description, weight_min, weight_max) VALUES
('African Elephant', 'The largest land animal, known for its large ears, long trunk, and tusks.', 4500, 6800),
('Tiger', 'A large carnivorous cat with orange fur and black stripes.', 90, 310),
('Bald Eagle', 'A bird of prey with a white head and brown body.', 3, 6.3),
('Emperor Penguin', 'The largest penguin species, known for its black and white plumage.', 22, 45),
('Saltwater Crocodile', 'The largest reptile, an apex predator.', 400, 1000),
('Komodo Dragon', 'The largest lizard, native to Indonesia.', 70, 90),
('Axolotl', 'A unique salamander that remains aquatic for life.', 0.06, 0.2),
('Poison Dart Frog', 'Small, colorful frogs with toxic skin.', 0.001, 0.03),
('Great White Shark', 'A large predatory shark.', 680, 1100),
('Clownfish', 'A small reef fish that forms symbiotic relationships with sea anemones.', 0.25, 0.4),
('Monarch Butterfly', 'A migratory butterfly with orange and black wings.', 0.00025, 0.00075),
('Goliath Beetle', 'One of the heaviest insects.', 0.05, 0.1),
('Goliath Birdeater', 'The world''s largest tarantula.', 0.17, 0.2),
('Black Widow Spider', 'A venomous spider known for its red hourglass marking.', 0.001, 0.001),
('Japanese Spider Crab', 'The largest arthropod.', 19, 19),
('Mantis Shrimp', 'Known for its powerful punch and complex vision.', 0.001, 0.01),
('Giant Squid', 'A deep-sea creature with large eyes.', 100, 275),
('Blue-Ringed Octopus', 'A highly venomous small octopus.', 0.026, 0.026),
('Crown-of-Thorns Starfish', 'A venomous starfish affecting coral reefs.', 0.5, 3),
('Sea Urchin', 'A spiny sea creature.', 0.05, 0.4);

-- Insert additional categories if needed
INSERT IGNORE INTO categories (name, description) VALUES
('Butterfly', 'Flying insects with large, often brightly colored wings'),
('Beetle', 'Insects with hard exoskeletons and wing cases'),
('Starfish', 'Marine invertebrates with radial symmetry'),
('Urchin', 'Spiny marine creatures');

-- Insert additional habitats if needed
INSERT IGNORE INTO habitats (name, description) VALUES
('Mangrove', 'Coastal saline or brackish water habitats'),
('Antarctic ice sheets', 'Polar ice caps'),
('Estuaries', 'Coastal water bodies where rivers meet the sea'),
('Rivers', 'Natural flowing watercourses'),
('Dry forests', 'Forests in dry climate regions'),
('Freshwater lakes', 'Inland bodies of fresh water'),
('Canals', 'Man-made waterways'),
('Woodlands', 'Areas covered with trees'),
('Urban areas', 'Human settlements'),
('Deep-sea ocean floors', 'The bottom of deep oceans'),
('Tide pools', 'Rocky pools filled with seawater');

-- Insert additional characteristics if needed
INSERT IGNORE INTO characteristics (name, description) VALUES
('Apex predator', 'Top of the food chain'),
('Unique adaptation', 'Has special biological features'),
('Heavy', 'Among the heaviest in its category'),
('Toxic', 'Produces toxins for defense'),
('Deep-sea', 'Lives in deep ocean environments'),
('Reef-dwelling', 'Lives in coral reef ecosystems'),
('Cold-adapted', 'Thrives in cold environments'),
('Urban-tolerant', 'Can live in human settlements');

-- Insert additional taxonomies if needed
INSERT IGNORE INTO taxonomies (taxonomic_rank, name) VALUES
('family', 'Accipitridae'),
('family', 'Crocodylidae'),
('family', 'Varanidae'),
('family', 'Ambystomatidae'),
('family', 'Dendrobatidae'),
('family', 'Lamnidae'),
('family', 'Pomacentridae'),
('family', 'Nymphalidae'),
('family', 'Scarabaeidae'),
('family', 'Theraphosidae'),
('family', 'Theridiidae'),
('family', 'Inachidae'),
('family', 'Architeuthidae'),
('family', 'Octopodidae'),
('family', 'Acanthasteridae'),
('order', 'Accipitriformes'),
('order', 'Crocodilia'),
('order', 'Squamata'),
('order', 'Urodela'),
('order', 'Anura'),
('order', 'Lamniformes'),
('order', 'Perciformes'),
('order', 'Lepidoptera'),
('order', 'Coleoptera'),
('order', 'Araneae'),
('order', 'Decapoda'),
('order', 'Oegopsida'),
('order', 'Octopoda'),
('order', 'Valvatida'),
('class', 'Amphibia'),
('class', 'Actinopterygii'),
('class', 'Insecta'),
('class', 'Arachnida'),
('class', 'Malacostraca'),
('class', 'Cephalopoda'),
('class', 'Echinoidea');

-- Create relationships for all animals

-- African Elephant
INSERT INTO animal_categories VALUES (1, 1); -- Mammal
INSERT INTO animal_habitats VALUES (1, 1), (1, 2), (1, 3); -- Grasslands, Savannas, Forests
INSERT INTO animal_diets VALUES (1, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (1, 1), (1, 9), (1, 12); -- Large, Social, Endangered
INSERT INTO animal_taxonomies VALUES 
(1, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(1, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(1, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(1, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Proboscidea'), 'order'),
(1, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Elephantidae'), 'family');

-- Tiger
INSERT INTO animal_categories VALUES (2, 1); -- Mammal
INSERT INTO animal_habitats VALUES (2, 1), (2, 22), (2, 2); -- Forests, Mangroves, Grasslands
INSERT INTO animal_diets VALUES (2, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (2, 1), (2, 13), (2, 12); -- Large, Apex predator, Endangered
INSERT INTO animal_taxonomies VALUES 
(2, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(2, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(2, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(2, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(2, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Felidae'), 'family');

-- Bald Eagle
INSERT INTO animal_categories VALUES (3, 2); -- Bird
INSERT INTO animal_habitats VALUES (3, 1), (3, 5), (3, 6); -- Forests, Wetlands, Coastlines
INSERT INTO animal_diets VALUES (3, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (3, 13), (3, 3); -- Apex predator, Colorful
INSERT INTO animal_taxonomies VALUES 
(3, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(3, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(3, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(3, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Accipitriformes'), 'order'),
(3, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Accipitridae'), 'family');

-- Emperor Penguin
INSERT INTO animal_categories VALUES (4, 2); -- Bird
INSERT INTO animal_habitats VALUES (4, 23); -- Antarctic ice sheets
INSERT INTO animal_diets VALUES (4, 5); -- Piscivore
INSERT INTO animal_characteristics VALUES (4, 1), (4, 9), (4, 28); -- Large, Social, Cold-adapted
INSERT INTO animal_taxonomies VALUES 
(4, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(4, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(4, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(4, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Sphenisciformes'), 'order'),
(4, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Spheniscidae'), 'family');

-- Saltwater Crocodile
INSERT INTO animal_categories VALUES (5, 3); -- Reptile
INSERT INTO animal_habitats VALUES (5, 24), (5, 25), (5, 6); -- Estuaries, Rivers, Coastlines
INSERT INTO animal_diets VALUES (5, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (5, 1), (5, 13), (5, 7); -- Large, Apex predator, Venomous
INSERT INTO animal_taxonomies VALUES 
(5, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(5, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(5, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Reptilia'), 'class'),
(5, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Crocodilia'), 'order'),
(5, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Crocodylidae'), 'family');

-- Komodo Dragon
INSERT INTO animal_categories VALUES (6, 3); -- Reptile
INSERT INTO animal_habitats VALUES (6, 26), (6, 2), (6, 3); -- Dry forests, Grasslands, Savannas
INSERT INTO animal_diets VALUES (6, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (6, 1), (6, 7), (6, 13); -- Large, Venomous, Apex predator
INSERT INTO animal_taxonomies VALUES 
(6, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(6, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(6, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Reptilia'), 'class'),
(6, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Squamata'), 'order'),
(6, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Varanidae'), 'family');

-- Axolotl
INSERT INTO animal_categories VALUES (7, 4); -- Amphibian
INSERT INTO animal_habitats VALUES (7, 27), (7, 28); -- Freshwater lakes, Canals
INSERT INTO animal_diets VALUES (7, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (7, 14), (7, 3); -- Unique adaptation, Colorful
INSERT INTO animal_taxonomies VALUES 
(7, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(7, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(7, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Amphibia'), 'class'),
(7, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Urodela'), 'order'),
(7, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ambystomatidae'), 'family');

-- Poison Dart Frog
INSERT INTO animal_categories VALUES (8, 4); -- Amphibian
INSERT INTO animal_habitats VALUES (8, 7); -- Rainforests
INSERT INTO animal_diets VALUES (8, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (8, 3), (8, 8), (8, 16); -- Colorful, Poisonous, Toxic
INSERT INTO animal_taxonomies VALUES 
(8, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(8, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(8, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Amphibia'), 'class'),
(8, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Anura'), 'order'),
(8, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Dendrobatidae'), 'family');

-- Great White Shark
INSERT INTO animal_categories VALUES (9, 5); -- Fish
INSERT INTO animal_habitats VALUES (9, 8), (9, 6); -- Open oceans, Coastlines
INSERT INTO animal_diets VALUES (9, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (9, 1), (9, 13), (9, 7); -- Large, Apex predator, Venomous
INSERT INTO animal_taxonomies VALUES 
(9, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(9, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(9, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Actinopterygii'), 'class'),
(9, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Lamniformes'), 'order'),
(9, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Lamnidae'), 'family');

-- Clownfish
INSERT INTO animal_categories VALUES (10, 5); -- Fish
INSERT INTO animal_habitats VALUES (10, 10); -- Coral reefs
INSERT INTO animal_diets VALUES (10, 5); -- Piscivore
INSERT INTO animal_characteristics VALUES (10, 3), (10, 18); -- Colorful, Reef-dwelling
INSERT INTO animal_taxonomies VALUES 
(10, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(10, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(10, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Actinopterygii'), 'class'),
(10, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Perciformes'), 'order'),
(10, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Pomacentridae'), 'family');

-- Monarch Butterfly
INSERT INTO animal_categories VALUES (11, 6); -- Insect
INSERT INTO animal_habitats VALUES (11, 2), (11, 1), (11, 29); -- Grasslands, Forests, Woodlands
INSERT INTO animal_diets VALUES (11, 6); -- Frugivore
INSERT INTO animal_characteristics VALUES (11, 3), (11, 11); -- Colorful, Migratory
INSERT INTO animal_taxonomies VALUES 
(11, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(11, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Arthropoda'), 'phylum'),
(11, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Insecta'), 'class'),
(11, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Lepidoptera'), 'order'),
(11, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Nymphalidae'), 'family');

-- Goliath Beetle
INSERT INTO animal_categories VALUES (12, 6); -- Insect
INSERT INTO animal_habitats VALUES (12, 7); -- Rainforests
INSERT INTO animal_diets VALUES (12, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (12, 1), (12, 15); -- Large, Heavy
INSERT INTO animal_taxonomies VALUES 
(12, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(12, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Arthropoda'), 'phylum'),
(12, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Insecta'), 'class'),
(12, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Coleoptera'), 'order'),
(12, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Scarabaeidae'), 'family');

-- Goliath Birdeater
INSERT INTO animal_categories VALUES (13, 7); -- Arachnid
INSERT INTO animal_habitats VALUES (13, 7); -- Rainforests
INSERT INTO animal_diets VALUES (13, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (13, 1), (13, 7), (13, 15); -- Large, Venomous, Heavy
INSERT INTO animal_taxonomies VALUES 
(13, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(13, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Arthropoda'), 'phylum'),
(13, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Arachnida'), 'class'),
(13, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Araneae'), 'order'),
(13, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Theraphosidae'), 'family');

-- Black Widow Spider
INSERT INTO animal_categories VALUES (14, 7); -- Arachnid
INSERT INTO animal_habitats VALUES (14, 29), (14, 2), (14, 30); -- Woodlands, Grasslands, Urban areas
INSERT INTO animal_diets VALUES (14, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (14, 7), (14, 16), (14, 31); -- Venomous, Toxic, Urban-tolerant
INSERT INTO animal_taxonomies VALUES 
(14, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(14, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Arthropoda'), 'phylum'),
(14, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Arachnida'), 'class'),
(14, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Araneae'), 'order'),
(14, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Theridiidae'), 'family');

-- Japanese Spider Crab
INSERT INTO animal_categories VALUES (15, 8); -- Crustacean
INSERT INTO animal_habitats VALUES (15, 31); -- Deep-sea ocean floors
INSERT INTO animal_diets VALUES (15, 7); -- Scavenger
INSERT INTO animal_characteristics VALUES (15, 1), (15, 17); -- Large, Deep-sea
INSERT INTO animal_taxonomies VALUES 
(15, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(15, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Arthropoda'), 'phylum'),
(15, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Malacostraca'), 'class'),
(15, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Decapoda'), 'order'),
(15, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Inachidae'), 'family');

-- Mantis Shrimp
INSERT INTO animal_categories VALUES (16, 8); -- Crustacean
INSERT INTO animal_habitats VALUES (16, 10); -- Coral reefs
INSERT INTO animal_diets VALUES (16, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (16, 14), (16, 18); -- Unique adaptation, Reef-dwelling
INSERT INTO animal_taxonomies VALUES 
(16, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(16, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Arthropoda'), 'phylum'),
(16, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Malacostraca'), 'class'),
(16, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Stomatopoda'), 'order');

-- Giant Squid
INSERT INTO animal_categories VALUES (17, 9); -- Mollusk
INSERT INTO animal_habitats VALUES (17, 8); -- Ocean
INSERT INTO animal_diets VALUES (17, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (17, 1), (17, 17); -- Large, Deep-sea
INSERT INTO animal_taxonomies VALUES 
(17, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(17, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Mollusca'), 'phylum'),
(17, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Cephalopoda'), 'class'),
(17, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Oegopsida'), 'order'),
(17, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Architeuthidae'), 'family');

-- Blue-Ringed Octopus
INSERT INTO animal_categories VALUES (18, 9); -- Mollusk
INSERT INTO animal_habitats VALUES (18, 32), (18, 10); -- Tide pools, Coral reefs
INSERT INTO animal_diets VALUES (18, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (18, 3), (18, 7), (18, 16); -- Colorful, Venomous, Toxic
INSERT INTO animal_taxonomies VALUES 
(18, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(18, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Mollusca'), 'phylum'),
(18, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Cephalopoda'), 'class'),
(18, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Octopoda'), 'order'),
(18, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Octopodidae'), 'family');

-- Crown-of-Thorns Starfish
INSERT INTO animal_categories VALUES (19, 10); -- Echinoderm
INSERT INTO animal_habitats VALUES (19, 10); -- Coral reefs
INSERT INTO animal_diets VALUES (19, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (19, 7), (19, 18); -- Venomous, Reef-dwelling
INSERT INTO animal_taxonomies VALUES 
(19, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(19, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Echinodermata'), 'phylum'),
(19, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Echinoidea'), 'class'),
(19, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Valvatida'), 'order'),
(19, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Acanthasteridae'), 'family');

-- Sea Urchin
INSERT INTO animal_categories VALUES (20, 10); -- Echinoderm
INSERT INTO animal_habitats VALUES (20, 8); -- Ocean
INSERT INTO animal_diets VALUES (20, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (20, 16); -- Toxic
INSERT INTO animal_taxonomies VALUES 
(20, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(20, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Echinodermata'), 'phylum'),
(20, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Echinoidea'), 'class');




-- Insertion des 30 nouveaux animaux
INSERT INTO animals (common_name, description, weight_min, weight_max) VALUES
('Red Panda', 'Small arboreal mammal with reddish-brown fur and a long tail', 3, 6),
('Polar Bear', 'Large white bear adapted to Arctic conditions', 350, 700),
('Gorilla', 'Largest living primate with great intelligence', 135, 180),
('Cheetah', 'Fastest land animal with distinctive black tear marks', 21, 72),
('Hippopotamus', 'Large semi-aquatic mammal with thick skin', 1300, 1800),
('Koala', 'Arboreal herbivorous marsupial native to Australia', 4, 15),
('Platypus', 'Egg-laying mammal with a duck-like bill', 0.7, 2.4),
('Kangaroo', 'Marsupial with powerful hind legs for hopping', 35, 90),
('Orangutan', 'Highly intelligent great ape with long arms', 33, 82),
('Rhinoceros', 'Large herbivore with one or two horns on its snout', 800, 2300),
('Panda', 'Bear with distinctive black and white markings', 70, 125),
('Zebra', 'African equids with distinctive black and white stripes', 175, 450),
('Grizzly Bear', 'North American brown bear subspecies', 180, 360),
('Chimpanzee', 'Highly intelligent primate closely related to humans', 40, 70),
('Lemur', 'Primate native to Madagascar with a long tail', 2, 4),
('Meerkat', 'Small mongoose living in underground burrows', 0.6, 0.9),
('Walrus', 'Large flippered marine mammal with tusks', 800, 1700),
('Manatee', 'Large aquatic herbivore sometimes called sea cow', 400, 550),
('Sloth', 'Slow-moving arboreal mammal living in trees', 2.5, 6.5),
('Armadillo', 'Small placental mammal with a leathery armor shell', 2.5, 6.5),
('Flamingo', 'Tall wading bird with pink feathers', 2, 4),
('Peacock', 'Colorful bird known for its extravagant tail feathers', 4, 6),
('Ostrich', 'Largest living bird that cannot fly', 63, 145),
('Toucan', 'Colorful bird with an oversized bill', 0.5, 0.8),
('Albatross', 'Large seabird with the longest wingspan of any bird', 6, 12),
('Chameleon', 'Lizard known for ability to change color', 0.1, 0.2),
('Anaconda', 'One of the largest snakes in the world', 30, 70),
('Pufferfish', 'Fish that inflates when threatened', 1, 2),
('Seahorse', 'Small fish with a horse-like head', 0.01, 0.1),
('Jellyfish', 'Free-swimming marine animal with umbrella-shaped bells', 0.02, 2);


-- Red Panda (ID: 21)
INSERT INTO animal_categories VALUES (21, 1); -- Mammal
INSERT INTO animal_habitats VALUES (21, 1); -- Forests
INSERT INTO animal_diets VALUES (21, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (21, 3), (21, 10); -- Colorful, Terrestrial
INSERT INTO animal_taxonomies VALUES 
(21, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(21, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(21, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(21, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(21, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ailuridae'), 'family');

-- Polar Bear (ID: 22)
INSERT INTO animal_categories VALUES (22, 1); -- Mammal
INSERT INTO animal_habitats VALUES (22, 6); -- Tundra
INSERT INTO animal_diets VALUES (22, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (22, 1), (22, 28); -- Large, Cold-adapted
INSERT INTO animal_taxonomies VALUES 
(22, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(22, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(22, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(22, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(22, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ursidae'), 'family');

-- Gorilla (ID: 23)
INSERT INTO animal_categories VALUES (23, 1); -- Mammal
INSERT INTO animal_habitats VALUES (23, 7); -- Rainforests
INSERT INTO animal_diets VALUES (23, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (23, 1), (23, 9); -- Large, Social
INSERT INTO animal_taxonomies VALUES 
(23, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(23, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(23, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(23, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Primates'), 'order'),
(23, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Hominidae'), 'family');

-- Cheetah (ID: 24)
INSERT INTO animal_categories VALUES (24, 1); -- Mammal
INSERT INTO animal_habitats VALUES (24, 2), (24, 3); -- Grasslands, Savannas
INSERT INTO animal_diets VALUES (24, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (24, 13), (24, 14); -- Apex predator, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(24, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(24, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(24, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(24, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(24, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Felidae'), 'family');

-- Hippopotamus (ID: 25)
INSERT INTO animal_categories VALUES (25, 1); -- Mammal
INSERT INTO animal_habitats VALUES (25, 5), (25, 25); -- Wetlands, Rivers
INSERT INTO animal_diets VALUES (25, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (25, 1), (25, 7); -- Large, Venomous
INSERT INTO animal_taxonomies VALUES 
(25, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(25, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(25, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(25, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Artiodactyla'), 'order'),
(25, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Hippopotamidae'), 'family');

-- Insertion des taxonomies supplémentaires nécessaires
INSERT IGNORE INTO taxonomies (taxonomic_rank, name) VALUES
('family', 'Ailuridae'),
('family', 'Ursidae'),
('family', 'Hominidae'),
('family', 'Hippopotamidae'),
('family', 'Phascolarctidae'),
('family', 'Ornithorhynchidae'),
('family', 'Macropodidae'),
('family', 'Pongidae'),
('family', 'Rhinocerotidae'),
('family', 'Equidae'),
('family', 'Lemuridae'),
('family', 'Herpestidae'),
('family', 'Odobenidae'),
('family', 'Trichechidae'),
('family', 'Bradypodidae'),
('family', 'Dasypodidae'),
('family', 'Phoenicopteridae'),
('family', 'Phasianidae'),
('family', 'Struthionidae'),
('family', 'Ramphastidae'),
('family', 'Diomedeidae'),
('family', 'Chamaeleonidae'),
('family', 'Boidae'),
('family', 'Tetraodontidae'),
('family', 'Syngnathidae'),
('family', 'Cyaneidae'),
('order', 'Primates'),
('order', 'Artiodactyla'),
('order', 'Diprotodontia'),
('order', 'Monotremata'),
('order', 'Struthioniformes'),
('order', 'Phoenicopteriformes'),
('order', 'Galliformes'),
('order', 'Procellariiformes'),
('order', 'Squamata'),
('order', 'Testudines'),
('order', 'Tetraodontiformes'),
('order', 'Syngnathiformes'),
('order', 'Semaeostomeae');


-- Insertion des relations pour les animaux supplementaire 

-- Koala (ID: 26)
INSERT INTO animal_categories VALUES (26, 1); -- Mammal
INSERT INTO animal_habitats VALUES (26, 1); -- Forests
INSERT INTO animal_diets VALUES (26, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (26, 10), (26, 12); -- Terrestrial, Endangered
INSERT INTO animal_taxonomies VALUES 
(26, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(26, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(26, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(26, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Diprotodontia'), 'order'),
(26, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Phascolarctidae'), 'family');

-- Platypus (ID: 27)
INSERT INTO animal_categories VALUES (27, 1); -- Mammal
INSERT INTO animal_habitats VALUES (27, 5), (27, 25); -- Wetlands, Rivers
INSERT INTO animal_diets VALUES (27, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (27, 7), (27, 14); -- Venomous, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(27, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(27, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(27, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(27, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Monotremata'), 'order'),
(27, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ornithorhynchidae'), 'family');

-- Kangaroo (ID: 28)
INSERT INTO animal_categories VALUES (28, 1); -- Mammal
INSERT INTO animal_habitats VALUES (28, 2), (28, 3); -- Grasslands, Savannas
INSERT INTO animal_diets VALUES (28, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (28, 14), (28, 10); -- Unique adaptation, Terrestrial
INSERT INTO animal_taxonomies VALUES 
(28, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(28, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(28, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(28, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Diprotodontia'), 'order'),
(28, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Macropodidae'), 'family');

-- Orangutan (ID: 29)
INSERT INTO animal_categories VALUES (29, 1); -- Mammal
INSERT INTO animal_habitats VALUES (29, 7); -- Rainforests
INSERT INTO animal_diets VALUES (29, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (29, 9), (29, 12); -- Social, Endangered
INSERT INTO animal_taxonomies VALUES 
(29, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(29, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(29, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(29, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Primates'), 'order'),
(29, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Hominidae'), 'family');

-- Rhinoceros (ID: 30)
INSERT INTO animal_categories VALUES (30, 1); -- Mammal
INSERT INTO animal_habitats VALUES (30, 2), (30, 3); -- Grasslands, Savannas
INSERT INTO animal_diets VALUES (30, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (30, 1), (30, 12); -- Large, Endangered
INSERT INTO animal_taxonomies VALUES 
(30, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(30, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(30, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(30, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Perissodactyla'), 'order'),
(30, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Rhinocerotidae'), 'family');

-- Panda (ID: 31)
INSERT INTO animal_categories VALUES (31, 1); -- Mammal
INSERT INTO animal_habitats VALUES (31, 1); -- Forests
INSERT INTO animal_diets VALUES (31, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (31, 3), (31, 12); -- Colorful, Endangered
INSERT INTO animal_taxonomies VALUES 
(31, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(31, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(31, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(31, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(31, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ursidae'), 'family');

-- Zebra (ID: 32)
INSERT INTO animal_categories VALUES (32, 1); -- Mammal
INSERT INTO animal_habitats VALUES (32, 2), (32, 3); -- Grasslands, Savannas
INSERT INTO animal_diets VALUES (32, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (32, 3), (32, 9); -- Colorful, Social
INSERT INTO animal_taxonomies VALUES 
(32, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(32, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(32, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(32, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Perissodactyla'), 'order'),
(32, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Equidae'), 'family');

-- Grizzly Bear (ID: 33)
INSERT INTO animal_categories VALUES (33, 1); -- Mammal
INSERT INTO animal_habitats VALUES (33, 1), (33, 29); -- Forests, Woodlands
INSERT INTO animal_diets VALUES (33, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (33, 1), (33, 13); -- Large, Apex predator
INSERT INTO animal_taxonomies VALUES 
(33, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(33, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(33, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(33, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(33, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ursidae'), 'family');

-- Chimpanzee (ID: 34)
INSERT INTO animal_categories VALUES (34, 1); -- Mammal
INSERT INTO animal_habitats VALUES (34, 7), (34, 1); -- Rainforests, Forests
INSERT INTO animal_diets VALUES (34, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (34, 9), (34, 14); -- Social, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(34, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(34, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(34, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(34, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Primates'), 'order'),
(34, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Hominidae'), 'family');

-- Lemur (ID: 35)
INSERT INTO animal_categories VALUES (35, 1); -- Mammal
INSERT INTO animal_habitats VALUES (35, 7), (35, 1); -- Rainforests, Forests
INSERT INTO animal_diets VALUES (35, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (35, 3), (35, 14); -- Colorful, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(35, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(35, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(35, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(35, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Primates'), 'order'),
(35, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Lemuridae'), 'family');

-- Meerkat (ID: 36)
INSERT INTO animal_categories VALUES (36, 1); -- Mammal
INSERT INTO animal_habitats VALUES (36, 2), (36, 4); -- Grasslands, Desert
INSERT INTO animal_diets VALUES (36, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (36, 9), (36, 10); -- Social, Terrestrial
INSERT INTO animal_taxonomies VALUES 
(36, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(36, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(36, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(36, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(36, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Herpestidae'), 'family');

-- Walrus (ID: 37)
INSERT INTO animal_categories VALUES (37, 1); -- Mammal
INSERT INTO animal_habitats VALUES (37, 8), (37, 6); -- Ocean, Coastlines
INSERT INTO animal_diets VALUES (37, 5); -- Piscivore
INSERT INTO animal_characteristics VALUES (37, 1), (37, 9); -- Large, Social
INSERT INTO animal_taxonomies VALUES 
(37, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(37, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(37, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(37, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Carnivora'), 'order'),
(37, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Odobenidae'), 'family');

-- Manatee (ID: 38)
INSERT INTO animal_categories VALUES (38, 1); -- Mammal
INSERT INTO animal_habitats VALUES (38, 8), (38, 5); -- Ocean, Wetlands
INSERT INTO animal_diets VALUES (38, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (38, 1), (38, 12); -- Large, Endangered
INSERT INTO animal_taxonomies VALUES 
(38, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(38, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(38, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(38, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Sirenia'), 'order'),
(38, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Trichechidae'), 'family');

-- Sloth (ID: 39)
INSERT INTO animal_categories VALUES (39, 1); -- Mammal
INSERT INTO animal_habitats VALUES (39, 7); -- Rainforests
INSERT INTO animal_diets VALUES (39, 1); -- Herbivore
INSERT INTO animal_characteristics VALUES (39, 14), (39, 10); -- Unique adaptation, Terrestrial
INSERT INTO animal_taxonomies VALUES 
(39, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(39, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(39, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(39, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Pilosa'), 'order'),
(39, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Bradypodidae'), 'family');

-- Armadillo (ID: 40)
INSERT INTO animal_categories VALUES (40, 1); -- Mammal
INSERT INTO animal_habitats VALUES (40, 2), (40, 4); -- Grasslands, Desert
INSERT INTO animal_diets VALUES (40, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (40, 14), (40, 10); -- Unique adaptation, Terrestrial
INSERT INTO animal_taxonomies VALUES 
(40, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(40, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(40, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Mammalia'), 'class'),
(40, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Cingulata'), 'order'),
(40, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Dasypodidae'), 'family');

-- Flamingo (ID: 41)
INSERT INTO animal_categories VALUES (41, 2); -- Bird
INSERT INTO animal_habitats VALUES (41, 5), (41, 27); -- Wetlands, Freshwater lakes
INSERT INTO animal_diets VALUES (41, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (41, 3), (41, 9); -- Colorful, Social
INSERT INTO animal_taxonomies VALUES 
(41, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(41, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(41, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(41, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Phoenicopteriformes'), 'order'),
(41, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Phoenicopteridae'), 'family');

-- Peacock (ID: 42)
INSERT INTO animal_categories VALUES (42, 2); -- Bird
INSERT INTO animal_habitats VALUES (42, 1), (42, 29); -- Forests, Woodlands
INSERT INTO animal_diets VALUES (42, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (42, 3), (42, 14); -- Colorful, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(42, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(42, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(42, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(42, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Galliformes'), 'order'),
(42, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Phasianidae'), 'family');

-- Ostrich (ID: 43)
INSERT INTO animal_categories VALUES (43, 2); -- Bird
INSERT INTO animal_habitats VALUES (43, 2), (43, 3); -- Grasslands, Savannas
INSERT INTO animal_diets VALUES (43, 3); -- Omnivore
INSERT INTO animal_characteristics VALUES (43, 1), (43, 14); -- Large, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(43, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(43, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(43, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(43, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Struthioniformes'), 'order'),
(43, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Struthionidae'), 'family');

-- Toucan (ID: 44)
INSERT INTO animal_categories VALUES (44, 2); -- Bird
INSERT INTO animal_habitats VALUES (44, 7); -- Rainforests
INSERT INTO animal_diets VALUES (44, 6); -- Frugivore
INSERT INTO animal_characteristics VALUES (44, 3), (44, 14); -- Colorful, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(44, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(44, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(44, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(44, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Piciformes'), 'order'),
(44, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Ramphastidae'), 'family');

-- Albatross (ID: 45)
INSERT INTO animal_categories VALUES (45, 2); -- Bird
INSERT INTO animal_habitats VALUES (45, 8); -- Ocean
INSERT INTO animal_diets VALUES (45, 5); -- Piscivore
INSERT INTO animal_characteristics VALUES (45, 11), (45, 14); -- Migratory, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(45, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(45, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(45, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Aves'), 'class'),
(45, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Procellariiformes'), 'order'),
(45, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Diomedeidae'), 'family');

-- Chameleon (ID: 46)
INSERT INTO animal_categories VALUES (46, 3); -- Reptile
INSERT INTO animal_habitats VALUES (46, 7), (46, 1); -- Rainforests, Forests
INSERT INTO animal_diets VALUES (46, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (46, 3), (46, 14); -- Colorful, Unique adaptation
INSERT INTO animal_taxonomies VALUES 
(46, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(46, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(46, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Reptilia'), 'class'),
(46, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Squamata'), 'order'),
(46, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Chamaeleonidae'), 'family');

-- Anaconda (ID: 47)
INSERT INTO animal_categories VALUES (47, 3); -- Reptile
INSERT INTO animal_habitats VALUES (47, 7), (47, 5); -- Rainforests, Wetlands
INSERT INTO animal_diets VALUES (47, 2); -- Carnivore
INSERT INTO animal_characteristics VALUES (47, 1), (47, 13); -- Large, Apex predator
INSERT INTO animal_taxonomies VALUES 
(47, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(47, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(47, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Reptilia'), 'class'),
(47, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Squamata'), 'order'),
(47, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Boidae'), 'family');

-- Pufferfish (ID: 48)
INSERT INTO animal_categories VALUES (48, 5); -- Fish
INSERT INTO animal_habitats VALUES (48, 8), (48, 10); -- Ocean, Coral reefs
INSERT INTO animal_diets VALUES (48, 5); -- Piscivore
INSERT INTO animal_characteristics VALUES (48, 7), (48, 16); -- Venomous, Toxic
INSERT INTO animal_taxonomies VALUES 
(48, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(48, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(48, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Actinopterygii'), 'class'),
(48, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Tetraodontiformes'), 'order'),
(48, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Tetraodontidae'), 'family');

-- Seahorse (ID: 49)
INSERT INTO animal_categories VALUES (49, 5); -- Fish
INSERT INTO animal_habitats VALUES (49, 8), (49, 10); -- Ocean, Coral reefs
INSERT INTO animal_diets VALUES (49, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (49, 14), (49, 18); -- Unique adaptation, Reef-dwelling
INSERT INTO animal_taxonomies VALUES 
(49, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(49, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Chordata'), 'phylum'),
(49, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Actinopterygii'), 'class'),
(49, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Syngnathiformes'), 'order'),
(49, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'family' AND name = 'Syngnathidae'), 'family');

-- Jellyfish (ID: 50)
INSERT INTO animal_categories VALUES (50, 11); -- Other (no specific category)
INSERT INTO animal_habitats VALUES (50, 8); -- Ocean
INSERT INTO animal_diets VALUES (50, 4); -- Insectivore
INSERT INTO animal_characteristics VALUES (50, 7), (50, 16); -- Venomous, Toxic
INSERT INTO animal_taxonomies VALUES 
(50, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'kingdom' AND name = 'Animalia'), 'kingdom'),
(50, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'phylum' AND name = 'Cnidaria'), 'phylum'),
(50, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'class' AND name = 'Scyphozoa'), 'class'),
(50, (SELECT taxonomy_id FROM taxonomies WHERE taxonomic_rank = 'order' AND name = 'Semaeostomeae'), 'order');

-- Insertion des taxonomies supplémentaires nécessaires
INSERT IGNORE INTO taxonomies (taxonomic_rank, name) VALUES
('phylum', 'Cnidaria'),
('class', 'Scyphozoa'),
('order', 'Sirenia'),
('order', 'Pilosa'),
('order', 'Cingulata'),
('order', 'Piciformes'),
('family', 'Cyaneidae');