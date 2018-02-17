DROP TABLE transactions CASCADE;
DROP TABLE tags CASCADE;


CREATE TABLE tags
(
  id SERIAL primary key,
  name VARCHAR(255)
);

CREATE TABLE transactions
(
  id SERIAL primary key,
  date_time TIMESTAMP(0) DEFAULT now(),
  vendor VARCHAR(255),
  amount INT,
  tag_id INT REFERENCES tags(id),
  details TEXT
);
