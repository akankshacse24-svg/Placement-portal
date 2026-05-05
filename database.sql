CREATE DATABASE placement_portal;

USE placement_portal;

CREATE TABLE student(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(50),
password VARCHAR(50)
);

CREATE TABLE questions(
id INT AUTO_INCREMENT PRIMARY KEY,
question VARCHAR(200),
option1 VARCHAR(50),
option2 VARCHAR(50),
option3 VARCHAR(50),
option4 VARCHAR(50),
answer VARCHAR(50)
);

INSERT INTO questions(question,option1,option2,option3,option4,answer)
VALUES('2+2=?','2','3','4','5','4'),
('5*3=?','15','10','20','25','15'),
('10 + 5 = ?', '10', '15', '20', '25', '15'),
('7 * 6 = ?', '42', '36', '48', '30', '42'),
('Square root of 81?', '7', '8', '9', '10', '9'),
('12 / 4 = ?', '2', '3', '4', '6', '3');

CREATE TABLE companies (
id INT AUTO_INCREMENT PRIMARY KEY,
company_name VARCHAR(100),
description TEXT
);

CREATE TABLE interview_questions (
id INT AUTO_INCREMENT PRIMARY KEY,
question TEXT
);

INSERT INTO companies(company_name,description)
VALUES('TCS','TCS recruitment process includes aptitude, technical and HR interview'),
('Infosys','Infosys recruitment includes coding test and interview'),
('Wipro','Wipro selection process includes aptitude and HR round');

INSERT INTO interview_questions(question)
VALUES('Tell me about yourself'),
('Why should we hire you?'),
('What are your strengths?'),
('Explain your final year project');

DELETE FROM questions WHERE id > 6;

DELETE FROM interview_questions WHERE id > 0;

INSERT INTO interview_questions(question)
VALUES
('Tell me about yourself'),
('Why should we hire you?'),
('What are your strengths?'),
('Explain your final year project'),
('What are your weaknesses?'),
('Describe a challenging situation you faced'),
('What is your biggest achievement?'),
('Why do you want this job?'),
('What are your career goals?'),
('Explain a technical concept you know');

truncate table companies;

INSERT INTO companies(company_name, description, process, tips)
VALUES('TCS',
 'TCS is a mass recruiter focusing on aptitude and basic programming.',
 '1. Online Aptitude Test\n2. Technical Interview\n3. HR Interview',
 'Practice aptitude daily, focus on basics of C/Java, be clear with resume'),
('Infosys',
 'Infosys focuses on coding and problem solving skills.',
 '1. Online Test (Aptitude + Coding)\n2. Technical Interview\n3. HR Interview',
 'Practice coding problems, DBMS basics, and communication skills'),
('Wipro',
 'Wipro emphasizes aptitude and communication.',
 '1. Aptitude Test\n2. Technical Round\n3. HR Round',
 'Prepare aptitude, revise core subjects, and improve spoken English');

UPDATE companies 
SET process = '1. Online Aptitude Test\n2. Technical Interview\n3. HR Interview',
    tips = 'Practice aptitude, revise basics of C/Java, prepare HR questions'
WHERE id = 1;

UPDATE companies 
SET process = '1. Aptitude + Coding Test\n2. Technical Interview\n3. HR Interview',
    tips = 'Focus on coding, DBMS, OOPs, and communication skills'
WHERE id = 2;

UPDATE companies 
SET process = '1. Aptitude Test\n2. Technical Round\n3. HR Round',
    tips = 'Prepare aptitude, revise core subjects, improve English'
WHERE id = 3;

delete from questions WHERE id>0;

INSERT INTO questions(question,option1,option2,option3,option4,answer) 
VALUES('What is 25% of 200?','25','50','75','100','50'),
('If 5x = 20, x = ?','2','3','4','5','4'),
('Find next number: 2,4,8,16,?','18','24','32','64','32'),
('A train travels 60 km in 1 hour. Speed?','50','60','70','80','60'),
('What is square root of 144?','10','11','12','13','12'),
('If cost price = 100 and selling price = 120, profit %?','10','20','25','30','20'),
('What is 15% of 300?','30','35','45','50','45'),
('If today is Monday, after 10 days?','Wednesday','Thursday','Friday','Saturday','Thursday'),
('Simplify: 12 + 8 ÷ 4','5','10','14','20','14'),
('Find odd one out: Apple, Banana, Mango, Carrot','Apple','Banana','Mango','Carrot','Carrot');

UPDATE companies 
SET description='TCS is one of the largest IT services and consulting companies in the world and a part of the Tata Group. Founded in 1968, it provides services such as software development, cloud computing, cybersecurity, data analytics, and business process outsourcing. TCS serves clients from various industries including banking, healthcare, retail, and manufacturing. Known for its innovation, strong global presence, and quality services, TCS has offices in many countries and employs thousands of professionals worldwide. It is also recognized for offering good career opportunities and training programs for fresh graduates.'
WHERE name='TCS';

UPDATE companies 
SET description='Infosys is a global leader in technology services and consulting, founded in 1981 and headquartered in India. It provides services such as software engineering, cloud computing, automation, artificial intelligence, and digital transformation solutions. Infosys helps businesses improve efficiency and adapt to changing technologies. The company serves clients in sectors like finance, healthcare, education, and manufacturing. Infosys is widely respected for its innovation, ethical business practices, employee training programs, and its contribution to the growth of the Indian IT industry.'
WHERE name='Infosys';

UPDATE companies 
SET description='Wipro is a leading multinational company based in India that provides information technology, consulting, and business process services. Established in 1945, Wipro initially started as a vegetable oil company before entering the IT industry. Today, it offers services like software solutions, digital transformation, artificial intelligence, cloud services, and cybersecurity. Wipro works with clients across industries such as healthcare, banking, retail, and telecommunications. The company is known for its customer-focused approach, sustainability initiatives, and opportunities for employee growth and development.'
WHERE name='Wipro';

INSERT INTO companies(company_name, description, process, tips)
VALUES('Accenture',
'Accenture is a global professional services company that specializes in information technology services, consulting, strategy, and operations. Founded in 1989, it operates in more than 120 countries and serves clients across industries such as banking, healthcare, retail, telecommunications, and manufacturing. The company provides services like cloud computing, cybersecurity, artificial intelligence, digital transformation, and business process management. Accenture is known for its innovation-driven approach, strong global presence, and commitment to helping organizations improve performance and adapt to new technologies.',
'Aptitude Test, Coding Test, Technical Interview, HR Interview',
'Practice aptitude, coding basics, communication skills'),

('Capgemini',
'Capgemini is a multinational company that provides consulting, technology, engineering, and outsourcing services to businesses around the world. Founded in 1967 and headquartered in France, Capgemini operates in many countries and serves industries such as finance, automotive, healthcare, retail, and public services. Its key services include software development, cloud solutions, cybersecurity, data analytics, and digital transformation. Capgemini is recognized for its customer-focused solutions, technological expertise, and commitment to sustainability and innovation in the IT sector.',
'Aptitude Test, Technical Round, HR Round',
'Prepare SQL, programming basics, confidence'),

('Cognizant',
'Cognizant is a leading multinational technology company that provides IT services, consulting, and business process outsourcing solutions to clients worldwide. Founded in 1994, the company is headquartered in the United States and has a strong presence in India and many other countries. Cognizant offers services such as software development, cloud computing, artificial intelligence, cybersecurity, data analytics, and digital transformation. It serves industries including healthcare, banking, retail, manufacturing, and insurance. The company is known for its customer-centric approach, innovative solutions, and strong career opportunities for professionals in the technology sector.',
'Online Test, Technical Interview, HR Interview',
'Focus on reasoning, verbal, interview answers');



