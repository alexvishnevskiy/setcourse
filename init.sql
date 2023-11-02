CREATE DATABASE IF NOT EXISTS setcourse;
USE setcourse;

CREATE TABLE IF NOT EXISTS user (
  user_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS schedule (
  sch_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  term ENUM('Fall', 'Winter', 'Spring', 'Summer') NOT NULL,
  PRIMARY KEY (sch_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS course (
  c_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (c_id)
);

CREATE TABLE IF NOT EXISTS classes (
  cl_id INT NOT NULL AUTO_INCREMENT,
  time VARCHAR(50) NOT NULL,
  term ENUM('Fall', 'Winter', 'Spring', 'Summer') NOT NULL,
  c_id INT NOT NULL,
  PRIMARY KEY (cl_id),
  FOREIGN KEY (c_id) REFERENCES course(c_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS professors (
  pr_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (pr_id)
);

CREATE TABLE IF NOT EXISTS reviews (
  pr_id INT NOT NULL,
  cl_id INT NOT NULL,
  review TEXT NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (pr_id, cl_id),
  FOREIGN KEY (pr_id) REFERENCES professors(pr_id),
  FOREIGN KEY (cl_id) REFERENCES classes(cl_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE IF NOT EXISTS teach (
  pr_id INT NOT NULL,
  cl_id INT NOT NULL,
  PRIMARY KEY (pr_id, cl_id),
  FOREIGN KEY (pr_id) REFERENCES professors(pr_id) ON DELETE CASCADE,
  FOREIGN KEY (cl_id) REFERENCES classes(cl_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS schedule2class (
  cl_id INT NOT NULL,
  sch_id INT NOT NULL,
  PRIMARY KEY (cl_id, sch_id),
  FOREIGN KEY (cl_id) REFERENCES classes(cl_id) ON DELETE CASCADE,
  FOREIGN KEY (sch_id) REFERENCES schedule(sch_id) ON DELETE CASCADE
);

-- User
INSERT IGNORE INTO user (first_name, last_name) VALUES ('Alice', 'Smith') ON DUPLICATE KEY UPDATE term = VALUES(term);;
INSERT IGNORE INTO user (first_name, last_name) VALUES ('Bob', 'Johnson');

-- Schedule 
INSERT IGNORE INTO schedule (user_id, term) VALUES (1, 'Winter');
INSERT IGNORE INTO schedule (user_id, term) VALUES (1, 'Fall');
INSERT IGNORE INTO schedule (user_id, term) VALUES (2, 'Fall');

-- Course
INSERT IGNORE INTO course (name) VALUES ('CSCI 180');
INSERT IGNORE INTO course (name) VALUES ('SOCI 143');

-- Classes
INSERT IGNORE INTO classes (time, term, c_id) VALUES ('10:00 - 11:30', 'Fall', 1);
INSERT IGNORE INTO classes (time, term, c_id) VALUES ('10:00 - 11:30', 'Winter', 1);
INSERT IGNORE INTO classes (time, term, c_id) VALUES ('10:00 - 11:30', 'Spring', 2);
INSERT IGNORE INTO classes (time, term, c_id) VALUES ('10:00 - 11:30', 'Summer', 2);

-- Professors
INSERT IGNORE INTO professors (first_name, last_name) VALUES ('John', 'Doe');
INSERT IGNORE INTO professors (first_name, last_name) VALUES ('Alex', 'White');
INSERT IGNORE INTO professors (first_name, last_name) VALUES ('Roze', 'Ding');

-- Reviews
INSERT IGNORE INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 1, 'Great class!', 1);
INSERT IGNORE INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 2, 'Very informative and engaging.', 2);
INSERT IGNORE INTO reviews (pr_id, cl_id, review, user_id) VALUES (2, 1, 'I learned a lot from this course.', 1);
 
-- Teach
INSERT IGNORE INTO teach (pr_id, cl_id) VALUES (1, 1);
INSERT IGNORE INTO teach (pr_id, cl_id) VALUES (1, 3);
INSERT IGNORE INTO teach (pr_id, cl_id) VALUES (2, 2);
INSERT IGNORE INTO teach (pr_id, cl_id) VALUES (3, 3);

-- Schedule2class
INSERT IGNORE INTO schedule2class(cl_id, sch_id) VALUES (1, 1);
INSERT IGNORE INTO schedule2class(cl_id, sch_id) VALUES (2, 1);
INSERT IGNORE INTO schedule2class(cl_id, sch_id) VALUES (3, 1);
INSERT IGNORE INTO schedule2class(cl_id, sch_id) VALUES (4, 2);
INSERT IGNORE INTO schedule2class(cl_id, sch_id) VALUES (4, );