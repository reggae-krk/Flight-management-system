CREATE OR REPLACE FUNCTION check_if_airplane_max_distance_is_bigger_than_connection_distance()
  RETURNS trigger AS $$
  DECLARE
    modelID INTEGER;
    max_airplane_dis INTEGER;
  BEGIN
    modelID = (SELECT model_id FROM airplanes WHERE id = NEW.airplane_id);
    max_airplane_dis = (SELECT max_distance FROM models WHERE id = modelID);

    IF max_airplane_dis < NEW.distance THEN
      RAISE WARNING 'Distance between cities is bigger than max airplane distance';
      RETURN NULL;
    end if;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER  check_distance
  BEFORE INSERT ON flight_connections
  FOR EACH ROW
  EXECUTE PROCEDURE check_if_airplane_max_distance_is_bigger_than_connection_distance();