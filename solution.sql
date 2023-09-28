
-- Exercise 1 - Joins

-- Question 1
-- SQL query to list the school names, community names and average attendance for communities with a hardship index of 98
SELECT cps.name_of_school, cps.community_area_name,cps.average_student_attendance
FROM CHICAGO_PUBLIC_SCHOOLS AS cps
LEFT JOIN CENSUS_DATA AS cd
ON cps.community_area_number = cd.community_area_number
WHERE cd.hardship_index = 98;

-- Question 2
-- SQL query to list all crimes that took place at a school. Include case number, crime type and community name
SELECT ccd.case_number,ccd.primary_type,cd.community_area_name 
FROM chicago_crime_data AS ccd
LEFT JOIN census_data AS cd
ON ccd.community_area_number = cd.community_area_number 
WHERE ccd.location_description LIKE '%SCHOOL%';

-- Exercise 2 - View

-- Question 1
-- SQL statement to create a view 
CREATE VIEW CHICAGOSCHOOL(School_Name,Safety_Rating,Family_Rating,Environment_Rating,Instruction_Rating,Leaders_Rating,Teachers_Rating) AS 
SELECT NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon,Environment_Icon,Instruction_Icon,Leaders_Icon,Teachers_Icon
FROM CHICAGO_PUBLIC_SCHOOLS;
-- Write and execute a SQL statement that returns all of the columns from the view.
SELECT * FROM CHICAGOSCHOOL;
-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.
SELECT School_Name, Leaders_Rating FROM CHICAGOSCHOOL;


-- Exercise 3 - Stored Procedure

-- Question 1
-- structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(in_School_ID integer, in_Leader_Score integer) -- Name of this stored procedure
LANGUAGE SQL 							-- Language used in this routine
MODIFIES SQL DATA 						-- This routine will only read data from the table
BEGIN	
    DECLARE C1 CURSOR -- CURSOR C1 will handle the result-set by retrieving records row by row from the table
    WITH RETURN FOR -- This routine will return retrieved records as a result-set to the caller query
    SELECT * FROM CHICAGO_PUBLIC_SCHOOLS;
    OPEN C1;
END 
@

-- Question 2
-- SQL statement to update the Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID to the value in the in_Leader_Score parameter
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(in_School_ID integer, in_Leader_Score integer) -- Name of this stored procedure
LANGUAGE SQL 							-- Language used in this routine
MODIFIES SQL DATA 						-- This routine will only read data from the table
BEGIN	
    UPDATE CHICAGO_PUBLIC_SCHOOL
	SET "Leaders_Score"= in_Leaders_Score
	WHERE 'School_ID' = in_School_ID;
END 
@

-- Question 3
-- SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID 
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(in_School_ID integer, in_Leader_Score integer) -- Name of this stored procedure
LANGUAGE SQL 							-- Language used in this routine
MODIFIES SQL DATA 						-- This routine will only read data from the table
BEGIN	
    UPDATE CHICAGO_PUBLIC_SCHOOL
	SET "Leaders_Score"= in_Leaders_Score
	WHERE 'School_ID' = in_School_ID;

    IF in_Leader_Score>0 AND in_Leader_Score<19 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Very weak'
			WHERE "SCHOOL_ID" = in_School_ID;	
		ELSEIF in_Leader_Score<40 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Weak'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<60 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Average'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<80 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Strong'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<100 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Very Strong'
			WHERE "SCHOOL_ID" = in_School_ID;	
		END IF;
-- Routine termination character
END 
@

-- Question 4
-- query to call the stored procedure, passing a valid school ID and a leader score of 50, to check that the procedure works as expected.
CALL UPDATE_LEADERS_SCORE(610281,38);

-- Exercise 4 - Transactions
-- Question 1
--  Update the stored procedure definition. Add a generic ELSE clause to the IF statement that rolls back the current work if the score did not fit any of the preceding categories

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(in_School_ID integer, in_Leader_Score integer) -- Name of this stored procedure
LANGUAGE SQL 							-- Language used in this routine
MODIFIES SQL DATA 						-- This routine will only read data from the table
BEGIN	
    UPDATE CHICAGO_PUBLIC_SCHOOL
	SET "Leaders_Score"= in_Leaders_Score
	WHERE 'School_ID' = in_School_ID;

    IF in_Leader_Score>0 AND in_Leader_Score<19 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Very weak'
			WHERE "SCHOOL_ID" = in_School_ID;	
		ELSEIF in_Leader_Score<40 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Weak'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<60 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Average'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<80 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Strong'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<100 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Very Strong'
			WHERE "SCHOOL_ID" = in_School_ID;	
        ELSE ROLLBACK WORK;
		END IF;
-- Routine termination character
END 
@


-- Question 2
-- Update the stored procedure definition again. Add a statement to commit the current unit of work at the end of the procedure.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE(in_School_ID integer, in_Leader_Score integer) -- Name of this stored procedure
LANGUAGE SQL 							-- Language used in this routine
MODIFIES SQL DATA 							-- This routine will only read data from the table
BEGIN	
		UPDATE CHICAGO_PUBLIC_SCHOOL
		SET "Leaders_Score"= in_Leaders_Score
		WHERE 'School_ID' = in_School_ID;
		
		IF in_Leader_Score>0 AND in_Leader_Score<19 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Very weak'
			WHERE "SCHOOL_ID" = in_School_ID;	
		ELSEIF in_Leader_Score<40 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Weak'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<60 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Average'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<80 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Strong'
			WHERE "SCHOOL_ID" = in_School_ID;
		ELSEIF in_Leader_Score<100 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOL
			SET "LEADERS_ICON" = 'Very Strong'
			WHERE "SCHOOL_ID" = in_School_ID;	
		ELSE ROLLBACK WORK;
		END IF;
		
		COMMIT WORK;
-- Routine termination character
END 
@

--Write and run one query to check that the updated stored procedure works as expected when a valid score of 38 is used.
CALL UPDATE_LEADERS_SCORE(610281,38);
--Write and run another query to check that the updated stored procedure works as expected when one uses an invalid score of 101.
CALL UPDATE_LEADERS_SCORE(610281,101);