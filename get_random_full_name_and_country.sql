create function get_random_full_name_and_country()
  returns TABLE(first_name text, last_name text, country text)
as $$
DECLARE
  first_names TEXT[] := ARRAY['Adam','Agnieszka','Alan','Piotr','Eryk','Filip','Mateusz','Jakub',
                        'Tomasz','Bartosz','Eliza','Magda','Monika','Wojciech','Konrad','Krystyna',
                        'Urszula','Kunegunda','Beatrycze','Laura','Gerard','Bernard','Cedryk','Oskar',
                        'Barbara','Beata','Tamara','Grzegorz','Marta','Olga','Aleksander','Aleksandra',
                        'Wiktoria','Kinga','Konstanty','Pawel','Ryszard','Kamila','Anna','Iga',
                        'Lech','Jaroslaw','Honorata','Hortensja','Donald','Hyzio','Dyzio','Zyzio',
                        'Jolanta','Gabriel','Ignacy','Estera','Malgorzata','Michal','Leon','Rafal'];
  last_names TEXT[] := ARRAY['Adamek','Kot','Raczek','Frycz','Kogut','Bolek','Kaczor','Hubka',
                        'Donda','Dymala','Frajer','Nedzarz','Oset','Mlecz','Mucha','Gupik',
                        'Rurkiewicz','Durczok','Pastuszek','Trynkiewicz','Wujek','Kapusta','Filipek','Piskosz'];

  country TEXT[] := ARRAY['POL', 'ARG', 'AUS', 'AUT', 'BEL', 'BLR', 'BRA', 'HRV', 'CPR', 'CZE', 'DNK', 'FRA',
                          'ESP', 'NLD', 'CAN', 'QAT', 'NOR', 'RUS', 'ITA', 'GBR'];
BEGIN
  RETURN QUERY SELECT first_names[rand_in_range(1, array_length(first_names, 1))] AS first_name,
                      last_names[rand_in_range(1, array_length(last_names, 1))] AS last_name,
                      country[rand_in_range(1, array_length(country, 1))] AS country;
END;
$$
  LANGUAGE plpgsql;
