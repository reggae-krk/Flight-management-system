CREATE OR REPLACE FUNCTION check_free_space()
  RETURNS trigger AS $$
DECLARE
  taken_seats_number INTEGER := (SELECT DISTINCT count(seat_number) FROM reservations WHERE flight_id = new.flight_id);
  plane_capacity INTEGER := (SELECT max_seats FROM models
                             WHERE id = (SELECT model_id FROM airplanes
                                         WHERE id = (SELECT airplane_id FROM flight_connections
                                                     WHERE id = (SELECT flight_connection_id FROM flights
                                                                 WHERE id = new.flight_id))));
BEGIN
  CASE
      WHEN taken_seats_number >= plane_capacity
            THEN RAISE WARNING 'There is no place left on that flight!';
            RETURN NULL;
      WHEN new.seat_number IN (SELECT DISTINCT seat_number FROM reservations WHERE flight_id = new.flight_id)
            THEN RAISE WARNING 'The seat is taken!';
            RETURN NULL; --
      WHEN new.seat_number > plane_capacity OR new.seat_number < 1
            THEN RAISE WARNING 'There is no such seat in this plane!';
            RETURN NULL;
      ELSE
        RAISE INFO 'Inserted new reservation: passenger_id: %, flight_id: %, seat: : %, is_child: %', new.passenger_id, new.flight_id, new.seat_number, new.is_child;
        RETURN new;
    END CASE;
END;
$$
  LANGUAGE plpgsql;

CREATE TRIGGER check_free_space_trigger
  BEFORE INSERT
  ON reservations
  FOR EACH ROW
  EXECUTE PROCEDURE check_free_space();

