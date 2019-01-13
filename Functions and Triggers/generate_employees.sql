-- generates first pilot, second pilot and 3 staff members for each airplane in the fleet
CREATE OR REPLACE FUNCTION generate_employees() RETURNS VOID AS $$
DECLARE
BEGIN
    INSERT INTO employees (first_name, last_name, role_id, salary, airplane_id)
          (SELECT get_random_name(), get_random_last_name(), (SELECT id FROM roles WHERE role_name = 'first pilot'), 4000, id FROM airplanes);
  INSERT INTO employees (first_name, last_name, role_id, salary, airplane_id)
          (SELECT get_random_name(), get_random_last_name(), (SELECT id FROM roles WHERE role_name = 'second pilot'), 4000, id FROM airplanes);
  INSERT INTO employees (first_name, last_name, role_id, salary, airplane_id)
          (SELECT get_random_name(), get_random_last_name(), (SELECT id FROM roles WHERE role_name = 'staff'), 4000, id FROM airplanes);
  INSERT INTO employees (first_name, last_name, role_id, salary, airplane_id)
          (SELECT get_random_name(), get_random_last_name(), (SELECT id FROM roles WHERE role_name = 'staff'), 4000, id FROM airplanes);
  INSERT INTO employees (first_name, last_name, role_id, salary, airplane_id)
          (SELECT get_random_name(), get_random_last_name(), (SELECT id FROM roles WHERE role_name = 'staff'), 4000, id FROM airplanes);
END;
$$
  LANGUAGE plpgsql;
