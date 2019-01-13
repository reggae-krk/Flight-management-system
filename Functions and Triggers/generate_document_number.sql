CREATE OR REPLACE FUNCTION generate_document_number()
  RETURNS VARCHAR(255) AS $$
DECLARE
  is_done BOOLEAN = FALSE;
  output VARCHAR(255);
BEGIN
  WHILE NOT is_done LOOP
    output = upper(chr(ascii('a') + rand_in_range(0, 25)));
    FOR i IN 1..7 LOOP
      output = output || rand_in_range(0,9);
    END LOOP;
    is_done = output NOT IN (SELECT document_number FROM documents);
  END LOOP;
  RAISE INFO 'Generated number: %', output;
  RETURN output;
END;
$$
  LANGUAGE plpgsql;
