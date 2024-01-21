CREATE TABLE Parent (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FamilyID INT,
    Name NVARCHAR(100),
    DOB DATE,
    Occupation NVARCHAR(100),
    Country NVARCHAR(100),
    LevelOfEducation NVARCHAR(100),
    FOREIGN KEY (FamilyID) REFERENCES family(ID)
);