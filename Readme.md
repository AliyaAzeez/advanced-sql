## Scenario
In this project, there are three datasets that are available on the City of Chicago’s Data Portal:

Socioeconomic indicators in Chicago
Chicago public schools
Chicago crime data

City of Chicago Datasets
Socioeconomic indicators in Chicago
This dataset contains a selection of six socioeconomic indicators of public health significance and a “hardship index,” for each Chicago community area, for the years 2008 – 2012. A detailed description of this dataset and the original dataset can be obtained from the Chicago Data Portal at:
https://data.cityofchicago.org/Health-Human-Services/Census-Data-Selected-socioeconomic-indicators-in-C/kn9c-c2s2

Chicago public schools
This dataset shows all school level performance data used to create CPS School Report Cards for the 2011-2012 school year. A detailed description of this dataset and the original dataset can be obtained from the Chicago Data Portal at:
https://data.cityofchicago.org/Education/Chicago-Public-Schools-Progress-Report-Cards-2011-/9xs2-f89t

Chicago crime data
This dataset reflects reported incidents of crime (with the exception of murders where data exists for each victim) that occurred in the City of Chicago from 2001 to present, minus the most recent seven days. A detailed description of this dataset and the original dataset can be obtained from the Chicago Data Portal at: https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2

Name the new tables as follows:

CENSUS_DATA
CHICAGO_PUBLIC_SCHOOLS
CHICAGO_CRIME_DATA

#### Exercise 1: Using Joins
Produce some reports about the communities and crimes in the Chicago area.  Use SQL join queries to access the data stored across multiple tables.

##### Question 1
Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.

##### Question 2
Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.

#### Exercise 2: Creating a View
For privacy reasons, create a view that enables users to select just the school name and the icon fields from the CHICAGO_PUBLIC_SCHOOLS table. By providing a view,users cannot see the actual scores given to a school, just the icon associated with their score. Define new names for the view columns to obscure the use of scores and icons in the original table.

##### Question 1
Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.

| Column name in CHICAGO_PUBLIC_SCHOOLS	| Column name in view  |
| --------------------------------------| -------------------- |
|   NAME_OF_SCHOOL	                    |   School_Name        |
|   Safety_Icon	                        |   Safety_Rating      |
|   Family_Involvement_Icon	            |   Family_Rating      |
|   Environment_Icon	                |   Environment_Rating |
|   Instruction_Icon	                |   Instruction_Rating |
|   Leaders_Icon	                    |   Leaders_Rating     |
|   Teachers_Icon	                    |   Teachers_Rating    |

Write and execute a SQL statement that returns all of the columns from the view.

Write and execute a SQL statement that returns just the school name and leaders rating from the view.

#### Exercise 3: Creating a Stored Procedure
The icon fields are calculated based on the value in the corresponding score field. Make sure that when a score field is updated, the icon field is updated too. To do this, write a stored procedure that receives the school id and a leaders score as input parameters, calculates the icon setting and updates the fields appropriately.

##### Question 1
Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer. Don’t forget to use the #SET TERMINATOR statement to use the @ for the CREATE statement terminator.

##### Question 2
Inside stored procedure, write a SQL statement to update the Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID to the value in the in_Leader_Score parameter.

##### Question 3
Inside stored procedure, write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID using the following information.

| Score lower limit	| Score upper limit	|       Icon      |
| ----------------- | ----------------- | --------------- |
|       80	        |        99	        |    Very strong  |
|       60	        |        79	        |       Strong    |
|       40	        |        59	        |      Average    |
|       20	        |        39	        |       Weak      |
|        0	        |        19	        |     Very weak   |

##### Question 4
Run the code to create the stored procedure.

Write a query to call the stored procedure, passing a valid school ID and a leader score of 50, to check that the procedure works as expected.


#### Exercise 4: Using Transactions
If someone calls the code with a score outside of the allowed range (0-99), then the score will be updated with the invalid data and the icon will remain at its previous value. There are various ways to avoid this problem, one of which is using a transaction.

##### Question 1
Update the stored procedure definition. Add a generic ELSE clause to the IF statement that rolls back the current work if the score did not fit any of the preceding categories.

##### Question 2
Update the stored procedure definition again. Add a statement to commit the current unit of work at the end of the procedure.

Run the code to replace the stored procedure.

Write and run one query to check that the updated stored procedure works as expected when a valid score of 38 is used.

Write and run another query to check that the updated stored procedure works as expected when one uses an invalid score of 101.