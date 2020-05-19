select * from reviews;


DROP TABLE IF EXISTS temp_tb;
CREATE TEMPORARY TABLE temp_tb SELECT * FROM reviews;
ALTER TABLE temp_tb DROP text, DROP title;
SELECT * FROM temp_tb;