-- 1
SELECT e.*
FROM Events e
JOIN Registrations r ON e.event_id=r.event_id
JOIN Users u ON u.user_id=r.user_id
WHERE e.status='upcoming'
AND e.city=u.city
ORDER BY e.start_date;

-- 2
SELECT e.title,AVG(f.rating) avg_rating
FROM Events e
JOIN Feedback f ON e.event_id=f.event_id
GROUP BY e.event_id
HAVING COUNT(*)>=10
ORDER BY avg_rating DESC;

-- 3
SELECT *
FROM Users
WHERE user_id NOT IN
(
SELECT user_id
FROM Registrations
WHERE registration_date>=CURDATE()-INTERVAL 90 DAY
);

-- 4
SELECT e.title,COUNT(*) session_count
FROM Events e
JOIN Sessions s ON e.event_id=s.event_id
WHERE HOUR(s.start_time) BETWEEN 10 AND 12
GROUP BY e.event_id;

-- 5
SELECT city,
COUNT(DISTINCT user_id) registrations
FROM Users
GROUP BY city
ORDER BY registrations DESC
LIMIT 5;

-- 6
SELECT event_id,
COUNT(*) resources
FROM Resources
GROUP BY event_id;

-- 7
SELECT u.full_name,
f.comments,
e.title
FROM Feedback f
JOIN Users u ON u.user_id=f.user_id
JOIN Events e ON e.event_id=f.event_id
WHERE rating<3;

-- 8
SELECT e.title,
COUNT(s.session_id)
FROM Events e
LEFT JOIN Sessions s
ON e.event_id=s.event_id
WHERE e.status='upcoming'
GROUP BY e.event_id;

-- 9
SELECT organizer_id,
status,
COUNT(*) total_events
FROM Events
GROUP BY organizer_id,status;

-- 10
SELECT e.title
FROM Events e
JOIN Registrations r
ON e.event_id=r.event_id
LEFT JOIN Feedback f
ON e.event_id=f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.event_id;

-- 11
SELECT registration_date,
COUNT(*) users
FROM Users
GROUP BY registration_date;

-- 12
SELECT e.title,
COUNT(*) total_sessions
FROM Events e
JOIN Sessions s
ON e.event_id=s.event_id
GROUP BY e.event_id
ORDER BY total_sessions DESC
LIMIT 1;

-- 13
SELECT e.city,
AVG(f.rating)
FROM Feedback f
JOIN Events e
ON e.event_id=f.event_id
GROUP BY e.city;

-- 14
SELECT e.title,
COUNT(*) registrations
FROM Registrations r
JOIN Events e
ON e.event_id=r.event_id
GROUP BY e.event_id
ORDER BY registrations DESC
LIMIT 3;

-- 15
SELECT s1.event_id
FROM Sessions s1
JOIN Sessions s2
ON s1.event_id=s2.event_id
AND s1.session_id<>s2.session_id
AND s1.start_time<s2.end_time
AND s1.end_time>s2.start_time;

-- 16
SELECT *
FROM Users
WHERE registration_date>=CURDATE()-INTERVAL 30 DAY
AND user_id NOT IN
(
SELECT user_id
FROM Registrations
);

-- 17
SELECT speaker_name,
COUNT(*)
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(*)>1;

-- 18
SELECT e.title
FROM Events e
LEFT JOIN Resources r
ON e.event_id=r.event_id
WHERE r.resource_id IS NULL;

-- 19
SELECT e.title,
COUNT(DISTINCT r.registration_id),
AVG(f.rating)
FROM Events e
LEFT JOIN Registrations r
ON e.event_id=r.event_id
LEFT JOIN Feedback f
ON e.event_id=f.event_id
WHERE e.status='completed'
GROUP BY e.event_id;

-- 20
SELECT u.full_name,
COUNT(DISTINCT r.event_id) attended,
COUNT(DISTINCT f.feedback_id) feedbacks
FROM Users u
LEFT JOIN Registrations r
ON u.user_id=r.user_id
LEFT JOIN Feedback f
ON u.user_id=f.user_id
GROUP BY u.user_id;

-- 21
SELECT u.full_name,
COUNT(*) total_feedbacks
FROM Feedback f
JOIN Users u
ON u.user_id=f.user_id
GROUP BY u.user_id
ORDER BY total_feedbacks DESC
LIMIT 5;

-- 22
SELECT user_id,event_id,
COUNT(*)
FROM Registrations
GROUP BY user_id,event_id
HAVING COUNT(*)>1;

-- 23
SELECT MONTH(registration_date),
COUNT(*)
FROM Registrations
GROUP BY MONTH(registration_date);

-- 24
SELECT e.title,
AVG(
TIMESTAMPDIFF
(MINUTE,start_time,end_time)
)
avg_duration
FROM Events e
JOIN Sessions s
ON e.event_id=s.event_id
GROUP BY e.event_id;

-- 25
SELECT e.title
FROM Events e
LEFT JOIN Sessions s
ON e.event_id=s.event_id
WHERE s.session_id IS NULL;