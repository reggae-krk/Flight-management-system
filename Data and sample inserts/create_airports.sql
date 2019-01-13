CREATE OR REPLACE FUNCTION add_airports() RETURNS VOID AS $$
BEGIN
  INSERT INTO airports (airport_code, airport_name, city_code) VALUES ('KRK', 'Krakow Balice', 'KRK'), ('WAW', 'Lotnisko Chopina', 'WAW'),
                                                                      ('WMI', 'Warszawa Modlin', 'WAW'), ('KTW', 'Katowice-Pyrzowice', 'KTW'),
                                                                      ('WRO', 'Wroclaw-Starachowice', 'WRO'), ('POZ', 'Poznan-Lawica', 'POZ'),
                                                                      ('GDN', 'Gdansk-Rebiechowo', 'GDN'), ('EZE', 'Buenos Aires-Ezeiza', 'BUA'),
                                                                      ('SYD', 'Sydney Airport', 'SYD'), ('MEL', 'Melbourne Airport', 'MEL'),
                                                                      ('VIE', 'Vienna-Schwechat', 'VIE'), ('INN', 'Innsbruck-Kranebitten', 'INN'),
                                                                      ('CRL', 'Brussels-Charleroi', 'BRU'), ('MSQ', 'Minsk-2', 'MSQ'),
                                                                      ('GIG', 'Rio de Janeiro-Galeao', 'RDJ'), ('ZAG', 'Zagreb Airport', 'ZAG'),
                                                                      ('LCA', 'Larnaca Airport', 'LCA'), ('PRG', 'Vaclav Havel Airport Prague', 'PRG'),
                                                                      ('CPH', 'Copenhagen-Kastrup', 'CPH'), ('CDG', 'Roissy-Charles de Gaulle', 'PAR'),
                                                                      ('ORY', 'Orly', 'PAR'), ('MAD', 'Madrid-Barajas', 'MAD'),
                                                                      ('BCN', 'Barcelona–El Prat', 'BCN'), ('AMS', 'Amsterdam-Schiphol', 'AMS'),
                                                                      ('YYC', 'Calgary International Airport', 'CAL'), ('DOH', 'Hamad International Airport', 'DOH'),
                                                                      ('OSL', 'Oslo-Gardermoen', 'OSL'), ('DME', 'Moscow-Domodedovo', 'MOW'),
                                                                      ('SVO', 'Moscow-Sheremetyevo', 'MOW'), ('FCO', 'Leonardo da Vinci–Fiumicino Airport', 'ROM'),
                                                                      ('STN', 'London-Stansted', 'LON'), ('LHR', 'London-Heathrow', 'LON');
END;
$$
  LANGUAGE plpgsql;

