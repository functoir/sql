-- USE amittai;
CREATE TABLE IF NOT EXISTS donut_list 
(
  donut_name VARCHAR(10),
  donut_type VARCHAR(6),
  fun_fact VARCHAR(10)
);
INSERT INTO donut_list (donut_name, donut_type, fun_fact)
VALUES 
  ('KDF', 'hard', 'tough!'),
  ('Mandazi', 'soft', 'easy');