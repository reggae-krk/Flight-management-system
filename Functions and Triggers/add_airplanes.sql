-- inserts airplanes into airplanes table - n of each existing model
CREATE OR REPLACE FUNCTION add_airplanes(n INTEGER)
  RETURNS VOID AS $$
BEGIN
  FOR i IN 1..n LOOP
    INSERT INTO airplanes (model_id) SELECT id FROM models;
  END LOOP;
END;
$$
  LANGUAGE plpgsql;
