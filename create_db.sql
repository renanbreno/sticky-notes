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

INSERT INTO notes(id, title, author, text, date, color) VALUES ('1', 'Nota 1', 'Renan Breno', 'TEXTO 1', '03/03/2021', '#DC143C');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('2', 'Nota 2', 'Renan Breno', 'TEXTO 2', '03/03/2021', '#DAA520');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('3', 'Nota 3', 'Renan Breno', 'TEXTO 3', '03/03/2021', '#98FB98');
INSERT INTO notes(id, title, author, text, date, color) VALUES ('4', 'Nota 4', 'Renan Breno', 'TEXTO 4', '03/03/2021', '#008080');
