CREATE TABLE Task (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    StudyID INT,
    Name NVARCHAR(255) NOT NULL,
    FOREIGN KEY (StudyID) REFERENCES Study(ID)
    -- Include other attributes as needed
);