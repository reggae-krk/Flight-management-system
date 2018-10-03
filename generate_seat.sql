CREATE OR REPLACE FUNCTION generate_seat(max INTEGER, reservation_id CHARACTER(6), OUT seat INTEGER)
  RETURNS INTEGER AS $$
BEGIN 
  WHILE seat IS NULL OR seat IN (SELECT seat_number FROM reservations WHERE trim(id) = trim(reservation_id))
  LOOP 
    seat := rand_in_range(1, max);
  END LOOP;
END;
$$
  LANGUAGE plpgsql;