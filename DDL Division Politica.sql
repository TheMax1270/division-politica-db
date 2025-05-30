
DROP VIEW IF EXISTS vwCiudades CASCADE;

DROP TABLE IF EXISTS Ciudad CASCADE;
DROP TABLE IF EXISTS Region CASCADE;
DROP TABLE IF EXISTS Pais CASCADE;
DROP TABLE IF EXISTS Moneda CASCADE;
DROP TABLE IF EXISTS TipoRegion CASCADE;
DROP TABLE IF EXISTS Continente CASCADE;

-- CREAR TABLA CONTINENTE
CREATE TABLE Continente( 
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

-- CREAR TABLA TIPOREGION
CREATE TABLE TipoRegion( 
    Id SERIAL PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL
);

-- CREAR TABLA MONEDA
CREATE TABLE Moneda(
    Id SERIAL PRIMARY KEY,
    Moneda VARCHAR(100) NOT NULL,
    Sigla VARCHAR(5) NOT NULL,
    Imagen BYTEA NULL
);

-- CREAR TABLA PAIS
CREATE TABLE Pais( 
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL, 
    IdContinente INTEGER NOT NULL, 
    CONSTRAINT fkPais_IdContinente FOREIGN KEY (IdContinente)
        REFERENCES Continente(Id),
    IdTipoRegion INTEGER NOT NULL,
    CONSTRAINT fkPais_IdTipoRegion FOREIGN KEY (IdTipoRegion)
        REFERENCES TipoRegion(Id),
    IdMoneda INTEGER NOT NULL,
    CONSTRAINT fkPais_IdMoneda FOREIGN KEY (IdMoneda)
        REFERENCES Moneda(Id),
    Mapa BYTEA NULL,
    Bandera BYTEA NULL
);

-- CREAR TABLA REGION
CREATE TABLE Region( 
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL, 
    IdPais INTEGER NOT NULL, 
    CONSTRAINT fkRegion_IdPais FOREIGN KEY (IdPais)
        REFERENCES Pais(Id),
    Area FLOAT NULL, 
    Poblacion INTEGER NULL
);

-- CREAR TABLA CIUDAD
CREATE TABLE Ciudad( 
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL, 
    IdRegion INTEGER NOT NULL, 
    CONSTRAINT fkCiudad_IdRegion FOREIGN KEY (IdRegion)
        REFERENCES Region(Id),
    Area FLOAT NULL, 
    Poblacion INTEGER NULL,
    CapitalPais BOOLEAN DEFAULT false NOT NULL,
    CapitalRegion BOOLEAN DEFAULT false NOT NULL,
    AreaMetropolitana BOOLEAN DEFAULT false NOT NULL
);

-- CREAR VISTA VWCIUDADES
CREATE VIEW vwCiudades AS
    SELECT C.Id AS IdCiudad, C.Nombre AS Ciudad,
           R.Id AS IdRegion, R.Nombre AS Region,
           P.Id AS IdPais, P.Nombre AS Pais,
           C.CapitalPais, C.CapitalRegion
    FROM Pais P
    LEFT JOIN Region R ON R.IdPais = P.Id
    LEFT JOIN Ciudad C ON C.IdRegion = R.Id;

