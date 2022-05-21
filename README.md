# Pewlett-Hackard-Analysis

## Objective
Use PostgreSQL to perform an analysis of the employees to determine who is eligible for retirement at Pewlett-Hackard.  My goal is to use the results to decide if a new mentoring program where experienced employees mentor newly hired people will be useful. 

### Analysis:
    - Task 1: Create an Entity Relationship Diagram (ERD) to map our data (csv files) and use the ERD to create tables for each CSV file in pgAdmin.
    - Task 2: Determine retirement eligibility by performing queries in pgAdmin and export to a csv file (retirement_info.csv).
    - Task 3: Create new tables for employee information, managers in each department, and employees in each department.  Also, export each to a csv file (emp_info.csv, manager_info.csv, dept_info.csv).
    - Task 4: Create a new table for the Sales and Development departments for the new mentoring program and export to a csv file (sales_dev_info.csv).
    - Task 5: Create a retirement titles table and export to a csv file (retirement_titles.csv).
    - Task 6: Create a mentorship-eligibility table and export to a csv file.

## Resources
- Software: pgAdmin 4 6.1, PostgreSQL 11.14
- Website: quickdatabasediagrams.com (mapping data)
- CSV files in the Data folder

## Results
### Retiring Titles Table
 - The most employees eligible for retirement hold senior titles (Engineer and Staff).

  ![retiring_titles_table](https://user-images.githubusercontent.com/33010018/152659068-8fc41940-738b-4902-8fc8-c056e049ed30.png)
 

### Count of Employee Numbers of Unique Titles Table
 - 72,458 roles will need to be filled as the employees begin to retire.

![unique_count](https://user-images.githubusercontent.com/33010018/152659037-7970d6d8-5d5a-4585-a26b-0ec40727ee58.png)
 


### Count of Employee Numbers of Mentorship Eligibility Table
- 1549 employees eligible for mentorship.

![mentors_count](https://user-images.githubusercontent.com/33010018/152659052-895ac3a0-62d6-4f34-be65-e178ea8f54f1.png)



## Summary
- Some results showed duplicates because some employees have switched titles during their time at the company.  
- After removing the duplicates and counting the number of employees eligible for retirement by title, my analysis shows only 2 managers are eligible.  The most employees eligible for retirement hold senior titles (Engineer and Staff).
- Per the count of the unique_titles table, at least 72,458 roles will need to be filled as the employees begin to retire. 
    - query: SELECT COUNT(emp_no) FROM unique_titles;
- Based on the count of the emp_no from the mentorship_eligibilty table, there only 1549 employees eligible for mentorship.
   - query: SELECT COUNT(emp_no) FROM mentorship_eligibilty;
-  We don't have enough mentors for the newly hired employees that will replace our potential retirees.

## Suggestions To Make The Mentoring Program Useful
-  After checking the count of titles on the mentorship_eligibilty table,  I found that there were only 294 Senior Engineers available.  Since the most eligible employees available for retirement are Senior Engineers, the company could find a way to increase the number of mentors available for that position. 

![Screen Shot 2022-02-06 at 12 20 08 PM](https://user-images.githubusercontent.com/33010018/152692975-46483f3c-ddde-4c5e-9f6b-1a6c38addb94.png)
  
 - After reviewing the retirement_titles table, I found that many employees have had multiple titles within the company.  The employees could mentor in previous roles instead of just the current title they hold.  This could increase the number of titles available for mentorship.

![Screen Shot 2022-02-06 at 12 49 10 PM](https://user-images.githubusercontent.com/33010018/152694308-2b454fc2-c2a1-4790-818b-ea6babd8471d.png)

