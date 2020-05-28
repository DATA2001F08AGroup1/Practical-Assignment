CREATE TABLE IF NOT EXISTS vulnerability_score AS
SELECT area_name, (health_service_density-health_service_avg)/health_service_stddev AS health_service_density_zscore,
(hosipital_bed_density-hosipital_bed_avg)/hosipital_bed_stddev AS hosipital_bed_density_zscore,
(old_people_percentage-old_people_avg)/old_people_stddev AS old_people_percentage_zscore,
(population_density-population_avg)/population_stddev AS population_density_zscore,
(migrant_population_density-migrant_population_avg)/migrant_population_stddev AS migrant_population_density_zscore,
1/(1 + exp(1.0)^(((health_service_density-health_service_avg)/health_service_stddev)+((old_people_percentage-old_people_avg)/old_people_stddev)-
((health_service_density-health_service_avg)/health_service_stddev)-((hosipital_bed_density-hosipital_bed_avg)/hosipital_bed_stddev)+
(migrant_population_density-migrant_population_avg)/migrant_population_stddev)) AS vulnerability_score
FROM densities,stddev_avg