-- Active: 1781180299291@@127.0.0.1@5433@users

-- CREATE DATABASE "users";



-- SELECT * FROM 'employees';

-- CREATE TABLE students (
--   student_id SERIAL PRIMARY KEY,
--   name VARCHAR(50) NOT NULL,
--   brach VARCHAR(30) NOT NULL
-- );

-- CREATE TABLE exam_scores (
--   score_id SERIAL PRIMARY KEY,
--   student_id INT NOT NULL REFERENCES students(student_id),
--   subject VARCHAR(30) NOT NULL,
--   score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
--   exam_month VARCHAR(7) NOT NULL
-- );

-- CREATE TABLE projects (
--   project_id SERIAL PRIMARY KEY,
--   student_id INT NOT NULL REFERENCES students(student_id),
--   title VARCHAR(80) NOT NULL,
--   marks INT NOT NULL CHECK (marks BETWEEN 0 AND 100)
-- );


-- INSERT INTO students (name, brach) VALUES
-- ('Laxman', 'MCA'),
-- ('Lakhan', 'BA'),
-- ('Lucky', '12th'),
-- ('Lakhya', '10th'),
-- ('Lakhu', 'PCB'),
-- ('Shinde', 'PCM'),
-- ('Patil', 'PCMB');

-- INSERT INTO exam_scores (student_id, subject, score, exam_month) VALUES
-- (1, 'Mathematics', 85, '2025-01'),
-- (1, 'Physics', 78, '2025-01'),
-- (1, 'Chemistry', 92, '2025-01'),
-- (2, 'Mathematics', 64, '2025-01'),
-- (2, 'Physics', 71, '2025-01'),
-- (2, 'Chemistry', 68, '2025-01'),
-- (3, 'Mathematics', 95, '2025-01'),
-- (3, 'Physics', 88, '2025-01'),
-- (3, 'Chemistry', 91, '2025-01'),
-- (4, 'Mathematics', 52, '2025-01'),
-- (4, 'Physics', 47, '2025-01'),
-- (4, 'Chemistry', 55, '2025-01'),
-- (5, 'Mathematics', 79, '2025-01'),
-- (5, 'Physics', 82, '2025-01'),
-- (5, 'Chemistry', 76, '2025-01'),
-- (6, 'Mathematics', 91, '2025-01'),
-- (6, 'Physics', 87, '2025-01'),
-- (6, 'Chemistry', 83, '2025-01'),
-- (7, 'Mathematics', 68, '2025-01'),
-- (7, 'Physics', 72, '2025-01'),
-- (7, 'Chemistry', 70, '2025-01');

-- INSERT INTO projects (student_id, title, marks) VALUES
-- (1, 'Solar Energy Harvesting System', 88),
-- (1, 'AI-Based Traffic Predictor', 91),
-- (1, 'Water Quality Monitoring Device', 86),
-- (2, 'E-Commerce Website Development', 67),
-- (2, 'Weather Forecasting App', 72),
-- (2, 'Personal Budgeting Tool', 70),
-- (3, 'Autonomous Robot Navigation', 96),
-- (3, 'Blockchain for Supply Chain', 94),
-- (3, 'Virtual Reality Classroom', 98),
-- (4, 'Mobile Health Tracker', 58),
-- (4, 'Online Quiz Platform', 61),
-- (4, 'Chatbot for Customer Support', 55),
-- (5, 'Fake News Detection Using ML', 84),
-- (5, 'Smart Home Automation', 79),
-- (5, 'Gesture-Controlled Drone', 89),
-- (6, 'Renewable Energy Simulator', 93),
-- (6, 'AI-Powered Recommendation System', 90),
-- (6, 'Cybersecurity Risk Analyzer', 87),
-- (7, 'Inventory Management System', 71),
-- (7, 'Fitness Tracking Mobile App', 68),
-- (7, 'E-Learning Platform Prototype', 74);


-- SELECT AVG(score) as class_average FROM exam_scores;


-- SELECT
--     s.name as student_name,
--     s.brach as student_branch,
--     e.score
-- FROM exam_scores as e
-- INNER JOIN students as s ON s.student_id = e.student_id;
