INSERT INTO document_type (type_name) VALUES ('PASSPORT'), ('ID_CARD');
INSERT INTO roles (role_name)
VALUES ('first pilot'), ('second pilot'), ('staff');
INSERT INTO services_cost (service_name, service_cost)
VALUES ('Luggage', 15), ('Seat selection', 5), ('Prioryty', 10);

INSERT INTO models (model_name, max_seats, monthly_conservation_cost, max_distance) VALUES ('A380', 853, 400000, 15700);

INSERT INTO airplanes (model_id) SELECT id FROM models WHERE model_name = 'A380';

INSERT INTO countries (country_code, country_name, belongs_to_ue) VALUES ('POL', 'Poland', TRUE);

INSERT INTO cities (city_code, city_name, country_code) VALUES ('KRK', 'Krakow', 'POL'), ('WAW', 'Warsaw', 'POL');

INSERT INTO airports (airport_code, airport_name, city_code)
VALUES ('KRK', 'Krakow Balice', 'KRK'), ('WAW', 'Lotnisko Chopina', 'WAW'), ('WMI', 'Warszawa Modlin', 'WAW');

INSERT INTO flight_connections (airplane_id, departure_airport, arrival_airport, distance)
VALUES (1, 'KRK', 'WAW', 300); -- add check constraint on plane id to check if max_distance from models > distance

INSERT INTO flights (id, flight_connection_id, scheduled_departure_time, scheduled_arrival_time, actual_departure_time, actual_arrival_time, base_price)
VALUES ('CA4200', 1, now(), now(), now(), now(), 350); -- check if scheduled arrival is > than scheduled_departure_time
-- check if base price > 0

INSERT INTO passengers (first_name, last_name)
VALUES ('Eliza', 'Golec'),
       ('Eryk', 'Dobkowski'),
       ('Monika', 'Gorecka'),
       ('Wojciech', 'Makiela'),
       ('Filip', 'Brzozowski');

INSERT INTO reservations (flight_id, passenger_id, seat_number, is_child) VALUES ('CA4200', 1, 300, TRUE ); -- add check constraint on is_child that checks if seat_number exists in reservations
-- check if documents table contains passport if destination country is not in EU

INSERT INTO additional_services (reservation_id, service_id, cost)
VALUES (1, 1, 15);

INSERT INTO documents (passenger_id, document_number, type_id)
VALUES (1, 'AXB99878', 2);

INSERT INTO employees (first_name, last_name, role_id, salary, airplane_id)
VALUES ('Konrad', 'Gadzina', 1, 1000, 1);