CREATE OR REPLACE VIEW ticket AS
  SELECT seat_number,
         (first_name || ' ' || last_name) AS full_name,
         scheduled_departure_time::DATE AS start_date,
         flight_id AS flight_number,
         scheduled_departure_time::TIME - INTERVAL '40 minutes' AS departure_time
  FROM reservations
  INNER JOIN passengers
            ON passengers.id = reservations.passenger_id
  INNER JOIN flights
            ON reservations.flight_id = flights.id;
