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

CREATE OR REPLACE FUNCTION check_if_time_flight_is_correct_update()
  RETURNS trigger AS $$
  DECLARE
    minutes INTEGER;
    interval_time VARCHAR(10);
  BEGIN
    IF OLD.flight_connection_id != NEW.flight_connection_id THEN
      minutes = calculate_flight_duration((SELECT distance
                                           FROM flight_connections
                                           WHERE id = NEW.flight_connection_id));
    ELSE
      minutes = calculate_flight_duration((SELECT distance
                                           FROM flight_connections
                                           WHERE id = OLD.flight_connection_id));
    END IF;

    interval_time = minutes || ' min';

    IF (NEW.scheduled_departure_time + interval_time::interval) != NEW.scheduled_arrival_time THEN
      RAISE WARNING 'Flight time is wrong';
      RETURN NULL;
    end if;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_flight_time_update
  BEFORE UPDATE ON flights
  FOR EACH ROW
  EXECUTE PROCEDURE check_if_time_flight_is_correct_update();

CREATE OR REPLACE FUNCTION check_if_time_flight_is_correct_insert()
  RETURNS trigger AS $$
  DECLARE
    minutes INTEGER;
    interval_time VARCHAR(10);
  BEGIN
    minutes = calculate_flight_duration((SELECT distance
                                           FROM flight_connections
                                           WHERE id = NEW.flight_connection_id));
    interval_time = minutes || ' min';

    IF (NEW.scheduled_departure_time + interval_time::interval) != NEW.scheduled_arrival_time THEN
      RAISE WARNING 'Flight time is wrong';
      RETURN NULL;
    end if;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_flight_time_insert
  BEFORE INSERT ON flights
  FOR EACH ROW
  EXECUTE PROCEDURE check_if_time_flight_is_correct_insert();
