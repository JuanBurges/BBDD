CREATE TABLE oficinas(
	Codigo INT Auto_increment not null,
	Direccion VARCHAR(256),
	Responsable VARCHAR(256),
	PRIMARY KEY (Codigo)
);

CREATE TABLE clientes(
	NIF CHAR(9) PRIMARY KEY not null,
	Direccion VARCHAR(256),
	Nombre VARCHAR(256),
	Telefono INT,
	Num_cuenta CHAR(24)
);

CREATE TABLE viajes(
	Codigo INT Auto_increment not null,
	Precio DECIMAL(6,2) not null,
	Regimen ENUM('Pension completa','Alojamiento','Desayuno y alojamiento'),
	Cod_oficina INT REFERENCES oficinas(Codigo),
	Cod_origen INT REFERENCES lugares(Codigo),
	Cod_destino INT REFERENCES lugares(Codigo),
	PRIMARY KEY (Codigo)
);

CREATE TABLE lugares(
	Codigo INT Auto_increment not null,
	Nombre VARCHAR(256),
	Pais VARCHAR(256) not null,
	PRIMARY KEY (Codigo)
);

CREATE TABLE reservas(
	NIF CHAR(9) REFERENCES clientes(NIF),
	Cod_oficina INT REFERENCES oficinas(Codigo),
	Cod_viaje INT REFERENCES viajes(Codigo),
	PRIMARY KEY (NIF,Cod_oficina,Cod_viaje)
);
CREATE TABLE viajes_oficinas(
	Cod_oficina INT REFERENCES oficinas(Codigo),
	Cod_viaje INT REFERENCES viajes(Codigo)
);
ALTER TABLE viajes DROP CONSTRAINT viajes_ibfk_1;