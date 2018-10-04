CREATE OR REPLACE FUNCTION generate_reservations(n INTEGER)
  RETURNS VOID AS $$
BEGIN
  WHILE (SELECT count(*) FROM reservations) < n LOOP
    INSERT INTO reservations (flight_id, passenger_id, seat_number, is_child)
        SELECT f.id AS flight_id, p.id AS passenger_id, generate_seat(m.max_seats, f.id) AS assigned_seat, FALSE AS is_child
          FROM flights f
          CROSS JOIN (SELECT * FROM passengers LIMIT 10000) AS p
          LEFT JOIN models m ON m.id = (SELECT model_id FROM airplanes a
                                        WHERE a.id = (SELECT airplane_id FROM flight_connections
                                                     WHERE id = f.flight_connection_id))
          ORDER BY random()
          LIMIT 1;
  END LOOP;
END;
$$
  LANGUAGE plpgsql;
