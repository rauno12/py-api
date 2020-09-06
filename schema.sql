
CREATE DATABASE api COLLATE = 'utf8_general_ci';

CREATE USER 'apiuser'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON api.* TO apiuser@localhost;

FLUSH PRIVILEGES;

DROP TABLE IF EXISTS sector;
CREATE TABLE sector (
    id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    parent_id INT(11) UNSIGNED,
    name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS submission;
CREATE TABLE submission (
    id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    session_id varchar(255) UNIQUE,
    username varchar(255) NOT NULL,
    is_agree_of_terms BOOLEAN NOT NULL
);

DROP TABLE IF EXISTS submission_sector;
CREATE TABLE submission_sector (
    submission_id INT(11) UNSIGNED NOT NULL,
    sector_id INT(11) UNSIGNED NOT NULL,
    PRIMARY KEY (submission_id, sector_id),
    FOREIGN KEY (submission_id) REFERENCES submission(id),
    FOREIGN KEY (sector_id) REFERENCES sector(id)
);

# Migrate sectors
INSERT INTO sector (id, parent_id, name) VALUES (1, null, 'Manufacturing');
INSERT INTO sector (id, parent_id, name) VALUES (2, 1, 'Construction materials');
INSERT INTO sector (id, parent_id, name) VALUES (3, 1, 'Electronics and Optics');
INSERT INTO sector (id, parent_id, name) VALUES (4, 1, 'Food and Beverage');
INSERT INTO sector (id, parent_id, name) VALUES (5, 4, 'Bakery & confectionery products');
INSERT INTO sector (id, parent_id, name) VALUES (6, 4, 'Beverages');
INSERT INTO sector (id, parent_id, name) VALUES (7, 4, 'Fish & fish products');
INSERT INTO sector (id, parent_id, name) VALUES (8, 4, 'Meat & meat products');
INSERT INTO sector (id, parent_id, name) VALUES (9, 4, 'Milk & dairy products');
INSERT INTO sector (id, parent_id, name) VALUES (10, 4, 'Other');
INSERT INTO sector (id, parent_id, name) VALUES (11, 4, 'Sweets & snack food');
INSERT INTO sector (id, parent_id, name) VALUES (12, 1, 'Furniture');
INSERT INTO sector (id, parent_id, name) VALUES (13, 12, 'Bathroom/sauna');
INSERT INTO sector (id, parent_id, name) VALUES (14, 12, 'Bedroom');
INSERT INTO sector (id, parent_id, name) VALUES (15, 12, 'Children’s room');
INSERT INTO sector (id, parent_id, name) VALUES (16, 12, 'Kitchen');
INSERT INTO sector (id, parent_id, name) VALUES (17, 12, 'Living room');
INSERT INTO sector (id, parent_id, name) VALUES (18, 12, 'Office');
INSERT INTO sector (id, parent_id, name) VALUES (19, 12, 'Other (Furniture)');
INSERT INTO sector (id, parent_id, name) VALUES (20, 12, 'Outdoor');
INSERT INTO sector (id, parent_id, name) VALUES (21, 12, 'Project furniture');
INSERT INTO sector (id, parent_id, name) VALUES (22, 1, 'Machinery');
INSERT INTO sector (id, parent_id, name) VALUES (23, 22, 'Machinery components');
INSERT INTO sector (id, parent_id, name) VALUES (24, 22, 'Machinery equipment/tools');
INSERT INTO sector (id, parent_id, name) VALUES (25, 22, 'Manufacture of machinery');
INSERT INTO sector (id, parent_id, name) VALUES (26, 22, 'Maritime');
INSERT INTO sector (id, parent_id, name) VALUES (27, 26, 'Aluminium and steel workboats');
INSERT INTO sector (id, parent_id, name) VALUES (28, 26, 'Boat/Yacht building');
INSERT INTO sector (id, parent_id, name) VALUES (29, 26, 'Ship repair and conversion');
INSERT INTO sector (id, parent_id, name) VALUES (30, 22, 'Metal structures');
INSERT INTO sector (id, parent_id, name) VALUES (31, 22, 'Other');
INSERT INTO sector (id, parent_id, name) VALUES (32, 22, 'Repair and maintenance service');
INSERT INTO sector (id, parent_id, name) VALUES (33, 1, 'Metalworking');
INSERT INTO sector (id, parent_id, name) VALUES (34, 33, 'Construction of metal structures');
INSERT INTO sector (id, parent_id, name) VALUES (35, 33, 'Houses and buildings');
INSERT INTO sector (id, parent_id, name) VALUES (36, 33, 'Metal products');
INSERT INTO sector (id, parent_id, name) VALUES (37, 33, 'Metal works');
INSERT INTO sector (id, parent_id, name) VALUES (38, 37, 'CNC-machining');
INSERT INTO sector (id, parent_id, name) VALUES (39, 37, 'Forgings, Fasteners');
INSERT INTO sector (id, parent_id, name) VALUES (40, 37, 'Gas, Plasma, Laser cutting');
INSERT INTO sector (id, parent_id, name) VALUES (41, 37, 'MIG, TIG, Aluminum welding');
INSERT INTO sector (id, parent_id, name) VALUES (42, 1, 'Plastic and Rubber');
INSERT INTO sector (id, parent_id, name) VALUES (43, 42, 'Packaging');
INSERT INTO sector (id, parent_id, name) VALUES (44, 42, 'Plastic goods');
INSERT INTO sector (id, parent_id, name) VALUES (45, 42, 'Plastic processing technology');
INSERT INTO sector (id, parent_id, name) VALUES (46, 45, 'Blowing');
INSERT INTO sector (id, parent_id, name) VALUES (47, 45, 'Moulding');
INSERT INTO sector (id, parent_id, name) VALUES (48, 45, 'Plastics welding and processing');
INSERT INTO sector (id, parent_id, name) VALUES (49, 42, 'Plastic profiles');
INSERT INTO sector (id, parent_id, name) VALUES (50, 1, 'Printing');
INSERT INTO sector (id, parent_id, name) VALUES (51, 50, 'Advertising');
INSERT INTO sector (id, parent_id, name) VALUES (52, 50, 'Book/Periodicals printing');
INSERT INTO sector (id, parent_id, name) VALUES (53, 50, 'Labelling and packaging printing');
INSERT INTO sector (id, parent_id, name) VALUES (54, 1, 'Textile and Clothing');
INSERT INTO sector (id, parent_id, name) VALUES (55, 54, 'Clothing');
INSERT INTO sector (id, parent_id, name) VALUES (56, 54, 'Textile');
INSERT INTO sector (id, parent_id, name) VALUES (57, 1, 'Wood');
INSERT INTO sector (id, parent_id, name) VALUES (58, 57, 'Other (Wood)');
INSERT INTO sector (id, parent_id, name) VALUES (59, 57, 'Wooden building materials');
INSERT INTO sector (id, parent_id, name) VALUES (60, 57, 'Wooden houses');
INSERT INTO sector (id, parent_id, name) VALUES (61, null, 'Other');
INSERT INTO sector (id, parent_id, name) VALUES (62, 61, 'Creative industries');
INSERT INTO sector (id, parent_id, name) VALUES (63, 61, 'Energy technology');
INSERT INTO sector (id, parent_id, name) VALUES (64, 61, 'Environment');
INSERT INTO sector (id, parent_id, name) VALUES (65, null, 'Service');
INSERT INTO sector (id, parent_id, name) VALUES (66, 65, 'Business services');
INSERT INTO sector (id, parent_id, name) VALUES (67, 65, 'Engineering');
INSERT INTO sector (id, parent_id, name) VALUES (68, 65, 'Information Technology and Telecommunications');
INSERT INTO sector (id, parent_id, name) VALUES (69, 68, 'Data processing, Web portals, E-marketing');
INSERT INTO sector (id, parent_id, name) VALUES (70, 68, 'Programming, Consultancy');
INSERT INTO sector (id, parent_id, name) VALUES (71, 68, 'Software, Hardware');
INSERT INTO sector (id, parent_id, name) VALUES (72, 68, 'Telecommunications');
INSERT INTO sector (id, parent_id, name) VALUES (73, 65, 'Tourism');
INSERT INTO sector (id, parent_id, name) VALUES (74, 65, 'Translation services');
INSERT INTO sector (id, parent_id, name) VALUES (75, 65, 'Transport and Logistics');
INSERT INTO sector (id, parent_id, name) VALUES (76, 75, 'Air');
INSERT INTO sector (id, parent_id, name) VALUES (77, 75, 'Rail');
INSERT INTO sector (id, parent_id, name) VALUES (78, 75, 'Road');
INSERT INTO sector (id, parent_id, name) VALUES (79, 75, 'Water');
COMMIT;

# Update primary key auto increment value after migration
ALTER TABLE sector AUTO_INCREMENT = 80;
