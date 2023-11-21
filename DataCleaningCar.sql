SELECT * FROM `decoded-reducer-404020.cars.car_info` LIMIT 1000

--------------------------------------------------------------------------------------------------------------------------------
-- Inspect fuel_type only contains 'gas' and 'diesel'
SELECT
DISTINCT fuel_type
FROM
`decoded-reducer-404020.cars.car_info`

--------------------------------------------------------------------------------------------------------------------------------
-- Inspect length which should be continuous from 141.1 to 208.1
SELECT
MIN(length) AS min_length,
MAX(length) AS max_length
FROM
`decoded-reducer-404020.cars.car_info`
# Results confirm that 141.1 and 208.1 are the minimum and maximum values respectively in this column. 

--------------------------------------------------------------------------------------------------------------------------------
-- Inspect if the num_of_doors column contains null values
SELECT *
FROM `decoded-reducer-404020.cars.car_info`
WHERE num_of_doors IS NULL
-- There are two rows where num_of_doors is null.I decide to input the null values as 4
UPDATE `decoded-reducer-404020.cars.car_info`
SET num_of_doors = 'four'
WHERE make='dodge' AND fuel_type='gas' AND body_style='sedan'

--------------------------------------------------------------------------------------------------------------------------------
-- Inspect num_of_cylinders
SELECT DISTINCT num_of_cylinders
FROM `decoded-reducer-404020.cars.car_info`
-- Correct the misspelling
UPDATE `decoded-reducer-404020.cars.car_info`
SET num_of_cylinders = 'two'
WHERE num_of_cylinders= 'tow'

--------------------------------------------------------------------------------------------------------------------------------
-- Inspect compression_ratio
SELECT
MIN(compression_ratio) AS min_compression_ratio,
MAX(compression_ratio) AS max_compression_ratio
FROM `decoded-reducer-404020.cars.car_info`
WHERE compression_ratio <> 70
-- There is a 70 that should be 7, now I want to remove this row. But first, I want to count how many rows were wrongly recorded.
SELECT COUNT(*) AS num_of_rows_to_delete
FROM `decoded-reducer-404020.cars.car_info`
WHERE compression_ratio = 70
-- There is only one row. Now delete this row. 
DELETE `decoded-reducer-404020.cars.car_info`
WHERE compression_ratio = 70

--------------------------------------------------------------------------------------------------------------------------------
-- Inspect drive_wheels column
SELECT DISTINCT drive_wheels
FROM `decoded-reducer-404020.cars.car_info`
-- There might be a space after '4wd', inspect 
SELECT DISTINCT drive_wheels, LENGTH(drive_wheels) AS string_length
FROM `decoded-reducer-404020.cars.car_info`
-- Update database using TRIM
UPDATE `decoded-reducer-404020.cars.car_info`
SET drive_wheels = TRIM(drive_wheels)
WHERE TRUE