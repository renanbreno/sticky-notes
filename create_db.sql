CREATE TABLE notes (
    id       TEXT    PRIMARY KEY,
    title     TEXT,
    author TEXT,
    text    TEXT,
    date    TEXT,
    color   TEXT
);

CREATE TABLE dev_academy (
    id    TEXT PRIMARY KEY,
    nome  TEXT,
    senha TEXT
);

CREATE TABLE settings (
    key    TEXT PRIMARY KEY,
    value  TEXT
);

INSERT INTO notes(id, title, author, text, date, color) VALUES ('1', 'Nota 1', 'Renan Breno', 'TEXTO 1', '03/03/2021', '#F3B0C3');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('2', 'Nota 2', 'Renan Breno', 'TEXTO 2', '03/03/2021', '#C6DBDA');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('3', 'Nota 3', 'Renan Breno', 'TEXTO 3', '03/03/2021', '#ABDEE6');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('4', 'Nota 4', 'Renan Breno', 'TEXTO 4', '03/03/2021', '#FFFFB5');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('5', 'Nota 1', 'Renan Breno', 'TEXTO 1', '03/03/2021', '#F3B0C3');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('6', 'Nota 2', 'Renan Breno', 'TEXTO 2', '03/03/2021', '#C6DBDA');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('7', 'Nota 3', 'Renan Breno', 'TEXTO 3', '03/03/2021', '#ABDEE6');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('8', 'Nota 4', 'Renan Breno', 'TEXTO 4', '03/03/2021', '#FFFFB5');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('9', 'Nota 1', 'Renan Breno', 'TEXTO 1', '03/03/2021', '#F3B0C3');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('10', 'Nota 2', 'Renan Breno', 'TEXTO 2', '03/03/2021', '#C6DBDA');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('11', 'Nota 3', 'Renan Breno', 'TEXTO 3', '03/03/2021', '#ABDEE6');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('12', 'Nota 4', 'Renan Breno', 'TEXTO 4', '03/03/2021', '#FFFFB5');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('13', 'Nota 1', 'Renan Breno', 'TEXTO 1', '03/03/2021', '#F3B0C3');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('14', 'Nota 2', 'Renan Breno', 'TEXTO 2', '03/03/2021', '#C6DBDA');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('15', 'Nota 3', 'Renan Breno', 'TEXTO 3', '03/03/2021', '#ABDEE6');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('16', 'Nota 4', 'Renan Breno', 'TEXTO 4', '03/03/2021', '#FFFFB5');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('17', 'Nota 1', 'Renan Breno', 'TEXTO 1', '03/03/2021', '#F3B0C3');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('18', 'Nota 2', 'Renan Breno', 'TEXTO 2', '03/03/2021', '#C6DBDA');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('19', 'Nota 3', 'Renan Breno', 'TEXTO 3', '03/03/2021', '#ABDEE6');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('20', 'Nota 4', 'Renan Breno', 'TEXTO 4', '03/03/2021', '#FFFFB5');
