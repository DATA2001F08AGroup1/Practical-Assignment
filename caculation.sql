CREATE TABLE IF NOT EXISTS densities  AS
SELECT DISTINCT neighbourhoods.area_name, health_service_num/land_area as health_service_density,
COALESCE(num_bed/land_area,'0') AS hosipital_bed_density, old_people_percentage, CAST(population AS NUMERIC)/land_area AS population_density,
COALESCE(CAST(migrant_population AS NUMERIC)/land_area,'0') AS migrant_population_density
FROM neighbourhoods
LEFT JOIN (SELECT DISTINCT neighbourhoods.area_name, COUNT(neighbourhoods.area_name) AS health_service_num, SUM(num_beds) AS num_bed
FROM neighbourhoods
LEFT JOIN postcodes ON neighbourhoods.area_name ILIKE '%' || postcodes.locality || '%'
JOIN health_service ON health_service.postcode=postcodes.postcode
GROUP BY neighbourhoods.area_name) n ON n.area_name = neighbourhoods.area_name
LEFT JOIN (SELECT area_name, area_id,
		   CASE total_person 
		   WHEN 0 THEN 1 
		   ELSE CAST(("70-74" + "75-79" + "80-84" + "85_and_over")AS numeric)/CAST(total_person AS numeric) END AS old_people_percentage
		   FROM people) b ON neighbourhoods.area_id = b.area_id
LEFT JOIN (SELECT destination, SUM(people) AS migrant_population
		  FROM travel
		  GROUP BY destination) t ON t.destination = neighbourhoods.area_id
ORDER BY neighbourhoods.area_name