--1) Find out the selling cost AVG for packages developed in Pascal

	SELECT AVG(SCost) FROM software WHERE DEVELOPIN = 'PASCAL'

--2) Display Names, Ages of all Programmers. 

	SELECT PNAME, DATEDIFF(YEAR, GETDATE(), DOB) as AGE FROM programmer
	
--3) Display the Names of those who have done the DAP Course

	SELECT PNAME FROM studies WHERE COURSE = 'DAP'

--4) Display the Names and Date of Births of all Programmers Born in January.

	SELECT PNAME, DOB FROM programmer WHERE MONTH(DOB) = 1

--5) What is the Highest Number of copies sold by a Package? 

	SELECT * FROM SOFTWARE WHERE SOLD = (SELECT MAX(SOLD) FROM SOFTWARE)

--6) Display lowest course Fee

	SELECT MIN(COURSE_FEE) FROM studies

--7) How many programmers done the PGDCA Course?

	SELECT COUNT(COURSE) FROM studies WHERE COURSE = 'PGDCA'

--8) How much revenue has been earned thru sales of Packages Developed in C

	SELECT SUM(SOLD) FROM software WHERE DEVELOPIN = 'C'

--9) Display the Details of the Software Developed by Ramesh. 

	SELECT * FROM software WHERE PNAME = 'Ramesh'

--10) How many Programmers Studied at Sabhari?

	SELECT COUNT(*) FROM studies GROUP BY INSTITUTE HAVING INSTITUTE = 'Sabhari'

--11) Display details of Packages whose sales crossed the 2000 Mark

	SELECT * FROM software WHERE DCOST > 2000

--12) Display the Details of Packages for which Development Cost have been recovered.

	SELECT * FROM software WHERE DCOST < SCOST

--13) What is the cost of the costliest software development in Basic?

	SELECT SCOST , DCOST FROM software WHERE DEVELOPIN = 'BASIC'

--14) How many Packages Developed in DBASE? 

	SELECT COUNT(DEVELOPIN) FROM software WHERE DEVELOPIN = 'DBASE'

--15) How many programmers studied in Pragathi?

	SELECT COUNT(INSTITUTE) FROM studies WHERE INSTITUTE = 'Pragathi'

--16) How many Programmers Paid 5000 to 10000 for their course? 

	SELECT COUNT(PNAME) FROM studies WHERE COURSE_FEE BETWEEN 5000 AND 10000

--17) What is AVG Course Fee

	SELECT AVG(COURSE_FEE) FROM studies

--18) Display the details of the Programmers Knowing C.

	SELECT * FROM programmer WHERE PROF1 = 'C' OR PROF2 = 'C'

--19) How many Programmers know either COBOL or PASCAL

	SELECT COUNT(PNAME) FROM programmer WHERE PROF1 IN ('COBOL','PASCAL') or PROF2 IN ('COBOL','PASCAL')

--20) How many Programmers Don’t know PASCAL and C 

	SELECT COUNT(PNAME) FROM programmer WHERE PROF1 NOT IN ('C','PASCAL') or PROF2 NOT IN ('C','PASCAL')

--21) How old is the Oldest Male Programmer.

	SELECT MAX(Age) AS OldestAge
	FROM (
    SELECT DATEDIFF(YEAR, DOB, GETDATE()) AS Age
    FROM programmer
    WHERE GENDER = 'M'
	) AS Subquery

--22) What is the AVG age of Female Programmers? 

	SELECT AVG(AGE) FROM 
		(SELECT DATEDIFF(YEAR,DOB, GETDATE()) AS AGE
		FROM programmer
		WHERE GENDER = 'F') AS SUBQUERY

--23)  Calculate the Experience in Years for each Programmer and Display with their 
--     names in Descending order
	
	SELECT PNAME, EXPE FROM 
		(SELECT *, DATEDIFF(YEAR,DOJ, GETDATE()) AS EXPE
		FROM programmer) AS subquery
		ORDER BY PNAME DESC

--24) Who are the Programmers who celebrate their Birthday’s During the Current
-- 	Month? 

	SELECT PNAME FROM programmer WHERE MONTH(DOB) = MONTH(GETDATE())

--25) How many Female Programmers are there? 

	SELECT COUNT (*) FROM programmer WHERE GENDER = 'M'

--26) What are the Languages studied by Male Programmers

	SELECT PROF1, COUNT(PROF1) FROM 
		(SELECT PROF1, GENDER FROM programmer 
		WHERE GENDER = 'M' 
		UNION ALL
		SELECT PROF2, GENDER FROM programmer
		WHERE GENDER = 'M'
		) AS subquery
		GROUP BY PROF1 

--27) What is the AVG Salary?

	SELECT AVG(salary) FROM programmer

--28) How many people draw salary 2000 to 4000?

	SELECT COUNT(*) FROM programmer WHERE SALARY between 2000 and 4000

--29) Display the details of those who don’t know Clipper, COBOL or PASCAL. 

	SELECT * FROM PROGRAMMER WHERE PROF1 NOT IN ('Clipper','COBOL','Pascal') AND PROF2 NOT IN ('Clipper','COBOL','Pascal')

--30) Display the Cost of Package Developed By each Programmer. 

	SELECT PNAME, SUM(DCOST) FROM software GROUP BY PNAME

--31) Display the sales values of the Packages Developed by the each Programmer

	SELECT PNAME, TITLE, SCOST FROM software

--32) Display the Number of Packages sold by Each Programmer.

	SELECT PNAME, SUM(SOLD) FROM software GROUP BY PNAME

--33) Display the sales cost of the packages Developed by each Programmer Language wise.

	SELECT DEVELOPIN, TITLE, SCOST FROM software ORDER BY DEVELOPIN ASC

--34) Display each language name with AVG Development Cost, AVG Selling Cost and
--    AVG Price per Copy.

	SELECT DEVELOPIN, AVG(DCOST), AVG(SCOST) FROM software GROUP BY DEVELOPIN 

--35) Display each programmer’s name, costliest and cheapest Packages Developed by him or 
--    her. 

	SELECT PNAME, MAX(SCOST), MIN(SCOST) FROM software GROUP BY PNAME

--36) Display each institute name with number of Courses, Average Cost per Course.

	SELECT INSTITUTE, COUNT(DISTINCT COURSE), AVG(COURSE_FEE) FROM studies GROUP BY INSTITUTE

--37) Display each institute Name with Number of Students. 

	SELECT INSTITUTE, COUNT(PNAME) FROM studies GROUP BY INSTITUTE

--38) Display Names of Male and Female Programmers. Gender also.

	SELECT GENDER, PNAME FROM programmer ORDER BY GENDER DESC

--39) Display the Name of Programmers and Their Packages.

	SELECT PNAME, TITLE FROM software ORDER BY PNAME 

--40) Display the Number of Packages in Each Language Except C and C++

	SELECT DEVELOPIN, COUNT(TITLE) FROM 
		( SELECT * FROM software WHERE DEVELOPIN NOT IN ('C', 'C++'))
		AS subquery
		GROUP BY DEVELOPIN
	
--41) Display the Number of Packages in Each Language for which Development Cost is
--    less than 1000.

	SELECT DEVELOPIN, COUNT(TITLE) FROM
		( SELECT * FROM software WHERE DCOST < 1000)
		AS subquery 
		GROUP BY DEVELOPIN
	
--42) Display AVG Difference between SCOST, DCOST for Each Package. 

	SELECT TITLE, AVG(DCOST - SCOST) as Average_Cost FROM software 
		GROUP BY TITLE

--43) Display the total SCOST, DCOST and amount to Be Recovered for each 
--    Programmer for Those Whose Cost has not yet been Recovered.

	SELECT TITLE, SCOST, DCOST, Amount FROM
		(SELECT DCOST - (SCOST*SOLD) as Amount , * FROM software)
		AS Subquery
		WHERE Amount > 0
	
--44) Display Highest, Lowest and Average Salaries for those earning more than 2000

	SELECT MAX(SALARY), MIN(SALARY) , AVG(SALARY) FROM
		(SELECT * FROM programmer WHERE SALARY > 2000)
		AS Subquery
	
--45) Who is the Highest Paid C Programmers? 

	SELECT TOP 1 PNAME, SALARY
		FROM programmer
		WHERE PROF1 = 'C' OR PROF2 = 'C'
		ORDER BY SALARY DESC
	
--46) Who is the Highest Paid Female COBOL Programmer?

	SELECT TOP 1 PNAME, SALARY
		FROM programmer
		WHERE PROF1 = 'COBOL' OR PROF2 = 'COBOL' AND GENDER = 'F'
		ORDER BY SALARY DESC
	
--47) Display the names of the highest paid programmers for each Language.

	SELECT PROF1, MAX(SALARY) FROM
		(SELECT PNAME, SALARY, PROF1 FROM programmer
		UNION ALL
		SELECT PNAME, SALARY, PROF1 FROM programmer)
		AS Subquery
		GROUP BY PROF1
	
	
--48) Who is the least experienced Programmer.

	SELECT TOP(1) PNAME FROM programmer
		ORDER BY ( DATEDIFF(YEAR,DOJ,GETDATE()) ) DESC
	
--49) Who is the most experienced male programmer knowing PASCAL.

	SELECT TOP(1) PNAME FROM programmer
		WHERE GENDER = 'M' AND (PROF1 = 'PASCAL' OR PROF2 = 'PASCAL')
		ORDER BY ( DATEDIFF(YEAR,DOJ,GETDATE()) ) ASC
	
--50) Which Language is known by only one Programmer

	SELECT  PROF1, COUNT(PROF1) FROM
		(SELECT PROF1 FROM programmer
		UNION ALL
		SELECT PROF1 FROM programmer)
		AS subquery
		GROUP BY PROF1
		HAVING COUNT(PROF1) = 1
		
--51) Who is the Above Programmer Referred in 50? 

	NIL

--52) Who is the Youngest Programmer knowing DBASE? 

	SELECT TOP(1) PNAME, AGE FROM
		(SELECT *, DATEDIFF(YEAR,DOB,GETDATE()) AS AGE FROM programmer WHERE PROF1 = 'DBASE' or PROF2 = 'DBASE'
		 ) AS Subquery
		 ORDER BY AGE ASC
	
--53) Which Female Programmer earning more than 3000 does not know C, C++, 
--    ORACLE or DBASE?

	SELECT * FROM PROGRAMMER WHERE PROF1 NOT IN ('c','c++','Oracle','DBase') AND PROF2 NOT IN ('c','c++','Oracle','DBase') AND GENDER = 'F' AND SALARY > 3000 

--54) Which Institute has most number of Students? 

	SELECT TOP 1 INSTITUTE , NUMBER FROM 
		( SELECT INSTITUTE , COUNT(*) as NUMBER FROM studies GROUP BY INSTITUTE)
		AS Subquery
		ORDER BY NUMBER DESC
	
--55) What is the Costliest course?

	SELECT TOP 1 COURSE, COURSE_FEE FROM studies 
	ORDER BY COURSE_FEE DESC

--56) Which course has been done by the most of the Students

	SELECT TOP 1 COURSE, COUNT(*) as COUNTC 
	FROM studies GROUP BY COURSE ORDER BY COUNTC DESC

--57) Which Institute conducts costliest course

	SELECT TOP 1 COURSE, COURSE_FEE FROM studies 
		ORDER BY COURSE_FEE DESC
	
--58) Display the name of the Institute and Course, which has below AVG course fee.

	SELECT INSTITUTE, COURSE_FEE FROM studies 
		WHERE COURSE_FEE < (SELECT AVG(COURSE_FEE) AS AVGF FROM studies)  
	
--59) Display the names of the courses whose fees are within 1000 (+ or -) of the 
--    Average Fee, 

	SELECT COURSE, COURSE_FEE FROM studies 
		WHERE COURSE_FEE BETWEEN (SELECT AVG(COURSE_FEE) AS AVGF FROM studies)-1000 
		AND (SELECT AVG(COURSE_FEE) AS AVGF FROM studies) + 1000
	
--60) Which package has the Highest Development cost?

	SELECT TOP (1) TITLE, DCOST FROM software ORDER BY DCOST DESC

--61) Which course has below AVG number of Students? 

	SELECT COURSE, COUNTS FROM
		(SELECT COURSE , COUNT(*)  AS COUNTS FROM studies GROUP BY COURSE) AS subquery
		WHERE COUNTS < 
		( SELECT CONVERT(FLOAT, AVG(CAST(COUNTS AS FLOAT))) FROM 
		  (SELECT COURSE , COUNT(*)  AS COUNTS FROM studies GROUP BY COURSE) AS subquery1
		)
	
--62) Which Package has the lowest selling cost

	SELECT TOP (1) TITLE, DCOST FROM software ORDER BY SCOST ASC

--63) Who Developed the Package that has sold the least number of copies?

	SELECT TOP (1) PNAME, TITLE, DCOST, SOLD FROM software ORDER BY SOLD ASC

--64) Which language has used to develop the package, which has the highest 
--    sales amount?

	SELECT TOP 1 *, SCOST*SOLD AS SALES FROM software order by SALES DESC

--65) How many copies of package that has the least difference between 
--    development and selling cost where sold.

	SELECT TOP 5 *, DCOST - SCOST AS DIFF FROM software order by DIFF ASC

--66) Which is the costliest package developed in PASCAL.

	SELECT TOP 1 TITLE, (DCOST) FROM software WHERE DEVELOPIN = 'PASCAL' ORDER BY DCOST DESC

--67) Which language was used to develop the most number of Packages. 

	SELECT TOP 1 DEVELOPIN, COUNT(*) AS COUNTD FROM software GROUP BY DEVELOPIN ORDER BY COUNTD DESC

--68) Which programmer has developed the highest number of Packages?

	SELECT TOP 1 PNAME, COUNT(*) AS COUNTD FROM software GROUP BY PNAME ORDER BY COUNTD DESC

--69) Who is the Author of the Costliest Package? 

	SELECT TOP 1 PNAME, TITLE, SCOST FROM software ORDER BY SCOST DESC

--70) Display the names of the packages, which have sold less than the AVG 
--    number of copies.

	SELECT TITLE , SOLD FROM software WHERE SOLD < (SELECT AVG(SOLD) FROM software)

--71) Who are the authors of the Packages, which have recovered more than double the 
--    Development cost? 

	SELECT PNAME, TITLE FROM software WHERE SOLD*SCOST > 2*DCOST

--72) Display the programmer Name and the cheapest packages developed by them in
--    each language.

	SELECT PNAME, MIN(DCOST) FROM software GROUP BY PNAME, DEVELOPIN

--73) Display the language used by each programmer to develop the Highest 
--    Selling and Lowest-selling package. 

	SELECT PNAME, DEVELOPIN, MIN(SCOST), MAX(SCOST) FROM software GROUP BY PNAME, DEVELOPIN

--74) Who is the youngest male Programmer born in 1965?

	SELECT TOP 1 PNAME, DOB FROM programmer WHERE YEAR(DOB) = 1965 ORDER BY DOB DESC

--75) Who is the oldest Female Programmer who joined in 1992?

	SELECT TOP 1 PNAME  FROM programmer WHERE YEAR(DOJ) = 1992 AND GENDER = 'F'
	ORDER BY DOB DESC

--76) In which year was the most number of Programmers born.

	SELECT TOP 1 YEAR(DOB) , COUNT( DOB) FROM programmer GROUP BY YEAR(DOB) ORDER BY COUNT( DOB) DESC

--77) In which month did most number of programmers join? 

	SELECT TOP 1 MONTH(DOJ) AS MOJ , COUNT( DOJ) as COUNTJ FROM programmer GROUP BY MONTH(DOJ) ORDER BY COUNT( DOJ) DESC

--78) In which language are most of the programmer’s proficient

	SELECT TOP 1 PROF1, COUNT(PROF1) FROM 
		(SELECT PROF1 FROM programmer
		UNION ALL
		SELECT PROF2 FROM programmer
		) AS Subquery
		GROUP BY PROF1
		ORDER BY COUNT( PROF1) DESC
	
--79) Who are the male programmers earning below the AVG salary of
--    Female Programmers? 

	SELECT PNAME, SALARY FROM programmer
		WHERE SALARY <
		(SELECT AVG(SALARY) FROM programmer WHERE GENDER  = 'F') AND GENDER = 'M'
	
--80) Who are the Female Programmers earning more than the Highest Paid? 

	SELECT PNAME, SALARY FROM programmer 
		WHERE SALARY >
		(SELECT MAX(SALARY) FROM programmer WHERE GENDER  = 'M'
		)

--81) Which language has been stated as the proficiency by most of the Programmers?

	SELECT TOP 1 PROF1, COUNT(PROF1) FROM 
		(SELECT PROF1 FROM programmer
		UNION ALL
		SELECT PROF2 FROM programmer
		) AS Subquery
		GROUP BY PROF1
		ORDER BY COUNT( PROF1) DESC
	
--82) Display the details of those who are drawing the same salary. 

	SELECT * FROM programmer ORDER BY SALARY

--83) Display the details of the Software Developed by the Male Programmers Earning 
--    More than 3000/-. 

	SELECT S.PNAME, TITLE , DEVELOPIN , SCOST , DCOST , SOLD 
		FROM software AS S
		JOIN
		programmer AS P
		ON S.PNAME = P.PNAME
		WHERE P.SALARY > 3000
		
--84) Display the details of the packages developed in Pascal by the Female 
--    Programmers. 

	SELECT S.PNAME, TITLE , DEVELOPIN , SCOST , DCOST , SOLD 
		FROM software AS S
		JOIN
		programmer AS P
		ON S.PNAME = P.PNAME
		WHERE GENDER = 'F' AND DEVELOPIN = 'PASCAL'
	
--85) Display the details of the Programmers who joined before 1990

	SELECT * FROM programmer WHERE YEAR(DOJ) < 1990

--86) Display the details of the Software Developed in C By female programmers of
--    Pragathi. 

	SELECT S.PNAME, TITLE , DEVELOPIN , SCOST , DCOST , SOLD 
		FROM software AS S
		JOIN
		programmer AS P
		ON S.PNAME = P.PNAME 
		JOIN
		studies AS ST
		ON  P.PNAME = ST.PNAME
		WHERE GENDER = 'F' AND INSTITUTE = 'Pragathi'
	
--87) Display the number of packages, No. of Copies Sold and sales value of
--   each programmer institute wise.

	SELECT COUNT(TITLE), SUM(SOLD) , SUM(SCOST) 
		FROM software AS S
		JOIN
		studies AS ST
		ON  S.PNAME = ST.PNAME
		GROUP BY INSTITUTE
	
--88) Display the details of the software developed in DBASE by Male Programmers, who 
--    belong to the institute in which most number of Programmers studied. 

	WITH TOP1 AS 
		(SELECT TOP 1 INSTITUTE FROM Studies GROUP BY INSTITUTE ORDER BY COUNT(*) DESC
		),
		SET1 AS 
		( SELECT PNAME FROM studies WHERE INSTITUTE = TOP1
		),
		SET2 AS 
		( SELECT PNAME FROM programmer WHERE GENDER = 'M' AND PNAME IN SET1 
		),
		SET3 AS 
		(SELECT PNAME FROM software WHERE DEVELOPIN = 'DBASE'
		)
		SELECT * FROM software WHERE PNAME IN SET3 AND PNAME IN SET2
	
--89) Display the details of the software Developed by the male programmers Born 
--    before 1965 and female programmers born after 1975. 

	SELECT Software.* FROM Software
		JOIN programmer ON Software.PName = programmer.PName WHERE Programmer.GENDER = 'M' AND YEAR(programmer.DOB)< 1965
		OR Programmer.GENDER = 'F' AND YEAR(programmer.DOB) > 1975
		
--90) Display the details of the software that has developed in the language which is
--    neither the first nor the second proficiency of the programmers

	SELECT Software.* FROM Software
		JOIN programmer ON Software.PName = programmer.PName 
		WHERE software.DEVELOPIN NOT IN 
		(SELECT programmer.PROF1 FROM Programmer) AND 
		software.DEVELOPIN NOT IN 
		(SELECT Programmer.PROF2 FROM Programmer)
	
--91) Display the details of the software developed by the male students of Sabhari. 

	SELECT S.PNAME, TITLE , DEVELOPIN , SCOST , DCOST , SOLD 
		FROM software AS S
		JOIN
		programmer AS P
		ON S.PNAME = P.PNAME 
		JOIN
		studies AS ST
		ON  P.PNAME = ST.PNAME
		WHERE GENDER = 'M' AND INSTITUTE = 'Sabhari'
	
--92) Display the names of the programmers who have not developed any packages.

	SELECT programmer.PNAME FROM software
		RIGHT JOIN programmer
		ON software.PNAME  = programmer.PNAME
		WHERE TITLE IS NULL
	
	--             OR 
	
	SELECT PNAME FROM programmer WHERE PNAME NOT IN (SELECT DISTINCT PNAME FROM software)

--93) What is the total cost of the Software developed by the programmers of Apple? 

	SELECT SUM(DCOST) FROM software
		JOIN studies
		ON software.PNAME  = studies.PNAME
		WHERE INSTITUTE = 'APPLE'
	
--94) Who are the programmers who joined on the same day?

	SELECT PNAME, DOJ FROM Programmer WHERE DOJ IN (SELECT DOJ FROM Programmer 
		GROUP BY DOJ HAVING COUNT(DOJ) > 1) ORDER BY DOJ
	
--95) Who are the programmers who have the same Prof2? 

	SELECT PNAME, PROF2 FROM Programmer WHERE PROF2 IN
		(SELECT PROF2 FROM programmer GROUP BY PROF2 HAVING COUNT(DOJ) > 1) ORDER BY PROF2
	
--96) Display the total sales value of the software, institute wise.

	SELECT INSTITUTE, SUM(SCOST*SOLD) FROM software
		JOIN studies
		ON software.PNAME  = studies.PNAME
		GROUP BY INSTITUTE
	
--97) In which institute does the person who developed the costliest package studied. 

	SELECT studies.PNAME , INSTITUTE FROM software
		JOIN studies
		ON software.PNAME  = studies.PNAME
		WHERE SCOST = (SELECT TOP 1 SCOST FROM software ORDER BY SCOST DESC) 
		
--98) Which language listed in prof1, prof2 has not been used to develop any package.

	SELECT DISTINCT PROF1 FROM 
		( SELECT PROF1 FROM programmer
		UNION ALL
		SELECT PROF2 FROM programmer
		) AS Subquery 
		WHERE PROF1 NOT IN (SELECT DEVELOPIN FROM software)
	
--99) How much does the person who developed the highest selling package earn and
	  what course did HE/SHE undergo

	SELECT studies.Pname , SALARY, COURSE  FROM programmer 
	  JOIN studies ON Programmer.PNAME = studies.PNAME
	  WHERE programmer.PNAME IN (SELECT PNAME FROM software where SOLD = (SELECT MAX(SOLD) FROM Software))

--100) What is the AVG salary for those whose software sales is more than 50,000/-.

	SELECT AVG(SALARY) FROM programmer
		 JOIN software
		 ON software.PNAME  = programmer.PNAME
		 WHERE SCOST*SOLD > 50000
	
	
--101) How many packages were developed by students, who studied in institute that 
--     charge the lowest course fee?

	SELECT COUNT(TITLE) FROM software
		JOIN studies
		ON software.PNAME  = studies.PNAME
		WHERE software.PNAME IN
		(SELECT PNAME FROM studies WHERE COURSE_FEE =
		  (SELECT TOP 1 COURSE_FEE FROM studies ORDER BY COURSE_FEE ASC)
		)
	
--102) How many packages were developed by the person who developed the 
--     cheapest package, where did HE/SHE study?

	SELECT COUNT(TITLE) FROM software
		JOIN studies
		ON software.PNAME  = studies.PNAME
		GROUP BY software.PNAME, INSTITUTE
		HAVING software.PNAME =
		(SELECT TOP 1 PNAME FROM software ORDER BY DCOST ASC)
	
--103)  How many packages were developed by the female programmers earning more 
--      than the highest paid male programmer?

	SELECT COUNT(TITLE) FROM software
		 JOIN programmer
		 ON software.PNAME = programmer.PNAME
		 WHERE GENDER = 'F' AND SALARY >
		 (SELECT TOP 1 SALARY FROM programmer WHERE GENDER = 'M'
		  ORDER BY SALARY DESC)
	
--104) How many packages are developed by the most experienced programmer form 
--     BDPS. 

	SELECT COUNT(TITLE) FROM software
		 JOIN programmer
		 ON software.PNAME = programmer.PNAME
		 WHERE software.PNAME = 
		  (SELECT TOP 1 PNAME
			FROM programmer ORDER BY DATEDIFF(YEAR,DOJ,GETDATE()) DESC 
		  )
	
--105) List the programmers (form the software table) and the institutes they studied

	SELECT DISTINCT software.PNAME, INSTITUTE FROM software
		JOIN studies
		ON software.PNAME  = studies.PNAME
	
--106) List each PROF with the number of Programmers having that PROF and the 
--     number of the packages in that PROF. 

	SELECT PROF1, COUNT(PNAME) AS COUNTP INTO PROF_TABLE 
		 FROM
		 ( SELECT PNAME,PROF1 FROM programmer
		 UNION ALL
		 SELECT PNAME,PROF2 FROM programmer
		 ) AS Subquery 
		 GROUP BY PROF1
	
		SELECT * FROM PROF_TABLE
	
		SELECT DEVELOPIN, COUNT(*) AS COUNTP INTO PACKAGE_TABLE
		FROM software
		GROUP BY DEVELOPIN
	
		SELECT * FROM PACKAGE_TABLE
	
		SELECT PROF_TABLE.PROF1, PROF_TABLE.COUNTP AS PROGRAMMERS, PACKAGE_TABLE.COUNTP AS PACKAGE
		FROM PROF_TABLE
		LEFT JOIN PACKAGE_TABLE
		ON PROF_TABLE.PROF1 = PACKAGE_TABLE.DEVELOPIN
	
		
--107) List the programmer names (from the programmer table) and No. Of Packages 
--     each has developed.

		SELECT programmer.PNAME, COUNT(TITLE) FROM software
		RIGHT JOIN programmer
		ON software.PNAME = programmer.PNAME
		GROUP BY programmer.PNAME
