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