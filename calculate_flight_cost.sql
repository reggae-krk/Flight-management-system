CREATE OR REPLACE FUNCTION calculate_flight_cost (distance INTEGER, date TIMESTAMP)
  RETURNS INTEGER AS $$
DECLARE
  price DECIMAL;
  day_of_week VARCHAR(255) := trim(to_char(date, 'DAY'));
BEGIN
  price = distance * 0.33;
  RAISE INFO 'day of week: %', day_of_week;
  RAISE INFO 'boolean: %', day_of_week LIKE '%SATURDAY%';
  CASE
    WHEN day_of_week LIKE 'SATURDAY' OR day_of_week LIKE 'SUNDAY' THEN RETURN (price + 20);
    ELSE RETURN price;
  END CASE;
END;
$$
  LANGUAGE plpgsql;

SELECT calculate_flight_cost(300, '2018-09-29');