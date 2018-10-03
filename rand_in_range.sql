CREATE FUNCTION rand_in_range(lower INTEGER, higher INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN floor(random()*(higher-lower+1) + lower);
END;
$$
  LANGUAGE plpgsql;