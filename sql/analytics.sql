-- Keep empty sessions in the report and compare attendance within each venue.
WITH session_summary AS (
    SELECT s.session_id, v.name AS venue_name, w.title, s.capacity,
           COUNT(r.participant_id) AS registrations
    FROM sessions AS s
    JOIN venues AS v USING (venue_id)
    JOIN workshops AS w USING (workshop_id)
    LEFT JOIN registrations AS r USING (session_id)
    GROUP BY s.session_id, v.name, w.title, s.capacity
)
SELECT session_id, venue_name, title, capacity, registrations,
       ROUND(100.0 * registrations / capacity, 1) AS utilization_pct,
       CASE WHEN registrations = 0 THEN 'empty'
            WHEN registrations >= capacity THEN 'full'
            ELSE 'available' END AS occupancy,
       ROUND(AVG(registrations) OVER (PARTITION BY venue_name), 1) AS venue_avg_registrations
FROM session_summary
ORDER BY venue_name, session_id;

-- Preserve workshops that do not yet have scheduled sessions.
SELECT w.workshop_id, w.title, COUNT(s.session_id) AS scheduled_sessions
FROM workshops AS w
LEFT JOIN sessions AS s USING (workshop_id)
GROUP BY w.workshop_id, w.title
ORDER BY w.workshop_id;
