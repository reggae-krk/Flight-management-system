CREATE OR REPLACE FUNCTION calculate_income_per_month(date DATE)
  RETURNS DECIMAL AS $$
DECLARE
  month INTEGER := DATE_PART('month', date);
  year INTEGER := DATE_PART('year', date);
  flights_record RECORD;
  reservation RECORD;
  flight_ids CHAR(6)[] := '{}';
  income DECIMAL := 0;
BEGIN
  FOR flights_record IN
    SELECT id FROM flights
    WHERE DATE_PART('month', scheduled_departure_time) = month
    AND DATE_PART('year', scheduled_departure_time) = year
  LOOP
    flight_ids := ARRAY_APPEND(flight_ids, flights_record.id);
  END LOOP;

  FOR i IN 1..ARRAY_LENGTH(flight_ids, 1) LOOP
    FOR reservation IN
      SELECT id FROM reservations
      WHERE flight_id = flight_ids[i]
    LOOP
      income := income + calculate_ticket_cost(reservation.id);
    END LOOP;
  END LOOP;
  RETURN income;
END;
$$
LANGUAGE plpgsql;
