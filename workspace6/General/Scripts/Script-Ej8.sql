CREATE DATABASE ej8Cooperativa

CREATE TABLE Cooperativas(
Nombre VARCHAR(256) PRIMARY KEY not null, 
Fecha_creacion DATE,
Localidad VARCHAR(256),
n_viviendas INT
);

CREATE TABLE Cooperativistas(
Nombre_y_apellidos VARCHAR(256),
NIF CHAR (9) PRIMARY KEY not null, 
Direccion VARCHAR(256),
Tel INT(9)
);


CREATE TABLE Banco(
Codigo INT(9) PRIMARY KEY not null, 
Nombre VARCHAR(256),
Nacionalidad VARCHAR(256)
);

CREATE TABLE Credito(
Numero_sec INT(9) Auto_increment not null PRIMARY KEY, 
Cantidad  INT,
Intereses INT,
Duracion VARCHAR(256),
Forma_pago VARCHAR(256)
);

CREATE TABLE Vivienda(
Id_vivienda INT(9) Auto_increment not null,
Tipo ENUM('piso','chalet','adosado'),
Localidad VARCHAR(256),
Direccion VARCHAR(256),
PRIMARY KEY (Id_vivienda)
);

CREATE TABLE Extras(
Codigo  INT(9) PRIMARY KEY not null,
Descripcion VARCHAR(256)
);

CREATE TABLE Altas(
	Id_socio INT(9) Auto_increment not null,
	NIF CHAR(9) REFERENCES Cooperativistas,
	Nombre_cooperativa VARCHAR(256) REFERENCES Cooperativas(Nombre),
	Fecha DATE,
	PRIMARY KEY (Id_socio,NIF,Nombre_cooperativa)
);

CREATE TABLE Solicitudes(
	Id_socio INT(9) REFERENCES Altas(Id_socio),
	Id_vivienda INT (9) REFERENCES Vivienda(Id_vivienda),
	Concedida BOOL, 
	PRIMARY KEY (Id_socio,Id_vivienda)
);

CREATE TABLE Extras_viviendas(
	Precios DECIMAL(6,2) not null,
	Id_vivienda INT(9) REFERENCES Vivienda(Id_vivienda),
	Id_producto INT(9) REFERENCES Extras(Codigo),
	PRIMARY KEY (Precios)
);

CREATE TABLE Credito_cooperativas(
	Id_banco INT(9) REFERENCES Banco(Codigo),
	Id_cooperativa VARCHAR(256) REFERENCES Cooperativas(Nombre),
	Num_sec INT(9) REFERENCES Credito(Numero_sec ),
	PRIMARY KEY (Id_banco,Id_cooperativa,Num_sec)
);

CREATE TABLE Credito_cooperativistas(
	Id_banco INT(9) REFERENCES Banco(Codigo),
	Id_cooperativista VARCHAR(256) REFERENCES Cooperativistas(NIF),
	Num_sec INT(9) REFERENCES Credito(Numero_sec ),
	PRIMARY KEY (Id_banco,Id_cooperativista,Num_sec)
);

ALTER TABLE Vivienda ADD Id_cooperativa VARCHAR(256) REFERENCES Cooperativas(Nombre);