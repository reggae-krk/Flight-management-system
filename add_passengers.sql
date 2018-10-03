CREATE OR REPLACE FUNCTION add_passengers(n INTEGER)
  RETURNS VOID AS $$
BEGIN
  FOR i IN 1..n LOOP
      INSERT INTO passengers (first_name, last_name) SELECT first_name, last_name FROM get_random_full_name();
  END LOOP;
END;
$$
  LANGUAGE plpgsql;