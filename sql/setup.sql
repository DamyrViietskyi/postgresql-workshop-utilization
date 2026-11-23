BEGIN;

CREATE TABLE participants (
    participant_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

CREATE TABLE workshops (
    workshop_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    level TEXT NOT NULL
    CHECK (level IN ('beginner', 'intermediate', 'advanced'))
);

CREATE TABLE instructors (
    instructor_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL
);

CREATE TABLE venues (
    venue_id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE sessions (
    session_id INTEGER PRIMARY KEY,
    workshop_id INTEGER NOT NULL,
    instructor_id INTEGER NOT NULL,
    venue_id INTEGER NOT NULL,
    starts_at TIMESTAMPTZ NOT NULL,
    capacity INTEGER NOT NULL,
    CHECK (capacity > 0),
    FOREIGN KEY (workshop_id) REFERENCES workshops(workshop_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id),
    FOREIGN KEY (venue_id) REFERENCES venues(venue_id)
);
CREATE TABLE registrations (
    session_id INTEGER NOT NULL,
    participant_id INTEGER NOT NULL,
    PRIMARY KEY (session_id, participant_id),
    FOREIGN KEY (session_id) REFERENCES sessions(session_id),
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id)
);
INSERT INTO participants VALUES
    (1, 'Demo participant 1', 'p1@example.invalid'),
    (2, 'Demo participant 2', 'p2@example.invalid'),
    (3, 'Demo participant 3', 'p3@example.invalid');
INSERT INTO workshops VALUES
    (1, 'SQL fundamentals', 'beginner'),
    (2, 'Data visualization', 'intermediate'),
    (3, 'Query planning', 'advanced');
INSERT INTO instructors VALUES (1, 'Demo instructor');
INSERT INTO venues VALUES (1, 'Room A'), (2, 'Room B');
INSERT INTO sessions VALUES
    (1, 1, 1, 1, '2026-09-02 10:00:00+00', 2),
    (2, 2, 1, 2, '2026-09-03 10:00:00+00', 8),
    (3, 1, 1, 1, '2026-09-04 10:00:00+00', 5);
INSERT INTO registrations VALUES (1, 1), (1, 2), (2, 3);

COMMIT;
