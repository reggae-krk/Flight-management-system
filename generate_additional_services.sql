CREATE OR REPLACE FUNCTION generate_additional_services (n INTEGER)
  RETURNS VOID AS $$
DECLARE
  random_reservation INTEGER;
  random_service INTEGER;
  current_service_cost DECIMAL;
BEGIN
  FOR i IN 1..n LOOP
    random_reservation = (SELECT id FROM reservations ORDER BY random() LIMIT 1);
    random_service = (SELECT id FROM services_cost ORDER BY random() LIMIT 1);
    current_service_cost = (SELECT service_cost FROM services_cost WHERE id = random_service);
    INSERT INTO additional_services (reservation_id, service_id, cost)
    VALUES (random_reservation, random_service, current_service_cost);
  END LOOP;
END;
$$
  LANGUAGE plpgsql;