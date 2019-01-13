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
  
CREATE OR REPLACE FUNCTION check_reserv_if_it_needs_passport()
  RETURNS trigger AS $$
  DECLARE
    is_passenger_from_ue BOOLEAN;
    list_documents integer[];
    list boolean[];
  BEGIN
    is_passenger_from_ue = (SELECT belongs_to_UE FROM countries
                WHERE country_code =
                      (SELECT country FROM passengers
                        WHERE id = NEW.passenger_id));

    list = (select array(SELECT country.belongs_to_ue
            FROM flights f
              inner join flight_connections fc on f.flight_connection_id = fc.id
              inner join airports a on fc.arrival_airport = a.airport_code or
                                       fc.departure_airport = a.airport_code
              inner join cities city on a.city_code = city.city_code
              inner join countries country on city.country_code = country.country_code
            where f.id = NEW.flight_id));

    list_documents = (SELECT array(SELECT type_id FROM documents WHERE passenger_id = NEW.passenger_id));

    IF (SELECT true = ALL(list)) THEN
      IF is_passenger_from_ue AND ((SELECT 1 = ANY(list_documents)) OR (SELECT 2 = ANY(list_documents))) THEN
        RETURN NEW;
      ELSEIF is_passenger_from_ue = FALSE AND (SELECT 1 = ANY(list_documents)) THEN
        RETURN NEW;
      ELSE
        RAISE WARNING 'Passenger needs passport';
        RETURN NULL;
      end if;
    ELSE
      IF (SELECT 1 = ANY(list)) THEN
        RETURN NEW;
      ELSE
        RAISE WARNING 'Passenger needs passport';
        RETURN NULL;
      end if;
    end if;

END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_documents
BEFORE INSERT ON reservations
FOR EACH ROW
EXECUTE PROCEDURE check_reserv_if_it_needs_passport();
