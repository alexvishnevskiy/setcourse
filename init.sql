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
  core_req VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL,
  units INT NOT NULL,
  PRIMARY KEY (c_id)
);

CREATE TABLE IF NOT EXISTS classes (
  cl_id INT NOT NULL AUTO_INCREMENT,
  time VARCHAR(50) NOT NULL,
  term ENUM('Fall', 'Winter', 'Spring', 'Summer') NOT NULL,
  total_seats INT NOT NULL,
  days VARCHAR(5) NOT NULL,
  description VARCHAR(700) NULL,
  location VARCHAR(100) NULL,
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
INSERT  INTO schedule (user_id, term) VALUES (1, 'Fall');
INSERT  INTO schedule (user_id, term) VALUES (2, 'Fall');

-- Course
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 10', 'N/A', 'sts', 'Introduction to Computer Science', 4);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 60', 'N/A', '', 'Introduction to C++ and Object-Oriented Programming', 4);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 61', 'N/A', '', 'Data Structures', 4);

-- Classes
-- INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 20,  'M/W/F', 'Introduction to computer science, and computer programming in Python. Basic programming structures, conditionals, loops, functions, recursion, arrays. Topics relating to the applications of and social impact of computing, including privacy, artificial intelligence, computation in physics, psychology, and biology. Discussion of cryptography, computation through history, networks, hardware, and basic runtime analysis.', "Rm 205 O'Connor Hall", 1);
-- INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 25, 'M/W/F', 'Introduction to computer science, and computer programming in Python. Basic programming structures, conditionals, loops, functions, recursion, arrays. Topics relating to the applications of and social impact of computing, including privacy, artificial intelligence, computation in physics, psychology, and biology. Discussion of cryptography, computation through history, networks, hardware, and basic runtime analysis.', "Rm 205 O'Connor Hall", 1);

-- INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('16:45 - 17:50', 'Fall', 30, 'M/W/F', 'Basic object-oriented programming techniques using C++: abstract data types and objects; encapsulation. The five phases of software development (specification, design, implementation, analysis, and testing). Memory management and pointers.', "Rm 207 O'Connor Hall", 2);
-- INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 15, 'M/W/F', 'Basic object-oriented programming techniques using C++: abstract data types and objects; encapsulation. The five phases of software development (specification, design, implementation, analysis, and testing). Memory management and pointers.', "Rm 104 Kenna Hall", 2);

-- INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 20, 'M/W/F', 'Specification, implementations, and analysis of basic data structures (stacks, queues, hash tables, binary trees) and their applications in sorting and searching algorithms. Using the Standard Template Library. Runtime Analysis.', "Rm 207 O'Connor Hall", 3);
-- INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 30, 'M/W/F', 'Specification, implementations, and analysis of basic data structures (stacks, queues, hash tables, binary trees) and their applications in sorting and searching algorithms. Using the Standard Template Library. Runtime Analysis.', "Rm 204 O'Connor Hall", 3);

-- Professors
-- INSERT  INTO professors (first_name, last_name) VALUES ('Shiva', 'Houshmand');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Natalie', 'Linnell');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Nicholas', 'Tran');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Smita', 'Ghosh');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Hien', 'Vu');

-- Reviews
-- INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 1, 'Great class!', 1);
-- INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 2, 'Very informative and engaging.', 2);
-- INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (2, 1, 'I learned a lot from this course.', 1);
 
-- Teach
-- INSERT INTO teach (pr_id, cl_id) VALUES (1, 1);
-- INSERT INTO teach (pr_id, cl_id) VALUES (2, 3);
-- INSERT INTO teach (pr_id, cl_id) VALUES (3, 4);
-- INSERT INTO teach (pr_id, cl_id) VALUES (4, 5);
-- INSERT INTO teach (pr_id, cl_id) VALUES (5, 6);


-- Schedule2class
-- INSERT INTO schedule2class(cl_id, sch_id) VALUES (1, 1);
-- INSERT INTO schedule2class(cl_id, sch_id) VALUES (2, 1);
-- INSERT INTO schedule2class(cl_id, sch_id) VALUES (3, 1);
-- INSERT INTO schedule2class(cl_id, sch_id) VALUES (4, 2);
-- INSERT INTO schedule2class(cl_id, sch_id) VALUES (3, 2);

-- START WINTER 2024 CLASSES

INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ACTG 11', 'N/A', '', 'Introduction to Financial Accounting', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 2, 'M/W/F', 'class description', "Rm 207 Lucas Hall", 1);
INSERT  INTO professors (first_name, last_name) VALUES ("Haidan", "Li");
INSERT INTO teach (pr_id, cl_id) VALUES (1, 1);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ACTG 12', 'N/A', '', 'Introduction to Managerial Accounting', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 19, 'M/W/F', 'class description', "Rm 120 Alumni Science Hall", 2);
INSERT  INTO professors (first_name, last_name) VALUES ("Stephen", "Carter");
INSERT INTO teach (pr_id, cl_id) VALUES (2, 2);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 16, 'T/TH', 'class description', "Rm 129 Vari Hall", 2);
INSERT  INTO professors (first_name, last_name) VALUES ("Joseph", "Maglione");
INSERT INTO teach (pr_id, cl_id) VALUES (3, 3);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 20, 'T/TH', 'class description', "Rm 102 Kenna Hall", 2);
INSERT  INTO professors (first_name, last_name) VALUES ("Haoning", "Richter");
INSERT INTO teach (pr_id, cl_id) VALUES (4, 4);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 19:10', 'Fall', 22, 'T/TH', 'class description', "Rm 102 Kenna Hall", 2);
INSERT INTO teach (pr_id, cl_id) VALUES (4, 5);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 3, 'T/TH', 'class description', "Rm 208 Lucas Hall", 2);
INSERT  INTO professors (first_name, last_name) VALUES ("Amanda", "Badger");
INSERT INTO teach (pr_id, cl_id) VALUES (5, 6);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ACTG 136', 'N/A', '', 'Cost Accounting', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 4, 'M/W/F', 'class description', "Rm 208 Lucas Hall", 3);
INSERT INTO teach (pr_id, cl_id) VALUES (2, 7);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ACTG 138', 'N/A', '', 'Tax Planning and Business Decisions', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 20, 'T/TH', 'class description', "Rm 208 Lucas Hall", 4);
INSERT  INTO professors (first_name, last_name) VALUES ("Suzanne", "Luttman");
INSERT INTO teach (pr_id, cl_id) VALUES (6, 8);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ACTG 140', 'N/A', '', 'Not for Profit Accounting', 3);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 15, 'W', 'class description', "Rm 310 Kenna Hall", 5);
INSERT INTO teach (pr_id, cl_id) VALUES (2, 9);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ACTG 155', 'N/A', '', 'Financial Information Systems', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 25, 'T/TH', 'class description', "Rm 120 Alumni Science Hall", 6);
INSERT  INTO professors (first_name, last_name) VALUES ("Xiaochen", "Zhu");
INSERT INTO teach (pr_id, cl_id) VALUES (7, 10);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('AMTH 108', 'N/A', '', 'Probability and Statistics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 21, 'M/W/F', 'class description', "Rm 212 Kenna Hall", 7);
INSERT  INTO professors (first_name, last_name) VALUES ("Robert", "Kleinhenz");
INSERT INTO teach (pr_id, cl_id) VALUES (8, 11);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('AMTH 108H', 'N/A', '', 'Probability and Statistics Honors', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 13, 'M/W/F', 'class description', "Rm 231 Mayer Theatre", 8);
INSERT INTO teach (pr_id, cl_id) VALUES (8, 12);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ANTH 110', 'N/A', '', 'Anthropological Theory', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 4, 'M/W/F', 'class description', "Rm 333 O'Connor Hall", 9);
INSERT  INTO professors (first_name, last_name) VALUES ("Ryan", "Anderson");
INSERT INTO teach (pr_id, cl_id) VALUES (9, 13);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ARTH 12A', 'N/A', 'c&i2', 'Cultures and Ideas II Venice Crossroads World', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 14, 'M/W/F', 'class description', "Rm 208 Edward M. Dowd Art & Art History", 10);
INSERT  INTO professors (first_name, last_name) VALUES ("Shriya", "Sridharan");
INSERT INTO teach (pr_id, cl_id) VALUES (10, 14);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 19, 'T/TH', 'class description', "Rm 208 Edward M. Dowd Art & Art History", 10);
INSERT  INTO professors (first_name, last_name) VALUES ("Blake", "DeMaria");
INSERT INTO teach (pr_id, cl_id) VALUES (11, 15);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 15, 'T/TH', 'class description', "Rm 208 Edward M. Dowd Art & Art History", 10);
INSERT INTO teach (pr_id, cl_id) VALUES (11, 16);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ARTH 185', 'N/A', 'diversity', 'Post', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 24, 'M/W', 'class description', "Rm 208 Edward M. Dowd Art & Art History", 11);
INSERT  INTO professors (first_name, last_name) VALUES ("nan", "");
INSERT INTO teach (pr_id, cl_id) VALUES (12, 17);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ARTS 57', 'N/A', 'arts', 'Digital Photography', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:00 - 13:20', 'Fall', 14, 'T/TH', 'class description', "Rm 302 Edward M. Dowd Art & Art History", 12);
INSERT  INTO professors (first_name, last_name) VALUES ("Renee", "Billingslea");
INSERT INTO teach (pr_id, cl_id) VALUES (13, 18);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ARTS 63', 'N/A', 'arts', 'Basic Ceramic Sculpture', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 10:20', 'Fall', 10, 'M/W', 'class description', "Rm 118 Edward M. Dowd Art & Art History", 13);
INSERT  INTO professors (first_name, last_name) VALUES ("Rachel", "Ashman");
INSERT INTO teach (pr_id, cl_id) VALUES (14, 19);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ARTS 74', 'N/A', 'arts', 'Basic Digital Imaging', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 12:50', 'Fall', 2, 'M/W', 'class description', "Rm 304 Edward M. Dowd Art & Art History", 14);
INSERT  INTO professors (first_name, last_name) VALUES ("Michael", "Martin");
INSERT INTO teach (pr_id, cl_id) VALUES (15, 20);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ARTS 155', 'N/A', 'arts', 'Photography in the Community', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 16:20', 'Fall', 22, 'T/TH', 'class description', "Rm 310 Edward M. Dowd Art & Art History", 15);
INSERT INTO teach (pr_id, cl_id) VALUES (13, 21);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOE 45', 'N/A', '', 'Programming in MATLAB and Python', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:10 - 19:00', 'Fall', 10, 'T/TH', 'class description', "RM 1302 SCDI", 16);
INSERT  INTO professors (first_name, last_name) VALUES ("Hamed", "Akbari");
INSERT INTO teach (pr_id, cl_id) VALUES (16, 22);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOE 130', 'N/A', '', 'Immune System for Engineers', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:10 - 19:00', 'Fall', 24, 'T/TH', 'class description', "Rm 125 Heafey Hall", 17);
INSERT  INTO professors (first_name, last_name) VALUES ("Eun", "Park");
INSERT INTO teach (pr_id, cl_id) VALUES (17, 23);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOE 174L', 'N/A', '', 'Microfabrication and Microfluidics for Bioengineering Applications Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 2, 'TH', 'class description', "RM 2307 SCDI", 18);
INSERT  INTO professors (first_name, last_name) VALUES ("Ismail", "Araci");
INSERT INTO teach (pr_id, cl_id) VALUES (18, 24);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 21, 'F', 'class description', "RM 2307 SCDI", 18);
INSERT INTO teach (pr_id, cl_id) VALUES (18, 25);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOE 176L', 'N/A', '', 'Biomolecular and Cellular Engineering II Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 1, 'W', 'class description', "RM 3307 SCDI", 19);
INSERT INTO teach (pr_id, cl_id) VALUES (17, 26);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOE 186', 'N/A', '', 'Biotechnology', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('19:10 - 21:00', 'Fall', 9, 'TH', 'class description', "Rm 125 Heafey Hall", 20);
INSERT INTO teach (pr_id, cl_id) VALUES (17, 27);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 1A', 'N/A', '', 'Energy and Matter L and L', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 21, 'T/TH', 'class description', "Rm 103 Alameda hall", 21);
INSERT  INTO professors (first_name, last_name) VALUES ("Raphael", "Ritson-Williams");
INSERT INTO teach (pr_id, cl_id) VALUES (19, 28);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:15 - 15:00', 'Fall', 18, 'T', 'class description', "RM 3207 SCDI", 21);
INSERT  INTO professors (first_name, last_name) VALUES ("Erin", "Schwartz");
INSERT INTO teach (pr_id, cl_id) VALUES (20, 29);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 1C', 'N/A', '', 'Systems L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 1, 'M/W/F', 'class description', "RM 2302 SCDI", 22);
INSERT  INTO professors (first_name, last_name) VALUES ("Angel", "Islas");
INSERT INTO teach (pr_id, cl_id) VALUES (21, 30);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 3, 'M/W/F', 'class description', "RM 2302 SCDI", 22);
INSERT  INTO professors (first_name, last_name) VALUES ("Janice", "Rooks");
INSERT INTO teach (pr_id, cl_id) VALUES (22, 31);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 14:30', 'Fall', 19, 'W', 'class description', "RM 3319 SCDI", 22);
INSERT INTO teach (pr_id, cl_id) VALUES (20, 32);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 18:45', 'Fall', 9, 'W', 'class description', "RM 3319 SCDI", 22);
INSERT INTO teach (pr_id, cl_id) VALUES (22, 33);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 3', 'N/A', 'natural science', 'Fitness Physiology L and L', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 18, 'T/TH', 'class description', "RM 3115 SCDI", 23);
INSERT  INTO professors (first_name, last_name) VALUES ("Farzaneh", "Ghiasvand");
INSERT INTO teach (pr_id, cl_id) VALUES (23, 34);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 20', 'N/A', '', 'Big Ideas in Biology', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:15 - 18:45', 'Fall', 4, 'W', 'class description', "Rm 103 Alameda hall", 24);
INSERT  INTO professors (first_name, last_name) VALUES ("Christelle", "Sabatier");
INSERT INTO teach (pr_id, cl_id) VALUES (24, 35);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 110', 'N/A', '', 'Genetics L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 9, 'F', 'class description', "RM 3303 SCDI", 25);
INSERT  INTO professors (first_name, last_name) VALUES ("Giorgio", "Lagna");
INSERT INTO teach (pr_id, cl_id) VALUES (25, 36);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 113', 'N/A', '', 'Microbiology L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 20, 'T/TH', 'class description', "Rm 212 Kenna Hall", 26);
INSERT  INTO professors (first_name, last_name) VALUES ("Craig", "Stephens");
INSERT INTO teach (pr_id, cl_id) VALUES (26, 37);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 23, 'TH', 'class description', "RM 3211 SCDI", 26);
INSERT INTO teach (pr_id, cl_id) VALUES (26, 38);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 114AW', 'N/A', '', 'Advanced Writing in Cell Biology LL', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 17, 'T', 'class description', "Rm 129 Heafey Hall", 27);
INSERT  INTO professors (first_name, last_name) VALUES ("Brian", "Bayless");
INSERT INTO teach (pr_id, cl_id) VALUES (27, 39);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 117', 'N/A', 'sts', 'Epidemiology L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 9, 'M/W/F', 'class description', "Rm 206 Daly Science 200", 28);
INSERT  INTO professors (first_name, last_name) VALUES ("Vanessa", "Errisuriz");
INSERT INTO teach (pr_id, cl_id) VALUES (28, 40);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 120', 'N/A', '', 'Animal Physiology L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 18, 'TH', 'class description', "RM 2305 SCDI", 29);
INSERT  INTO professors (first_name, last_name) VALUES ("Elizabeth", "Dahlhoff");
INSERT INTO teach (pr_id, cl_id) VALUES (29, 41);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 160', 'N/A', '', 'Biostatistics L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 22, 'M/W/F', 'class description', "RM 1302 SCDI", 30);
INSERT  INTO professors (first_name, last_name) VALUES ("John", "Dialesandro");
INSERT INTO teach (pr_id, cl_id) VALUES (30, 42);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BIOL 181', 'N/A', '', 'Special Topics Marine Biodiversity', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 12, 'T/TH', 'class description', "RM 3306 SCDI", 31);
INSERT  INTO professors (first_name, last_name) VALUES ("Dawn", "Hart");
INSERT INTO teach (pr_id, cl_id) VALUES (31, 43);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BUSN 85', 'N/A', '', 'Business Law', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 11, 'M/W/F', 'class description', "Rm 108 Edward M. Dowd Art & Art History", 32);
INSERT  INTO professors (first_name, last_name) VALUES ("Michael", "Dana");
INSERT INTO teach (pr_id, cl_id) VALUES (32, 44);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BUSN 179', 'N/A', '', 'Effective Communication in Business', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 4, 'M/W/F', 'class description', "Rm 114 Aloysius Varsi Hall", 33);
INSERT  INTO professors (first_name, last_name) VALUES ("Reginald", "Duhe");
INSERT INTO teach (pr_id, cl_id) VALUES (33, 45);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 10, 'T/TH', 'class description', "Rm 114 Aloysius Varsi Hall", 33);
INSERT  INTO professors (first_name, last_name) VALUES ("Michael", "Aquilina");
INSERT INTO teach (pr_id, cl_id) VALUES (34, 46);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 19:20', 'Fall', 18, 'T/TH', 'class description', "Rm 128 Vari Hall", 33);
INSERT  INTO professors (first_name, last_name) VALUES ("Brett", "Yokom");
INSERT INTO teach (pr_id, cl_id) VALUES (35, 47);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('BUSN 190', 'N/A', '', 'LSB Peer Advising Practicum', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:25 - 19:10', 'Fall', 9, 'M', 'class description', "RM 1302 SCDI", 34);
INSERT  INTO professors (first_name, last_name) VALUES ("Denise", "Ho");
INSERT INTO teach (pr_id, cl_id) VALUES (36, 48);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CENG 20L', 'N/A', '', 'Geology Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 18, 'T', 'class description', "RM 1322 SCDI", 35);
INSERT  INTO professors (first_name, last_name) VALUES ("Sukhmander", "Singh");
INSERT INTO teach (pr_id, cl_id) VALUES (37, 49);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 12, 'TH', 'class description', "RM 1322 SCDI", 35);
INSERT INTO teach (pr_id, cl_id) VALUES (37, 50);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CENG 41', 'N/A', '', 'Mechanics I Statics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 8, 'M/W/F', 'class description', "Rm 122 Heafey Hall", 36);
INSERT  INTO professors (first_name, last_name) VALUES ("Mohaddeseh", "Peyro");
INSERT INTO teach (pr_id, cl_id) VALUES (38, 51);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CENG 125L', 'N/A', '', 'Municipal Engineering Design Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 12, 'TH', 'class description', "Rm 202 Heafey Hall", 37);
INSERT  INTO professors (first_name, last_name) VALUES ("Rong", "He");
INSERT INTO teach (pr_id, cl_id) VALUES (39, 52);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CENG 135L', 'N/A', '', 'Reinforced Concrete Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 13, 'W', 'class description', "Rm 111 Alameda hall", 38);
INSERT  INTO professors (first_name, last_name) VALUES ("Rocio", "Segura");
INSERT INTO teach (pr_id, cl_id) VALUES (40, 53);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CENG 141L', 'N/A', '', 'Fluid Mechanics and Hydraulic Engineering Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 4, 'T', 'class description', "Rm 202 Heafey Hall", 39);
INSERT  INTO professors (first_name, last_name) VALUES ("Edwin", "Maurer");
INSERT INTO teach (pr_id, cl_id) VALUES (41, 54);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 9, 'F', 'class description', "Rm 202 Heafey Hall", 39);
INSERT INTO teach (pr_id, cl_id) VALUES (41, 55);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHEM 11', 'N/A', 'natural science', 'General Chemistry I L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:20 - 11:10', 'Fall', 1, 'T', 'class description', "RM 1311 SCDI", 40);
INSERT  INTO professors (first_name, last_name) VALUES ("Raymond", "Gipson");
INSERT INTO teach (pr_id, cl_id) VALUES (42, 56);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:20 - 18:10', 'Fall', 2, 'TH', 'class description', "RM 1311 SCDI", 40);
INSERT  INTO professors (first_name, last_name) VALUES ("Joshua", "Visser");
INSERT INTO teach (pr_id, cl_id) VALUES (43, 57);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:05', 'Fall', 4, 'F', 'class description', "RM 1311 SCDI", 40);
INSERT  INTO professors (first_name, last_name) VALUES ("Poonam", "Narula");
INSERT INTO teach (pr_id, cl_id) VALUES (44, 58);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHEM 12', 'N/A', 'natural science', 'General Chemistry II L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:20 - 18:10', 'Fall', 5, 'T', 'class description', "RM 1307 SCDI", 41);
INSERT  INTO professors (first_name, last_name) VALUES ("Parnian", "Lak");
INSERT INTO teach (pr_id, cl_id) VALUES (45, 59);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:05', 'Fall', 1, 'W', 'class description', "RM 1304 SCDI", 41);
INSERT  INTO professors (first_name, last_name) VALUES ("Megan", "Tichy");
INSERT INTO teach (pr_id, cl_id) VALUES (46, 60);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 15:00', 'Fall', 14, 'TH', 'class description', "RM 1304 SCDI", 41);
INSERT INTO teach (pr_id, cl_id) VALUES (46, 61);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHEM 12H', 'N/A', 'natural science', 'General Chemistry II L and L Honors', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 22, 'M/W/F', 'class description', "Rm 104 Alameda hall", 42);
INSERT  INTO professors (first_name, last_name) VALUES ("Meaghan", "Deegan");
INSERT INTO teach (pr_id, cl_id) VALUES (47, 62);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHEM 32', 'N/A', '', 'Organic Chemistry II', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:05', 'Fall', 21, 'F', 'class description', "RM 2114 SCDI", 43);
INSERT INTO teach (pr_id, cl_id) VALUES (42, 63);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHEM 33', 'N/A', '', 'Organic Chemistry III', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:05', 'Fall', 20, 'W', 'class description', "RM 2109 SCDI", 44);
INSERT  INTO professors (first_name, last_name) VALUES ("Beatrice", "Ruhland");
INSERT INTO teach (pr_id, cl_id) VALUES (48, 64);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:20 - 18:10', 'Fall', 19, 'TH', 'class description', "RM 2109 SCDI", 44);
INSERT  INTO professors (first_name, last_name) VALUES ("Michael", "Carrasco");
INSERT INTO teach (pr_id, cl_id) VALUES (49, 65);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHEM 111', 'N/A', '', 'Instrumental Analysis', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 17:00', 'Fall', 6, 'TH', 'class description', "RM 2206B SCDI", 45);
INSERT  INTO professors (first_name, last_name) VALUES ("Paul", "Abbyad");
INSERT INTO teach (pr_id, cl_id) VALUES (50, 66);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHIN 2', 'N/A', '', 'Introduction to Chinese Language and Chinese', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 16:35', 'Fall', 19, 'M/W/F', 'class description', "Rm 102 O'Connor Hall", 46);
INSERT  INTO professors (first_name, last_name) VALUES ("Yujie", "Ge");
INSERT INTO teach (pr_id, cl_id) VALUES (51, 67);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHIN 22', 'N/A', '', 'Chinese Language and Chinese', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 11, 'M/W/F', 'class description', "Rm 231 Mayer Theatre", 47);
INSERT  INTO professors (first_name, last_name) VALUES ("Hsin-hung", "Yeh");
INSERT INTO teach (pr_id, cl_id) VALUES (52, 68);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CHST 75', 'N/A', 'sts', 'Technology and Education', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 19, 'M/W/F', 'class description', "Rm 164 Graham Hall", 48);
INSERT  INTO professors (first_name, last_name) VALUES ("Elizabeth", "Day");
INSERT INTO teach (pr_id, cl_id) VALUES (53, 69);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CLAS 22', 'N/A', '', 'Elementary Greek II', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 9, 'M/W/F', 'class description', "Rm 015 O'Connor Hall", 49);
INSERT  INTO professors (first_name, last_name) VALUES ("Daniel", "Turkeltaub");
INSERT INTO teach (pr_id, cl_id) VALUES (54, 70);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CLAS 65', 'N/A', 'rel2', 'Classical Mythology', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 21, 'T/TH', 'class description', "Rm 104 O'Connor Hall", 50);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 71);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CLAS 108', 'N/A', '', 'Classical Greek History Tyrants Traitors and Rebels', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 17, 'M/W/F', 'class description', "Rm 163 Graham Hall", 51);
INSERT  INTO professors (first_name, last_name) VALUES ("Nicholas", "Lindberg");
INSERT INTO teach (pr_id, cl_id) VALUES (55, 72);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CLAS 173', 'N/A', 'sts', 'Bath and Body Works in Ancient Rome', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 19, 'M/W/F', 'class description', "Rm 104 Alameda hall", 52);
INSERT  INTO professors (first_name, last_name) VALUES ("Elizabeth", "Crofton-Sleigh");
INSERT INTO teach (pr_id, cl_id) VALUES (56, 73);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 4', 'N/A', 'social science', 'Approaches to Communication Research', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 10, 'M/W/F', 'class description', "Rm 129 Heafey Hall", 53);
INSERT  INTO professors (first_name, last_name) VALUES ("Stephenson", "Whitestone");
INSERT INTO teach (pr_id, cl_id) VALUES (57, 74);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 30', 'N/A', 'arts', 'Digital Filmmaking', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 13, 'T/TH', 'class description', "Rm 109 Vari Hall", 54);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 75);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('16:00 - 17:30', 'Fall', 12, 'W', 'class description', "Rm 102 Vari Hall", 54);
INSERT  INTO professors (first_name, last_name) VALUES ("Michele", "Sieglitz");
INSERT INTO teach (pr_id, cl_id) VALUES (58, 76);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 19, 'W', 'class description', "Rm 102 Vari Hall", 54);
INSERT  INTO professors (first_name, last_name) VALUES ("Fernando", "Silva");
INSERT INTO teach (pr_id, cl_id) VALUES (59, 77);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 100', 'N/A', '', 'Quantitative Methods', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 20, 'M/W/F', 'class description', "Rm 107 Kenna Hall", 55);
INSERT  INTO professors (first_name, last_name) VALUES ("Paul", "Soukup");
INSERT INTO teach (pr_id, cl_id) VALUES (60, 78);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 114', 'N/A', 'sts', 'Body Politics', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 24, 'M/W/F', 'class description', "Rm 129 Vari Hall", 56);
INSERT  INTO professors (first_name, last_name) VALUES ("Laura", "Ellingson");
INSERT INTO teach (pr_id, cl_id) VALUES (61, 79);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 131F', 'N/A', 'arts', 'Short Fiction Production', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 24, 'T/TH', 'class description', "Rm 109 Vari Hall", 57);
INSERT  INTO professors (first_name, last_name) VALUES ("Emily", "Reese");
INSERT INTO teach (pr_id, cl_id) VALUES (62, 80);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:40', 'Fall', 11, 'T', 'class description', "Rm 102 Vari Hall", 57);
INSERT INTO teach (pr_id, cl_id) VALUES (58, 81);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 13:15', 'Fall', 22, 'W', 'class description', "Rm 102 Vari Hall", 57);
INSERT INTO teach (pr_id, cl_id) VALUES (58, 82);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 133', 'N/A', '', 'Producing', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 1, 'T/TH', 'class description', "Rm 109 Vari Hall", 58);
INSERT  INTO professors (first_name, last_name) VALUES ("Nicole", "Opper");
INSERT INTO teach (pr_id, cl_id) VALUES (63, 83);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 137S', 'N/A', '', 'Film  Sustainability', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 20:40', 'Fall', 18, 'T', 'class description', "Rm 135 Vari Hall", 59);
INSERT  INTO professors (first_name, last_name) VALUES ("Maria", "Judnick");
INSERT INTO teach (pr_id, cl_id) VALUES (64, 84);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 184', 'N/A', 'c&i3', 'Global Media and Postcolonial Identity', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 13, 'M/W/F', 'class description', "Rm 302 Alumni Science Hall", 60);
INSERT  INTO professors (first_name, last_name) VALUES ("Rohit", "Chopra");
INSERT INTO teach (pr_id, cl_id) VALUES (65, 85);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('COMM 190', 'N/A', '', 'Journalism Practicum', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 16:50', 'Fall', 16, 'M', 'class description', "Rm 138 Vari Hall", 61);
INSERT  INTO professors (first_name, last_name) VALUES ("Gordon", "Young");
INSERT INTO teach (pr_id, cl_id) VALUES (66, 86);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 10', 'N/A', 'sts', 'Introduction to Computer Science', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 2, 'M/W/F', 'class description', "Rm 205 O'Connor Hall", 62);
INSERT  INTO professors (first_name, last_name) VALUES ("Shiva", "Houshmand");
INSERT INTO teach (pr_id, cl_id) VALUES (67, 87);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 11, 'T', 'class description', "Rm 122 Heafey Hall", 62);
INSERT  INTO professors (first_name, last_name) VALUES ("Anh", "Nhan");
INSERT INTO teach (pr_id, cl_id) VALUES (68, 88);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 60', 'N/A', '', 'Introduction to C and Object', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 19:20', 'Fall', 7, 'T', 'class description', "Rm 103 O'Connor Hall", 63);
INSERT  INTO professors (first_name, last_name) VALUES ("Anant", "Dhayal");
INSERT INTO teach (pr_id, cl_id) VALUES (69, 89);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 61', 'N/A', '', 'Data Structures', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 1, 'M/W/F', 'class description', "Rm 207 O'Connor Hall", 64);
INSERT  INTO professors (first_name, last_name) VALUES ("Smita", "Ghosh");
INSERT INTO teach (pr_id, cl_id) VALUES (70, 90);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 3, 'M/W/F', 'class description', "Rm 204 O'Connor Hall", 64);
INSERT  INTO professors (first_name, last_name) VALUES ("Hien", "Vu");
INSERT INTO teach (pr_id, cl_id) VALUES (71, 91);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 161', 'N/A', '', 'Theory of Automata and Languages', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 6, 'M/W/F', 'class description', "Rm 106 O'Connor Hall", 65);
INSERT  INTO professors (first_name, last_name) VALUES ("Sara", "Krehbiel");
INSERT INTO teach (pr_id, cl_id) VALUES (72, 92);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 163', 'N/A', '', 'Theory of Algorithms', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 3, 'M/W/F', 'class description', "RM 3302 SCDI", 66);
INSERT  INTO professors (first_name, last_name) VALUES ("Nicholas", "Tran");
INSERT INTO teach (pr_id, cl_id) VALUES (73, 93);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 169', 'N/A', '', 'Programming Languages', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 8, 'M/W/F', 'class description', "Rm 106 O'Connor Hall", 67);
INSERT  INTO professors (first_name, last_name) VALUES ("Natalie", "Linnell");
INSERT INTO teach (pr_id, cl_id) VALUES (74, 94);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 183', 'N/A', '', 'Data Science', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 19, 'M/W/F', 'class description', "Rm 306 Kenna Hall", 68);
INSERT INTO teach (pr_id, cl_id) VALUES (70, 95);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 10L', 'N/A', '', 'Introduction to Programming Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 14, 'W', 'class description', "Rm 203 Heafey Hall", 69);
INSERT  INTO professors (first_name, last_name) VALUES ("Ha", "Kim");
INSERT INTO teach (pr_id, cl_id) VALUES (75, 96);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 11', 'N/A', '', 'Advanced Programming', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 25, 'M/W/F', 'class description', "RM 3301 SCDI", 70);
INSERT  INTO professors (first_name, last_name) VALUES ("Angela", "Musurlian");
INSERT INTO teach (pr_id, cl_id) VALUES (76, 97);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 11L', 'N/A', '', 'Advanced Programming Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 22, 'M', 'class description', "Rm 203 Heafey Hall", 71);
INSERT INTO teach (pr_id, cl_id) VALUES (76, 98);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 20', 'N/A', '', 'Introduction to Embedded Systems', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 7, 'M/W/F', 'class description', "RM 2301 SCDI", 72);
INSERT  INTO professors (first_name, last_name) VALUES ("Younghyun", "Cho");
INSERT INTO teach (pr_id, cl_id) VALUES (77, 99);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 20L', 'N/A', '', 'Embedded Systems Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 19, 'TH', 'class description', "Rm 112 Heafey Hall", 73);
INSERT  INTO professors (first_name, last_name) VALUES ("Michael", "Schimpf");
INSERT INTO teach (pr_id, cl_id) VALUES (78, 100);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 79', 'N/A', '', 'Object', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 21, 'M/W/F', 'class description', "RM 1301 SCDI", 74);
INSERT  INTO professors (first_name, last_name) VALUES ("Farokh", "Eskafi");
INSERT INTO teach (pr_id, cl_id) VALUES (79, 101);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 12, 'T/TH', 'class description', "Rm 104 Alameda hall", 74);
INSERT  INTO professors (first_name, last_name) VALUES ("Behnam", "Dezfouli");
INSERT INTO teach (pr_id, cl_id) VALUES (80, 102);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 79L', 'N/A', '', 'Object', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:15 - 20:00', 'Fall', 5, 'TH', 'class description', "Rm 203 Heafey Hall", 75);
INSERT INTO teach (pr_id, cl_id) VALUES (79, 103);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 122', 'N/A', '', 'Computer Architecture', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 6, 'M/W/F', 'class description', "RM 3115 SCDI", 76);
INSERT  INTO professors (first_name, last_name) VALUES ("Weijia", "Shang");
INSERT INTO teach (pr_id, cl_id) VALUES (81, 104);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 122L', 'N/A', '', 'Computer Architecture Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:15 - 20:00', 'Fall', 8, 'TH', 'class description', "Rm 202 Heafey Hall", 77);
INSERT INTO teach (pr_id, cl_id) VALUES (81, 105);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 146', 'N/A', '', 'Computer Networks', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 11, 'M/W/F', 'class description', "RM 3301 SCDI", 78);
INSERT  INTO professors (first_name, last_name) VALUES ("Salem", "Agtash");
INSERT INTO teach (pr_id, cl_id) VALUES (82, 106);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 169', 'N/A', '', 'Web Information Management', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 22, 'T/TH', 'class description', "RM 2302 SCDI", 79);
INSERT  INTO professors (first_name, last_name) VALUES ("Yi", "Fang");
INSERT INTO teach (pr_id, cl_id) VALUES (83, 107);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 174L', 'N/A', '', 'Software Engineering Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 1, 'W', 'class description', "Rm 224 Heafey Hall", 80);
INSERT  INTO professors (first_name, last_name) VALUES ("Kai", "Lukoff");
INSERT INTO teach (pr_id, cl_id) VALUES (84, 108);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 177', 'N/A', '', 'Operating Systems', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 21, 'T/TH', 'class description', "RM 3301 SCDI", 81);
INSERT  INTO professors (first_name, last_name) VALUES ("Sean", "Choi");
INSERT INTO teach (pr_id, cl_id) VALUES (85, 109);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 177L', 'N/A', '', 'Operating Systems Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 13, 'T', 'class description', "Rm 106 Heafey Hall", 82);
INSERT  INTO professors (first_name, last_name) VALUES ("Ahmed", "Amer");
INSERT INTO teach (pr_id, cl_id) VALUES (86, 110);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSEN 178', 'N/A', '', 'Introduction to Database Systems', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 11, 'T/TH', 'class description', "RM 3301 SCDI", 83);
INSERT  INTO professors (first_name, last_name) VALUES ("Shiva", "Jahangiri");
INSERT INTO teach (pr_id, cl_id) VALUES (87, 111);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('DANC 43', 'N/A', 'arts', 'Ballet I', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 25, 'M/W/F', 'class description', "Rm 124 Music And Dance - Studio A", 84);
INSERT  INTO professors (first_name, last_name) VALUES ("Karyn", "Connell");
INSERT INTO teach (pr_id, cl_id) VALUES (88, 112);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('DANC 58', 'N/A', '', 'Pilates Mat Class', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 18, 'M/W/F', 'class description', "Rm 125 Music And Dance - Studio B", 85);
INSERT INTO teach (pr_id, cl_id) VALUES (88, 113);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('DANC 140', 'N/A', 'arts', 'Ballet IV', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 16, 'T/TH', 'class description', "Rm 124 Music And Dance - Studio A", 86);
INSERT INTO teach (pr_id, cl_id) VALUES (88, 114);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECEN 21', 'N/A', '', 'Introduction to Logic Design', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 25, 'T/TH', 'class description', "Rm 122 Heafey Hall", 87);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 115);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECEN 50L', 'N/A', '', 'Electric Circuits I Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 7, 'TH', 'class description', "RM 4002 SCDI", 88);
INSERT  INTO professors (first_name, last_name) VALUES ("Yu", "Zheng");
INSERT INTO teach (pr_id, cl_id) VALUES (89, 116);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 16, 'F', 'class description', "RM 4002 SCDI", 88);
INSERT INTO teach (pr_id, cl_id) VALUES (89, 117);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECEN 141L', 'N/A', '', 'Communication Systems Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 19, 'W', 'class description', "RM 4006 SCDI", 89);
INSERT  INTO professors (first_name, last_name) VALUES ("Anoosheh", "Heidarzadeh");
INSERT INTO teach (pr_id, cl_id) VALUES (90, 118);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 1', 'N/A', 'social science', 'Principles of Microeconomics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 5, 'T/TH', 'class description', "Rm 206 Lucas Hall", 90);
INSERT  INTO professors (first_name, last_name) VALUES ("Patricia", "Cameron-Loyd");
INSERT INTO teach (pr_id, cl_id) VALUES (91, 119);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 22, 'M/W/F', 'class description', "Rm 206 Lucas Hall", 90);
INSERT  INTO professors (first_name, last_name) VALUES ("Orkhan", "Hasanaliyev");
INSERT INTO teach (pr_id, cl_id) VALUES (92, 120);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 13, 'M/W/F', 'class description', "Rm 232 Vari Hall", 90);
INSERT  INTO professors (first_name, last_name) VALUES ("Damian", "Park");
INSERT INTO teach (pr_id, cl_id) VALUES (93, 121);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 2', 'N/A', 'social science', 'Principles of Macroeconomics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 5, 'T/TH', 'class description', "Rm 135 Vari Hall", 91);
INSERT  INTO professors (first_name, last_name) VALUES ("Vito", "Cormun");
INSERT INTO teach (pr_id, cl_id) VALUES (94, 122);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 24, 'T/TH', 'class description', "Rm 206 Lucas Hall", 91);
INSERT  INTO professors (first_name, last_name) VALUES ("Kris", "Mitchener");
INSERT INTO teach (pr_id, cl_id) VALUES (95, 123);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 8, 'M/W/F', 'class description', "Rm 207 Lucas Hall", 91);
INSERT  INTO professors (first_name, last_name) VALUES ("Kevin", "Chiu");
INSERT INTO teach (pr_id, cl_id) VALUES (96, 124);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 9, 'M/W/F', 'class description', "Rm 210 Lucas Hall", 91);
INSERT  INTO professors (first_name, last_name) VALUES ("Wenxin", "Xie");
INSERT INTO teach (pr_id, cl_id) VALUES (97, 125);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 3', 'N/A', '', 'International Economics Development and Growth', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 21, 'T/TH', 'class description', "Rm 306 Lucas Hall", 92);
INSERT  INTO professors (first_name, last_name) VALUES ("Sofia", "Kotsiri");
INSERT INTO teach (pr_id, cl_id) VALUES (98, 126);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 17, 'M/W/F', 'class description', "Rm 309 Lucas Hall", 92);
INSERT  INTO professors (first_name, last_name) VALUES ("Gabriela", "Dobrescu");
INSERT INTO teach (pr_id, cl_id) VALUES (99, 127);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 101', 'N/A', '', 'Resources Food and the Environment', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 19, 'M/W', 'class description', "Rm 206 Lucas Hall", 93);
INSERT  INTO professors (first_name, last_name) VALUES ("Gregory", "Baker");
INSERT INTO teach (pr_id, cl_id) VALUES (100, 128);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 113', 'N/A', '', 'Intermediate Microeconomics I', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 20, 'M/W/F', 'class description', "Rm 164 Graham Hall", 94);
INSERT  INTO professors (first_name, last_name) VALUES ("Serguei", "Maliar");
INSERT INTO teach (pr_id, cl_id) VALUES (101, 129);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 114', 'N/A', '', 'Intermediate Microeconomics II', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 3, 'M/W/F', 'class description', "RM 3116 SCDI", 95);
INSERT INTO teach (pr_id, cl_id) VALUES (101, 130);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ECON 170', 'N/A', '', 'Mathematical Economics I Static Optimization', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 5, 'T/TH', 'class description', "Rm 207 Lucas Hall", 96);
INSERT INTO teach (pr_id, cl_id) VALUES (91, 131);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 1A', 'N/A', 'ctw1', 'Critical Thinking and Writing I', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 20, 'M/W/F', 'class description', "RM 3301 SCDI", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("Cindy", "Swenson");
INSERT INTO teach (pr_id, cl_id) VALUES (102, 132);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 1, 'M/W', 'class description', "RM 3301 SCDI", 97);
INSERT INTO teach (pr_id, cl_id) VALUES (102, 133);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 4, 'M/W/F', 'class description', "Rm 210 O'Connor Hall", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("David", "Coad");
INSERT INTO teach (pr_id, cl_id) VALUES (103, 134);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 16:35', 'Fall', 6, 'M/W/F', 'class description', "Rm 129 Heafey Hall", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("Lina", "Geriguis");
INSERT INTO teach (pr_id, cl_id) VALUES (104, 135);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 4, 'M/W/F', 'class description', "Rm 102 O'Connor Hall", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("Leonard", "Crosby");
INSERT INTO teach (pr_id, cl_id) VALUES (105, 136);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 6, 'M/W/F', 'class description', "Rm 110 O'Connor Hall", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("Ryan", "Ikeda");
INSERT INTO teach (pr_id, cl_id) VALUES (106, 137);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 4, 'M/W/F', 'class description', "Rm 101 Alameda hall", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("Mostafa", "Jalal");
INSERT INTO teach (pr_id, cl_id) VALUES (107, 138);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 17, 'T/TH', 'class description', "Rm 108 Edward M. Dowd Art & Art History", 97);
INSERT  INTO professors (first_name, last_name) VALUES ("Christopher", "Pascua");
INSERT INTO teach (pr_id, cl_id) VALUES (108, 139);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 9, 'T/TH', 'class description', "Rm 108 Edward M. Dowd Art & Art History", 97);
INSERT INTO teach (pr_id, cl_id) VALUES (108, 140);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 2A', 'N/A', 'ctw2', 'Critical Thinking and Writing II', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 2, 'M/W/F', 'class description', "Rm 108 Alameda hall", 98);
INSERT  INTO professors (first_name, last_name) VALUES ("Scott", "Wagar");
INSERT INTO teach (pr_id, cl_id) VALUES (109, 141);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 20, 'M/W/F', 'class description', "Rm 210 O'Connor Hall", 98);
INSERT INTO teach (pr_id, cl_id) VALUES (105, 142);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 19, 'M/W/F', 'class description', "Rm 128 Vari Hall", 98);
INSERT INTO teach (pr_id, cl_id) VALUES (106, 143);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 16, 'M/W/F', 'class description', "Rm 110 O'Connor Hall", 98);
INSERT  INTO professors (first_name, last_name) VALUES ("Amna", "Yusuf");
INSERT INTO teach (pr_id, cl_id) VALUES (110, 144);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('18:00 - 19:05', 'Fall', 14, 'M/W/F', 'class description', "Rm 210 O'Connor Hall", 98);
INSERT INTO teach (pr_id, cl_id) VALUES (102, 145);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 6, 'T/TH', 'class description', "Rm 232 Vari Hall", 98);
INSERT  INTO professors (first_name, last_name) VALUES ("Cruz", "Medina");
INSERT INTO teach (pr_id, cl_id) VALUES (111, 146);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 2H', 'N/A', 'ctw2', 'Critical Thinking and Writing II Honors', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 11, 'M/W/F', 'class description', "Rm 122 Edward M. Dowd Art & Art History", 99);
INSERT  INTO professors (first_name, last_name) VALUES ("Maura", "Tarnoff");
INSERT INTO teach (pr_id, cl_id) VALUES (112, 147);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 12A', 'N/A', 'c&i2', 'Cultures and Ideas II Film Around the Globe', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 19:20', 'Fall', 21, 'T/TH', 'class description', "Rm 109 O'Connor Hall", 100);
INSERT  INTO professors (first_name, last_name) VALUES ("Robin", "Tremblay-McGaw");
INSERT INTO teach (pr_id, cl_id) VALUES (113, 148);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 69AM', 'N/A', 'diversity', 'Literature by American Women Writers of Color', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 8, 'T/TH', 'class description', "Rm 301 Alumni Science Hall", 101);
INSERT INTO teach (pr_id, cl_id) VALUES (113, 149);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 100GR', 'N/A', '', 'Writing in the Public Interest Grants Proposals and Reports', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 19:20', 'Fall', 4, 'T/TH', 'class description', "Rm 220 Alumni Science Hall", 102);
INSERT  INTO professors (first_name, last_name) VALUES ("Stephen", "Carroll");
INSERT INTO teach (pr_id, cl_id) VALUES (114, 150);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 107S', 'N/A', '', 'Sustainability Stories  Film', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 20:40', 'Fall', 1, 'T', 'class description', "Rm 135 Vari Hall", 103);
INSERT INTO teach (pr_id, cl_id) VALUES (64, 151);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 151C', 'N/A', '', 'Studies in Shakespeare', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 19, 'T/TH', 'class description', "Rm 007 Casa Italiana Residence", 104);
INSERT  INTO professors (first_name, last_name) VALUES ("Jose", "Villagrana");
INSERT INTO teach (pr_id, cl_id) VALUES (115, 152);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 153', 'N/A', 'diversity', 'In Memory of Toni Morrison', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 1, 'M/W/F', 'class description', "Rm 102 Alameda hall", 105);
INSERT  INTO professors (first_name, last_name) VALUES ("Allia", "Griffin");
INSERT INTO teach (pr_id, cl_id) VALUES (116, 153);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 179W', 'N/A', '', 'Playwriting', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 1, 'T/TH', 'class description', "Rm 231 Mayer Theatre", 106);
INSERT  INTO professors (first_name, last_name) VALUES ("Brian", "Thorstenson");
INSERT INTO teach (pr_id, cl_id) VALUES (117, 154);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGL 181', 'N/A', '', 'Engineering Communications Practical Writing and Presentation Skills for Engineers', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 25, 'M/W/F', 'class description', "Rm 209 O'Connor Hall", 107);
INSERT  INTO professors (first_name, last_name) VALUES ("Jacquelyn", "Hendricks");
INSERT INTO teach (pr_id, cl_id) VALUES (118, 155);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGR 1L', 'N/A', '', 'Introduction to Engineering Lab', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 12:00', 'Fall', 24, 'T', 'class description', "RM 2302 SCDI", 108);
INSERT  INTO professors (first_name, last_name) VALUES ("Jessica", "Kuczenski");
INSERT INTO teach (pr_id, cl_id) VALUES (119, 156);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 17:00', 'Fall', 15, 'T', 'class description', "RM 2302 SCDI", 108);
INSERT  INTO professors (first_name, last_name) VALUES ("Raghavendra", "Morusupalli");
INSERT INTO teach (pr_id, cl_id) VALUES (120, 157);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGR 16', 'N/A', 'rel1', 'Values In Technology', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 23, 'M', 'class description', "Rm 214 Bergin Hall", 109);
INSERT  INTO professors (first_name, last_name) VALUES ("Matthew", "Gaudet");
INSERT INTO teach (pr_id, cl_id) VALUES (121, 158);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 15, 'F', 'class description', "Rm 214 Bergin Hall", 109);
INSERT INTO teach (pr_id, cl_id) VALUES (121, 159);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENGR 19', 'N/A', 'ethics', 'Ethics in Technology', 0);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:05', 'Fall', 16, 'T', 'class description', "Rm 225 Heafey Hall", 110);
INSERT  INTO professors (first_name, last_name) VALUES ("Kathryn", "Moles");
INSERT INTO teach (pr_id, cl_id) VALUES (122, 160);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:10 - 16:15', 'Fall', 22, 'T', 'class description', "Rm 225 Heafey Hall", 110);
INSERT INTO teach (pr_id, cl_id) VALUES (122, 161);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('16:20 - 17:25', 'Fall', 14, 'T', 'class description', "Rm 225 Heafey Hall", 110);
INSERT INTO teach (pr_id, cl_id) VALUES (122, 162);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 18, 'W', 'class description', "RM 2302 SCDI", 110);
INSERT INTO teach (pr_id, cl_id) VALUES (122, 163);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENVS 5', 'N/A', 'natural science', 'My Environment', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 11:15', 'Fall', 24, 'F', 'class description', "RM 3205 SCDI", 111);
INSERT  INTO professors (first_name, last_name) VALUES ("Andy", "II");
INSERT INTO teach (pr_id, cl_id) VALUES (123, 164);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENVS 101', 'N/A', '', 'Capstone Seminar', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 3, 'M/W', 'class description', "Rm 105 Alameda hall", 112);
INSERT  INTO professors (first_name, last_name) VALUES ("Iris", "Stewart-Frey");
INSERT INTO teach (pr_id, cl_id) VALUES (124, 165);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 6, 'T/TH', 'class description', "Rm 163 Graham Hall", 112);
INSERT  INTO professors (first_name, last_name) VALUES ("Charles", "Gabbe");
INSERT INTO teach (pr_id, cl_id) VALUES (125, 166);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENVS 110', 'N/A', '', 'Environmental Statistics L and L', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 20, 'M/W/F', 'class description', "RM 1302 SCDI", 113);
INSERT INTO teach (pr_id, cl_id) VALUES (30, 167);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENVS 122', 'N/A', 'civic engagement', 'Environmental Politics and Policy', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 1, 'T/TH', 'class description', "RM 3302 SCDI", 114);
INSERT INTO teach (pr_id, cl_id) VALUES (125, 168);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ENVS 198', 'N/A', '', 'Environmental Proseminar', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('16:45 - 17:50', 'Fall', 4, 'W', 'class description', "Rm 164 Graham Hall", 115);
INSERT  INTO professors (first_name, last_name) VALUES ("Virginia", "Matzek");
INSERT INTO teach (pr_id, cl_id) VALUES (126, 169);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ETHN 138', 'N/A', 'c&i3', 'Black Migration in the World', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 15, 'M/W', 'class description', "Rm 205 O'Connor Hall", 116);
INSERT  INTO professors (first_name, last_name) VALUES ("Harry", "Odamtten");
INSERT INTO teach (pr_id, cl_id) VALUES (127, 170);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('ETHN 154', 'N/A', 'diversity', 'Women of Color in the US', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 23, 'T/TH', 'class description', "Rm 206 O'Connor Hall", 117);
INSERT  INTO professors (first_name, last_name) VALUES ("Jesica", "Fernandez");
INSERT INTO teach (pr_id, cl_id) VALUES (128, 171);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('FNCE 124', 'N/A', '', 'Investments', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 23, 'M/W', 'class description', "Rm 207 Lucas Hall", 118);
INSERT  INTO professors (first_name, last_name) VALUES ("Gustavo", "Schwenkler");
INSERT INTO teach (pr_id, cl_id) VALUES (129, 172);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('FNCE 125', 'N/A', '', 'Corporate Financial Policy', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 5, 'M/W/F', 'class description', "Rm 307 Lucas Hall", 119);
INSERT  INTO professors (first_name, last_name) VALUES ("Elyas", "Fermand");
INSERT INTO teach (pr_id, cl_id) VALUES (130, 173);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('FNCE 132', 'N/A', '', 'Financial Derivatives', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 16, 'M/W/F', 'class description', "Rm 306 Lucas Hall", 120);
INSERT  INTO professors (first_name, last_name) VALUES ("Wen-Yao", "Ku");
INSERT INTO teach (pr_id, cl_id) VALUES (131, 174);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('FREN 2', 'N/A', '', 'Introduction to French Language and Francophone Cultures II', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 19, 'M/W/F', 'class description', "Rm 220 Alumni Science Hall", 121);
INSERT  INTO professors (first_name, last_name) VALUES ("Keziah", "Poole");
INSERT INTO teach (pr_id, cl_id) VALUES (132, 175);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('GERM 11A', 'N/A', 'c&i1', 'Cultures and Ideas I Multicultural German Voices', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 18, 'T/TH', 'class description', "Rm 111 Kenna Hall", 122);
INSERT  INTO professors (first_name, last_name) VALUES ("Josef", "Hellebrandt");
INSERT INTO teach (pr_id, cl_id) VALUES (133, 176);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 11A', 'N/A', 'c&i1', 'Cultures and Ideas I Slavery  Unfreedom', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 24, 'M/W/F', 'class description', "Rm 003 Casa Italiana Residence", 123);
INSERT  INTO professors (first_name, last_name) VALUES ("Megan", "Gudgeirsson");
INSERT INTO teach (pr_id, cl_id) VALUES (134, 177);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 12A', 'N/A', 'c&i2', 'Cultures and Ideas II Slavery  Unfreedom', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 2, 'M/W/F', 'class description', "Rm 204 O'Connor Hall", 124);
INSERT  INTO professors (first_name, last_name) VALUES ("Michael", "Brillman");
INSERT INTO teach (pr_id, cl_id) VALUES (135, 178);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 84', 'N/A', 'diversity', 'US Womens History', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 7, 'M/W/F', 'class description', "Rm 304 Kenna Hall", 125);
INSERT  INTO professors (first_name, last_name) VALUES ("Nancy", "Unger");
INSERT INTO teach (pr_id, cl_id) VALUES (136, 179);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 93', 'N/A', 'civic engagement, c&i3', 'The Cold War', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 9, 'M/W/F', 'class description', "Rm 003 Casa Italiana Residence", 126);
INSERT INTO teach (pr_id, cl_id) VALUES (134, 180);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 101S', 'N/A', '', 'Historical Writing', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('18:00 - 21:00', 'Fall', 21, 'W', 'class description', "Rm 116 Bergin Hall", 127);
INSERT  INTO professors (first_name, last_name) VALUES ("Gregory", "Wigmore");
INSERT INTO teach (pr_id, cl_id) VALUES (137, 181);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 157', 'N/A', 'c&i3', 'Black Migration in the World', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 14, 'M/W', 'class description', "Rm 205 O'Connor Hall", 128);
INSERT INTO teach (pr_id, cl_id) VALUES (127, 182);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('HIST 172', 'N/A', 'diversity', 'The Civil War Era', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 18, 'M/W/F', 'class description', "Rm 019 Sobrato Residence", 129);
INSERT INTO teach (pr_id, cl_id) VALUES (134, 183);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('JAPN 101', 'N/A', '', 'Japanese Popular Culture', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 8, 'M/W/F', 'class description', "Rm 301 Alumni Science Hall", 130);
INSERT  INTO professors (first_name, last_name) VALUES ("Tomoko", "Takeda");
INSERT INTO teach (pr_id, cl_id) VALUES (138, 184);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('LEAD 2', 'N/A', '', 'LEAD Seminar', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 4, 'W', 'class description', "Rm 114 Aloysius Varsi Hall", 131);
INSERT  INTO professors (first_name, last_name) VALUES ("Raymond", "Plaza");
INSERT INTO teach (pr_id, cl_id) VALUES (139, 185);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 1, 'T/TH', 'class description', "Rm 232 Vari Hall", 131);
INSERT  INTO professors (first_name, last_name) VALUES ("Clare", "Bettencourt");
INSERT INTO teach (pr_id, cl_id) VALUES (140, 186);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MATH 9L', 'N/A', '', 'Precalculus Laboratory', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 4, 'T', 'class description', "Rm 201 O'Connor Hall", 132);
INSERT  INTO professors (first_name, last_name) VALUES ("Shruthi", "Sridhar");
INSERT INTO teach (pr_id, cl_id) VALUES (141, 187);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MATH 12', 'N/A', 'math', 'Calculus and Analytic Geometry II', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 23, 'M/W/F', 'class description', "Rm 205 O'Connor Hall", 133);
INSERT  INTO professors (first_name, last_name) VALUES ("Chi-Yun", "Hsu");
INSERT INTO teach (pr_id, cl_id) VALUES (142, 188);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MATH 13', 'N/A', '', 'Calculus and Analytic Geometry III', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 23, 'M/W/F', 'class description', "Rm 107 O'Connor Hall", 134);
INSERT  INTO professors (first_name, last_name) VALUES ("Shilpa", "Dasgupta");
INSERT INTO teach (pr_id, cl_id) VALUES (143, 189);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 4, 'M/W/F', 'class description', "Rm 308 Lucas Hall", 134);
INSERT INTO teach (pr_id, cl_id) VALUES (68, 190);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 18, 'M/W/F', 'class description', "Rm 207 Daly Science 200", 134);
INSERT  INTO professors (first_name, last_name) VALUES ("Reza", "Shariatmadari");
INSERT INTO teach (pr_id, cl_id) VALUES (144, 191);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MATH 53', 'N/A', '', 'Linear Algebra', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 20, 'M/W/F', 'class description', "Rm 135 Vari Hall", 135);
INSERT  INTO professors (first_name, last_name) VALUES ("Byron", "Walden");
INSERT INTO teach (pr_id, cl_id) VALUES (145, 192);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 13, 'M/W/F', 'class description', "Rm 105 O'Connor Hall", 135);
INSERT  INTO professors (first_name, last_name) VALUES ("Glenn", "Appleby");
INSERT INTO teach (pr_id, cl_id) VALUES (146, 193);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MATH 178', 'N/A', '', 'Cryptography', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 16:35', 'Fall', 20, 'M/W/F', 'class description', "Rm 104 O'Connor Hall", 136);
INSERT  INTO professors (first_name, last_name) VALUES ("Shamil", "Asgarli");
INSERT INTO teach (pr_id, cl_id) VALUES (147, 194);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MECH 12L', 'N/A', '', 'Engineering Graphics  CAD II', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:00 - 13:45', 'Fall', 16, 'T', 'class description', "Rm 107 Heafey Hall", 137);
INSERT  INTO professors (first_name, last_name) VALUES ("Rodney", "");
INSERT INTO teach (pr_id, cl_id) VALUES (148, 195);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MECH 45', 'N/A', '', 'Applied Programming in MATLAB', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 25, 'M/W/F', 'class description', "Rm 122 Heafey Hall", 138);
INSERT  INTO professors (first_name, last_name) VALUES ("Peter", "Woytowitz");
INSERT INTO teach (pr_id, cl_id) VALUES (149, 196);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MECH 121', 'N/A', '', 'Thermodynamics I', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 19, 'T/TH', 'class description', "Rm 129 Heafey Hall", 139);
INSERT  INTO professors (first_name, last_name) VALUES ("Robert", "Marks");
INSERT INTO teach (pr_id, cl_id) VALUES (150, 197);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MECH 171', 'N/A', '', 'Special Topics in Material Mechanics Manufacturing and Design MMMD', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('19:10 - 21:00', 'Fall', 14, 'M/W', 'class description', "Rm 122 Heafey Hall", 140);
INSERT  INTO professors (first_name, last_name) VALUES ("Jun", "Wang");
INSERT INTO teach (pr_id, cl_id) VALUES (151, 198);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MGMT 80', 'N/A', 'c&i3', 'Global and Cultural Environment of Business', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 15, 'M/W/F', 'class description', "Rm 210 Lucas Hall", 141);
INSERT  INTO professors (first_name, last_name) VALUES ("Vahideh", "Abaeian");
INSERT INTO teach (pr_id, cl_id) VALUES (152, 199);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MGMT 80S', 'N/A', 'c&i3', 'Global  Cultur Environ of Bus', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 6, 'M/W/F', 'class description', "Rm 209 Lucas Hall", 142);
INSERT  INTO professors (first_name, last_name) VALUES ("Long", "Le");
INSERT INTO teach (pr_id, cl_id) VALUES (153, 200);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MGMT 160', 'N/A', '', 'Management of Organizations', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 9, 'T/TH', 'class description', "Rm 008 Casa Italiana Residence", 143);
INSERT  INTO professors (first_name, last_name) VALUES ("Francine", "Gordon");
INSERT INTO teach (pr_id, cl_id) VALUES (154, 201);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 16, 'T/TH', 'class description', "Rm 008 Casa Italiana Residence", 143);
INSERT INTO teach (pr_id, cl_id) VALUES (154, 202);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 5, 'T/TH', 'class description', "Rm 008 Casa Italiana Residence", 143);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 203);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MGMT 162', 'N/A', '', 'Strategic Analysis', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 25, 'T/TH', 'class description', "Rm 307 Lucas Hall", 144);
INSERT  INTO professors (first_name, last_name) VALUES ("Timothy", "Harris");
INSERT INTO teach (pr_id, cl_id) VALUES (155, 204);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MGMT 162S', 'N/A', '', 'Strategic Analysis', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 12, 'T/TH', 'class description', "Rm 102 Alameda hall", 145);
INSERT  INTO professors (first_name, last_name) VALUES ("Shaohua", "Lu");
INSERT INTO teach (pr_id, cl_id) VALUES (156, 205);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MGMT 174', 'N/A', '', 'Social Psychology of Leadership', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 19, 'T/TH', 'class description', "Rm 107 O'Connor Hall", 146);
INSERT  INTO professors (first_name, last_name) VALUES ("Lisa", "Shannon");
INSERT INTO teach (pr_id, cl_id) VALUES (157, 206);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MILS 22', 'N/A', '', 'Army Doctrine Team Development and Decision Making', 3);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 16, 'T/TH', 'class description', "Rm 003 Casa Italiana Residence", 147);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 207);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MKTG 169', 'N/A', '', 'Adv Retail Studies Seminar', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 17, 'T/TH', 'class description', "Rm 207 O'Connor Hall", 148);
INSERT  INTO professors (first_name, last_name) VALUES ("Kirthi", "Kalyanam");
INSERT INTO teach (pr_id, cl_id) VALUES (158, 208);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 22, 'T/TH', 'class description', "Rm 205 O'Connor Hall", 148);
INSERT INTO teach (pr_id, cl_id) VALUES (158, 209);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MKTG 175', 'N/A', '', 'Internet Marketing and E', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 16, 'T/TH', 'class description', "Rm 210 Edward M. Dowd Art & Art History", 149);
INSERT  INTO professors (first_name, last_name) VALUES ("Patrick", "Williams");
INSERT INTO teach (pr_id, cl_id) VALUES (159, 210);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MKTG 181', 'N/A', '', 'Principles of Marketing', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 12, 'T/TH', 'class description', "Rm 104 Kenna Hall", 150);
INSERT  INTO professors (first_name, last_name) VALUES ("Jang", "Choi");
INSERT INTO teach (pr_id, cl_id) VALUES (160, 211);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MKTG 181S', 'N/A', '', 'Principles of Marketing', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 2, 'M/W/F', 'class description', "Rm 108 Alameda hall", 151);
INSERT  INTO professors (first_name, last_name) VALUES ("Shunyao", "Yan");
INSERT INTO teach (pr_id, cl_id) VALUES (161, 212);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 8', 'N/A', 'arts', 'Introduction to Listening Western Music', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 9, 'T/TH', 'class description', "Rm 119 Music And Dance", 152);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 213);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 116', 'N/A', '', 'Music at Noon', 1);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 24, 'M/W', 'class description', "Rm 103 Music And Dance - Recital Hall", 153);
INSERT  INTO professors (first_name, last_name) VALUES ("Ray", "Furuta");
INSERT INTO teach (pr_id, cl_id) VALUES (162, 214);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 131', 'N/A', '', 'Music Writing and Research', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 20, 'T/TH', 'class description', "Rm 119 Music And Dance", 154);
INSERT  INTO professors (first_name, last_name) VALUES ("Christina", "Zanfagna");
INSERT INTO teach (pr_id, cl_id) VALUES (163, 215);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 143', 'N/A', 'arts', 'Chamber Singers', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 10, 'T/TH', 'class description', "Rm 103 Music And Dance - Recital Hall", 155);
INSERT  INTO professors (first_name, last_name) VALUES ("Scot", "Hanna-Weir");
INSERT INTO teach (pr_id, cl_id) VALUES (164, 216);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 145', 'N/A', 'arts', 'Jazz Ensemble', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('19:30 - 22:00', 'Fall', 3, 'W', 'class description', "Rm 106 Music And Dance - Rehearsal Hall", 156);
INSERT  INTO professors (first_name, last_name) VALUES ("Carl", "Schultz");
INSERT INTO teach (pr_id, cl_id) VALUES (165, 217);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 152', 'N/A', 'arts', 'World Music Ensemble', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:40 - 20:40', 'Fall', 19, 'TH', 'class description', "Rm 106 Music And Dance - Rehearsal Hall", 157);
INSERT INTO teach (pr_id, cl_id) VALUES (162, 218);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('MUSC 154', 'N/A', 'arts', 'Wind Ensemble', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('19:00 - 22:00', 'Fall', 3, 'M', 'class description', "Rm 106 Music And Dance - Rehearsal Hall", 158);
INSERT  INTO professors (first_name, last_name) VALUES ("Anthony", "Rivera");
INSERT INTO teach (pr_id, cl_id) VALUES (166, 219);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('NEUR 10', 'N/A', '', 'Explorations in Neuroscience', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 7, 'T/TH', 'class description', "RM 3116 SCDI", 159);
INSERT  INTO professors (first_name, last_name) VALUES ("Jennifer", "Frihauf");
INSERT INTO teach (pr_id, cl_id) VALUES (167, 220);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('OMIS 15', 'N/A', '', 'Introduction to Spreadsheets', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 12:00', 'Fall', 21, 'F', 'class description', "Rm 310 Lucas Hall", 160);
INSERT  INTO professors (first_name, last_name) VALUES ("Sumana", "Sur");
INSERT INTO teach (pr_id, cl_id) VALUES (168, 221);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('OMIS 41', 'N/A', '', 'Statistics and Data Analysis II', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 5, 'M/W/F', 'class description', "Rm 308 Lucas Hall", 161);
INSERT  INTO professors (first_name, last_name) VALUES ("Xuan", "Tan");
INSERT INTO teach (pr_id, cl_id) VALUES (169, 222);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('OMIS 108E', 'N/A', '', 'Sustainable Operations Management', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 2, 'T/TH', 'class description', "Rm 209 Lucas Hall", 162);
INSERT  INTO professors (first_name, last_name) VALUES ("Thunyarat", "Amornpetchkul");
INSERT INTO teach (pr_id, cl_id) VALUES (170, 223);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('OMIS 120', 'N/A', '', 'Web Programming', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 18:50', 'Fall', 9, 'F', 'class description', "Rm 208 Lucas Hall", 163);
INSERT  INTO professors (first_name, last_name) VALUES ("Haibing", "Lu");
INSERT INTO teach (pr_id, cl_id) VALUES (171, 224);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('OMIS 137', 'N/A', '', 'Object', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 9, 'T/TH', 'class description', "Rm 135 Vari Hall", 164);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 225);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 2H', 'N/A', 'ctw2', 'Critical Think and Write II Honors', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 4, 'M/W/F', 'class description', "Rm 122 Edward M. Dowd Art & Art History", 165);
INSERT  INTO professors (first_name, last_name) VALUES ("Robert", "Shanklin");
INSERT INTO teach (pr_id, cl_id) VALUES (172, 226);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 11A', 'N/A', 'c&i1', 'Cultures and Ideas I Justice SelfOthersCommunity', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 2, 'T/TH', 'class description', "Rm 302 Alumni Science Hall", 166);
INSERT  INTO professors (first_name, last_name) VALUES ("Erin", "Bradfield");
INSERT INTO teach (pr_id, cl_id) VALUES (173, 227);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 12A', 'N/A', 'c&i2', 'Cultures and Ideas II Personal Identity and Community', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 20, 'T/TH', 'class description', "Rm 003 Casa Italiana Residence", 167);
INSERT  INTO professors (first_name, last_name) VALUES ("Kimberly", "Dill");
INSERT INTO teach (pr_id, cl_id) VALUES (174, 228);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 23, 'M/W/F', 'class description', "Rm 003 Casa Italiana Residence", 167);
INSERT  INTO professors (first_name, last_name) VALUES ("Matthew", "Izor");
INSERT INTO teach (pr_id, cl_id) VALUES (175, 229);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 7, 'M/W/F', 'class description', "Rm 003 Casa Italiana Residence", 167);
INSERT INTO teach (pr_id, cl_id) VALUES (175, 230);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 26', 'N/A', 'ethics', 'Ethics in Business', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 21, 'M/W/F', 'class description', "Rm 122 Heafey Hall", 168);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 231);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 27H', 'N/A', 'ethics', 'Ethics in Health Care', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 22, 'M/W/F', 'class description', "Rm 206 Edward M. Dowd Art & Art History", 169);
INSERT  INTO professors (first_name, last_name) VALUES ("Lawrence", "Nelson");
INSERT INTO teach (pr_id, cl_id) VALUES (176, 232);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 32', 'N/A', 'ethics', 'Neuroethics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 15, 'T/TH', 'class description', "Rm 111 Kenna Hall", 170);
INSERT  INTO professors (first_name, last_name) VALUES ("Erick", "Ramirez");
INSERT INTO teach (pr_id, cl_id) VALUES (177, 233);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 142B', 'N/A', '', 'Medieval Philosophy Augustine', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 16, 'T/TH', 'class description', "Commons Mclaughlin-Walsh Residence Hall", 171);
INSERT  INTO professors (first_name, last_name) VALUES ("Jeffrey", "Steele");
INSERT INTO teach (pr_id, cl_id) VALUES (178, 234);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHIL 180', 'N/A', '', 'Special Topics in Non Western Philosophy Japanese Philosophy Nishida', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 25, 'M/W/F', 'class description', "Rm 103 O'Connor Hall", 172);
INSERT INTO teach (pr_id, cl_id) VALUES (175, 235);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHYS 31', 'N/A', 'natural science', 'Physics for Scientists and Engineers I', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 16, 'M/W/F', 'class description', "RM 1308 SCDI", 173);
INSERT  INTO professors (first_name, last_name) VALUES ("Kristin", "Kulas");
INSERT INTO teach (pr_id, cl_id) VALUES (179, 236);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:30', 'Fall', 3, 'T', 'class description', "RM 2319 SCDI", 173);
INSERT  INTO professors (first_name, last_name) VALUES ("John", "Jameson");
INSERT INTO teach (pr_id, cl_id) VALUES (180, 237);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:00 - 17:00', 'Fall', 20, 'TH', 'class description', "RM 2319 SCDI", 173);
INSERT  INTO professors (first_name, last_name) VALUES ("Hassan", "Alshal");
INSERT INTO teach (pr_id, cl_id) VALUES (181, 238);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:40 - 12:40', 'Fall', 25, 'F', 'class description', "RM 2319 SCDI", 173);
INSERT  INTO professors (first_name, last_name) VALUES ("Omid", "Ahmadi-Gorgi");
INSERT INTO teach (pr_id, cl_id) VALUES (182, 239);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PHYS 34', 'N/A', '', 'Physics for Scientists and Engineers IV', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 3, 'M/W/F', 'class description', "RM 2301 SCDI", 174);
INSERT  INTO professors (first_name, last_name) VALUES ("Bachana", "Lomsadze");
INSERT INTO teach (pr_id, cl_id) VALUES (183, 240);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 1', 'N/A', 'civic engagement', 'Introduction to US Politics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 20, 'M/W/F', 'class description', "Rm 304 Kenna Hall", 175);
INSERT  INTO professors (first_name, last_name) VALUES ("Vivien", "Leung");
INSERT INTO teach (pr_id, cl_id) VALUES (184, 241);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 2', 'N/A', 'c&i3, social science', 'Introduction to Comparative Politics', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 25, 'T/TH', 'class description', "Rm 133 Vari Hall", 176);
INSERT  INTO professors (first_name, last_name) VALUES ("Eric", "Mosinger");
INSERT INTO teach (pr_id, cl_id) VALUES (185, 242);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 30', 'N/A', '', 'Introduction to Political Philosophy', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 14, 'M/W/F', 'class description', "Rm 133 Vari Hall", 177);
INSERT  INTO professors (first_name, last_name) VALUES ("Peter", "Minowitz");
INSERT INTO teach (pr_id, cl_id) VALUES (186, 243);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 112', 'N/A', '', 'History of Political Philosophy II Liberalism and Its Roots', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 4, 'M/W/F', 'class description', "Rm 133 Vari Hall", 178);
INSERT INTO teach (pr_id, cl_id) VALUES (186, 244);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 123', 'N/A', '', 'Global Environmental Politics', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 6, 'T/TH', 'class description', "Rm 128 Vari Hall", 179);
INSERT  INTO professors (first_name, last_name) VALUES ("Dennis", "Gordon");
INSERT INTO teach (pr_id, cl_id) VALUES (187, 245);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 157', 'N/A', 'civic engagement', 'Environmental Politics and Policy', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 18, 'T/TH', 'class description', "RM 3302 SCDI", 180);
INSERT INTO teach (pr_id, cl_id) VALUES (125, 246);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('POLI 195L', 'N/A', '', 'Seminar in US Politics', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:50 - 17:30', 'Fall', 15, 'T/TH', 'class description', "Rm 122 Edward M. Dowd Art & Art History", 181);
INSERT  INTO professors (first_name, last_name) VALUES ("Elsa", "Chen");
INSERT INTO teach (pr_id, cl_id) VALUES (188, 247);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 1', 'N/A', 'social science', 'General Psychology I', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 3, 'M/W/F', 'class description', "Rm 120 Alumni Science Hall", 182);
INSERT INTO teach (pr_id, cl_id) VALUES (167, 248);

INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 1, 'M/W/F', 'class description', "Rm 120 Alumni Science Hall", 182);
INSERT  INTO professors (first_name, last_name) VALUES ("Barbara", "O'Brien");
INSERT INTO teach (pr_id, cl_id) VALUES (189, 249);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 51', 'N/A', '', 'Statistics and Methods', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 19, 'M/W/F', 'class description', "Rm 101 Alumni Science Hall", 183);
INSERT  INTO professors (first_name, last_name) VALUES ("Dena", "Bahmani");
INSERT INTO teach (pr_id, cl_id) VALUES (190, 250);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 116', 'N/A', '', 'Advanced Topics in Psychopathology', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 5, 'T/TH', 'class description', "Rm 120 Alumni Science Hall", 184);
INSERT  INTO professors (first_name, last_name) VALUES ("Thomas", "Plante");
INSERT INTO teach (pr_id, cl_id) VALUES (191, 251);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 150', 'N/A', '', 'Social Psychology', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 15, 'M/W/F', 'class description', "Rm 109 O'Connor Hall", 185);
INSERT  INTO professors (first_name, last_name) VALUES ("Kathryn", "Bruchmann");
INSERT INTO teach (pr_id, cl_id) VALUES (192, 252);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 162', 'N/A', '', 'Cultural Psychology', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 8, 'T/TH', 'class description', "Rm 101 Alumni Science Hall", 186);
INSERT  INTO professors (first_name, last_name) VALUES ("Birgit", "Koopmann-Holm");
INSERT INTO teach (pr_id, cl_id) VALUES (193, 253);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 166', 'N/A', '', 'Human Neuropsychology', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 20, 'M/W/F', 'class description', "Rm 220 Alumni Science Hall", 187);
INSERT INTO teach (pr_id, cl_id) VALUES (167, 254);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('PSYC 172', 'N/A', '', 'Adolescent Development', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 7, 'M/W/F', 'class description', "Rm 101 Alumni Science Hall", 188);
INSERT  INTO professors (first_name, last_name) VALUES ("Romina", "Miller");
INSERT INTO teach (pr_id, cl_id) VALUES (194, 255);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('RSOC 56', 'N/A', 'rel2', 'The Meaning of Life', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('18:00 - 19:45', 'Fall', 5, 'M/W', 'class description', "Rm 310 Kenna Hall", 189);
INSERT  INTO professors (first_name, last_name) VALUES ("Kevin", "Chaves");
INSERT INTO teach (pr_id, cl_id) VALUES (195, 256);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('RSOC 99', 'N/A', 'rel2', 'Sociology of Religion', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 5, 'M/W/F', 'class description', "Rm 308 Kenna Hall", 190);
INSERT  INTO professors (first_name, last_name) VALUES ("John", "Heller");
INSERT INTO teach (pr_id, cl_id) VALUES (196, 257);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('RSOC 184', 'N/A', 'rel3', 'Race and Religion in the United States', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('08:30 - 10:10', 'Fall', 25, 'T/TH', 'class description', "Rm 163 Graham Hall", 191);
INSERT  INTO professors (first_name, last_name) VALUES ("Bryson", "White");
INSERT INTO teach (pr_id, cl_id) VALUES (197, 258);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SCTR 168', 'N/A', 'rel3', 'Character of God Hebrew Bible', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 24, 'M/W/F', 'class description', "Rm 201 O'Connor Hall", 192);
INSERT  INTO professors (first_name, last_name) VALUES ("Cathleen", "Chopra-McGowan");
INSERT INTO teach (pr_id, cl_id) VALUES (198, 259);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 1', 'N/A', 'social science', 'Principles of Sociology', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 17, 'M/W/F', 'class description', "Rm 109 O'Connor Hall", 193);
INSERT  INTO professors (first_name, last_name) VALUES ("Cara", "Chiaraluce");
INSERT INTO teach (pr_id, cl_id) VALUES (199, 260);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 30', 'N/A', 'civic engagement', 'Self Community and Society', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 5, 'M/W', 'class description', "Rm 101 Alameda hall", 194);
INSERT  INTO professors (first_name, last_name) VALUES ("Zachary", "Frazier");
INSERT INTO teach (pr_id, cl_id) VALUES (200, 261);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 35', 'N/A', 'social science', 'Introduction to Research', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 20, 'T/TH', 'class description', "Rm 107 O'Connor Hall", 195);
INSERT  INTO professors (first_name, last_name) VALUES ("Laura", "Nichols");
INSERT INTO teach (pr_id, cl_id) VALUES (201, 262);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 99', 'N/A', 'rel2', 'Sociology of Religion', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 7, 'M/W/F', 'class description', "Rm 105 Alameda hall", 196);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 263);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 170', 'N/A', 'diversity', 'Body Politics', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 14, 'T/TH', 'class description', "Rm 109 O'Connor Hall", 197);
INSERT  INTO professors (first_name, last_name) VALUES ("Margaret", "Hunter");
INSERT INTO teach (pr_id, cl_id) VALUES (202, 264);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 172', 'N/A', 'civic engagement', 'Management of Health Care Organizations', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('15:30 - 17:15', 'Fall', 11, 'M/W', 'class description', "Rm 108 Alameda hall", 198);
INSERT  INTO professors (first_name, last_name) VALUES ("Sheila", "Yuter");
INSERT INTO teach (pr_id, cl_id) VALUES (203, 265);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SOCI 198', 'N/A', 'civic engagement', 'Public Sociology', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('11:45 - 15:00', 'Fall', 9, 'F', 'class description', "Rm 232 Vari Hall", 199);
INSERT INTO teach (pr_id, cl_id) VALUES (199, 266);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SPAN 3', 'N/A', '', 'Introduction to Spanish and Spanish', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 6, 'M/W/F', 'class description', "Rm 111 Kenna Hall", 200);
INSERT  INTO professors (first_name, last_name) VALUES ("Maria", "Bauluz");
INSERT INTO teach (pr_id, cl_id) VALUES (204, 267);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SPAN 22', 'N/A', '', 'Latino Cultures and Identities', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 10, 'M/W/F', 'class description', "Rm 304 Kenna Hall", 201);
INSERT  INTO professors (first_name, last_name) VALUES ("Ariel", "Schindewolf");
INSERT INTO teach (pr_id, cl_id) VALUES (205, 268);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SPAN 101', 'N/A', '', 'Introduction to Literary and Cultural Analysis', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 22, 'T/TH', 'class description', "Rm 207 O'Connor Hall", 202);
INSERT  INTO professors (first_name, last_name) VALUES ("Jose", "Ortigas");
INSERT INTO teach (pr_id, cl_id) VALUES (206, 269);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('SPAN 144', 'N/A', '', 'Contemporary Indigenous Cultures', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 24, 'M/W/F', 'class description', "Rm 212 Kenna Hall", 203);
INSERT  INTO professors (first_name, last_name) VALUES ("Victor", "Quiroz");
INSERT INTO teach (pr_id, cl_id) VALUES (207, 270);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('TESP 124', 'N/A', 'rel3', 'Theology of Marriage', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 19, 'T/TH', 'class description', "Rm 209 O'Connor Hall", 204);
INSERT  INTO professors (first_name, last_name) VALUES ("Sally", "Vance-Trembath");
INSERT INTO teach (pr_id, cl_id) VALUES (208, 271);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('TESP 183', 'N/A', 'rel3', 'Ignatian Spirituality', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 22, 'M/W/F', 'class description', "Rm 008 Casa Italiana Residence", 205);
INSERT  INTO professors (first_name, last_name) VALUES ("Robert", "Scholla");
INSERT INTO teach (pr_id, cl_id) VALUES (209, 272);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 9', 'N/A', '', 'Defining the Performing Artist', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 6, 'M/W/F', 'class description', "Rm 226 Mayer Theatre - Rehearsal Hall 2", 206);
INSERT  INTO professors (first_name, last_name) VALUES ("Kristin", "Kusanovich");
INSERT INTO teach (pr_id, cl_id) VALUES (210, 273);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 11A', 'N/A', 'c&i1', 'Cultures and Ideas I All the Worlds a Stage', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 24, 'M/W/F', 'class description', "Rm 231 Mayer Theatre", 207);
INSERT  INTO professors (first_name, last_name) VALUES ("Lazlo", "Pearlman");
INSERT INTO teach (pr_id, cl_id) VALUES (211, 274);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 37', 'N/A', '', 'Graphics and Rendering for Theatre Design', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 22, 'T/TH', 'class description', "Rm 301 Mayer Theatre - Library", 208);
INSERT INTO teach (pr_id, cl_id) VALUES (12, 275);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 39', 'N/A', '', 'Production Workshop', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('16:45 - 17:50', 'Fall', 20, 'W', 'class description', "Rm 224 Mayer Theatre - Fess Parker Theatre", 209);
INSERT  INTO professors (first_name, last_name) VALUES ("Erik", "Sunderman");
INSERT INTO teach (pr_id, cl_id) VALUES (212, 276);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 118', 'N/A', '', 'Studies in Shakespeare', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:20 - 12:00', 'Fall', 6, 'T/TH', 'class description', "Rm 007 Casa Italiana Residence", 210);
INSERT INTO teach (pr_id, cl_id) VALUES (115, 277);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 163', 'N/A', 'diversity', 'Theatre of Dissent', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:00 - 15:40', 'Fall', 19, 'T/TH', 'class description', "Rm 231 Mayer Theatre", 211);
INSERT  INTO professors (first_name, last_name) VALUES ("Karina", "Gutierrez");
INSERT INTO teach (pr_id, cl_id) VALUES (213, 278);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 170', 'N/A', '', 'Playwriting', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 18, 'T/TH', 'class description', "Rm 231 Mayer Theatre", 212);
INSERT INTO teach (pr_id, cl_id) VALUES (117, 279);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('THTR 186', 'N/A', '', 'Stage Directing', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 6, 'M/W/F', 'class description', "Rm 226 Mayer Theatre - Rehearsal Hall 2", 213);
INSERT  INTO professors (first_name, last_name) VALUES ("Jeffrey", "Bracco");
INSERT INTO teach (pr_id, cl_id) VALUES (214, 280);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('UGST 101', 'N/A', '', 'Fellowship and Grad School Preparation', 2);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('17:25 - 19:10', 'Fall', 7, 'W', 'class description', "Rm 302 Alumni Science Hall", 214);
INSERT INTO teach (pr_id, cl_id) VALUES (114, 281);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('WGST 11A', 'N/A', 'c&i1', 'Cultures and Ideas I Gender in Transnl Perspective', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 15, 'M/W/F', 'class description', "Rm 201 O'Connor Hall", 215);
INSERT  INTO professors (first_name, last_name) VALUES ("CiAuna", "Heard");
INSERT INTO teach (pr_id, cl_id) VALUES (215, 282);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('WGST 12A', 'N/A', 'c&i2', 'Cultures and Ideas II GenderCultureScience  Tech', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 8, 'T/TH', 'class description', "Rm 210 Edward M. Dowd Art & Art History", 216);
INSERT  INTO professors (first_name, last_name) VALUES ("Mukta", "Sharangpani");
INSERT INTO teach (pr_id, cl_id) VALUES (216, 283);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('WGST 44', 'N/A', 'rel2', 'Sexuality and Spiriuality in Latinx Theology', 4);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 18, 'M/W/F', 'class description', "Rm 105 Kenna Hall", 217);
INSERT  INTO professors (first_name, last_name) VALUES ("Pearl", "Barros");
INSERT INTO teach (pr_id, cl_id) VALUES (217, 284);


INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('WGST 141A', 'N/A', '', 'th Century Womens British Literature', 5);
INSERT  INTO classes (time, term, total_seats, days, description, location, c_id) VALUES ('12:10 - 13:50', 'Fall', 20, 'T/TH', 'class description', "Rm 163 Graham Hall", 218);
INSERT  INTO professors (first_name, last_name) VALUES ("Kirstyn", "Leuner");
INSERT INTO teach (pr_id, cl_id) VALUES (218, 285);

-- END WINTER 2024 CLASSES
