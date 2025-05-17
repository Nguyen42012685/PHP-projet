CREATE DATABASE IF NOT EXISTS zooriddle;
USE zooriddle;

-- Taxonomic hierarchy tables (for better normalization)
CREATE TABLE kingdoms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE phyla (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    kingdom_id INT,
    FOREIGN KEY (kingdom_id) REFERENCES kingdoms(id)
);

CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    phylum_id INT,
    FOREIGN KEY (phylum_id) REFERENCES phyla(id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

CREATE TABLE families (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Conservation status table
CREATE TABLE conservation_statuses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(10),
    description TEXT
);

-- Animal types table (now linked to classes)
CREATE TABLE animal_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- Regions table (for habitats)
CREATE TABLE regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    continent VARCHAR(50)
);

-- Habitats table (now linked to regions)
CREATE TABLE habitats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(id)
);

-- Animals table (now with proper foreign keys)
CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100),
    weight VARCHAR(50),
    description TEXT,
    image_path VARCHAR(255),
    type_id INT,
    difficulty ENUM('easy', 'medium', 'hard') DEFAULT 'medium',
    family_id INT,
    conservation_status_id INT,
    FOREIGN KEY (type_id) REFERENCES animal_types(id),
    FOREIGN KEY (family_id) REFERENCES families(id),
    FOREIGN KEY (conservation_status_id) REFERENCES conservation_statuses(id)
);

-- Animal habitats junction table (unchanged but now with better references)
CREATE TABLE animal_habitats (
    animal_id INT,
    habitat_id INT,
    PRIMARY KEY (animal_id, habitat_id),
    FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE,
    FOREIGN KEY (habitat_id) REFERENCES habitats(id) ON DELETE CASCADE
);

-- Insert taxonomic hierarchy data
INSERT INTO kingdoms (name, description) VALUES
('Animalia', 'Multicellular eukaryotic organisms that form the biological kingdom Animalia');

INSERT INTO phyla (name, description, kingdom_id) VALUES
('Chordata', 'Animals possessing a notochord at some stage of development', 1),
('Arthropoda', 'Invertebrate animals with an exoskeleton and segmented body', 1),
('Mollusca', 'Soft-bodied invertebrates, often with shells', 1),
('Echinodermata', 'Marine animals with radial symmetry', 1);

INSERT INTO classes (name, description, phylum_id) VALUES
-- Chordata classes
('Mammalia', 'Mammals - warm-blooded vertebrates with hair/fur', 1),
('Aves', 'Birds - feathered, winged vertebrates', 1),
('Reptilia', 'Reptiles - cold-blooded scaly vertebrates', 1),
('Amphibia', 'Amphibians - live both in water and on land', 1),
('Chondrichthyes', 'Cartilaginous fishes like sharks and rays', 1),
('Actinopterygii', 'Ray-finned fishes', 1),
-- Arthropoda classes
('Insecta', 'Insects - six-legged invertebrates', 2),
('Arachnida', 'Arachnids - eight-legged invertebrates', 2),
('Malacostraca', 'Crustaceans like crabs and shrimp', 2),
-- Mollusca classes
('Cephalopoda', 'Cephalopods like octopus and squid', 3),
-- Echinodermata classes
('Echinoidea', 'Sea urchins and sand dollars', 4),
('Asteroidea', 'Starfish', 4);

INSERT INTO orders (name, description, class_id) VALUES
-- Mammal orders
('Proboscidea', 'Elephants and relatives', 1),
('Carnivora', 'Carnivorous mammals', 1),
-- Bird orders
('Accipitriformes', 'Birds of prey', 2),
('Sphenisciformes', 'Penguins', 2),
-- Reptile orders
('Crocodilia', 'Crocodiles and alligators', 3),
('Squamata', 'Lizards and snakes', 3),
-- Amphibian orders
('Urodela', 'Salamanders and newts', 4),
('Anura', 'Frogs and toads', 4),
-- Fish orders
('Lamniformes', 'Mackerel sharks', 5),
('Perciformes', 'Perch-like fishes', 6),
-- Insect orders
('Lepidoptera', 'Butterflies and moths', 7),
('Coleoptera', 'Beetles', 7),
-- Arachnid orders
('Araneae', 'Spiders', 8),
-- Crustacean orders
('Decapoda', 'Crabs, lobsters, shrimp', 9),
('Stomatopoda', 'Mantis shrimp', 9),
-- Cephalopod orders
('Oegopsida', 'Deep-sea squids', 10),
('Octopoda', 'Octopuses', 10),
-- Echinoderm orders
('Valvatida', 'Starfish order', 12);

INSERT INTO families (name, description, order_id) VALUES
-- Mammal families
('Elephantidae', 'Elephants', 1),
('Felidae', 'Cats', 2),
-- Bird families
('Accipitridae', 'Hawks, eagles, kites', 3),
('Spheniscidae', 'Penguins', 4),
-- Reptile families
('Crocodylidae', 'Crocodiles', 5),
('Varanidae', 'Monitor lizards', 6),
-- Amphibian families
('Ambystomatidae', 'Mole salamanders', 7),
('Dendrobatidae', 'Poison dart frogs', 8),
-- Fish families
('Lamnidae', 'Mackerel sharks', 9),
('Pomacentridae', 'Damselfishes', 10),
-- Insect families
('Nymphalidae', 'Brush-footed butterflies', 11),
('Scarabaeidae', 'Scarab beetles', 12),
-- Arachnid families
('Theraphosidae', 'Tarantulas', 13),
('Theridiidae', 'Cobweb spiders', 13),
-- Crustacean families
('Inachidae', 'Spider crabs', 14),
-- Cephalopod families
('Architeuthidae', 'Giant squids', 16),
('Octopodidae', 'Octopuses', 17),
-- Echinoderm families
('Acanthasteridae', 'Crown-of-thorns starfish', 18);

-- Insert conservation statuses
INSERT INTO conservation_statuses (status, abbreviation, description) VALUES
('Least Concern', 'LC', 'Widespread and abundant'),
('Near Threatened', 'NT', 'Close to qualifying for threatened'),
('Vulnerable', 'VU', 'High risk of endangerment in the wild'),
('Endangered', 'EN', 'High risk of extinction in the wild'),
('Critically Endangered', 'CR', 'Extremely high risk of extinction'),
('Not Evaluated', 'NE', 'Not yet assessed');

-- Insert regions
INSERT INTO regions (name, description, continent) VALUES
('Africa', 'African continent', 'Africa'),
('Asia', 'Asian continent', 'Asia'),
('North America', 'North American continent', 'North America'),
('Antarctica', 'Antarctic continent', 'Antarctica'),
('Australia/Asia', 'Australia and Southeast Asia', 'Australia/Asia'),
('Central/South America', 'Central and South America', 'South America'),
('Mexico', 'Country in North America', 'North America'),
('Global', 'Worldwide distribution', 'Global'),
('Pacific Ocean', 'Pacific Ocean region', 'Ocean'),
('Pacific/Indian Oceans', 'Pacific and Indian Oceans', 'Ocean');

-- Insert habitats
INSERT INTO habitats (name, description, region_id) VALUES
('Grasslands', 'Open areas dominated by grasses', 1),
('Savannas', 'Mixed woodland-grassland ecosystems', 1),
('Forests', 'Dense collections of trees', 2),
('Mangroves', 'Coastal saline or brackish water habitats', 2),
('Wetlands', 'Land areas saturated with water', 3),
('Coastlines', 'Where land meets the sea', 3),
('Antarctic ice', 'Polar ice sheets', 4),
('Estuaries', 'Where rivers meet the sea', 5),
('Rivers', 'Natural flowing watercourses', 5),
('Dry forests', 'Forests in seasonal tropical climates', 2),
('Rainforests', 'Dense, moist forests with high rainfall', 6),
('Freshwater lakes', 'Inland bodies of fresh water', 7),
('Open oceans', 'Vast deep sea areas', 8),
('Coral reefs', 'Underwater ecosystems of coral', 8),
('Woodlands', 'Areas with scattered trees', 3),
('Urban areas', 'Human settlements', 8),
('Deep-sea floors', 'Ocean depths below 200m', 9),
('Tide pools', 'Rocky pools filled with seawater', 10),
('Ocean floors', 'The bottom of marine environments', 8);

-- Insert animal types
INSERT INTO animal_types (name, description, class_id) VALUES
('Mammal', 'Warm-blooded vertebrates with hair/fur and mammary glands', 1),
('Bird', 'Feathered, winged, egg-laying vertebrates', 2),
('Reptile', 'Cold-blooded vertebrates with scaly skin', 3),
('Amphibian', 'Cold-blooded vertebrates that live both in water and on land', 4),
('Fish', 'Aquatic vertebrates with gills and fins', 6), -- Using Actinopterygii for fish
('Shark', 'Cartilaginous fish', 5),
('Insect', 'Invertebrates with six legs and three body segments', 7),
('Arachnid', 'Invertebrates with eight legs and two body segments', 8),
('Crustacean', 'Aquatic invertebrates with hard exoskeletons', 9),
('Mollusk', 'Soft-bodied invertebrates, often with shells', 10),
('Echinoderm', 'Marine invertebrates with radial symmetry', 11);

-- Insert animals with proper foreign keys
INSERT INTO animals (name, scientific_name, weight, description, image_path, type_id, difficulty, family_id, conservation_status_id) VALUES
('African Elephant', 'Loxodonta africana', '4,500-6,800 kg', 'The largest land animal, known for its large ears, long trunk, and tusks', 'images/elephant.jpg', 1, 'easy', 1, 3),
('Tiger', 'Panthera tigris', '90-310 kg', 'A large carnivorous cat with orange fur and black stripes', 'images/tiger.jpg', 1, 'easy', 2, 4),
('Bald Eagle', 'Haliaeetus leucocephalus', '3-6.3 kg', 'A bird of prey with a white head and brown body', 'images/eagle.jpg', 2, 'medium', 3, 1),
('Emperor Penguin', 'Aptenodytes forsteri', '22-45 kg', 'The largest penguin species, known for its black and white plumage', 'images/penguin.jpg', 2, 'medium', 4, 2),
('Saltwater Crocodile', 'Crocodylus porosus', '400-1,000 kg', 'The largest reptile, an apex predator', 'images/crocodile.jpg', 3, 'hard', 5, 1),
('Komodo Dragon', 'Varanus komodoensis', '70-90 kg', 'The largest lizard, native to Indonesia', 'images/komodo.jpg', 3, 'hard', 6, 4),
('Axolotl', 'Ambystoma mexicanum', '60-200 g', 'A unique salamander that remains aquatic for life', 'images/axolotl.jpg', 4, 'hard', 7, 5),
('Poison Dart Frog', 'Dendrobates spp.', '1-30 g', 'Small, colorful frogs with toxic skin', 'images/frog.jpg', 4, 'medium', 8, 6),
('Great White Shark', 'Carcharodon carcharias', '680-1,100 kg', 'A large predatory shark', 'images/shark.jpg', 6, 'medium', 9, 3),
('Clownfish', 'Amphiprioninae', '250-400 g', 'A small reef fish that forms symbiotic relationships with sea anemones', 'images/clownfish.jpg', 5, 'easy', 10, 1),
('Monarch Butterfly', 'Danaus plexippus', '0.25-0.75 g', 'A migratory butterfly with orange and black wings', 'images/butterfly.jpg', 7, 'easy', 11, 2),
('Goliath Beetle', 'Goliathus spp.', '50-100 g', 'One of the heaviest insects', 'images/beetle.jpg', 7, 'medium', 12, 6),
('Goliath Birdeater', 'Theraphosa blondi', '170-200 g', 'The world\'s largest tarantula', 'images/tarantula.jpg', 8, 'hard', 13, 6),
('Black Widow Spider', 'Latrodectus mactans', '1 g', 'A venomous spider known for its red hourglass marking', 'images/spider.jpg', 8, 'medium', 14, 6),
('Japanese Spider Crab', 'Macrocheira kaempferi', '19 kg', 'The largest arthropod', 'images/crab.jpg', 9, 'hard', 15, 6),
('Mantis Shrimp', 'Stomatopoda', '1-10 g', 'Known for its powerful punch and complex vision', 'images/shrimp.jpg', 9, 'hard', 16, 6),
('Giant Squid', 'Architeuthis dux', '100-275 kg', 'A deep-sea creature with large eyes', 'images/squid.jpg', 10, 'hard', 17, 1),
('Blue-Ringed Octopus', 'Hapalochlaena spp.', '26 g', 'A highly venomous small octopus', 'images/octopus.jpg', 10, 'hard', 18, 1),
('Crown-of-Thorns Starfish', 'Acanthaster planci', '0.5-3 kg', 'A venomous starfish affecting coral reefs', 'images/starfish.jpg', 11, 'medium', 19, 6),
('Sea Urchin', 'Echinoidea', '50-400 g', 'A spiny sea creature', 'images/urchin.jpg', 11, 'medium', NULL, 6);

-- Link animals to habitats
INSERT INTO animal_habitats (animal_id, habitat_id) VALUES
(1,1),(1,2),  -- African Elephant
(2,3),(2,4),  -- Tiger
(3,5),(3,6),  -- Bald Eagle
(4,7),        -- Emperor Penguin
(5,8),(5,9),  -- Saltwater Crocodile
(6,10),       -- Komodo Dragon
(7,11),(7,12), -- Axolotl
(8,11),       -- Poison Dart Frog
(9,13),(9,6), -- Great White Shark
(10,14),      -- Clownfish
(11,1),(11,3),(11,5), -- Monarch Butterfly
(12,11),      -- Goliath Beetle
(13,11),      -- Goliath Birdeater
(14,15),(14,16), -- Black Widow Spider
(15,17),      -- Japanese Spider Crab
(16,14),      -- Mantis Shrimp
(17,13),(17,17), -- Giant Squid
(18,14),(18,18), -- Blue-Ringed Octopus
(19,14),      -- Crown-of-Thorns Starfish
(20,19);      -- Sea Urchin