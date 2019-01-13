CREATE OR REPLACE FUNCTION add_passengers(n INTEGER)
  RETURNS VOID AS $$
BEGIN
  FOR i IN 1..n LOOP
      INSERT INTO passengers (first_name, last_name, country) SELECT first_name, last_name, country FROM get_random_full_name_and_country();
 get_random_full_name();
  END LOOP;
END;
$$
  LANGUAGE plpgsql;
