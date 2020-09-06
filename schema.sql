
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