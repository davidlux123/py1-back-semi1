CREATE DATABASE IF NOT EXISTS SoundStream;
USE SoundStream;

CREATE TABLE IF NOT EXISTS Usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nombres TEXT NOT NULL,
  apellidos TEXT NOT NULL,
  foto TEXT NOT NULL,
  correo TEXT NOT NULL,
  pass TEXT NOT NULL,
  fecha_nac TEXT NULL,
  PRIMARY KEY (id_usuario)
);

CREATE TABLE IF NOT EXISTS Artista (
  id_artista INT NOT NULL AUTO_INCREMENT,
  nombre TEXT NOT NULL,
  foto TEXT NOT NULL,
  fecha_nac TEXT NOT NULL,
  PRIMARY KEY (id_artista)
);

CREATE TABLE IF NOT EXISTS Album (
  id_album INT NOT NULL AUTO_INCREMENT,
  id_artista INT NOT NULL,
  nombre TEXT NOT NULL,
  descripcion TEXT NULL,
  foto TEXT NOT NULL,
  PRIMARY KEY (id_album),
  FOREIGN KEY Album (id_artista) REFERENCES Artista (id_artista));

CREATE TABLE IF NOT EXISTS Cancion (
  id_cancion INT NOT NULL AUTO_INCREMENT,
  id_album INT NOT NULL,
  nombre TEXT NOT NULL,
  foto TEXT NOT NULL,
  duracion TEXT NOT NULL,
  artista INT NOT NULL,
  PRIMARY KEY (id_cancion, id_album),
  FOREIGN KEY Cancion (id_album) REFERENCES Album (id_album)
);

CREATE TABLE IF NOT EXISTS Playlist (
  nombre TEXT NOT NULL,
  descripcion TEXT NULL,
  foto TEXT NOT NULL,
  id_usuario INT NOT NULL,
  id_cancion INT NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
  FOREIGN KEY (id_cancion) REFERENCES Cancion (id_cancion)
);

CREATE TABLE IF NOT EXISTS Logs (
  id_usuario INT NOT NULL,
  id_cancion INT NOT NULL,
  type text,
  descripcion text, 
  FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
  FOREIGN KEY (id_cancion) REFERENCES Cancion (id_cancion)
);
