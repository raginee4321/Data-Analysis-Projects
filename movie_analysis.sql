mysql> use movie_analysis
Database changed
mysql> SELECT Title,
    -> Vote_Count,
    -> Vote_Average
    -> FROM mymoviedb
    -> WHERE Vote_Count>1000
    -> ORDER BY Vote_Average DESC;
+-------------------------+------------+--------------+
| Title                   | Vote_Count | Vote_Average |
+-------------------------+------------+--------------+
| Spider-Man: No Way Home |       8940 |          8.3 |
| The Batman              |       1151 |          8.1 |
| Encanto                 |       5076 |          7.7 |
| Eternals                |       4726 |          7.2 |
| The King's Man          |       1793 |            7 |
| Red Notice              |       3193 |          6.8 |
+-------------------------+------------+--------------+
6 rows in set (0.00 sec)

mysql> SELECT Title,
    -> Popularity,
    -> Vote_Average
    -> FROM mymoviedb
    -> ORDER BY Popularity DESC;
+-----------------------------------------+------------+--------------+
| Title                                   | Popularity | Vote_Average |
+-----------------------------------------+------------+--------------+
| Spider-Man: No Way Home                 |   5083.954 |          8.3 |
| The Batman                              |   3827.658 |          8.1 |
| No Exit                                 |   2618.087 |          6.3 |
| Encanto                                 |   2402.201 |          7.7 |
| The King's Man                          |   1895.511 |            7 |
| The Commando                            |   1750.484 |          6.6 |
| Scream                                  |   1675.161 |          6.8 |
| Kimi                                    |   1601.782 |          6.3 |
| Fistful of Vengeance                    |   1594.013 |          5.3 |
| Eternals                                |   1537.406 |          7.2 |
| Pursuit                                 |   1500.523 |          5.9 |
| My Hero Academia: World Heroes' Mission |   1485.064 |          7.3 |
| Restless                                |   1468.377 |          5.9 |
| Nightmare Alley                         |   1455.144 |          7.1 |
| The Ice Age Adventures of Buck Wild     |   1431.307 |          7.1 |
| Texas Chainsaw Massacre                 |    1312.79 |          5.1 |
| The Requin                              |   1252.317 |          4.6 |
| Looop Lapeta                            |   1240.946 |            6 |
| Red Notice                              |   1178.544 |          6.8 |
+-----------------------------------------+------------+--------------+
19 rows in set (0.00 sec)

mysql> SELECT Genre
    -> COUNT(*) AS Total_Movies
    -> FROM mymoviedb
    -> GROUP BY Genre
    -> ORDER BY Total_Movies DESC;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'COUNT(*) AS Total_Movies
FROM mymoviedb
GROUP BY Genre
ORDER BY Total_Movies DES' at line 2
mysql> SELECT Genre
    -> COUNT(*) AS Total_Movies
    -> FROM mymoviedb
    -> GROUP BY Genre
    -> ORDER BY Total_Movies DESC;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'COUNT(*) AS Total_Movies
FROM mymoviedb
GROUP BY Genre
ORDER BY Total_Movies DES' at line 2
mysql> SELECT Genre,
    ->        COUNT(*) AS Total_Movies
    -> FROM mymoviedb
    -> GROUP BY Genre
    -> ORDER BY Total_Movies DESC;
+---------------------------------------+--------------+
| Genre                                 | Total_Movies |
+---------------------------------------+--------------+
| Thriller                              |            3 |
| Action, Crime, Thriller               |            2 |
| Action, Adventure, Science Fiction    |            1 |
| Crime, Mystery, Thriller              |            1 |
| Animation, Comedy, Family, Fantasy    |            1 |
| Action, Adventure, Thriller, War      |            1 |
| Horror, Mystery, Thriller             |            1 |
| Action, Crime, Fantasy                |            1 |
| Science Fiction                       |            1 |
| Animation, Action, Fantasy, Adventure |            1 |
| Action, Thriller, Crime               |            1 |
| Crime, Drama, Thriller                |            1 |
| Animation, Comedy, Adventure, Family  |            1 |
| Horror                                |            1 |
| Action, Comedy, Crime                 |            1 |
| Action, Comedy, Crime, Thriller       |            1 |
+---------------------------------------+--------------+
16 rows in set (0.00 sec)

mysql> SELECT Title,
    -> Vote_Average,
    -> Vote_Count
    -> FROM mymoviedb
    -> WHERE Vote_Count>500
    -> ORDER BY Vote_Average DESC
    -> LIMIT 20;
+-------------------------------------+--------------+------------+
| Title                               | Vote_Average | Vote_Count |
+-------------------------------------+--------------+------------+
| Spider-Man: No Way Home             |          8.3 |       8940 |
| The Batman                          |          8.1 |       1151 |
| Encanto                             |          7.7 |       5076 |
| Eternals                            |          7.2 |       4726 |
| Nightmare Alley                     |          7.1 |        952 |
| The Ice Age Adventures of Buck Wild |          7.1 |        737 |
| The King's Man                      |            7 |       1793 |
| Scream                              |          6.8 |        821 |
| Red Notice                          |          6.8 |       3193 |
| Texas Chainsaw Massacre             |          5.1 |        521 |
+-------------------------------------+--------------+------------+
10 rows in set (0.00 sec)

mysql> SELECT YEAR(Release_Date) AS Release_Year,
    -> COUNT(*) AS Movies_Release
    -> SUM(COUNT(*)) OVER (ORDER BY YEAR(Release_Date)
    -> ) AS Running_Total
    -> FROM mymoviedb
    -> GROUP BY Release_Year;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SUM(COUNT(*)) OVER (ORDER BY YEAR(Release_Date)
) AS Running_Total
FROM mymovied' at line 3
mysql> SELECT YEAR(Release_Date) AS Release_Year,
    ->        COUNT(*) AS Movies_Released,
    ->        SUM(COUNT(*)) OVER (ORDER BY YEAR(Release_Date)) AS Running_Total
    -> FROM mymoviedb
    -> GROUP BY YEAR(Release_Date);
+--------------+-----------------+---------------+
| Release_Year | Movies_Released | Running_Total |
+--------------+-----------------+---------------+
|         2021 |               7 |             7 |
|         2022 |              12 |            19 |
+--------------+-----------------+---------------+
2 rows in set (0.00 sec)

mysql> SELECT Title,
    -> Vote_Average,
    -> RANK() OVER(ORDER BY Vote_Average DESC) AS Movie_Rank
    -> FROM mymoviedb;
+-----------------------------------------+--------------+------------+
| Title                                   | Vote_Average | Movie_Rank |
+-----------------------------------------+--------------+------------+
| Spider-Man: No Way Home                 |          8.3 |          1 |
| The Batman                              |          8.1 |          2 |
| Encanto                                 |          7.7 |          3 |
| My Hero Academia: World Heroes' Mission |          7.3 |          4 |
| Eternals                                |          7.2 |          5 |
| Nightmare Alley                         |          7.1 |          6 |
| The Ice Age Adventures of Buck Wild     |          7.1 |          6 |
| The King's Man                          |            7 |          8 |
| Scream                                  |          6.8 |          9 |
| Red Notice                              |          6.8 |          9 |
| The Commando                            |          6.6 |         11 |
| No Exit                                 |          6.3 |         12 |
| Kimi                                    |          6.3 |         12 |
| Looop Lapeta                            |            6 |         14 |
| Pursuit                                 |          5.9 |         15 |
| Restless                                |          5.9 |         15 |
| Fistful of Vengeance                    |          5.3 |         17 |
| Texas Chainsaw Massacre                 |          5.1 |         18 |
| The Requin                              |          4.6 |         19 |
+-----------------------------------------+--------------+------------+
19 rows in set (0.04 sec)

mysql> SELECT Title,
    -> Vote_Average
    -> FROM mymoviedb
    -> ORDER BY Vote_Average DESC
    -> LIMIT 10;
+-----------------------------------------+--------------+
| Title                                   | Vote_Average |
+-----------------------------------------+--------------+
| Spider-Man: No Way Home                 |          8.3 |
| The Batman                              |          8.1 |
| Encanto                                 |          7.7 |
| My Hero Academia: World Heroes' Mission |          7.3 |
| Eternals                                |          7.2 |
| Nightmare Alley                         |          7.1 |
| The Ice Age Adventures of Buck Wild     |          7.1 |
| The King's Man                          |            7 |
| Scream                                  |          6.8 |
| Red Notice                              |          6.8 |
+-----------------------------------------+--------------+
10 rows in set (0.00 sec)

mysql> SELECT Original_Language,
    -> Popularity
    -> FROM mymoviedb
    -> GROUP BY Original_Language
    -> ORDER BY Total_Movies DESC;
ERROR 1054 (42S22): Unknown column 'Total_Movies' in 'order clause'
mysql> SELECT Original_Language,
    ->        COUNT(*) AS Total_Movies
    -> FROM mymoviedb
    -> GROUP BY Original_Language
    -> ORDER BY Total_Movies DESC;
+-------------------+--------------+
| Original_Language | Total_Movies |
+-------------------+--------------+
| en                |           16 |
| ja                |            1 |
| fr                |            1 |
| hi                |            1 |
+-------------------+--------------+
4 rows in set (0.00 sec)

mysql> SELECT Title,
    -> POpularity
    -> FROM mymoviedb
    -> ORDER BY Popularity DESC
    -> LIMIT 10;
+-------------------------+------------+
| Title                   | POpularity |
+-------------------------+------------+
| Spider-Man: No Way Home |   5083.954 |
| The Batman              |   3827.658 |
| No Exit                 |   2618.087 |
| Encanto                 |   2402.201 |
| The King's Man          |   1895.511 |
| The Commando            |   1750.484 |
| Scream                  |   1675.161 |
| Kimi                    |   1601.782 |
| Fistful of Vengeance    |   1594.013 |
| Eternals                |   1537.406 |
+-------------------------+------------+
10 rows in set (0.00 sec)

mysql> SELECT Original_Language
    -> ROUND(AVG(Vote_Average),2) AS Avg_Rating
    -> FROM mymoviedb
    -> GROUP BY Original_Language
    -> ORDER BY Avg_Rating DESC;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(AVG(Vote_Average),2) AS Avg_Rating
FROM mymoviedb
GROUP BY Original_Language
OR' at line 2
mysql> SELECT Original_Language
    -> ROUND(AVG(Vote_Average), 2) AS Avg_Rating
    -> FROM mymoviedb
    -> GROUP BY Original_Language
    -> ORDER BY Avg_Rating DESC;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(AVG(Vote_Average), 2) AS Avg_Rating
FROM mymoviedb
GROUP BY Original_Language
O' at line 2
mysql> SELECT Original_Language,
    ->        ROUND(AVG(Vote_Average), 2) AS Avg_Rating
    -> FROM mymoviedb
    -> GROUP BY Original_Language
    -> ORDER BY Avg_Rating DESC;
+-------------------+------------+
| Original_Language | Avg_Rating |
+-------------------+------------+
| ja                |        7.3 |
| en                |       6.64 |
| hi                |          6 |
| fr                |        5.9 |
+-------------------+------------+
4 rows in set (0.00 sec)

mysql> SELECT  Year(Released_Date) AS Release_Year,
    -> COUNT(*) AS Total_Movies
    -> FROM mymoviedb
    -> GROUP BY Release_Year
    -> ORDER BY Release_Year
    -> ;
ERROR 1054 (42S22): Unknown column 'Released_Date' in 'field list'
mysql> SELECT  Year(Release_Date) AS Release_Year,
    -> COUNT(*) AS Total_Movies
    -> FROM mymoviedb
    -> GROUP BY Release_Year
    -> ORDER BY Release_Year
    -> ;
+--------------+--------------+
| Release_Year | Total_Movies |
+--------------+--------------+
|         2021 |            7 |
|         2022 |           12 |
+--------------+--------------+
2 rows in set (0.00 sec)

mysql> SELECT YEAR(Release_Date) AS Release_Year,
    -> ROUND(AVG(Vote_Average), 2) AS Avg_Rating
    -> FROM mymoviedb
    -> GROUP BY Release_Year
    -> ORDER BY Avg_Rating DESC;
+--------------+------------+
| Release_Year | Avg_Rating |
+--------------+------------+
|         2021 |       7.34 |
|         2022 |       6.17 |
+--------------+------------+
2 rows in set (0.00 sec)

mysql>