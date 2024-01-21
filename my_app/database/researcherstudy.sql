CREATE TABLE ResearcherStudy (
    ResearcherID INT,
    StudyID INT,
    PRIMARY KEY (ResearcherID, StudyID),
    FOREIGN KEY (ResearcherID) REFERENCES Researcher(ID),
    FOREIGN KEY (StudyID) REFERENCES Study(ID)
);