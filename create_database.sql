DROP DATABASE IF EXISTS flights_management_system;
CREATE DATABASE flights_management_system;

CREATE TABLE airplanes (
  id SERIAL PRIMARY KEY,
  model_id INTEGER NOT NULL REFERENCES models(id)
);

CREATE TABLE models (
  id SERIAL,
  model_name VARCHAR(255) NOT NULL,
  max_seats INTEGER NOT NULL,
  monthly_conservation_cost DECIMAL NOT NULL,
  max_distance INTEGER NOT NULL
);

CREATE TABLE flight_connections (
  id SERIAL,
  airplane_id INTEGER REFERENCES airplanes(id),
  departure_city CHAR(3) REFERENCES airports(aiport_code) ON DELETE CASCADE ON UPDATE CASCADE,
  arrival_city CHAR(3) REFERENCES airports(airport_code) ON DELETE CASCADE ON UPDATE CASCADE,
  distance INTEGER NOT NULL
);

CREATE TABLE flights (
  id CHAR(6) PRIMARY KEY,
  flight_connection_id INTEGER NOT NULL REFERENCES flight_connections(id) ON DELETE CASCADE  ON UPDATE CASCADE,
  scheduled_departure_time TIMESTAMP NOT NULL,
  scheduled_arrival_time TIMESTAMP NOT NULL,
  actual_departure_time TIMESTAMP NOT NULL,
  actual_arrival_time TIMESTAMP NOT NULL,
  base_price DECIMAL NOT NULL
);

CREATE TABLE employees (
  id SERIAL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  salary DECIMAL NOT NULL,
  airplane_id INTEGER REFERENCES airplanes(id)
);

CREATE TABLE IF NOT EXISTS countries (
  country_code CHAR(3) PRIMARY KEY,
  country_name VARCHAR(255) NOT NULL,
  belongs_to_UE BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS cities (
  city_code CHAR(3) PRIMARY KEY,
  city_name VARCHAR(255) NOT NULL,
  country_code CHAR(3) NOT NULL,
  FOREIGN KEY (country_code)
  REFERENCES countries(country_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS airports (
  airport_code      CHAR(3) PRIMARY KEY,
  airport_name    VARCHAR(255)       NOT NULL,
  city_code CHAR(3)       NOT NULL,
  FOREIGN KEY (city_code)
  REFERENCES cities(city_code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS document_type (
  type_id SERIAL PRIMARY KEY,
  type_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS documents (
  passenger_id INTEGER NOT NULL,
  document_number VARCHAR(255) NOT NULL,
  type_id INTEGER NOT NULL,
  FOREIGN KEY (passenger_id)
  REFERENCES passengers(passenger_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (type_id)
  REFERENCES document_type(type_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS services_cost (
  id SERIAL PRIMARY KEY,
  service_name VARCHAR(255) NOT NULL,
  service_cost DECIMAL NOT NULL
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  flight_id CHAR(6) NOT NULL REFERENCES flights(id) ON DELETE CASCADE ON UPDATE CASCADE,
  passenger_id INTEGER NOT NULL REFERENCES passengers(id) ON DELETE CASCADE ON UPDATE CASCADE,
  seat_number INTEGER NOT NULL,
--   function set default for seat number
  is_child BOOLEAN
);

CREATE TABLE additional_services (
  reservations_id INTEGER NOT NULL REFERENCES reservations(id) ON DELETE CASCADE ON UPDATE CASCADE,
  service_id INTEGER NOT NULL REFERENCES services_cost(id),
  cost DECIMAL NOT NULL
);

CREATE TABLE passengers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

CREATE TABLE budget (
  date TIMESTAMP NOT NULL,
  income DECIMAL NOT NULL,
  outcome DECIMAL NOT NULL
);
