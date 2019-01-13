CREATE OR REPLACE FUNCTION find_flights_by_city(dep_city VARCHAR(255))
  RETURNS TABLE (
  "FROM" VARCHAR(255),
  "DEPARTURE AIRPORT" CHARACTER(3),
  "TO" VARCHAR(255),
  "ARRIVAL AIRPORT" CHARACTER(3),
  "DEPARTURE TIME" TIMESTAMP,
  "ARRIVAL TIME" TIMESTAMP,
  "PRICE" DECIMAL
  ) AS $$
BEGIN
  RETURN QUERY SELECT "DEP CITY", "DEP AIRPORT", "ARR CITY", "ARR AIRPORT", "DEP TIME", "ARR TIME", "FLIGHT PRICE"
               FROM flights_list
               WHERE lower("DEP CITY") = lower(dep_city);
END;
$$
  LANGUAGE plpgsql;

-- overloaded function to find flights both: by departure and arrival city
CREATE OR REPLACE FUNCTION find_flights_by_city(dep_city VARCHAR(255), arr_city VARCHAR(255))
  RETURNS TABLE (
  "FROM" VARCHAR(255),
  "DEPARTURE AIRPORT" CHARACTER(3),
  "TO" VARCHAR(255),
  "ARRIVAL AIRPORT" CHARACTER(3),
  "DEPARTURE TIME" TIMESTAMP,
  "ARRIVAL TIME" TIMESTAMP,
  "PRICE" DECIMAL
  ) AS $$
BEGIN
  RETURN QUERY SELECT "DEP CITY", "DEP AIRPORT", "ARR CITY", "ARR AIRPORT", "DEP TIME", "ARR TIME", "FLIGHT PRICE"
               FROM flights_list
               WHERE lower("DEP CITY") = lower(dep_city) AND
                     lower("ARR CITY") = lower(arr_city);
END;
$$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_flights_by_city(dep_city VARCHAR(255), date_from TIMESTAMP, date_to TIMESTAMP)
  RETURNS TABLE (
  "FROM" VARCHAR(255),
  "DEPARTURE AIRPORT" CHARACTER(3),
  "TO" VARCHAR(255),
  "ARRIVAL AIRPORT" CHARACTER(3),
  "DEPARTURE TIME" TIMESTAMP,
  "ARRIVAL TIME" TIMESTAMP,
  "PRICE" DECIMAL
  ) AS $$
BEGIN
  RETURN QUERY SELECT "DEP CITY", "DEP AIRPORT", "ARR CITY", "ARR AIRPORT", "DEP TIME", "ARR TIME", "FLIGHT PRICE"
               FROM flights_list
               WHERE lower("DEP CITY") = lower(dep_city) AND
                      "DEP TIME" >= date_from AND
                      "ARR TIME" <= date_to;
END;
$$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_flights_by_city(dep_city VARCHAR(255), arr_city VARCHAR(255), date_from TIMESTAMP, date_to TIMESTAMP)
  RETURNS TABLE (
  "FROM" VARCHAR(255),
  "DEPARTURE AIRPORT" CHARACTER(3),
  "TO" VARCHAR(255),
  "ARRIVAL AIRPORT" CHARACTER(3),
  "DEPARTURE TIME" TIMESTAMP,
  "ARRIVAL TIME" TIMESTAMP,
  "PRICE" DECIMAL
  ) AS $$
BEGIN
  RETURN QUERY SELECT "DEP CITY", "DEP AIRPORT", "ARR CITY", "ARR AIRPORT", "DEP TIME", "ARR TIME", "FLIGHT PRICE"
               FROM flights_list
               WHERE lower("DEP CITY") = lower(dep_city) AND
                     lower("ARR CITY") = lower(arr_city) AND
                      "DEP TIME" >= date_from AND
                      "ARR TIME" <= date_to;
END;
$$
  LANGUAGE plpgsql;
