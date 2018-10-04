CREATE OR REPLACE FUNCTION add_cities() RETURNS VOID AS $$
BEGIN
  INSERT INTO cities (city_code, city_name, country_code) VALUES ('KRK', 'Krakow', 'POL'), ('WAW', 'Warsaw', 'POL'), ('KTW', 'Katowice', 'POL'),
                                                               ('WRO', 'Wroclaw', 'POL'), ('POZ', 'Poznan', 'POL'), ('GDN', 'Gdansk', 'POL'),
                                                               ('BUA', 'Buenos Aires', 'ARG'), ('SYD', 'Sydney', 'AUS'), ('MEL', 'Melbourne', 'AUS'),
                                                               ('VIE', 'Vienna', 'AUT'), ('INN', 'Innsbruck', 'AUT'), ('BRU', 'Brussels', 'BEL'),
                                                               ('MSQ', 'Minsk', 'BLR'), ('RDJ', 'Rio de Janeiro', 'BRA'), ('ZAG', 'Zagreb', 'HRV'),
                                                               ('LCA', 'Larnaca', 'CPR'), ('PRG', 'Prague', 'CZE'), ('CPH', 'Copenhagen', 'DNK'),
                                                               ('PAR', 'Paris', 'FRA'), ('MAD', 'Madrid', 'ESP'), ('BCN', 'Barcelona', 'ESP'),
                                                               ('AMS', 'Amsterdam', 'NLD'), ('CAL', 'Calgary', 'CAN'), ('DOH', 'Doha', 'QAT'),
                                                               ('OSL', 'Oslo', 'QAT'), ('MOW', 'Moscow', 'RUS'), ('ROM', 'Rome', 'ITA'), ('LON', 'London', 'GBR');
END;
$$
  LANGUAGE plpgsql;




