CREATE OR REPLACE FUNCTION calculate_expenses_per_month(date DATE)
  RETURNS DECIMAL AS $$
DECLARE
  month INTEGER := DATE_PART('month', date);
  year INTEGER := DATE_PART('year', date);
  already_calculated_airplanes INTEGER[] := '{}';
  airplane INTEGER;
  flight RECORD;
  expenses DECIMAL := 0;
BEGIN
  expenses := expenses + (SELECT SUM(salary) FROM employees);
  FOR flight IN
    SELECT DISTINCT flight_connection_id AS id FROM flights
    WHERE DATE_PART('month', scheduled_departure_time) = month
    AND DATE_PART('year', scheduled_departure_time) = year
  LOOP
    airplane := (SELECT airplane_id FROM flight_connections WHERE flight.id = id);
    IF already_calculated_airplanes @> ARRAY[airplane] THEN
      CONTINUE;
    ELSE
      expenses := expenses + (SELECT monthly_conservation_cost FROM models
                           WHERE id = (SELECT model_id FROM airplanes
                                      WHERE airplanes.id = airplane));
      already_calculated_airplanes := ARRAY_APPEND(already_calculated_airplanes, airplane);
    END IF;
  END LOOP;
  RETURN expenses;
END;
$$
LANGUAGE plpgsql;