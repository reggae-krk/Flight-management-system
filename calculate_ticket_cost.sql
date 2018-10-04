CREATE OR REPLACE FUNCTION calculate_ticket_cost(reservationID INTEGER)
  RETURNS DECIMAL AS $$
DECLARE
    flightID CHAR(6) := (SELECT flight_id FROM reservations
                WHERE id = reservationID);
    flight_cost DECIMAL;
    additional_services_cost DECIMAL;
BEGIN
  IF (SELECT is_child FROM reservations WHERE id = reservationID) THEN
    flight_cost := 0;
  ELSE
    flight_cost := (SELECT base_price FROM flights WHERE id = flightID);
  END IF;

  additional_services_cost := (SELECT SUM(cost) FROM additional_services WHERE reservation_id = reservationID);

  IF additional_services_cost IS NOT NULL THEN
    RETURN flight_cost + additional_services_cost;
  ELSE
    RETURN flight_cost;
  END IF;
END;
$$
LANGUAGE plpgsql;
