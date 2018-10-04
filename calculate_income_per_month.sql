CREATE OR REPLACE FUNCTION calculate_income_per_month(date DATE)
  RETURNS DECIMAL AS $$
DECLARE
  flights_record RECORD;
  reservation RECORD;
  flightIDs CHAR(6)[] := '{}';
  income DECIMAL := 0;
BEGIN
  FOR flights_record IN
    SELECT id, scheduled_departure_time FROM flights
    WHERE scheduled_departure_time::DATE = date
  LOOP
    flightIDs := array_append(flightIDs, flights_record.id);
  END LOOP;

  FOR i IN 1..array_length(flightIDs, 1) LOOP
    FOR reservation IN
      SELECT id FROM reservations
      WHERE flight_id = flightIDs[i]
    LOOP
      income := income + calculate_ticket_cost(reservation.id);
    END LOOP ;
  END LOOP;

  RAISE NOTICE USING MESSAGE = flightIDs;
  RETURN income;
END;
$$
LANGUAGE plpgsql;

SELECT calculate_income_per_month('2018-10-03');