CREATE OR REPLACE FUNCTION get_random_name() RETURNS text AS $$
DECLARE
  first_names TEXT[] := ARRAY['Adam','Agnieszka','Alan','Piotr','Eryk','Filip','Mateusz','Jakub',
                        'Tomasz','Bartosz','Eliza','Magda','Monika','Wojciech','Konrad','Krystyna',
                        'Urszula','Kunegunda','Beatrycze','Laura','Gerard','Bernard','Cedryk','Oskar',
                        'Barbara','Beata','Tamara','Grzegorz','Marta','Olga','Aleksander','Aleksandra',
                        'Wiktoria','Kinga','Konstanty','Pawel','Ryszard','Kamila','Anna','Iga',
                        'Lech','Jaroslaw','Honorata','Hortensja','Donald','Hyzio','Dyzio','Zyzio',
                        'Jolanta','Gabriel','Ignacy','Estera','Malgorzata','Michal','Leon','Rafal'];
BEGIN
  RETURN first_names[rand_in_range(1, array_length(first_names, 1))];
END;
$$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_random_last_name() RETURNS text AS $$
DECLARE
  last_names TEXT[] := ARRAY['Adamek','Kot','Raczek','Frycz','Kogut','Bolek','Kaczor','Hubka',
                        'Donda','Dymala','Frajer','Nedzarz','Oset','Mlecz','Mucha','Gupik',
                        'Rurkiewicz','Durczok','Pastuszek','Trynkiewicz','Wujek','Kapusta','Filipek','Piskosz'];
BEGIN
  RETURN last_names[rand_in_range(1, array_length(last_names, 1))];
END;
$$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_random_full_name()
  RETURNS TABLE(first_name text, last_name text)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT get_random_name() AS first_name,
                      get_random_last_name() AS last_name;
END;
$$;
