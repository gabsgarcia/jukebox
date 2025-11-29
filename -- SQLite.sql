-- SQLite
-- List all artists (only names)
SELECT artists.name FROM artists;

-- Count the number of tracks that are shorter than 2 minutes
-- Nota: milliseconds precisa ser convertido para minutos (1 minuto = 60.000 ms)
SELECT COUNT(tracks.id) FROM tracks 
WHERE tracks.milliseconds < 120000;  -- 120.000 ms = 2 minutos

-- List the first ten albums of the Jukebox DB, sorted alphabetically
SELECT albums.title FROM albums
ORDER BY albums.title ASC  -- ASC é opcional (padrão), mas deixa claro
LIMIT 10;  -- LIMIT sempre vem depois do ORDER BY

-- List the track and album information for the tracks 
-- which names are containing a given keyword (case insensitive)
SELECT 
    tracks.name,
    albums.title
FROM tracks
JOIN albums ON tracks.album_id = albums.id  -- FK em tracks aponta para PK em albums
WHERE UPPER(tracks.name) LIKE UPPER("%music%");  -- UPPER nos dois lados para case insensitive

-- List the top 5 Rock artists 
-- with the most tracks
SELECT artists.name, 
        COUNT(*) AS track_count  -- COUNT(*) conta todas as linhas do grupo
FROM artists
-- Sequência de JOINs: artists → albums → tracks → genres
JOIN albums ON albums.artist_id = artists.id    -- FK album aponta para artist
JOIN tracks ON tracks.album_id = albums.id      -- FK track aponta para album
JOIN genres ON tracks.genre_id = genres.id      -- FK track aponta para genre
WHERE genres.name = "Rock"  -- Filtro ANTES do agrupamento
GROUP BY artists.name  -- Agrupa por artista para contar tracks
ORDER BY track_count DESC  -- Ordena do maior para o menor
LIMIT 5;  -- Pegando apenas os top 5 