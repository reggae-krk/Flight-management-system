CREATE OR REPLACE FUNCTION generate_documents() RETURNS VOID AS $$
BEGIN
  INSERT INTO documents (passenger_id, document_number, type_id)
      (SELECT id, generate_document_number(), (SELECT document_type.type_id FROM document_type WHERE type_name = 'PASSPORT')
    FROM passengers);
END;
$$
  LANGUAGE plpgsql;

SELECT generate_documents();