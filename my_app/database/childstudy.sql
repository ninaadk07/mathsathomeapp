CREATE TABLE ChildStudy (
    ChildID INT,
    StudyID INT,
    PRIMARY KEY (ChildID, StudyID),
    FOREIGN KEY (ChildID) REFERENCES Child(ID),
    FOREIGN KEY (StudyID) REFERENCES Study(ID)
);
