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

CREATE TABLE IF NOT EXISTS classAvail (
  cl_id INT NOT NULL,
  total_seats INT NOT NULL,
  available_seats INT NOT NULL,
  PRIMARY KEY (cl_id),
  FOREIGN KEY (cl_id) REFERENCES classes(cl_id) ON DELETE CASCADE
);

-- trigger to decrease available seats
DELIMITER //

CREATE TRIGGER decrease_available_seats
AFTER INSERT ON schedule2class
FOR EACH ROW
BEGIN
    UPDATE classAvail
    SET available_seats = available_seats - 1
    WHERE cl_id = NEW.cl_id;
END;

//
DELIMITER ;


-- -- trigger to increase available seats
DELIMITER //

CREATE TRIGGER increase_available_seats
AFTER DELETE ON schedule2class
FOR EACH ROW
BEGIN
    UPDATE classAvail
    SET available_seats = available_seats + 1
    WHERE cl_id = OLD.cl_id;
END;

//
DELIMITER ;


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
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 62', 'N/A', '', 'Advanced Programming', 4);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 146', 'N/A', '', 'Optimization I', 5);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 161', 'N/A', '', 'Theory of Automata and Languages', 5);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 163', 'N/A', '', 'Theory of Algorithms', 5);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 169', 'N/A', '', 'Programming Languages', 5);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 183', 'N/A', '', 'Data Science', 5);
-- INSERT  INTO course (title, co_reqs, core_req, name, units) VALUES ('CSCI 185', 'N/A', '', 'Web and Data Mining', 5);

-- Classes
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 'M/W/F', 'Introduction to computer science, and computer programming in Python. Basic programming structures, conditionals, loops, functions, recursion, arrays. Topics relating to the applications of and social impact of computing, including privacy, artificial intelligence, computation in physics, psychology, and biology. Discussion of cryptography, computation through history, networks, hardware, and basic runtime analysis.', "Rm 205 O'Connor Hall", 1);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 'M/W/F', 'Introduction to computer science, and computer programming in Python. Basic programming structures, conditionals, loops, functions, recursion, arrays. Topics relating to the applications of and social impact of computing, including privacy, artificial intelligence, computation in physics, psychology, and biology. Discussion of cryptography, computation through history, networks, hardware, and basic runtime analysis.', "Rm 205 O'Connor Hall", 1);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('16:45 - 17:50', 'Fall', 'M/W/F', 'Basic object-oriented programming techniques using C++: abstract data types and objects; encapsulation. The five phases of software development (specification, design, implementation, analysis, and testing). Memory management and pointers.', "Rm 207 O'Connor Hall", 2);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 'M/W/F', 'Basic object-oriented programming techniques using C++: abstract data types and objects; encapsulation. The five phases of software development (specification, design, implementation, analysis, and testing). Memory management and pointers.', "Rm 104 Kenna Hall", 2);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 'M/W/F', 'Specification, implementations, and analysis of basic data structures (stacks, queues, hash tables, binary trees) and their applications in sorting and searching algorithms. Using the Standard Template Library. Runtime Analysis.', "Rm 207 O'Connor Hall", 3);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('08:00 - 09:05', 'Fall', 'M/W/F', 'Specification, implementations, and analysis of basic data structures (stacks, queues, hash tables, binary trees) and their applications in sorting and searching algorithms. Using the Standard Template Library. Runtime Analysis.', "Rm 204 O'Connor Hall", 3);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 'M/W/F', 'Advanced object-oriented programming and applications of object-oriented programming and data structures. Topics include GUI design, testing and debugging skills, graphs, file processing, inheritance, polymorphism, and design and implementation of large software projects. Topics will be applied primarily in the context of a social network, developed iteratively throughout the quarter. Software development projects will include topics in data science, security, and algorithms.', "RM 3116 SCDI", 4);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 'M/W/F', 'Methods for finding local maxima and minima of functions of multiple variables in either unconstrained or constrained domains: the Hessian matrix; Newton’s Method; Lagrangians; Karush-Kuhn-Tucker conditions; Convexity and Convex Programming; Methods for determining functions that optimize an objective, like maximizing profit or minimizing task completion time; Calculus of variations; Optimal control; and Deterministic dynamic programming.', "Rm 218 Kenna Hall", 5);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 'M/W/F', 'Classification of automata, formal languages, and grammars. Chomsky hierarchy. Representation of automata and grammars, BNF. Deterministic and nondeterministic finite state automata. Regular expressions and languages. Push-down automata. Context-free languages. Context-sensitive grammars and linear bounded automata. Recursively enumerable languages. Turing machines; normal forms; undecidability.', "Rm 106 O'Connor Hall", 6);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('10:30 - 11:35', 'Fall', 'M/W/F', 'Classification of automata, formal languages, and grammars. Chomsky hierarchy. Representation of automata and grammars, BNF. Deterministic and nondeterministic finite state automata. Regular expressions and languages. Push-down automata. Context-free languages. Context-sensitive grammars and linear bounded automata. Recursively enumerable languages. Turing machines; normal forms; undecidability.', "Rm 106 O'Connor Hall", 6);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 'M/W/F', 'Introduction to techniques of design and analysis of algorithms: asymptotic notations and running times of recursive algorithms. Design strategies: brute-force, divide and conquer, decrease and conquer, transform and conquer, dynamic programming, greedy technique. Intractability: P and NP, approximation algorithms.', "Rm 102 Kenna Hall", 7);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 'M/W/F', 'Introduction to techniques of design and analysis of algorithms: asymptotic notations and running times of recursive algorithms. Design strategies: brute-force, divide and conquer, decrease and conquer, transform and conquer, dynamic programming, greedy technique. Intractability: P and NP, approximation algorithms.', "Rm 105 Kenna Hall", 7);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 'M/W/F', 'Introduction to techniques of design and analysis of algorithms: asymptotic notations and running times of recursive algorithms. Design strategies: brute-force, divide and conquer, decrease and conquer, transform and conquer, dynamic programming, greedy technique. Intractability: P and NP, approximation algorithms.', "RM 3302 SCDI", 7);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('13:00 - 14:05', 'Fall', 'M/W/F', 'Comparative study of major classes of programming languages, with particular focus on functional programming. Introduction to theoretical definitions of languages and run-time concerns, with emphasis on strong points and weak points of various languages and on using the appropriate language for a given task. Programs written in several languages (e.g., Python, Java, Scala).', "Rm 106 O'Connor Hall", 8);
-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('14:15 - 15:20', 'Fall', 'M/W/F', 'Comparative study of major classes of programming languages, with particular focus on functional programming. Introduction to theoretical definitions of languages and run-time concerns, with emphasis on strong points and weak points of various languages and on using the appropriate language for a given task. Programs written in several languages (e.g., Python, Java, Scala).', "Rm 106 O'Connor Hall", 8);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('11:45 - 12:50', 'Fall', 'M/W/F', 'Data manipulation, analysis, and visualization. Statistical modeling, dimension reduction and techniques of supervised and unsupervised learning. Big data software technologies.', "Rm 306 Kenna Hall", 9);

-- INSERT  INTO classes (time, term, days, description, location, c_id) VALUES ('09:15 - 10:20', 'Fall', 'M/W/F', 'Web and data mining paradigms, data pre-processing and analysis, information retrieval and search engines, text analysis, link analysis, ranking, advanced topics.', "RM 3302 SCDI", 10);

-- Professors
-- INSERT  INTO professors (first_name, last_name) VALUES ('Shiva', 'Houshmand');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Natalie', 'Linnell');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Nicholas', 'Tran');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Smita', 'Ghosh');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Hien', 'Vu');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Ray', 'Li');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Daniel', 'Ostrov');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Sara', 'Krehbiel');
-- INSERT  INTO professors (first_name, last_name) VALUES ('Venkatesh', 'Srinivasan');
-- INSERT  INTO professors (first_name, last_name) VALUES ('TBD', '');

-- Reviews
-- INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 1, 'Great class!', 1);
-- INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (1, 2, 'Very informative and engaging.', 2);
-- INSERT INTO reviews (pr_id, cl_id, review, user_id) VALUES (2, 1, 'I learned a lot from this course.', 1);
 
-- Teach
-- INSERT INTO teach (pr_id, cl_id) VALUES (1, 1);
-- INSERT INTO teach (pr_id, cl_id) VALUES (1, 2);
-- INSERT INTO teach (pr_id, cl_id) VALUES (2, 3);
-- INSERT INTO teach (pr_id, cl_id) VALUES (3, 4);
-- INSERT INTO teach (pr_id, cl_id) VALUES (4, 5);
-- INSERT INTO teach (pr_id, cl_id) VALUES (5, 6);
-- INSERT INTO teach (pr_id, cl_id) VALUES (6, 7);
-- INSERT INTO teach (pr_id, cl_id) VALUES (7, 8);
-- INSERT INTO teach (pr_id, cl_id) VALUES (8, 9);
-- INSERT INTO teach (pr_id, cl_id) VALUES (8, 10);
-- INSERT INTO teach (pr_id, cl_id) VALUES (9, 11);
-- INSERT INTO teach (pr_id, cl_id) VALUES (9, 12);
-- INSERT INTO teach (pr_id, cl_id) VALUES (3, 13);
-- INSERT INTO teach (pr_id, cl_id) VALUES (2, 14);
-- INSERT INTO teach (pr_id, cl_id) VALUES (2, 15);
-- INSERT INTO teach (pr_id, cl_id) VALUES (4, 16);
-- INSERT INTO teach (pr_id, cl_id) VALUES (10, 17);


-- classAvail
INSERT INTO classAvail (cl_id, total_seats, available_seats) VALUES (1, 25, 25);
INSERT INTO classAvail (cl_id, total_seats, available_seats) VALUES (2, 20, 20);
INSERT INTO classAvail (cl_id, total_seats, available_seats) VALUES (3, 30, 30);
INSERT INTO classAvail (cl_id, total_seats, available_seats) VALUES (4, 20, 20);
INSERT INTO classAvail (cl_id, total_seats, available_seats) VALUES (5, 15, 15);
INSERT INTO classAvail (cl_id, total_seats, available_seats) VALUES (6, 25, 25);


-- Schedule2class
INSERT INTO schedule2class(cl_id, sch_id) VALUES (1, 1);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (2, 1);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (3, 1);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (4, 2);
INSERT INTO schedule2class(cl_id, sch_id) VALUES (3, 2);
