CREATE DATABASE test;

use test;


SELECT COUNT(DISTINCT country) AS num_countries
FROM player_mast
WHERE tournament = '2016-EURO';



SELECT COUNT(*) AS num_matches
FROM match_mast
WHERE match_result IS NOT NULL;


SELECT MIN(match_date) AS start_date
FROM match_mast
WHERE tournament = 'EURO' AND match_date >= '2016-01-01';


SELECT v.venue_name, c.city_name
FROM match_mast m
JOIN soccer_venue v ON m.venue_id = v.venue_id
JOIN soccer_city c ON v.city_id = c.city_id
WHERE m.play_stage = 'Final' AND m.tournament = 'EURO' AND m.match_year = 2016;


SELECT md.match_no, sc.country_name, COUNT(gd.goal_id) AS goal_score
FROM match_details md
JOIN goal_details gd ON md.match_no = gd.match_no AND md.match_stage = gd.match_stage
JOIN soccer_country sc ON md.team_id = sc.team_id
WHERE gd.goal_type = 'Normal' 
GROUP BY md.match_no, sc.country_name
ORDER BY md.match_no;


SELECT pm.player_name, sc.country_name, COUNT(gd.goal_id) AS num_goals
FROM goal_details gd
JOIN player_mast pm ON gd.player_id = pm.player_id
JOIN soccer_country sc ON pm.country_id = sc.country_id
WHERE gd.goal_type = 'Normal'
GROUP BY pm.player_name, sc.country_name
ORDER BY num_goals DESC;


SELECT pm.player_name, sc.country_name, COUNT(gd.goal_id) AS num_goals
FROM goal_details gd
JOIN player_mast pm ON gd.player_id = pm.player_id
JOIN soccer_country sc ON pm.country_id = sc.country_id
WHERE gd.tournament = 'EURO' AND gd.goal_type = 'Normal'
GROUP BY pm.player_name, sc.country_name
ORDER BY num_goals DESC
LIMIT 1;


SELECT md.match_no, sc.country_name
FROM match_details md
JOIN soccer_country sc ON md.team_id = sc.team_id
WHERE md.match_stage = 'Group' AND md.match_year = 2016
ORDER BY md.match_no
LIMIT 1;

SELECT match_no, play_stage, goal_score, audience
FROM match_mast
ORDER BY audience DESC
LIMIT 1;


SELECT gd.match_no, sc.country_name, pm.player_name, COUNT(gd.goal_id) AS num_goals
FROM goal_details gd
JOIN player_mast pm ON gd.player_id = pm.player_id
JOIN soccer_country sc ON pm.country_id = sc.country_id
GROUP BY gd.match_no, sc.country_name, pm.player_name
ORDER BY gd.match_no;
