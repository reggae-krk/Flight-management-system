CREATE OR REPLACE FUNCTION id_exists(id_to_check CHARACTER(6))
  RETURNS BOOLEAN AS $$
BEGIN 
  RETURN id_to_check IN (SELECT id FROM flights);
END;
$$
  LANGUAGE plpgsql;
