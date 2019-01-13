CREATE or REPLACE FUNCTION add_countries() RETURNS VOID AS $$
BEGIN
  INSERT INTO countries (country_code, country_name, belongs_to_ue) VALUES ('POL', 'Poland', TRUE), ('ARG', 'Argentina', FALSE), ('AUS', 'Australia', FALSE),
                                                                           ('AUT', 'Austria', TRUE), ('BEL', 'Belgium', TRUE), ('BLR', 'Belarus', FALSE),
                                                                           ('BRA', 'Brazil', FALSE), ('HRV', 'Croatia', TRUE), ('CPR', 'Cyprus', TRUE),
                                                                           ('CZE', 'Czechia', TRUE), ('DNK', 'Denmark', TRUE),  ('FRA', 'France', TRUE),
                                                                           ('ESP', 'Spain', TRUE), ('NLD', 'Netherlands', TRUE), ('CAN', 'Canada', FALSE),
                                                                           ('QAT', 'Qatar', FALSE), ('NOR', 'Norway', FALSE), ('RUS', 'Russian Federation', FALSE),
                                                                           ('ITA', 'Italy', TRUE), ('GBR', 'United Kingdom', TRUE);
END;
$$
  LANGUAGE plpgsql;



















