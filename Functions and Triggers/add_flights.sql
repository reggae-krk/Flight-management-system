-- add flight with return flight for each airplane in the fleet
CREATE OR REPLACE FUNCTION add_flights(start_date TIMESTAMP)
  RETURNS VOID AS $$
DECLARE
  start_date_return TIMESTAMP := start_date + '5 hours';
  departure_date TIMESTAMP;
  departure_date_return TIMESTAMP;
BEGIN

  FOR i IN 0..30 LOOP
      departure_date := start_date + ((i || 'days')::INTERVAL);
      departure_date_return := start_date_return + ((i || 'days')::INTERVAL);
      RAISE INFO 'inserting for date: %', departure_date;

      INSERT INTO flights (id, flight_connection_id, scheduled_departure_time, scheduled_arrival_time, base_price)
          (SELECT generate_flight_id(),
                  id,
                  CASE
                    WHEN id%2 != 0 THEN departure_date
                    ELSE (departure_date + (((calculate_flight_duration(distance) + 120) || 'minutes')::INTERVAL))
                  END,
                  CASE
                    WHEN id%2 != 0 THEN (departure_date + ((calculate_flight_duration(distance) || 'minutes')::INTERVAL))
                    ELSE (departure_date + (((calculate_flight_duration(distance)*2 + 120) || 'minutes')::INTERVAL))
                  END,
                  calculate_flight_cost(distance, departure_date)
          FROM flight_connections);
  END LOOP;
END;
$$
  LANGUAGE plpgsql;

SELECT add_flights('2018-10-02 10:00:00'::TIMESTAMP);
