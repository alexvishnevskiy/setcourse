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
  title VARCHAR(15) NOT NULL,
  co_reqs VARCHAR(20) NULL,
  name VARCHAR(100) NOT NULL,
  units INT NOT NULL,
  PRIMARY KEY (c_id)
);

CREATE TABLE IF NOT EXISTS classes (
  cl_id INT NOT NULL AUTO_INCREMENT,
  time VARCHAR(50) NOT NULL,
  term ENUM('Fall', 'Winter', 'Spring', 'Summer') NOT NULL,
  days VARCHAR(5) NOT NULL,
  description VARCHAR(150) NULL,
  location VARCHAR(15) NULL,
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
INSERT  INTO user (first_name, last_name) VALUES ('Alice', 'Smith');
INSERT  INTO user (first_name, last_name) VALUES ('Bob', 'Johnson');

-- Schedule 
INSERT  INTO schedule (user_id, term) VALUES (1, 'Winter');
INSERT  INTO schedule (user_id, term) VALUES (1, 'Fall');
INSERT  INTO schedule (user_id, term) VALUES (2, 'Fall');

-- Course
INSERT  INTO course (title, co_reqs, name, units) VALUES ('CSCI 180', 'CSCI 180 L', 'Management of software', 5);
INSERT  INTO course (title, co_reqs, name, units) VALUES ('SOCI 143', 'SOCI 143 L', 'Sociology', 5);

-- Classes
INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('14:00 - 15:30', 'Fall', 'M/W/F', 'Class A ...', 'O Connor 207', 1);
INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('10:00 - 11:30', 'Fall', 'T/TH', 'Class B ...', 'O Connor 208', 1);
INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('10:00 - 11:30', 'Fall', 'M/F', 'Class C ...', 'O Connor 209', 2);
INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('10:00 - 11:30', 'Fall', 'M/W/F', 'Class D ...', 'O Connor 210', 2);

-- Professors
INSERT  INTO professors (first_name, last_name) VALUES ('John', 'Doe');
INSERT  INTO professors (first_name, last_name) VALUES ('Alex', 'White');
INSERT  INTO professors (first_name, last_name) VALUES ('Roze', 'Ding');

-- Reviews
INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 1, 'Great class!', 1);
INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 2, 'Very informative and engaging.', 2);
INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (2, 1, 'I learned a lot from this course.', 1);
 
-- Teach
INSERT INTO teach (pr_id, cl_id) VALUES (1, 1);
INSERT INTO teach (pr_id, cl_id) VALUES (1, 3);
INSERT INTO teach (pr_id, cl_id) VALUES (2, 2);
INSERT INTO teach (pr_id, cl_id) VALUES (3, 3);

-- Schedule2class
INSERT INTO schedule2class(cl_id, sch_id) VALUES (1, 1);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (2, 1);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (3, 1);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (4, 2);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (3, 2);