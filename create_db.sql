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
