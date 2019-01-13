-- returns duration of the flight based on the distance and average speed of the plane + 30 minutes
-- average speed of the plane is fixed to 1000km/h
CREATE OR REPLACE FUNCTION calculate_flight_duration(distance INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (distance*60/1000 + 30);
END;
$$
  LANGUAGE plpgsql;
