CREATE OR REPLACE VIEW flights_list AS
  SELECT departure_city.city_name AS "DEP CITY",
                       fc.departure_airport AS "DEP AIRPORT",
                       arrival_city.city_name AS "ARR CITY",
                       fc.arrival_airport AS "ARR AIRPORT",
                       flights.scheduled_departure_time AS "DEP TIME",
                       flights.scheduled_arrival_time AS "ARR TIME",
                       flights.base_price AS "FLIGHT PRICE"

              FROM cities departure_city

              JOIN airports departure_airports ON departure_airports.city_code = departure_city.city_code
              JOIN flight_connections fc ON fc.departure_airport = departure_airports.airport_code
              JOIN airports arrival_airports ON arrival_airports.airport_code = fc.arrival_airport
              JOIN cities arrival_city ON arrival_city.city_code = arrival_airports.city_code
              JOIN flights ON flights.flight_connection_id = fc.id;
DROP VIEW flights_list;