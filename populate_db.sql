CREATE OR REPLACE FUNCTION populate_db()
  RETURNS VOID AS $$
BEGIN
  INSERT INTO document_type (type_name) VALUES ('PASSPORT'), ('ID_CARD');
  RAISE INFO 'INSERTED: document_types';
  INSERT INTO roles (role_name) VALUES ('first pilot'), ('second pilot'), ('staff');
  RAISE INFO 'INSERTED: role names';
  INSERT INTO services_cost (service_name, service_cost) VALUES ('Luggage', 15), ('Seat selection', 5), ('Priority', 10);
  RAISE INFO 'INSERTED: services cost';
  PERFORM add_countries();
  RAISE INFO 'INSERTED: countries';
  PERFORM add_cities();
  RAISE INFO 'INSERTED: cities';
  PERFORM add_airports();
  RAISE INFO 'INSERTED: airports';
  PERFORM add_modules();
  RAISE INFO 'INSERTED: models';
  PERFORM add_airplanes(10);
  RAISE INFO 'INSERTED: airplanes (10)';
  PERFORM add_passengers(40000);
  RAISE INFO 'INSERTED: passengers (40 000)';
  PERFORM generate_documents();
  RAISE INFO 'INSERTED: documents (40 000)';
  PERFORM add_connections();
  RAISE INFO 'INSERTED: connections';
  PERFORM add_flights('2018-10-01 10:00:00'::TIMESTAMP);
  RAISE INFO 'INSERTED: flights';
  PERFORM generate_reservations(5000);
  RAISE INFO 'INSERTED: reservations';
  PERFORM generate_additional_services(15000);
  RAISE INFO 'INSERTED: additional services';
  PERFORM generate_employees();
  RAISE INFO 'INSERTED: employees';
END;
$$
  LANGUAGE plpgsql;