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
  BEFORE INSERT OR UPDATE ON flight_connections
  FOR EACH ROW
  EXECUTE PROCEDURE check_if_airplane_max_distance_is_bigger_than_connection_distance();

CREATE OR REPLACE FUNCTION check_if_base_price_is_bigger_than_0()
  RETURNS trigger AS $$
  BEGIN
    IF 0 >= NEW.base_price THEN
      RAISE WARNING 'Base price cannot be lower than 0!';
      RETURN NULL;
    end if;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_base_price
  BEFORE INSERT OR UPDATE ON flights
  FOR EACH ROW
  EXECUTE PROCEDURE check_if_base_price_is_bigger_than_0();

-- check trigger
-- INSERT INTO flights(SELECT generate_flight_id(), 22, to_timestamp('2018-10-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_timestamp('2018-10-01 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), null, null, 0::decimal);



