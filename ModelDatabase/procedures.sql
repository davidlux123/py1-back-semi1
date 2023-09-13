USE Semi1;
-- Tabla de respuestas para los procedimientos
-- 0: No se pudo ejecutar el procedimiento
-- 1: Se ejecuto correctamente el procedimiento
-- 2: Falta de permisos para ejecutar el procedimiento

-- Procedure para insertar usuarios, verificando que no exista el correo
-- PROCEDURE IF EXISTS crearUsuario;
--DELIMITER $$
CREATE PROCEDURE crearUsuario(
    IN nombres TEXT,
    IN apellidos TEXT,
    IN foto TEXT,
    IN correo TEXT,
    IN password TEXT,
    IN fecha_nac TEXT
)
BEGIN
    IF NOT EXISTS (SELECT * FROM Usuario u WHERE u.correo = correo) THEN
        INSERT INTO Usuario (nombres, apellidos, foto, correo, password, fecha_nac) VALUES (nombres, apellidos, foto, correo, password, fecha_nac);
        SELECT 1 AS respuesta;
    ELSE
        SELECT 0 AS respuesta;
    END IF;
END--$$
--DELIMITER ;


-- Procedure para insertar artistas, verificando que no exista el nombre
DROP PROCEDURE IF EXISTS crearArtista;
DELIMITER $$
CREATE PROCEDURE crearArtista(
    IN nombre TEXT,
    IN foto TEXT,
    IN fecha_nac TEXT
)
BEGIN
    IF NOT EXISTS (SELECT * FROM Artista a WHERE a.nombre = nombre) THEN
        INSERT INTO Artista (nombre, foto, fecha_nac) VALUES (nombre, foto, fecha_nac);
        SELECT 1 AS respuesta;
    ELSE
        SELECT 0 AS respuesta;
    END IF;
END$$
DELIMITER ;

-- Procedure para insertar albumes, verificando que no exista el nombre
DROP PROCEDURE IF EXISTS crearAlbum;
DELIMITER $$
CREATE PROCEDURE crearAlbum(
    IN id_artista INT,
    IN nombre TEXT,
    IN descripcion TEXT,
    IN foto TEXT
)
BEGIN
    IF NOT EXISTS (SELECT * FROM Album a WHERE a.nombre = nombre) THEN
        INSERT INTO Album (id_artista, nombre, descripcion, foto) VALUES (id_artista, nombre, descripcion, foto);
        SELECT 1 AS respuesta;
    ELSE
        SELECT 0 AS respuesta;
    END IF;
END$$
DELIMITER ;


-- Procedure para insertar canciones, verificando que no exista el nombre y que el album exista
DROP PROCEDURE IF EXISTS crearCancion;
DELIMITER $$
CREATE PROCEDURE crearCancion(
    IN id_album INT,
    IN nombre TEXT,
    IN foto TEXT,
    IN duracion TEXT,
    IN artista INT
)
BEGIN
    IF EXISTS (SELECT * FROM Album a WHERE a.id_album = id_album) THEN
        IF NOT EXISTS (SELECT * FROM Cancion c WHERE c.nombre = nombre AND c.id_album = id_album) THEN
            INSERT INTO Cancion (id_album, nombre, foto, duracion, artista) VALUES (id_album, nombre, foto, duracion, artista);
            SELECT 1 AS respuesta;
        ELSE
            SELECT 0 AS respuesta;
        END IF;
    ELSE
        SELECT 2 AS respuesta;
    END IF;
END$$
DELIMITER ;


-- Procedure para insertar playlist, verificando que no exista el nombre y que el usuario exista
DROP PROCEDURE IF EXISTS crearPlaylist;
DELIMITER $$
CREATE PROCEDURE crearPlaylist(
    IN id_usuario INT,
    IN nombre TEXT,
    IN foto TEXT
)
BEGIN
    IF EXISTS (SELECT * FROM Usuario u WHERE u.id_usuario = id_usuario) THEN
        IF NOT EXISTS (SELECT * FROM Playlist p WHERE p.nombre = nombre AND p.id_usuario = id_usuario) THEN
            INSERT INTO Playlist (id_usuario, nombre, foto) VALUES (id_usuario, nombre, foto);
            SELECT 1 AS respuesta;
        ELSE
            SELECT 0 AS respuesta;
        END IF;
    ELSE
        SELECT 2 AS respuesta;
    END IF;
END$$
DELIMITER ;

-- Procedure para insertar canciones a playlist, verificando que el usuario, la cancion y la playlist existan
DROP PROCEDURE IF EXISTS agregarCancionPlaylist;
DELIMITER $$
CREATE PROCEDURE agregarCancionPlaylist(
    IN id_usuario INT,
    IN id_cancion INT,
    IN id_playlist INT
)
BEGIN
    IF EXISTS (SELECT * FROM Usuario u WHERE u.id_usuario = id_usuario) THEN
        IF EXISTS (SELECT * FROM Cancion c WHERE c.id_cancion = id_cancion) THEN
            IF EXISTS (SELECT * FROM Playlist p WHERE p.id_playlist = id_playlist) THEN
                INSERT INTO Playlist_Cancion (id_usuario, id_cancion, id_playlist) VALUES (id_usuario, id_cancion, id_playlist);
                SELECT 1 AS respuesta;
            ELSE
                SELECT 0 AS respuesta;
            END IF;
        ELSE
            SELECT 0 AS respuesta;
        END IF;
    ELSE
        SELECT 0 AS respuesta;
    END IF;
END$$

