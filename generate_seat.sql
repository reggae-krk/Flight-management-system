CREATE OR REPLACE FUNCTION generate_seat(max INTEGER, given_flight_id CHARACTER(6), OUT seat INTEGER)
  RETURNS INTEGER AS $$
BEGIN 
  WHILE seat IS NULL OR seat IN (SELECT seat_number FROM reservations WHERE flight_id = given_flight_id)
  LOOP
    seat := (SELECT numbers FROM GENERATE_SERIES(1, max) AS numbers
        LEFT JOIN (SELECT seat_number FROM reservations WHERE flight_id = given_flight_id) AS taken_seats
        ON numbers = taken_seats.seat_number WHERE taken_seats.seat_number IS NULL
    LIMIT 1);
  END LOOP;
END;
$$
  LANGUAGE plpgsql;