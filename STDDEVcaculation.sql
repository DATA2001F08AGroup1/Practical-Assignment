CREATE TABLE IF NOT EXISTS stddev_avg AS
SELECT AVG(health_service_density) AS health_service_avg,STDDEV(health_service_density) AS health_service_stddev,
 AVG(hosipital_bed_density) AS hosipital_bed_avg,
 STDDEV(hosipital_bed_density) AS hosipital_bed_stddev, AVG(old_people_percentage) AS old_people_avg,
 STDDEV(old_people_percentage) AS old_people_stddev,
 AVG(population_density) AS population_avg, STDDEV(population_density) AS population_stddev,
 AVG(migrant_population_density) AS migrant_population_avg, STDDEV(migrant_population_density) AS migrant_population_stddev
FROM densities