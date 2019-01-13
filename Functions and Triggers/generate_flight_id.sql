CREATE OR REPLACE FUNCTION generate_flight_id(OUT generated_id CHARACTER(6)) AS $$
BEGIN
  WHILE id_exists(generated_id) OR generated_id IS NULL LOOP
    generated_id := 'CA' || rand_in_range(1000, 9999);
  END LOOP;
END;
$$
  LANGUAGE plpgsql;
