CREATE OR REPLACE FUNCTION add_connections() RETURNS VOID AS $$
BEGIN
  INSERT INTO flight_connections (airplane_id, departure_airport, arrival_airport, distance)
  VALUES ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = '787-8') LIMIT 1), 'KRK', 'GIG', 11000),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = '787-8') LIMIT 1), 'GIG', 'KRK', 11000),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A380F') LIMIT 1), 'WAW', 'STN', 1500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A380F') LIMIT 1), 'STN', 'WAW', 1500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = '737-800') LIMIT 1), 'ORY', 'SVO', 2800),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = '737-800') LIMIT 1), 'SVO', 'ORY', 2800),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A320-200') LIMIT 1), 'MAD', 'SVO', 3500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A320-200') LIMIT 1), 'SVO', 'MAD', 3500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A321-200') LIMIT 1), 'INN', 'BCN', 3500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A321-200') LIMIT 1), 'BCN', 'INN', 3500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A340-600') LIMIT 1), 'VIE', 'MEL', 12900),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A340-600') LIMIT 1), 'MEL', 'VIE', 12900),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A380-800') LIMIT 1), 'AMS', 'MEL', 15500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'A380-800') LIMIT 1), 'MEL', 'AMS', 15500),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'ATR-72') LIMIT 1), 'WRO', 'KRK', 450),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'ATR-72') LIMIT 1), 'KRK', 'WRO', 450),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'CRJ-900') LIMIT 1), 'WRO', 'GDN', 700),
         ((SELECT id FROM airplanes WHERE model_id = (SELECT id FROM models WHERE model_name = 'CRJ-900') LIMIT 1), 'GDN', 'WRO', 700);
END;
$$
  LANGUAGE plpgsql;
