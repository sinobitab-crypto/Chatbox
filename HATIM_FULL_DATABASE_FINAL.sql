-- HATIM MASTER DATABASE
-- Sources: https://www.hatim.ac.in/ ; https://www.hatimlibrary.in/ ; HATIM Prospectus 2026
-- Generated: 2026-08-13
-- MySQL 8.0+
-- The database deliberately keeps source_text/source_url fields so extracted information
-- can be traced back to the original HATIM source.

DROP DATABASE IF EXISTS hatim_database;
CREATE DATABASE hatim_database CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hatim_database;

CREATE TABLE institution (
    institution_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    short_name VARCHAR(50),
    established_year YEAR,
    established_date VARCHAR(100),
    address VARCHAR(500),
    email VARCHAR(255),
    phone VARCHAR(100),
    website VARCHAR(500),
    affiliation VARCHAR(500),
    recognition VARCHAR(1000),
    accreditation VARCHAR(500),
    management VARCHAR(1000),
    source_url VARCHAR(500),
    source_text LONGTEXT
);

CREATE TABLE source_pages (
    source_id INT PRIMARY KEY AUTO_INCREMENT,
    source_url VARCHAR(1000) NOT NULL,
    source_type VARCHAR(50),
    title VARCHAR(500),
    source_date VARCHAR(100),
    extracted_text LONGTEXT,
    notes TEXT
);

CREATE TABLE milestones (
    milestone_id INT PRIMARY KEY AUTO_INCREMENT,
    event_date VARCHAR(100),
    event_text LONGTEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    short_name VARCHAR(100),
    programme VARCHAR(255),
    description LONGTEXT,
    learning_outcomes LONGTEXT,
    teaching_methods LONGTEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    department_id INT,
    course_name VARCHAR(255) NOT NULL,
    award VARCHAR(255),
    duration VARCHAR(100),
    semesters VARCHAR(100),
    affiliation_status VARCHAR(500),
    introduction_objectives LONGTEXT,
    course_outcomes LONGTEXT,
    curriculum_details LONGTEXT,
    source_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE add_on_courses (
    add_on_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description LONGTEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE skill_courses (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    fee_category VARCHAR(100),
    course_name VARCHAR(255),
    fee_name VARCHAR(255),
    amount DECIMAL(10,2),
    period VARCHAR(100),
    notes LONGTEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE admission_criteria (
    criterion_id INT PRIMARY KEY AUTO_INCREMENT,
    programme VARCHAR(255),
    criterion LONGTEXT,
    reservation_details LONGTEXT,
    direct_admission_details LONGTEXT,
    hostel_admission_details LONGTEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE bus_fares (
    bus_fare_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_point VARCHAR(255),
    monthly DECIMAL(10,2),
    per_semester DECIMAL(10,2),
    one_way DECIMAL(10,2),
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE facilities (
    facility_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    description LONGTEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE statistics (
    statistic_id INT PRIMARY KEY AUTO_INCREMENT,
    metric VARCHAR(255),
    value_text VARCHAR(255),
    year_or_period VARCHAR(100),
    notes TEXT,
    source_id INT,
    FOREIGN KEY (source_id) REFERENCES source_pages(source_id)
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    role VARCHAR(255),
    department VARCHAR(255),
    qualification VARCHAR(1000),
    joining_date VARCHAR(100),
    contact_number VARCHAR(100),
    source_id INT
);

CREATE TABLE committees (
    committee_id INT PRIMARY KEY AUTO_INCREMENT,
    committee_name VARCHAR(255),
    period VARCHAR(100),
    description LONGTEXT,
    source_id INT
);

CREATE TABLE committee_members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    committee_id INT,
    person_name VARCHAR(255),
    role VARCHAR(255),
    additional_details VARCHAR(1000),
    source_id INT,
    FOREIGN KEY (committee_id) REFERENCES committees(committee_id)
);

CREATE TABLE library_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255),
    resource_count INT,
    source_id INT
);

CREATE TABLE library_departments (
    library_department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255),
    resource_count INT,
    source_id INT
);

CREATE TABLE library_resources (
    resource_id INT PRIMARY KEY AUTO_INCREMENT,
    resource_title VARCHAR(500),
    resource_type VARCHAR(100),
    department VARCHAR(255),
    resource_url VARCHAR(1000),
    source_id INT
);

CREATE TABLE notices_news (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_type VARCHAR(50),
    title VARCHAR(500),
    item_date VARCHAR(100),
    url VARCHAR(1000),
    details LONGTEXT,
    source_id INT
);

CREATE TABLE alumni (
    alumni_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    department VARCHAR(255),
    graduation_year VARCHAR(50),
    batch VARCHAR(100),
    details LONGTEXT,
    source_id INT
);

CREATE TABLE academic_calendar_items (
    calendar_id INT PRIMARY KEY AUTO_INCREMENT,
    event_date VARCHAR(100),
    day VARCHAR(50),
    event_text LONGTEXT,
    source_id INT
);

CREATE TABLE awards_results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    year_or_period VARCHAR(100),
    department VARCHAR(255),
    title VARCHAR(500),
    details LONGTEXT,
    source_id INT
);

CREATE TABLE institutional_information (
    info_id INT PRIMARY KEY AUTO_INCREMENT,
    section VARCHAR(255),
    information LONGTEXT,
    source_id INT
);
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/','website','HATIM Home','2026','Higher and Technical Institute, Mizoram (HATIM). Established 2007; Baptist Church of Mizoram undertaking; affiliated to Mizoram University; UGC recognised 2(f) and 12(B); NAAC B+ in 2024 (1st Cycle). Address: Kawmzawl, Pukpui, Lunglei - 796691. Email: hatimoffice@gmail.com. Phone: 8787808163. Eight departments: Commerce, Computer Science, Education, English, History, Philosophy, Psychology, Social Work. 2026-2027 admission is advertised.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/about-the-college','website','About the College','2026','Established in June 2007; first residential co-ed college in Mizoram undertaken by a Christian organization (Baptist Church of Mizoram). Quality education, good moral conduct, Christian values and English-speaking culture. Managed privately by Society of Higher and Technical Studies under BCM. Courses: B.Com, BCA, BSW, BA English, History, Philosophy, Education, Psychology. Extensive milestones from 2006 onward, including establishment, affiliation, facilities, campus move, new departments, LMS, museum, basketball court and village adaptation programme.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/affiliation-and-recognition','website','Affiliation & Recognition','2026','HATIM is affiliated to Mizoram University. BA Education and BA Psychology are under provisional affiliation. UGC Section 2(f) and 12(B) recognition confirmed by UGC letter F. No. 8-610/2014 (CPP-I/C), dated 17 August 2016. AICTE approval confirmed by letter F.No. Eastern/2024-25/1-44338597034 dated 9 May 2024.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/naac','website','NAAC','2026','NAAC action committee aims include assessment/accreditation, academic quality, self-evaluation, accountability, autonomy, innovation and quality-related research/training. Committee: Vuansanga Vanchhawng (Convener), Hannah Lalnunpuii Khiangte, Immanuel Lalramenkima, P.C. Laltlanzuala, H. Lalrinawma. Planned activities include studying UGC/NAAC norms, working with IQAC and academic bodies, studying accredited colleges and SSRs, expert advice and follow-up action points.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/administrative-staff','website','Administrative Staff','2026','Administrative staff list including Principal, Vice Principal, LDC, Senior Assistant, Accounts Officer, Cashier, Work Supervisor, Librarian, Assistant Librarian, Librarian Staff, Lab Technician, Peons and Residence Guide/Assistant Professor, with joining dates, qualifications and contact numbers.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/add-on-courses','website','Add-on Courses','2026','Basic Computer Course / CCC; HATIM English Proficiency Certificate Course (HEPCC); Basic Research Methodology.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/learning-outcomes','website','Learning Outcomes of HATIM','2026','Programme and course outcomes are communicated through semester orientations, department orientation programmes, teachers, help desks at admission, lesson plans, one-to-one mentoring, Student Handbooks and Parents-Teachers Meetings.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/museum','website','History Museum','2026','History Museum aims to educate students, faculty and the public through cultural materials. Inaugurated on World Heritage Day, 18 April 2023, by the Principal at the time. Galleries include Natural, Cultural, Technological, Fine Arts and Archives. More than 40 types of materials, numbering in the hundreds, have been collected from different parts of Mizoram.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/library-committee','website','Library Committee','2023-2025','Convenor Lalrokhawma, Secretary C. Lalruatkima, members include HODs of Computer Science, Commerce, Social Work, English, History, Philosophy, Psychology and Education, IQAC coordinators and Principal ex-officio. 2021-2023 list also recorded.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/academic-and-career-counselling-cell','website','Academic & Career Counselling Cell','2023-2025','2023-2025: Convener RTC. Lalremruata; Assistant Convener Rebek Lalramtiami; Secretary A. Lalremtluangi; Ex-Officio Principal and IQAC Coordinators. Earlier 2021-2023 members also listed.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/cells-and-committees','website','Cells and Committees','2020 onward','Cells/committees include Web & Media Cell, Board of Academics, Anti Ragging, Library Committee, Examination Moderation Board, Seminar & Refresher Course, Games & Sports, Residence Management & Service, Scripture & Human Value Education, Students Care & Guidance, Cafeteria, Tuck Shop, Laboratory & Technical, Alumni Cell and Disaster Management. Council Body and IQAC membership is listed.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/iqac-function','website','Internal Quality Assurance Cell','2013 onward','IQAC established in 2013 under NAAC/UGC guidance. Chairman: the Principal (by virtue of office); Coordinator Dr John C. Lalduhsaka; Assistant Coordinator K. Lalmuanpuia; society representative Lalhmangaihi Hrahsel; ex-officio Vice Principal R. Lalnunthara; members include all HODs, Web/Media convener, Librarian, student representative, non-teaching representative and BCM representatives. Objectives, strategies, functions and benefits are documented.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/choir','website','Choir','2007 onward','HATIM Choir founded in 2007. Performs at graduation, Advance Christmas, fresher social and institutional functions. Objectives include Godliness, good learning, courtesy, mutual respect, tolerance, balanced curriculum and confidence in singing.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/evangelical-wing','website','HATIM Evangelical Wing','2008 onward','HEW established August 2008; maintains worship services; affiliated with UESI in 2013. Leaders attend UESI camps from 2016. Activities include Wednesday prayer meetings, praise and worship, Bible study and quiet time; monthly UESI contribution of Rs 3000; fasting programme in Ladies'' Residence Sundays 5:30-6:15 pm; prayer gatherings in Gents Residence. Strength 2023-2024: 384 members; office bearers and executive members recorded.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/students-council','website','Students Council','2024-2025','Constitution adopted at 56th Council Body Meeting on 20 July 2017. 2024-2025 office bearers: Chairman: the Principal; Vice Chairman Stephen Lalnunpuia; General Secretary Naomi Lalruatdiki; Assistant General Secretary Johny Lalmuanpuia; Treasurer Lallawmkimi Chawngthu; Assistant Treasurer Vanlalawmpuii.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/committee-members','website','Alumni Committee Members','2023 onward','HATIM Alumni Association governing body: President H. Lalmuanzuala, Vice President Isaak Rosangliana, Secretary Lalremliana Chhakchhuak, Assistant Secretary H. Lalromawia, Treasurer Rebek Lalfansangi, Finance Secretary H.K Lalrintluangi.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/alumni-cell','website','Alumni Cell','2023-2025','2023-2025 liaison officer C. Lalrinsangi; members RTC. Lalremruata and Vanlalkimliani. 2021-2023 liaison H. Lalruatkima and members John C. Lalduhsaka, RTC. Lalremruata, R. Vanlalawmpuia, Vanlalkimliani.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/alumni','website','Alumni','2026','Public alumni entries include Joseph Lalrinawma (English, 2015), Laldinkimi Khiangte (Commerce, 2012), B. Lalramliana, F. Lalhluzuala, Malsawmzuali, VL. Thlamuanpuii, Esther Lalhlupuii, Lallianzami, F. Lalduhsangi, Nathan C Lalremruatpuia, P Lalhruaitluanga, David Lalnunthara, R. Lalngaizuala, K. Lalhruaitluangi, HD Vanlalrinawmi. Registration fields include full name, parent name, nationality, category, religion, address, work status, employer, designation, joining date, email, phone, photo, department, batch, graduation year, achievement and feedback.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/internal-complain-committee','website','Internal Complaints Committee','2026','Aims include prevention/prohibition/redressal of sexual harassment and student grievances relating to academics, administration, hostel, fees, infrastructure and activities. Complaint mechanisms include complaint box and written complaints. Inquiry is to be set up within 7 days if reasonable and completed within 90 days; reports may go to Principal/Academic Council.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/location-map','website','Location Map','2026','HATIM Campus Zoning Layout is provided. Address Kawmzawl, Pukpui, Lunglei - 796691.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/campus-map','website','Campus Map','2026','HATIM Campus Layout is provided.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/page/undertaking','website','Undertaking','2026','HATIM declares affiliation to Mizoram University and undertaking to adhere to applicable statutory regulatory authorities including UGC, AICTE and others.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/academic/calendar','website','Academic Calendar','2026','Academic calendar page includes dates/events such as re-dedication of BCM workers, Missionary Day, residence entry, college commencement/devotions, regular classes, lesson plans, Republic Day, State Day, CA-I, Chapchar Kut, Commerce Day, Holistica 6.0, Holi, World Social Work Day, CA-II, UESI meeting, Good Friday, Easter Monday, May Day and University examinations.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/academic/results','website','Results','2026','Results archive contains internal/continuous assessment results from 2019 onward across Computer Science, Commerce, Social Work, English, Philosophy, History, Education and Psychology, including many semester-specific CA-I/CA-II and overall results.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/notifications','website','Notifications Archive','2026','Notifications include 2026 reopening, 2026 end-semester exam routine, 2026-2027 admission, 2026 CA result, 2025 CA results, 2025 conference, 2025 admission, 2024 calendars/results, 2023 results/admission and older 2018-2020 notices.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/news','website','News','2026','Latest news includes HATIM securing 3 top-ten BCA positions (3 July 2026), 17th HATIM Valedictory Ceremony (19 June 2026), Second Continuous Assessment result (27 April 2026) and 2026-2027 admission notice (21 April 2026).');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatimlibrary.in/','website','HATIM Library Digital Repository','2026','Digital repository of Higher And Technical Institute Mizoram. 809+ resources, 8 departments, 7 categories, free access. Categories: Question Bank 494, Lecture Videos 108, Research Papers 9, Field Work Report 8, Project Work 184, Syllabus 6, Prospectus 0. Departments: Computer Science 274, Commerce 267, Social Work 130, English 29, Philosophy 30, Psychology 2, History 61, Education 16. Features search, browse resources and online library clearance.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/bca','website','Computer Science / BCA','2026','Department syllabus areas: Mathematics-I (Discrete), PC Software & Computer Fundamentals, Internet & Web Design, practicals; Programming in C, Mathematics-II Numerical Analysis, Computer Architecture & Organization, MIS, practical C and Assembly; Data Structures using C, Operating Systems, Accounting & Financial Management, E-Commerce & Web Technology, practical Data Structure/Web Technology/Tally; OOP C++, System Analysis and Design, Unix/Shell Programming, Networking-I, practical C++/Unix; Networking-II, DBMS, GUI Programming, Software Engineering, practical VB and DBMS.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/bcom','website','Commerce','2026','Core learning areas: Financial, Cost and Corporate Accounting, Taxation, Insurance, Banking; marketing, management, industrial, mercantile and company laws/practices; research in management/marketing/finance; IT and E-Commerce; secretarial and clerical practices. Compulsory: General English, Mizo (MIL), Environmental Studies. Methods include lectures, presentations, exercises/tests, assignments, seminars/workshops, library work, skill development, Commerce Day and cleanliness drives.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/ba-english','website','English','2026','Core: History of English Literature, History of English Language and Phonetics, Poetry/Short Stories, Fiction I, Drama I, Women''s Writings, Literary Theory/Criticism, Fiction II, Indian Writing in English, Drama II, American Literature. Electives: Philosophy, History, Psychology, Education. Compulsory: General English, Alternative English, Mizo, Environmental Studies. Methods include lectures/PPT, group work, library, seminars, quizzes/tests and functional English classes.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/history','website','History','2026','Three-year Bachelor''s degree, CBCS, 140 credits. Covers pre-colonial Mizoram to 1960s, socio-economic/religious/political/cultural developments in India and world, gender and historical events, movements and ideas, public history, archaeology, digital technologies, research methodology and heritage studies. Elective since 2011-12; full-fledged core/honors from 2020-21.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/philosophy','website','Philosophy','2026','Aims at Logic, critical thinking, ethics, Indian and Western philosophy and practical philosophy under CBCS. Outcomes include critical thinking/argumentation, moral reasoning, reading/comprehension of philosophical texts and interdisciplinary thinking. Established with English in 2011 as elective; full-fledged core from 2020-21.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/education','website','Education','2026','BA Education is described on the department page as a three-year degree and includes educational concepts, ideas, methods and applications; NEP 2020 implementation is highlighted, field visits are conducted, and outcomes include understanding educational tenets, explaining concepts, creating ideas/methods/solutions and judgement/innovation.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/psychology','website','Psychology','2026','BA Psychology develops knowledge in core psychology, ethical research/practical work, awareness of behaviour and social roles. Three-year, six-semester CBCS. Department set up in 2020, first elective then core, described as first college in southern Mizoram to offer Psychology as an undergraduate core. Includes practical psychological tools and project research.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/departments/bsw','website','Social Work','2026','Core areas: Introduction to Social Work, Psychology/Sociology for Social Workers, Field Work; working with individuals/groups, economics/politics; social problems, communities, family/child welfare; social work research, welfare organisations, community development; policy/planning, human rights, disability, health/mental health; social legislation, social defense, environmental studies, substance abuse/HIV/AIDS. Methods include lectures, PPT, group work, library, seminars, fieldwork, visits, conferences, rural camps, charity, block placement and etiquette drives.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/news/details/411/HATIM%20ADMISSION%20NOTICE%20FOR%202026%20-%202027%20SESSION','website','HATIM Admission Notice 2026-2027','21 April 2026','Courses: B.Com, BCA, BSW, BA Education, English, History, Philosophy, Psychology. Online application at admission.hatim.ac.in; offline at Admin Office, HATIM Campus, Kawmzawl. Free admission fee for HSSLC/Class XII distinction 75%+; direct admission for first class and above; day scholar/hosteller options; college bus for day scholars; hostel first-come-first-served. Course contact numbers are listed on the notice.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/notifications/details/62/HATIM%20ADMISSION%20NOTICE%20FOR%202025%20-%202026%20SESSION','website','HATIM Admission Notice 2025-2026','1 May 2025','Same eight degree programmes; online/offline application; free admission fee for 75%+ distinction; direct admission for first class and above; day scholar/hosteller; bus service; hostel first-come-first-served; course-specific contacts.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatim.ac.in/notifications/details/29/admission%20notice%20for%202022%20-%202023%20session','website','Admission Notice 2022-2023','21 May 2022','Eight degree programmes. Direct admission for HSSLC First Division and above. Application processing fee ₹200. Admission fee ₹2000. Monthly fee BCA ₹2800, BSW ₹2800, B.Com ₹2600, BA ₹2300. Hostel admission ₹1000 and monthly ₹6000. Free campus WiFi and free conveyance for day scholars within college-bus routes.');
INSERT INTO source_pages(source_url,source_type,title,source_date,extracted_text) VALUES ('https://www.hatimlibrary.in/','website','Library Resource Inventory','2026','Library categories and department counts are captured in normalized tables. Featured/recent examples include BCA syllabus, BSW syllabus, BCom syllabus, BA Education Revised, BA Philosophy CBCS Revised and BA History Syllabus 2021.');

INSERT INTO institution(name,short_name,established_year,established_date,address,email,phone,website,affiliation,recognition,accreditation,management,source_url,source_text)
VALUES
('Higher and Technical Institute, Mizoram','HATIM',2007,'June 2007','Kawmzawl, Pukpui, Lunglei - 796691','hatimoffice@gmail.com','8787808163','https://www.hatim.ac.in/','Affiliated to Mizoram University','UGC recognised under Sections 2(f) and 12(B); AICTE approved','NAAC Accredited B+ Grade, 2.68 CGPA, First Cycle 2024','Privately managed by Society of Higher and Technical Studies under the aegis of Baptist Church of Mizoram (BCM)','https://www.hatim.ac.in/page/about-the-college','First residential co-ed college in Mizoram undertaken by a Christian organization; quality education based on good moral conduct, Christian values and English-speaking culture.');

INSERT INTO departments(name,short_name,programme,description,learning_outcomes,teaching_methods,source_id) VALUES
('Computer Science','BCA','Bachelor of Computer Applications','Professional undergraduate programme in Computer Applications; objectives include knowledge and skills for the information-technology world.','Technical skills in software programming, hardware maintenance and system planning; career paths include software/business systems, consulting, technical writing, IT training and support.','Lectures, practical laboratory work and syllabus-specific practicals.',26),
('Commerce','B.Com','Bachelor of Commerce','Commerce curriculum includes accounting, taxation, insurance, banking, marketing, management, laws, IT and research.','Preparation for banking, accounting, entrepreneurship, e-business, taxation, financing and insurance; Entrepreneurship Knowledge Cell supports entrepreneurs.','Lectures, presentations, exercises/tests, assignments, seminars, workshops, library work, skill development.',27),
('English','BA English','Bachelor of Arts (English)','BA English Literature uses Mizoram University syllabus and is a full-time undergraduate degree.','Knowledge of English literature/language, phonetics, practical language use, drama, short stories, plays and poems.','Lecture/PPT, group discussion/work, library, seminars, quizzes/tests, functional English.',28),
('History','BA History','Bachelor of Arts (History)','Three-year CBCS degree with 140 credits; history from pre-colonial Mizoram to 1960s and wider world history.','Historical knowledge, reading/thinking skills, citizenship, research methodology and critical interpretation.','Not separately specified on page.',29),
('Philosophy','BA Philosophy','Bachelor of Arts (Philosophy)','Logic, critical thinking, ethics and Indian/Western philosophy under CBCS.','Critical thinking, argumentation, moral reasoning, philosophical reading and interdisciplinary thinking.','Not separately specified on page.',30),
('Education','BA Education','Bachelor of Arts (Education)','UG programme emphasizing educational concepts, ideas, methods, applications and NEP 2020.','Educational knowledge, analytical investigation, new ideas/methods/solutions, independent/collaborative research and higher study preparation.','Field visits and classroom teaching.',31),
('Psychology','BA Psychology','Bachelor of Arts (Psychology)','Three-year/six-semester CBCS course; department established in 2020.','Knowledge of psychological concepts, ethical research, diverse populations, behavioural understanding, psychological assessment and project research.','Theoretical study, practical experimentation and project work.',32),
('Social Work','BSW','Bachelor of Social Work','Full-time undergraduate course focused on social change, development, human relationships and empowerment.','Professional approaches, knowledge, skills and techniques for social issues; employment in hospitals, education, welfare, NGOs, government and other settings.','Lectures, PPT, group work, library, seminars, field work, observation visits, conferences, rural camps, charity and block placement.',35);

INSERT INTO courses(department_id,course_name,award,duration,semesters,affiliation_status,introduction_objectives,course_outcomes,curriculum_details,source_id) VALUES
(1,'Bachelor of Computer Applications (BCA)','BCA','Undergraduate degree',NULL,'Mizoram University','Full-time professional undergraduate degree in Computer Applications.','Software programming, hardware maintenance and system planning; careers in business ownership, software authorship, consulting, systems/equipment, management, software/hardware industries, technical writing, IT training and support.','Mathematics, PC software, computer fundamentals, web design, C, numerical analysis, architecture, MIS, data structures, OS, accounting, E-commerce, OOP C++, system analysis, Unix/Shell, networking, DBMS, GUI programming, software engineering, VB practical and DBMS practical.',28),
(2,'Bachelor of Commerce (B.Com)','B.Com','Undergraduate degree',NULL,'Mizoram University','Full-time undergraduate degree preparing students for commercial-world careers.','Banking, accounting, entrepreneurship, e-business, taxation, financing and insurance; practical skills and leadership through House of Commerce.','Accounting, taxation, insurance, banking, marketing, management, laws, research, IT/E-commerce and secretarial practices.',29),
(3,'Bachelor of Arts (English)','BA English','Full-time undergraduate degree',NULL,'Mizoram University','BA course with English Literature as core.','English literature/language, phonetics, composition, drama, short stories, plays and poetry.', 'English literature/language, phonetics, poetry, short stories, fiction, drama, women writings, literary criticism, Indian writing and American literature.',30),
(4,'Bachelor of Arts (History)','BA History','3 years on department page / 4 years under NEP description in 2026 prospectus','6/8 depending on framework','Mizoram University','Full-time undergraduate history course covering major socio-economic, cultural, religious and political developments.','Indian/world history, research, critical interpretation and competitive examination preparation.','Pre-colonial Mizoram, India, Northeast, America, Europe, China, South Asia, gender, public history, archaeology, digital technologies, research methodology and heritage studies.',31),
(5,'Bachelor of Arts (Philosophy)','BA Philosophy','3 years on department page / 3 years in prospectus','6', 'Mizoram University / CBCS','Quality study in logic, critical thinking, ethics and Indian/Western philosophy.','Critical thinking, logical reasoning, moral concepts, philosophical texts and interdisciplinary arguments.','Logic, ethics, Indian and Western philosophy, legal/philosophical analysis and practical philosophy.',32),
(6,'Bachelor of Arts (Education)','BA Education','4 years in 2026 prospectus','8','Mizoram University / NEP 2020','Four-year UG programme with research project on fourth year; emphasizes educational disciplines in first three years.','Educational concepts, analytical investigation, innovation, research and teacher-training preparation.','Educational concepts, ideas, methods, applications and research project.',33),
(7,'Bachelor of Arts (Psychology)','BA Psychology','4 years in 2026 prospectus','8','Mizoram University / NEP 2020','Four-year programme aligned with NEP 2020; interdisciplinary first three years and research project in fourth.','Psychological theories, human behaviour, research methods, psychological tests and application.','Behavioural/cognitive development, social/organizational/lifespan contexts, practical tools and research project.',34),
(8,'Bachelor of Social Work (BSW)','BSW','Full-time undergraduate degree',NULL,'Mizoram University','Course promotes social change, development, problem solving and empowerment.','Professional social-work skills and employment readiness across welfare, government, NGOs, health, education and social-service sectors.','Social work foundations, psychology/sociology, fieldwork, individuals/groups, economics/politics, social problems, community work, research, welfare organizations, policy, human rights, disability, health, legislation and social defense.',35);

INSERT INTO add_on_courses(name,description,source_id) VALUES
('Basic Computer Course / CCC','Certificate/add-on course.',6),
('HATIM English Proficiency Certificate Course (HEPCC)','Certificate/add-on course.',6),
('Basic Research Methodology','Certificate/add-on course.',6),
('Computer Concepts (CCC)','Prospectus 2026 add-on course.',2),
('Computer Hardware and Networking','Prospectus 2026 add-on course.',2);

INSERT INTO skill_courses(name,source_id) VALUES
('Gardening',2),('Plumbing and Sanitation',2),('House wiring',2),('Men''s parlouring',2),('Beauty and wellness',2);

INSERT INTO fees(fee_category,course_name,fee_name,amount,period,notes,source_id) VALUES
('Institution','All','Admission Fee',2000,'At admission','Compulsory unless otherwise decided; admission fee and one month fee due at admission.',2),
('Institution','Bachelor of Commerce (B.Com)','Course Fee',17400,'Per semester',NULL,2),
('Institution','Bachelor of Commerce (B.Com)','Course Fee',3000,'Per month',NULL,2),
('Institution','Bachelor of Computer Applications (BCA)','Course Fee',19000,'Per semester',NULL,2),
('Institution','Bachelor of Computer Applications (BCA)','Course Fee',3300,'Per month',NULL,2),
('Institution','Bachelor of Social Work (BSW)','Course Fee',17400,'Per semester',NULL,2),
('Institution','Bachelor of Social Work (BSW)','Course Fee',3000,'Per month',NULL,2),
('Institution','Bachelor of Arts (BA)','Course Fee',15000,'Per semester',NULL,2),
('Institution','Bachelor of Arts (BA)','Course Fee',2600,'Per month',NULL,2),
('Institution','BA Psychology','Practical Fee',100,'Per month','Collected every semester starting from 3rd semester.',2),
('Hostel/Residence','All','Admission Fee',1000,'At admission','Only HATIM regular students are admissible.',2),
('Hostel/Residence','All','Monthly Fee',6000,'Per month','Independent from institution fees.',2);

INSERT INTO admission_criteria(programme,criterion,reservation_details,direct_admission_details,hostel_admission_details,source_id) VALUES
('Bachelor of Arts (BA)','All streams with 45% aggregate marks in 10+2 for General and 5% relaxation for SC/ST/OBC.','15% SC; 7.5% ST; 27% OBC; 5% PwD; 5% Sports Quota; 5% EWS.','Candidates securing 60% (First Class) and above in Class 12 eligible for direct admission.','Hostel seats first come first serve.',2),
('Bachelor of Commerce (B.Com)','Preferably Commerce background with 45% aggregate in 10+2 for General and 5% relaxation for SC/ST/OBC.','Same reservation framework stated in prospectus.','60% and above in Class 12 eligible for direct admission.','Hostel seats first come first serve.',2),
('Bachelor of Computer Applications (BCA)','Science/any applicable stream with 50% aggregate in 10+2 for General and 5% relaxation for SC/ST/OBC.','Same reservation framework stated in prospectus.','60% and above in Class 12 eligible for direct admission.','Hostel seats first come first serve.',2),
('Bachelor of Social Work (BSW)','All streams with 45% aggregate in 10+2 for General and 5% relaxation for SC/ST/OBC.','Same reservation framework stated in prospectus.','60% and above in Class 12 eligible for direct admission.','Hostel seats first come first serve.',2);

INSERT INTO facilities(name,description,source_id) VALUES
('ERP system','Enterprise Resource Planning system manages academic and administrative activities.',2),
('Automated Library','Automated library with 12,000+ volumes.',2),
('Digital Library / Institutional Repository','Digital library and institutional repository.',2),
('IT Centre','Well-furnished IT centre.',2),
('Language Laboratory','Language laboratory.',2),
('Psychology Laboratory','Laboratory for behavioural studies.',2),
('ICT enabled classrooms','ICT-enabled classrooms.',2),
('Campus WiFi','Internet/WiFi-enabled campus.',2),
('CCTV monitoring','CCTV-monitored buildings and campus.',2),
('Solid Waste Management','Decentralised solid waste management system.',2),
('Cafeteria','Campus cafeteria.',2),
('Power backup','10KW solar plant and total 35KVA diesel generators for uninterrupted power supply.',2),
('Hostels','Ladies hostel capacity 100; Gents hostel capacity 100.',2),
('Gymnasium','Gymnasium facility.',2),
('Sports facilities','Various sports facilities including basketball court and playground.',2),
('Music facilities','Music facilities.',2),
('Smoke-free campus','Campus described as smoke free.',2),
('Alumni Association','Support of strong Alumni Association.',2),
('College buses','Conveyance available for day scholars within routes of college buses.',2),
('History Museum','Natural, Cultural, Technological, Fine Arts and Archives galleries.',7);

INSERT INTO statistics(metric,value_text,year_or_period,notes,source_id) VALUES
('Teaching staff','35 regular/contract + 6 fixed pay/casual + 4 part-time/guest = 45','2025','Prospectus at-a-glance.',2),
('Non-teaching staff','18 regular/contract + 11 fixed pay/casual = 29','2025','Prospectus at-a-glance.',2),
('Students','300+','2025','Number of students.',2),
('Campus area','30 acres','2025','Campus area.',2),
('Gents hostel capacity','100','2025','Hostel capacity.',2),
('Ladies hostel capacity','100','2025','Hostel capacity.',2),
('Graduates','999','Since 2010','Total graduates.',2),
('Mizoram University subject toppers','21','2010-2025','Number of MZU subject toppers.',2),
('Students in top 10 in MZU exams','216','2010-2025','Number of students placed in top 10.',2),
('Library volumes','12000+','2025','Automated library.',2),
('NAAC CGPA','2.68','2024','B+ grade, first cycle.',2),
('Library resources','809+','2026','Digital repository.',25),
('Library departments','8','2026','Digital repository.',25),
('Library categories','7','2026','Digital repository.',25),
('HEW members','384','2023-2024','HATIM Evangelical Wing.',14);

INSERT INTO library_categories(category_name,resource_count,source_id) VALUES
('Question Bank',494,25),('Lecture Videos',108,25),('Research Papers',9,25),('Field Work Report',8,25),('Project Work',184,25),('Syllabus',6,25),('Prospectus',0,25);

INSERT INTO library_departments(department_name,resource_count,source_id) VALUES
('Computer Science',274,25),('Commerce',267,25),('Social Work',130,25),('English',29,25),('Philosophy',30,25),('Psychology',2,25),('History',61,25),('Education',16,25);

INSERT INTO library_resources(resource_title,resource_type,department,resource_url,source_id) VALUES
('BCA syllabus','Syllabus','Computer Science','https://www.hatimlibrary.in/',27),
('BSW syllabus','Syllabus','Social Work','https://www.hatimlibrary.in/',27),
('BCom Syllabus','Syllabus','Commerce','https://www.hatimlibrary.in/',27),
('BA Education Revised','Syllabus','Education','https://www.hatimlibrary.in/',27),
('BA Philosophy cbcs Revised','Syllabus','Philosophy','https://www.hatimlibrary.in/',27),
('BA History Syllabus 2021','Syllabus','History','https://www.hatimlibrary.in/',27);

INSERT INTO bus_fares(bus_point,monthly,per_semester,one_way,source_id) VALUES
('Theriat',1750,8500,150,2),('Sethlun',1650,8000,140,2),('3 Gate',1600,7750,130,2),
('Lunglawn',1400,6750,120,2),('Kawizau',1350,6500,120,2),('A.O.C',1300,6250,110,2),
('Falkawn',1300,6250,110,2),('Faith Hospital',1250,6000,90,2),('Civil Hospital',1250,6000,90,2),
('A.P Tlang',1200,5750,80,2),('Venglai',1150,5500,70,2),('Tlabung Peng',1100,5250,70,2),
('G. College Peng',1100,5250,60,2),('S.B.I, R.T.P',1050,5000,60,2),('Kikawn',1000,4750,60,2),
('Zohnuai Peng',950,4500,50,2),('Serkawn',900,4250,40,2),('Lungdawhkhawn',850,4000,40,2),
('CHB Point',850,4000,40,2),('Pukpui',400,1750,30,2);

INSERT INTO staff(name,role,department,qualification,joining_date,contact_number,source_id) VALUES
('Dr. R. Lalnunthara','Principal',NULL,'Ph.D, M.Com, NET, M.Phil','08.05.2008','7005 127 689',5),
('Hannah Lalnunpuii Khiangte','Vice Principal',NULL,'MA(English)',NULL,'897 4637 462',5),
('PC. Lalbiakdika','L.D.C',NULL,'M.A','05.07.2014','9862 516 041',5),
('Vanlalruata Kawlni','Senior Assistant',NULL,'B.A','01.06.1996','9436 157 695',5),
('Lalhmunmawia','Asst. Accounts Officer',NULL,'M.A (Public Administration)','04.04.2022','9612 567 059',5),
('K. Lalramchanmawii','Cashier',NULL,'M.A','01.07.2016','8794 680 027',5),
('T. Lalrinmuana','Work Supervisor',NULL,'M.A, PG Certificate in Psycological Councelling','22.06.2007','9633 148 647',5),
('Lalrokhawma','Librarian',NULL,'M.LISc, M.Phil','22.06.2007','9366 974 587',5),
('C. Lalruatkima','Asst. Librarian',NULL,'M.LISc, M.Phil','01.06.2012','7005 176 983',5),
('Lalrinsanga Kawlni','Librarian Staff',NULL,'HSSLC','23.01.2014','7628 003 190',5),
('Vanlalnghaka Hnamte','Lab Technician',NULL,'MCA, Diploma in Computer Hardware Maintenance','28.02.2010','9612 737 854',5),
('Lalruattluanga Colney','Peon',NULL,'HSSLC','01.08.2015','8415 905 443',5),
('Lalremtluangi Chawngthu','Peon',NULL,'HSSLC','15.12.2008','9615 181 911',5),
('H. Lalrinawma','Residence Guide/Asst. Professor',NULL,'M.Tech (Computer Science), B.E (Computer Science), NET','04.04.2008','9862 363 669',5);

INSERT INTO committees(committee_name,period,description,source_id) VALUES
('Internal Quality Assurance Cell (IQAC)','2013 onward','Quality assurance cell under NAAC/UGC guidelines; coordinates quality enhancement and institutional processes.',12),
('NAAC Action Committee','2024 onward','Assessment/accreditation, quality teaching-learning, self-evaluation, accountability, autonomy, innovation and quality research/training.',4),
('Library Committee','2023-2025','Library governance and coordination; HODs, IQAC coordinators and Principal included.',9),
('Academic & Career Counselling Cell','2023-2025','Academic and career counselling support.',10),
('Web, Media and Publication Board','2023-2025','Web, media and publication activities.',19),
('Alumni Cell','2023-2025','Alumni liaison and coordination.',17),
('HATIM Alumni Association Governing Body','2023 onward','Alumni association governing body.',16),
('Internal Complaints Committee','2026','Prevention, prohibition and redressal of sexual harassment and student grievances.',20),
('HATIM Evangelical Wing','2023-2024','Spiritual/worship activities and student fellowship.',14),
('HATIM Students Council','2024-2025','Student governance body.',15);

INSERT INTO committee_members(committee_id,person_name,role,additional_details,source_id) VALUES
(1,'The Principal','Chairman','By virtue of office',12),
(1,'Dr. John C. Lalduhsaka','Coordinator','HOD Philosophy',12),
(1,'K. Lalmuanpuia','Assistant Coordinator','HOD Computer Science',12),
(1,'Lalhmangaihi Hrahsel','Society Representative','Ex-Principal LGC and Govt. Zirtiri Residential Science College; Ex-Deputy Director Technical Branch H&TE',12),
(1,'Dr. R. Lalnunthara','Ex-Officio','Vice Principal',12),
(2,'Vuansanga Vanchhawng','Convener',NULL,4),
(2,'Hannah Lalnunpuii Khiangte','Member','English',4),
(2,'Immanuel Lalramenkima','Member','English',4),
(2,'P.C. Laltlanzuala','Member','Computer Sciences',4),
(2,'H. Lalrinawma','Member','Computer Sciences',4),
(3,'Lalrokhawma','Convenor','Librarian',9),
(3,'C. Lalruatkima','Secretary','Assistant Librarian',9),
(4,'RTC. Lalremruata','Convener',NULL,10),
(4,'Rebek Lalramtiami','Assistant Convener',NULL,10),
(4,'A. Lalremtluangi','Secretary',NULL,10),
(5,'H. Lalruatkima','Convener','Assistant Professor, Computer Science',19),
(5,'R. Lalruatfela','Member','Assistant Professor, Computer Science',19),
(5,'Vanlalnghaka Hnamte','Member','Lab Technician',19),
(5,'C. Lalrinsangi','Member','Assistant Professor, Commerce',19),
(5,'Deborah Zonunpuii','Member','Assistant Professor, Psychology',19),
(6,'C. Lalrinsangi','Liaison Officer',NULL,17),
(6,'RTC. Lalremruata','Member',NULL,17),
(6,'Vanlalkimliani','Member',NULL,17),
(7,'H. Lalmuanzuala','President','BCA 2015-2018 Batch',16),
(7,'Isaak Rosangliana','Vice President','BSW 2011-2014 Batch',16),
(7,'Lalremliana Chhakchhuak','Secretary','BA English 2016-2019 Batch',16),
(7,'H. Lalromawia','Assistant Secretary','BA English 2015-2018 Batch',16),
(7,'Rebek Lalfansangi','Treasurer','B.Com 2012-2015 Batch',16),
(7,'H.K Lalrintluangi','Finance Secretary','BCA 2012-2015 Batch',16),
(9,'H. Lalthianghlima','President','HEW 2023-2024',14),
(9,'Jacob Lalruatsanga','Vice-President','HEW 2023-2024',14),
(9,'Noel VL Zikpuii Pachuau','Secretary','HEW 2023-2024',14),
(9,'Rosangpuia Chhakchhuak','Assistant Secretary','HEW 2023-2024',14),
(9,'C. Lalchhanhimi','Treasurer','HEW 2023-2024',14),
(9,'Andie B. Lalvenpuii','Finance Secretary','HEW 2023-2024',14),
(10,'The Principal','Chairman','Principal',15),
(10,'Stephen Lalnunpuia','Vice Chairman','IV B.Com',15),
(10,'Naomi Lalruatdiki','General Secretary','IV BSW',15),
(10,'Johny Lalmuanpuia','Assistant General Secretary','II BA',15),
(10,'Lallawmkimi Chawngthu','Treasurer','IV BA',15),
(10,'Vanlalawmpuii','Assistant Treasurer','IV BCA',15);

INSERT INTO alumni(name,department,graduation_year,batch,details,source_id) VALUES
('Joseph Lalrinawma','English','2015',NULL,NULL,16),
('Laldinkimi Khiangte','Commerce','2012',NULL,NULL,16),
('B. Lalramliana','Commerce','2016',NULL,NULL,16),
('F. Lalhluzuala','Commerce','2016',NULL,NULL,16),
('Malsawmzuali','Commerce','2016',NULL,NULL,16),
('VL. Thlamuanpuii','Commerce','2016',NULL,NULL,16),
('Esther Lalhlupuii','Commerce','2016',NULL,NULL,16),
('Lallianzami','Commerce','2016',NULL,NULL,16),
('F. Lalduhsangi','Commerce','2016',NULL,NULL,16),
('Nathan C Lalremruatpuia','English','2018',NULL,NULL,16),
('P Lalhruaitluanga','Computer Science','2016',NULL,NULL,16),
('David Lalnunthara','Commerce','2017',NULL,NULL,16),
('R. Lalngaizuala','Computer Science','2014',NULL,NULL,16),
('K. Lalhruaitluangi','English','2017',NULL,NULL,16),
('HD Vanlalrinawmi','English','2016',NULL,NULL,16);

INSERT INTO notices_news(item_type,title,item_date,url,details,source_id) VALUES
('Notification','Schedule for Re-opening and Commencement of ODD Semester 2026','25 June 2026','https://www.hatim.ac.in/notifications','Listed in notifications archive.',25),
('Notification','Exam routine, seat arrangement and invigilation roster for End-Semester Exam (Jan-June 2026)','11 May 2026','https://www.hatim.ac.in/notifications','Listed in notifications archive.',25),
('Notification','HATIM ADMISSION NOTICE FOR 2026-2027 SESSION','21 April 2026','https://www.hatim.ac.in/news/details/411/HATIM%20ADMISSION%20NOTICE%20FOR%202026%20-%202027%20SESSION','Eight undergraduate programmes; online/offline admission; 75%+ distinction free admission fee; direct admission; day scholar/hosteller; bus; hostel first-come-first-served.',36),
('News','HATIM secures 3 top ten positions in BCA','3 July 2026','https://www.hatim.ac.in/news','Latest news item.',26),
('News','17th HATIM Valedictory Ceremony','19 June 2026','https://www.hatim.ac.in/news','Latest news item.',26),
('News','Second Continuous Assessment result, Apr 2026','27 April 2026','https://www.hatim.ac.in/news','Latest news item.',26),
('Notification','First Continuous Assessment result, February 2026','6 March 2026','https://www.hatim.ac.in/notifications','Listed in archive.',25),
('Notification','Two-Day International Conference on Humanities and Social Sciences - July 30-31, 2025','29 July 2025','https://www.hatim.ac.in/notifications','Listed in archive.',25),
('Notification','HATIM ADMISSION NOTICE FOR 2025-2026 SESSION','1 May 2025','https://www.hatim.ac.in/notifications/details/62/HATIM%20ADMISSION%20NOTICE%20FOR%202025%20-%202026%20SESSION','Admission notice.',37);

INSERT INTO academic_calendar_items(event_date,day,event_text,source_id) VALUES
('08 January','Monday','Re-dedication of BCM workers at BCM Church, Serkawn',23),
('11 January','Thursday','Missionary Day',23),
('15 January','Monday','Students inside Lunglei Town entry to residence before 01:30 PM; outside Lunglei Town before 03:00 PM; College Commencement/devotions 09:30 AM; classroom arrangement/cleaning; orientation of staff/faculty and teaching methodology training.',23),
('16 January','Tuesday','Commencement of regular class as per MZU notification',23),
('24 January','Wednesday','Submission of Lesson Plans',23),
('26 January','Friday','Republic Day',23),
('01 February','Thursday','BSW VI Semester students entry to residence before 03:00 PM',23),
('20 February','Tuesday','State Day',23),
('23-28 February','Friday-Wednesday','First Internal Continuous Assessment (CA-I)',23),
('03 March','Saturday','Chapchar Kut',23),
('09 March','Friday','Commerce Day; Holistica 6.0 (IT Festival)',23),
('13 March','Tuesday','Holi',23),
('21 March','Wednesday','World Social Work Day (Observance)',23),
('10-14 April','Tuesday-Saturday','Second Internal Continuous Assessment (CA-II)',23),
('14 April','Saturday','UESI North East: Mizoram State 6th Annual Meeting',23),
('30 March','Friday','Good Friday (Gazetted Holiday); Ambedkar Jayanti (Observance)',23),
('02 April','Monday','Easter Monday',23),
('01 May','Tuesday','May Day (Observance); University Examinations',23);

INSERT INTO awards_results(year_or_period,department,title,details,source_id) VALUES
('2024','Institution','NAAC B+','First cycle; 2.68 CGPA; assessment completed 12-13 December 2024; result declared 20 December 2024.',2),
('2010-2025','Institution','MZU Subject Toppers','21 subject toppers.',2),
('2010-2025','Institution','Top 10 in Mizoram University Exams','216 students placed in top 10.',2),
('2023','Institution','Cleanest Institution in Lunglei','First prize awarded by Urban Development and Poverty Alleviation Department, Lunglei District, Government of Mizoram.',2),
('2023','Institution','History Museum inaugurated','18 April 2023.',7);

INSERT INTO institutional_information(section,information,source_id) VALUES
('Salient Features','World-class quality education at affordable price; good infrastructure and dedicated faculty; co-ed residential institute with separate male/female residences; wide spectrum of extra-curricular/co-curricular activities; well-stocked expanding library; well-equipped computer laboratory; internet for staff/students; dress code reflecting neatness, modesty and standards; commitment to local communities/nation; emphasis on tlawmngaihna; strong English-speaking skills; responsible care of environment.',2),
('Vision','HATIM envisions a Deemed University based on moral and human values where quality and relevant education is provided to mould and educate youth of the contemporary world. It seeks high standards, commitment to hard work and dependence on God, with balanced secular education and spiritual grooming.',2),
('Mission','Provide/facilitate quality education to mould and equip students with relevant knowledge/skills; make competent, reliable and responsible citizens; provide holistic development through human values, academic excellence and professional competence; cultivate leadership, communication, interpersonal skills, commitment, problem-solving, value-driven mindset, professionalism, flexibility, motivation and intellectual curiosity.',2),
('Core Values','Readiness and willingness to seek, share and serve; faith and total dependence on God; commitment to devotion, worship and balanced human values teaching; hardwork; lifelong learning; integrity and accountability; teamwork.',2),
('College Verse','Romans 11:36: From Him and to Him, and through Him are all things.',2),
('College Motto','Seek, Share, Serve.',2),
('College Houses','Lorrain House – Red; Savidge House – Yellow; Clark House – White; Chapman House – Blue.',2),
('College Hymn','How Great Thou Art.',2),
('College Flower','Dandelion – reflects resilience and the ability to multiply even under the harshest conditions.',2),
('Admission 2026 contacts','BCA 98622 19007; BCOM 98629 53757; BSW 87949 16678; BA Education 82570 50435; BA English 95502 43092; BA History 75071 39140; BA Philosophy 93982 25404; BA Psychology 81318 26170.',36),
('Admission application','Online: https://admission.hatim.ac.in/ ; Offline: Admin Office, HATIM Campus, Kawmzawl, Pukpui, Lunglei.',36),
('Campus culture','Residential co-ed; separate hostels/residences; WiFi enabled; smoke free; sports and music facilities; gymnasium; power backup; strong alumni association.',2),
('Library clearance','Online library clearance application and certificate; instant certificate; 100% online; no fees.',25);

-- Milestones from the HATIM About page
INSERT INTO milestones(event_date,event_text,source_id) VALUES
('October 2006','Project work on establishment of the College was in full swing.',2),
('November 2006','Final inspection of proposed College building; groundwork/renovation; Governing Board established; Government of Mizoram granted BCM permission to establish college.',2),
('21 June 2007','College started with Principal, 2 lecturers and 3 other staff; classes commenced with 29 students.',2),
('24 January 2008','College inaugurated by Dr. R. Lalthangliana, Hon''ble Minister, Government of Mizoram.',2),
('7 March 2008','Mizoram University team visited HATIM for affiliation.',2),
('17 August 2008','College started English Service every Sunday afternoon for Lunglei town.',2),
('October 2008','Mizoram University granted provisional affiliation for BCA, B.Com (Hons) and B.Com (Gen).',2),
('July 2010','BSW introduced after Mizoram University affiliation.',2),
('24 January 2011','HATIM foundation day observed.',2),
('08 March 2011','Official College website launched and Topper''s Plate installed.',2),
('April 2011','Fully equipped Conference Hall operational.',2),
('May 2011','Gymnasium opened.',2),
('June 2011','BA English Core introduced after Mizoram University affiliation.',2),
('December 2011','Ground breaking of new campus at Kawmzawl.',2),
('August 2012','Additional Computer Laboratory No. 2 opened; 10 KV Kirloskar diesel generator installed.',2),
('November 2012','Library automation completed; Men''s Hostel construction at Kawmzawl completed.',2),
('December 2012','First Annual Magazine DOKIMOS released.',2),
('08 September 2013','Foundation for ST Girls Hostel laid at Kawmzawl.',2),
('April 2014','Internet access to all faculty rooms.',2),
('May 2015','Fences made and road blacktopping completed; two new college buses purchased.',2),
('June 2015','Men''s Residence shifted to Kawmzawl main campus.',2),
('10 December 2015','Official website re-launched.',2),
('14 January 2016','ST Girls Hostel inaugurated.',2),
('30 March 2016','Farewell and pension of former Principal Dr. Chawngthanpari.',2),
('April 2016','Foundation laid for Administrative Block.',2),
('16 May 2016','Dr. Rema Chhakchhuak took principal charge.',2),
('22 June 2016','Contract between NECS and BCM signed for Administrative Building.',2),
('22 August 2016','UGC recognition under 2(f) and 12(b) received.',2),
('17 September 2016','Construction of Vertical Extension of Ladies Residence-II started; foundation for Academic Block C laid.',2),
('14 February 2019','Move to Kawmzawl initiated by Commerce, English and Social Work; Computer Applications remained at town campus until notice.',2),
('15 March 2019','Foundation for Academic Block C laid.',2),
('July 2020','BA History, Philosophy, Education and Psychology Core introduced after MZU affiliation.',2),
('September 2020','HATIM LMS online teaching started 7 September 2020; 115 lecture videos/tutorials recorded and uploaded in first 15 days.',2),
('November 2020','All departments and offices shifted fully from Chanmari town campus to Kawmzawl.',2),
('March 2021','Academic Block A ready for occupation.',2),
('09 March 2021','New academic session commenced with admission of Day Scholars.',2),
('21 February 2022','Administrative Building inaugurated by Rev. Dr. V. Laldingliana.',2),
('4 July 2022','First Core students in Psychology and Education enrolled as third-year core students.',2),
('4 July 2022','BA & B.Com faculty rooms/classrooms in Academic Block C occupied.',2),
('9 September 2022','HATIM Literary Club established; first meeting had 64 student enrolments.',2),
('29 November 2022','New computer/IT lab, Psychology lab and Language Lab in Academic Block C inaugurated.',2),
('26 January 2023','HATIM received first prize for cleanest institution in Lunglei.',2),
('3 February 2023','Single-use-plastic-free campus declaration held.',2),
('18 April 2023','First HATIM campus museum inaugurated.',2),
('22 March 2024','Village adaptation programme at Zotuitlang.',2),
('28 March 2024','Principal moved into campus after completion of Principal''s Quarter; basketball court completed.',2);


-- ============================================================
-- FULL PROSPECTUS PAGE TEXT
-- Every page is retained as source text so no OCR-extracted
-- prospectus information is discarded.
-- ============================================================

CREATE TABLE prospectus_pages (
    page_id INT PRIMARY KEY,
    page_number INT NOT NULL,
    page_title VARCHAR(500),
    extracted_text LONGTEXT NOT NULL,
    source_url VARCHAR(1000) NOT NULL
);

-- A small explicit source index makes it easy for an application/chatbot to retrieve provenance.
CREATE INDEX idx_source_pages_type ON source_pages(source_type);
CREATE INDEX idx_departments_name ON departments(name);
CREATE INDEX idx_courses_name ON courses(course_name);
CREATE INDEX idx_staff_name ON staff(name);
CREATE INDEX idx_notices_date ON notices_news(item_date);
CREATE INDEX idx_library_category ON library_categories(category_name);

-- Useful chatbot query view
CREATE OR REPLACE VIEW v_chatbot_knowledge AS
SELECT 'institution' AS entity_type, institution_id AS entity_id, name AS title, source_url, source_text AS content FROM institution
UNION ALL
SELECT 'source_page', source_id, title, source_url, extracted_text FROM source_pages
UNION ALL
SELECT 'department', department_id, name, NULL, CONCAT(description,' ',learning_outcomes,' ',teaching_methods) FROM departments
UNION ALL
SELECT 'course', course_id, course_name, NULL, CONCAT(introduction_objectives,' ',course_outcomes,' ',curriculum_details) FROM courses
UNION ALL
SELECT 'facility', facility_id, name, NULL, description FROM facilities
UNION ALL
SELECT 'milestone', milestone_id, event_date, NULL, event_text FROM milestones
UNION ALL
SELECT 'notice_news', item_id, title, url, details FROM notices_news
UNION ALL
SELECT 'institutional_info', info_id, section, NULL, information FROM institutional_information;


-- SOURCE ID MAP: 1..39 follow the source_pages insertion order above.
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (1,1,'HATIM cover and institutional overview','IBHER AND TECHNICAL INSTITUTE, MIZ0RAy

~) HATIM

ESTD. 2007

NAAC Accredited B+ Institute
Affiliated to Mizoram University, AICTE Approved, UGC recognised 2f & 12B Institute

(A Baptist Church of Mizoram undertaking)

o g

All India Council for National Service National Cadet
Mizoram University University Grants Commission Govt. of Mizoram Technical Education (AICTE) Scheme (NSS) Corps (NCC)

www.hatim.ac.in','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (2,2,'About HATIM, salient features, at-a-glance, vision, mission and values','g qd e ora A omp q AA
cle) o d of Decemb 024
e d on Decemb 0, 2024 a g ade ‘B 68 PA
0 A private and anced college 0 0 AA ditatio
2 an ps 4
‘4 Ar Gi = r
Bebe | aa “ *
‘ | Bhi \\3 — if ed | Oe
F = At, we. 4
y 4 2 } J y
3 Vw? fe Ay L it : ees jy, ) ¢ !
Wty a a ‘so f w \\''@ =
ily ak. 2 |
we _EBAs A —
‘ * ZiP vga:
b NG Ne ] eon |
meses LL LE
yi ee » Se eZ : ) yr

FIRST CYCLE

AV

ACCREDITED BY

4 Ss
. —
@282b ARE f
4 wr a _J/
a rs
JN

x
NAAC

NATIONAL ASSESSMENT AND ACCREDITATION COUNCIL

GRADE ‘B+'' (2.68 CGPA)

First Non-Governmental (Private & Self-finance) College in Mizoram to be accredited by NAAC','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (3,3,'Institutional best practices, add-on/skill courses and BCA/BSW','ABOUT
HATIM

Established in June, 2007, the Higher and Technical Institute, Mizoram (HATIM) is the first residential Co-ed
College in Mizoram that is undertaken by a christian organization (Baptist Church of Mizoram).

HATIM genuinely cares for the youth of the society and always seeks to fulfill its mission in positively transforming
lives of young people through education. One will find in the Institute quality education based on good moral
conduct, human values and English-speaking culture.

It strives to bring willing and committed teachers from all over the state, to teach and guide students in their
academic pursuits for excellence and earnest commitment.

SALIENT FEATURES OF HATIM

+ World-class quality education at affordable price. * Cultivating deep commitment to serve local
+ Agood infrastructure and dedicated faculty. communities and the nation.
+ Aco-ed residential institute with separate homely * Commitment to emphasize and embody
residences for male and female students. tlawmngaihna - the golden Mizo ethos of
+ Wide spectrum of extra-curricular and co-curricular selflessness and respect for elders.
activities under committed Academicians. + Sharp focus and commitment to develop strong
+ Well-stocked library that is still expanding. English-speaking skills so as to equip students to
+ Well-equipped Computer Laboratory. function confidently in cross-cultural environment.
+ Internet facilities for the staff and students. + Responsible care of the environment
+ Dress code that reflects neatness, modesty and
standards generally accepted at Indian/Mizo
Educational Institutes.','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (4,4,'BCA and BSW course information','HIGHER AND TECHNICAL INSTITUTE, MIZORAM (HATIM)

At-A-Glance

Estd : JUNE 2007

Teaching staff:

Regular / Contract - 35
Fixed Pay/Casual- 6
Part-time /Guest - 4
Total - 45

[vA

aWVata
Ann

WWW

Non-Teaching Staff

Regular / Conract - 18
Fixed pay / Casual -
Total - 29

< }+

* "No. of students (2025)

Hostels Capacity:
Ladies'' Hostel — - 100
Gents'' Hostel - 100

of me || mi ay |
cil £ ww Frit in 0
Pie Campus Area

Total No. of Graduates (Since 2010): 999

rene

No. of Mizoram University (MZU) Subject Toppers (2010 - 2025) : /

*
No. of students placed in Top 10

in Mizoram University Exams (2010 - 2025): A | U

pene

Facilities:

+ Enterprise Resource Planning (ERP) system
manage all Academic and Administrative activities

+ Automated Library with 12000+ volumes

* Digital Library / Institutional Repository

+ Well furnished I.T. Centre

+ Language Laboratory

+ Psychology Laboratory (for behavioural studies)

« ICT enabled classrooms

* Internet WiFi enabled Campus

« CCTV monitored buildings and Campus

* Decentralised Solid Waste Management System
* Cafeteria

* 10KW Solar Plant and a total of 35KVA Diesel
Generators for uninterupterd power supply','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (5,5,'B.Com and BA History course information','VISION

The Higher and Technical Institute, Mizoram envisions a Deemed University
based on moral and human values where quality and relevant education is
provided to mould and educate the youth of contemporary world.

The vision entails an institute with the highest standards with a commitment to
ilape whe hardwork and dependence on God where there is a balanced integration of
a iB. secular education and spiritual grooming as the underpinning philosophy for
the right kind of understanding for students to have a better future in this
competitive world.

Our mission is to provide and facilitate quality education to students so as — to mould
and equip them with relevant knowledge and skills; to make them competent, reliable and
responsible citizens in the society, nation and beyond.

We seek to be a nurturing ground for students and provide holistic development through
human values teaching, academic excellence and professional competence to make effective
contribution to society in a dynamic environment. Students will be equipped and enabled

to seek, share and serve continually to be genuine sources of blessing for the society
through excellence in education. They will serve the contemporary world by

transforming societies at large and they will make crucial contributions to

communal harmony and national integration.

We are committed to imparting good leadership qualities, communication and
interpersonal skills, commitment, problem-solving ability, value-driven mind-set,
professionalism, flexibility, motivation, and sharp intellectual curiosity in our students.

CORE VALUES:

* Readiness and willingness to seek,
share and serve

« Faith and total dependence on God

* Commitment to devotion, worship and
balanced human values teaching

+ Hardwork

* Lifelong learning

* Integrity and accountability

+ Teamwork','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (6,6,'BA English and BA Philosophy course information','Add-On Courses: Our Best Practices:
* Course on Computer Concepts (CCC) * Reliable career guidance and counselling
* Computer Hardware and Networking + Regular Mentoring sessions

* Nurturing talents and creativity through Interest Clubs
College Festival NATIONAL CADET NATIONAL SERVICE

Hill Fest CORPS (NCC) SCHEME (NSS)','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (7,7,'BA Education and BA Psychology course information','SKILL ENHANCEMENT COURSES
The college currently offers the following skill enhancement courses for students:-

* Gardening * Men’s parlouring
+ Plumbing and Sanitation * Beauty and wellness
+ House wiring

College Verse :

College Houses and Colours : College Hymn : How Great Thou Art

Lorrain House — Red ee College Flower : Dandelion - reflects resilience
Savidge House - Yellow and the ability to multiply even under the

Clark House — White harshest of conditions.

‘i, ‘ollege Motto : Seek, Share, Se
Chapman House - Blue am" pes —','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (8,8,'Admission qualification criteria and reservation','INTRODUCTION & OBJECTIVES:

Bachelor of Computer Applications (BCA) is a full-time professional undergraduate degree course in
Computer Applications. The basic objective of BCA Course is to provide young minds with the required
knowledge and necessary skills to get rewarding careers into the ever changing world of Information
technology.

COURSE OUTCOMES:

The Graduates will be technically skilled in software programming, hardware
maintenance, system planning etc. Career opportunities include entrepreneurial
roles in the computer world as independent business owners, software authors,
consultants, or suppliers of systems and equipments. They can be employed in
the field of Management, Software and Hardware Industries, Technical writing, IT
Training Institutes, Software Consultancy & Technical Support. Scan to download Syllabus

BACHELOR OF
SOCIAL WORK (BSW)

Bachelor of Social Work (BSW) is a ful time undergraduate course. It is a subject with a prime concern to
promote social change, development, problem solving in human relationships and empowerment of people to
enhance the quality of life and well-being for the betterment of the society.

Bachelor of Social Work Course is designed to empower its learners with pro-
fessional approaches, knowledge, skills and, techniques to be able to deal with
different kinds of issues and challenges in life. Social work study has a
wide-range of job orientation and employment opportunity. As a social worker,
they can work in different areas such as Hospital, Education sector, Social wel-
fare programme and scheme, Human rights Agencies, Disaster management,
Church/Community base organization, NGOs and Government sector, Industry, .
various kinds of Home like Old Age, Orphanage, Child care Centre and so on. Scan to download Syllabus','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (9,9,'Fees, management, application and college bus fare','"BACHELOR OF
COMMERCE (B, COM)

INTRODUCTION & OBJECTIVES:

Bachelor Of Commerce (B. Com) is a full-time undergraduate degree course. The main objective is to prepare,
support and encourage students to excel in various facets of the commercial world. The department gave a great
environment for students not only to conquer in academics but also in other extra curriculum.

The course gives a good opportunity for the graduates in seeking jobs in different fields like, Banking,
Accounting, Entrepreneurship, E. Business (E. Commerce), taxation, Financing, insurance, etc. The curri-
culum is designed in such a way that the graduates will be able to sucessfully tackle with different problems
in Business world. The Entrepreneurship Knowledge Cell (EKC) functions under the umbrella of Commerce
Department as an assisting agency for ambitious entrepreneurs of the region, which assists the aspiring
entrepreneurs to work and achieve on their future endeavours.

In addition to the regular subjects, the Department offers optional add-on courses aimed
at building practical skills. These cover areas like tour operators, baking, house wiring,
beauty and management etc.. and are provided as supplementary papers to benefit stu-
dents beyond the core curriculum.

Within the Department, there is also a student-led body called the House of Commerce.
Its purpose is to create more opportunities for students and support leadership develop-
ment across various fields. Students are assigned different roles and take part in a range scan to download Syllabus
of activities through this body.

INTRODUCTION & OBJECTIVES:

The Bachelor of Arts in History is a full-time undergraduate degree course under Mizoram University. Since New
Education Policy (NEP) 2020 is implemented, the course is designed for 4 years (I to VIII semesters) and aimed
at the students to - familiarise with the major socio-economic, cultural, religious and political developments, chang-
es and continuity of the history of different countries like India (including Mizoram and other parts of Northeast)
America, Europe, China and South Asia; examines the intersection of gender and historical events, movements
and ideas and the role of public history; provide the role of Archaeology and Digital technologies in the study of his-
tory; acquaint the knowledge of Research Methodology and various approaches in historical writing; and engage
in field project like Heritage studies, Archives, Museums, Local and Community history.

COURSE OUTCOMES:

After completion of the Course, a student of BA (History) will be equipped with a
vast knowledge of Indian history and other parts of the World. The curriculum posi-
tively will prepare for various competitive examinations; help to become a better
reader, thinker and good citizen; develop in understanding the process of conduct-
ing a research project in the field of history; and provide analytical skills by critical
interpreting historical events through oral and written communications.

Scan to download Syllabus','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (10,10,'College bus fare and institutional information',', BACHELOR OF ARTS (BA): ENGLISH

2 ORICCTIVEC-

The B.A. course with English Literature as its core uses the syllabus prescribed by the Mizoram University.
It is a full time undergraduate degree course.

COURSE AND LEARNING OUTCOMES:

After completion of the course, a student of B.A. (English) will be equipped with
knowledge of history of English literature and that of English language. He/she
will have gone through systematic learning of Phonetics and its practical
usage; will have been equipped with interest in literature and thus, skilled in
composition of drama, short stories, plays, poems, fiction etc. The curriculum :
also sharpens a student interested in theatre art through practical learning. Scan to download Syllabus

INTRODUCTION & OBJECTIVES:

The Department of Philosophy aims at providing quality in Logic, critical thinking, ethics and tradi-
tional approach to different theories of both Indian and Western Philosophy and also to practical
philosophy across semesters within three years under NEP 2020 adapted by Mizoram University.

COURSE AND LEARNING OUTCOMES:

After completion of the B.A. (Philosophy) course a student will be well equipped with -

* problem-solving capacities, the ability in critical thinking and forming arguments thereby enhancing
the student logical reasoning acumen. This helps immensely in appearing for various competitive
examinations such as banking, civil services etc.

+ the knowledge of general philosophical analysis of law and legal institutions.

* understanding of moral concepts and principles and apply them practically in
their day to day life. ;

* ability to read and comprehend philosophical texts and form argument, thereby fF
enabling to think rationally about any philosophical ideologies relevant to both
theoretical and practical aspects of it.

Scan to download Syllabus','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (11,11,'Campus and facilities','7 BACHELOR OF ARTS (BA): EDUCATION

The Under Graduate Bachelor of Arts in Education is a four-year UG Programme with a research pro-
ject on the fourth year and emphasizes on the integration of various disciplines on the first three years
of the Programme (in line with NEP 2020). The general objective of the Programme is to help students
acquire extensive knowledge about educational concepts, ideas, methods and applications. Along with
this objective, it also emphasizes on developing higher cognitive abilities, enhancing skill-based educa-
tion, promoting scientific temper and inculcating research enthusiasm among the students.

COURSE AND | FARNING OUTCOMES:
COURSE AND LEARNING OUTCOMES:

After completing the course, the students will:

1. Be well acquainted with the basic tenets of Education. a i
2. Be able to use their analytical ability for in-depth investigative studies.
3. Use their acquired knowledge for the purpose of creating new ideas, methods a er
and solutions to problems.
Be able to conduct research in the field of education independently or in colla- [pL
boration with NGO''s and interest groups. a
Be prepared to pursue further education in teacher training institutes and bn
institutions of higher learning. Scan to download Syllabus

oO

ey
aes?

INTRODUCTION & OBJECTIVES:

The Undergraduate Bachelor of Arts in Psychology is a four-year program that aligns with the principles out-
lined in the National Education Policy (NEP) 2020. The program emphasizes interdisciplinary integration
throughout the first three years, allowing students to explore various disciplines alongside psychology. In the
fourth year, students can opt for a research project, applying their skills to a psychology area of interest. The
program explores behavioral and cognitive development across social, organizational, and lifespan contexts,
fostering a comprehensive understanding of human psychology.

COURSE AND LEARNING OUTCOMES:

1. Students will understand established theories and concepts in psychology
for application in diverse settings.

2. Students will gain insights into human behavior through theoretical study
and practical experimentation.

3. Students will apply various research methods in psychological studies.

4. Students will be equipped with the skills to administer, interpret, and utilize
psychological tests effectively. conto domead Siti','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (12,12,'Campus facilities and contact information','QUALIFICATION CRITERIA FOR ADMISSION

Considering the criteria laid out by Mizoram University, the qualification criteria of candidates who

are eligible to take admission for the new Academic session are as below:

(i) Bachelor of Arts (BA): All streams with 45% aggregate marks in 10+2 for General and 5%
relaxation for SC/ST/OBC.

(ii) Bachelor of Commerce (B.Com): Preferably with Commerce background with 45% aggregate
marks in 10+2 for General and 5% relaxation for SC/ST/OBC.

(iii) Bachelor of Computer Applications (BCA): All streams with 50% aggregate marks in 10+2 for
General and 5% relaxation for SC/ST/OBC.

(iv) Bachelor of Social Work (BSW): All streams with 45% aggregate marks in 10+2 for General and
5% relaxation for SC/ST/OBC.

The petals reservations can be made for the allotment of seats:
15% for Schedules Castes (SC), 7.5% for Scheduled Tribes (ST), 27% for Other Backward
Classes (OBC), 5% for Persons with Disabilities (Divyangjan).
5% Sports Quota
5% for Economically Weaker Section (EWS)

Candidates securing 60% (First Class) and above in Class 12 examination will be eligible for
Direct Admission.

Candidates applying for Hoste! Admission will be given seats on First Come First Serve basis.
Free Admission for Distinction Mark Holders','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (13,13,'Campus imagery / facilities','STRUCTURE OF FEES

Course Fee PerSemester or Per Month

Bachelor of Commerce (B.Com) = 17,400 = 3,000
Bachelor of Computer Applications (BCA) = 19,000 3,300
Bachelor of Social Work (BSW) = 17,400 F 3,000
Bachelor of Arts (BA) = 15,000 = 2,600','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (14,14,'Campus imagery / facilities','MANAGEMENT OF HATIM

HATIM is established and privately anaged by the Society of Higher and
Technical Studies under the aegis of the Baptist Church of Mizoram (BCM).
The BCM is a congregation with a membership of more than one hundred and
seventy thousand, and the entire community is committed to render its service
to fulfil this Educational Ministry.

y ADMISSION APPLICATION

Candidates may apply either online and offline.

Online application at : https://admission.hatim.ac.in

Offline application at : Administrative Block, HATIM Campus, Kawmzawl, Lunglei.
=) Free Internet Wifi on the Campus;
(3) Conveyance (Bus) available for day scholars within routes of College Buses.

COLLEGE BUS FARE
BUS POINT MONTHLY PER SEMESTER ONE WAY
Theiriat 1,750 8,500 150
Sethiun 1,650 8,000 140
3 Gate 1,600 7,750 130
Lunglawn 1,400 6,750 120
Kawizau 1,350 6,500 120
A.O.C 1,300 6,250 no
Falkawn 1,300 6,250 no
Faith Hospital 1,250 6,000 90
Civil Hospital 1,250 6,000 90
A.P Tlang 1,200 5,750 80
Venglai 1,150 5,500 70
Tlabung Peng 1,100 5,250 70
G, College Peng 1,100 5,250 60
S.B.1, R.T.P 1,050 5,000 60
Kikawn 1,000 4,750 60
Zohnuai Peng 950 4,500 50

Serkawn 900 4,250 40

Lungdawhkawn 850 4,000 40
_ CHB Point 4,000 40','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (15,15,'Campus facilities photographs','MAIN GATE','HATIM Prospectus 2026');
INSERT INTO prospectus_pages(page_id,page_number,page_title,extracted_text,source_url) VALUES (16,16,'Campus photographs, activities and contact information','Photographic page. Visible labels: CAMPUS; WiFi Enabled; Smoke Free; Lush Green; Litter Free; Various Sports & Music facilities; Gymnasium; Good Power Back-up; Support of strong Alumni Association; VALENDICTORY CEREMONY; SPIRITUAL NURTURING PROGRAMME; TEACHERS'' DAY; SEIL TOUR; HILL FEST 2025 - A YOUTH FESTIVAL; PALM SUNDAY; ONE DAY SPORTS. Footer: HIGHER AND TECHNICAL INSTITUTE MIZORAM (HATIM), KAWMZAWL, PUKPUI, LUNGLEI: P.O. ZOTLANG - 796691, MIZORAM; Phone 8787808163; Email office@hatim.ac.in; Website www.hatim.ac.in; Instagram hatim_college_official; FB & YT: HATIM.','HATIM Prospectus 2026');

-- ============================================================
-- VERIFIED WEBSITE INVENTORY / ADDITIONAL WEB FACTS
-- ============================================================

CREATE TABLE website_inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    page_type VARCHAR(100),
    title VARCHAR(500),
    url VARCHAR(1000),
    content LONGTEXT,
    last_checked VARCHAR(100)
);

INSERT INTO website_inventory(page_type,title,url,content,last_checked) VALUES
('Home','HATIM Home','https://www.hatim.ac.in/','Higher and Technical Institute, Mizoram. Estd. 2007; Baptist Church of Mizoram undertaking; affiliated to Mizoram University; UGC recognised 2f and 12B; NAAC B+ in 2024 (1st Cycle). Address Kawmzawl, Pukpui, Lunglei - 796691; email hatimoffice@gmail.com; phone 8787808163. Eight departments: Commerce, Computer Science, Education, English, History, Philosophy, Psychology, Social Work.','2026'),
('Admission','HATIM Admission Notice 2026-2027','https://hatim.ac.in/news/details/411/HATIM%20ADMISSION%20NOTICE%20FOR%202026%20-%202027%20SESSION','Eight programmes: B.Com, BCA, BSW, BA Education, BA English, BA History, BA Philosophy, BA Psychology. Online application at admission.hatim.ac.in; offline at Admin Office, HATIM Campus. Free admission fee for HSSLC/Class XII distinction 75%+; direct admission for first class and above; day scholar/hosteller; college bus for day scholars; hostel first-come-first-served. 2026 contacts: BCA 98622 19007; BCOM 98629 53757; BSW 87949 16678; BA Education 82570 50435; BA English 95502 43092; BA History 75071 39140; BA Philosophy 93982 25404; BA Psychology 81318 26170.','2026'),
('About','About the College','https://www.hatim.ac.in/page/about-the-college','HATIM is established and privately managed by the Society of Higher and Technical Studies under the aegis of Baptist Church of Mizoram. Courses offered: B.Com, BCA, BSW, BA English, History, Philosophy, Education and Psychology. Milestones begin in October 2006 and include establishment in June 2007, inauguration in January 2008, affiliation, campus development, new core departments, LMS, museum and other developments.','2026'),
('Objectives','Objectives and Core Values','https://www.hatim.ac.in/page/objectives','Objectives include future-professional relevance, rigorous evolving programmes, practical faculty knowledge, personal student care, conducive development environment, Christian values, hi-tech exposure, collaboration with Church/Government/NGOs/institutions, and international outlook. Core values include devotion and faith, seek/share/serve, respect and integrity, inclusivity, nature, hard work, accountability, teamwork and openness to progress.','2026'),
('Department','Computer Science','https://hatim.ac.in/departments/bca','BCA syllabus areas include Mathematics-I (Discrete), PC Software and Computer Fundamentals, Internet/Web Design and practicals; C programming, Numerical Analysis, Computer Architecture, MIS and practicals; Data Structures, Operating Systems, Accounting/Financial Management, E-Commerce/Web Technology and practicals; OOP C++, System Analysis and Design, Unix/Shell, Networking-I and practicals; Networking-II, DBMS, GUI Programming, Software Engineering and practical VB/DBMS. Faculty listed include Joseph Lalhunmawia, H. Lalrinawma, K. Lalmuanpuia, R. Vanlalawmpuia, H. Lalruatkima, R. Lalruatfela and Biakhluzuala Samtes.','2026'),
('Department','Commerce','https://hatim.ac.in/departments/bcom','Core areas include financial/cost/corporate accounting, taxation, insurance, banking, marketing, management, industrial/mercantile/company laws, research in management/marketing/finance, IT/E-commerce, secretarial/clerical practices. Compulsory papers include General English, Mizo and Environmental Studies. Methods include lectures, presentations, exercises/tests, assignments, seminars/workshops, library work, skills development, Commerce Day and cleanliness drives.','2026'),
('Department','English','https://hatim.ac.in/departments/ba-english','Core areas include history of English literature/language and phonetics, poetry/short stories, fiction, drama, women writings, literary theory/criticism, Indian writing in English and American literature. Electives include Philosophy, History, Psychology and Education. Compulsory papers include General English, Alternative English, Mizo and Environmental Studies. Teaching includes lectures/PPT, group work, library, seminars, quizzes/tests and functional English classes.','2026'),
('Department','History','https://hatim.ac.in/departments/history','Three-year Bachelor’s Degree under CBCS with 140 credits on the department page. Learning covers pre-colonial Mizoram to the 1960s, socio-economic/religious/political/cultural developments in India and the world, individual and society, competitive examinations, reading/thinking and citizenship. History was an elective from 2011-2012 and became full-fledged core/honors from 2020-2021.','2026'),
('Department','Philosophy','https://hatim.ac.in/departments/philosophy','Focuses on Logic, critical thinking, ethics, Indian and Western Philosophy and practical philosophy. Outcomes include critical thinking, argument formation, logical reasoning, moral concepts, philosophical reading and interdisciplinary arguments. Department established with English in 2011 as an elective and became full-fledged core in 2020-2021.','2026'),
('Department','Education','https://hatim.ac.in/departments/education','Education department describes a BA programme emphasizing educational concepts, ideas, methods and applications, NEP 2020, field visits, analytical investigation, innovation and research. Current website page describes three-year degree outcomes while the 2026 prospectus describes a four-year NEP programme with fourth-year research project.','2026'),
('Department','Psychology','https://hatim.ac.in/departments/psychology','Psychology programme develops knowledge in core psychology, ethical research/practical work, awareness of behaviour and interaction, and responsible social roles. Current website page describes a three-year CBCS course; 2026 prospectus describes a four-year NEP 2020 programme with interdisciplinary first three years and optional fourth-year research project.','2026'),
('Department','Social Work','https://hatim.ac.in/departments/bsw','Core areas include introduction to social work, psychology/sociology for social workers, fieldwork, work with individuals/groups/communities, economics/politics, social problems, family/child welfare, social work research, welfare organisations, community development, social policy/planning, human rights, disability, health/mental health, legislation, social defense, environmental studies, substance abuse and HIV/AIDS.','2026'),
('Facility','Language Laboratory','https://www.hatim.ac.in/page/language-lab','Computer-based language practice with listening, speaking, reading and writing activities. Powered by Sonako, 10 computers with high-speed internet and audio-visual aids; capacity 9 students. Nine systems: i3 3.30GHz, 500GB, 4GB, UPS, 16:9 LCD. One server: i3 3.30GHz, 500GB, 2GB, 10 UPS, 16:9 LCD.','2026'),
('Facility','College Buses','https://hatim.ac.in/page/college-buses-5nos','Facilities page lists 5 college buses, amphitheatre, CCTV surveillance, disabled-friendly facilities, drinking water, Entrepreneurship Knowledge Cell, free WiFi campus, museum and vehicle parking.','2026'),
('Museum','History Museum','https://hatim.ac.in/page/museum','Educational museum for students, faculty, public, researchers and interested learners. Inaugurated 18 April 2023 by the Principal at the time. Galleries: Natural, Cultural, Technological, Fine Arts and Archives. More than 40 types of materials, numbering in the hundreds, collected from different parts of Mizoram.','2026'),
('Governance','Students Council','https://hatim.ac.in/page/students-council','Student council constitution adopted at the 56th Council Body Meeting on 20 July 2017. Purpose includes leadership, student welfare, co-curricular/extracurricular activities, competitions, social/cultural programmes and harmonious college relations. 2024-2025 office bearers: Chairman: the Principal; Vice Chairman Stephen Lalnunpuia; General Secretary Naomi Lalruatdiki; Assistant General Secretary Johny Lalmuanpuia; Treasurer Lallawmkimi Chawngthu; Assistant Treasurer Vanlalawmpuii.','2026'),
('Governance','Alumni Association Constitution','https://hatim.ac.in/page/constitution-alumni','HATIM Alumni Association registered under Mizoram Societies Registration Act, 2005, Registration No. MSR 1107 dated 21.10.2019. Objectives include alumni-HATIM ties, a common platform, loyalty, college welfare, contributions and support for economically backward students. Membership open to anyone completing the three-year HATIM degree; membership fee Rs.10 at admission. General Body quorum 25%; Governing Body 11-20 members; term 3 years; financial year 1 April-31 March.','2026'),
('NAAC','NAAC Peer Team Visit 1st Cycle','https://hatim.ac.in/page/naac-peer-team-visit-1st-cycle','NAAC Peer Team visited 12-13 December 2024. Team: Prof. Bashir Ahmad Joo (Chairperson), Prof. Alok Singh (Member Coordinator), Dr. Vitthal Ghule (Member). Evaluation included academics, administration/accounts, Anti-ragging Cell, Women’s Cell, Internal Complaint Committee, laboratories, classrooms, museum, library, hostels, sports, solid waste management and IQAC.','2026'),
('Library','HATIM Digital Library','https://www.hatimlibrary.in/','Digital repository of HATIM. 809+ resources, 8 departments, 7 categories, free access. Categories: Question Bank 494, Lecture Videos 108, Research Papers 9, Field Work Report 8, Project Work 184, Syllabus 6, Prospectus 0. Departments: Computer Science 274, Commerce 267, Social Work 130, English 29, Philosophy 30, Psychology 2, History 61, Education 16. Library clearance is online, instant, 100% online and no fees. Contact library@hatimlibrary.in.','2026'),
('News','New Gents Residence Warden Quarters and Multipurpose Hall Foundation','https://hatim.ac.in/news/details/360/Dedication%20of%20the%20New%20Gent%E2%80%99s%20Residence%20Warden%20Quarters%20%26%20Foundation%20Laying%20for%20the%20Multipurpose%20Hall','On 4 February 2025, new Gents Residence warden quarters were dedicated at HATIM Campus and foundation laid for a new Multipurpose Hall.','2026'),
('News','IASE M.Ed Study Tour','https://hatim.ac.in/news/details/354/Internship%20and%20Curriculum-Based%20Study%20Tour%20to%20HATIM%20by%202nd%20Semester%20M.Ed%20Students%20of%20IASE%2C%20Aizawl','On 8 April 2025, 23 M.Ed students and two faculty members visited IT Centre, Language Laboratory, Psychology Laboratory, History Museum, Library, Sculpture Garden, Eco Garden, NSS Park and Cafeteria.','2026');

-- Import verification table: useful after importing in phpMyAdmin.
CREATE TABLE data_import_summary (
    summary_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100) NOT NULL,
    expected_minimum_rows INT NOT NULL,
    description VARCHAR(500)
);

INSERT INTO data_import_summary(table_name,expected_minimum_rows,description) VALUES
('institution',1,'Main institutional record'),
('source_pages',39,'Website/source records used for the structured database'),
('departments',8,'Eight HATIM academic departments'),
('courses',8,'Eight current undergraduate programmes'),
('fees',1,'Fee records from the 2026 prospectus'),
('admission_criteria',4,'Admission criteria by programme group'),
('facilities',1,'Facilities from prospectus/website'),
('staff',1,'Administrative staff records'),
('committees',1,'Committee/cell records'),
('committee_members',1,'Committee membership records'),
('library_categories',7,'Seven HATIM Library resource categories'),
('library_departments',8,'Eight HATIM Library departments'),
('library_resources',1,'Featured library resources'),
('bus_fares',1,'College bus fare records'),
('alumni',1,'Alumni records'),
('academic_calendar_items',1,'Academic calendar entries'),
('awards_results',1,'Awards/results/institutional achievements'),
('institutional_information',1,'Vision, mission, values and institutional information'),
('milestones',1,'Historical milestones'),
('prospectus_pages',16,'Every page of the 2026 prospectus is retained as source text'),
('website_inventory',15,'Verified website/library page inventory and extracted facts');

-- Search-friendly indexes. No long UNIQUE indexes are used.
CREATE INDEX idx_source_url ON source_pages(source_url(191));
CREATE INDEX idx_prospectus_page ON prospectus_pages(page_number);
CREATE INDEX idx_website_title ON website_inventory(title(191));

-- A unified chatbot knowledge view containing both structured information
-- and full source-page/prospectus text.
CREATE OR REPLACE VIEW v_full_chatbot_knowledge AS
SELECT 'institution' AS source_kind, CAST(institution_id AS CHAR) AS record_id,
       name AS title, source_url, source_text AS content
FROM institution
UNION ALL
SELECT 'source_page', CAST(source_id AS CHAR), title, source_url, extracted_text
FROM source_pages
UNION ALL
SELECT 'prospectus_page', CAST(page_id AS CHAR), page_title, source_url, extracted_text
FROM prospectus_pages
UNION ALL
SELECT 'website_inventory', CAST(inventory_id AS CHAR), title, url, content
FROM website_inventory
UNION ALL
SELECT 'department', CAST(department_id AS CHAR), name, NULL,
       CONCAT_WS('\n', description, learning_outcomes, teaching_methods)
FROM departments
UNION ALL
SELECT 'course', CAST(course_id AS CHAR), course_name, NULL,
       CONCAT_WS('\n', introduction_objectives, course_outcomes, curriculum_details)
FROM courses
UNION ALL
SELECT 'facility', CAST(facility_id AS CHAR), name, NULL, description
FROM facilities
UNION ALL
SELECT 'institutional_information', CAST(info_id AS CHAR), section, NULL, information
FROM institutional_information
UNION ALL
SELECT 'milestone', CAST(milestone_id AS CHAR), event_date, NULL, event_text
FROM milestones
UNION ALL
SELECT 'notice_news', CAST(item_id AS CHAR), title, url, details
FROM notices_news;
