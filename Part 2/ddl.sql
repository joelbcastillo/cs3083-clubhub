CREATE TABLE Person (
	pid VARCHAR(30) PRIMARY KEY NOT NULL,
	passwd CHAR(32) NOT NULL,
	fname VARCHAR(32),
	lname VARCHAR(32),
	email VARCHAR(64),
	role ENUM('student', 'advisor') NOT NULL,
);

CREATE TABLE Advisor (
	aid VARCHAR(30) NOT NULL,
	phone CHAR(12),
	FOREIGN KEY(aid) REFERENCES Person(pid)
);

CREATE TABLE Student (
	sid VARCHAR(30) NOT NULL,
	gender ENUM('M', 'F', 'O'),
	class VARCHAR(30),
	FOREIGN KEY(sid) REFERENCES Person(pid)
);

CREATE TABLE Club (
	cid INT PRIMARY KEY NOT NULL,
	cname VARCHAR(32),
	description VARCHAR(512),
	aid VARCHAR(30) NOT NULL,
	FOREIGN KEY(aid) REFERENCES Advisor(aid)
);

CREATE TABLE Event (
	eid INT PRIMARY KEY NOT NULL,
	ename VARCHAR(32),
	description VARCHAR(512), 
	datetime DATETIME,
	location VARCHAR(512),
	public BOOLEAN DEFAULT FALSE,
);

CREATE TABLE Keyword (
	kid INT PRIMARY KEY NOT NULL,
	topic VARCHAR(32)
);

CREATE TABLE Comment (
	comment_id INT PRIMARY KEY NOT NULL
	comment VARCHAR(512),
	cid INT,
	eid INT,
	public BOOLEAN DEFAULT FALSE,
	FOREIGN KEY(cid) REFERENCES Club(id),
	FOREIGN KEY(eid) REFERENCES Event(id),
	FOREIGN KEY(public) REFERENCES Event(public)
);

CREATE TABLE Membership (
	sid VARCHAR(30) NOT NULL,
	cid INT NOT NULL,
	role ENUM('','','') -- What are possible roles?
	PRIMARY KEY(sid, cid),
	FOREIGN KEY(sid) REFERENCES Student(sid),
	FOREIGN KEY(cid) REFERENCES Club(cid)
);	

CREATE TABLE Sponsors (
	eid INT NOT NULL,
	cid INT NOT NULL,
	PRIMARY KEY(eid, cid),
	FOREIGN KEY(eid) REFERENCES Event(eid),
	FOREIGN KEY(cid) REFERENCES Comment(cid)
);

CREATE TABLE Event_Attendees (
	pid VARCHAR(30) NOT NULL,
	eid VARCHAR(30) NOT NULL,
	PRIMARY KEY(pid, eid),
	FOREIGN KEY(pid) REFERENCES Person(pid),
	FOREIGN KEY(eid) REFERENCES Event(eid)
);