CREATE TABLE clientes(
	NIF CHAR(9) PRIMARY KEY not null,
	Nombre VARCHAR(256),
	Direccion VARCHAR(256),
	Numero_cuenta INT(24) not null
);
ALTER TABLE clientes DROP Numero_cuenta;
ALTER TABLE clientes ADD Numero_cuenta CHAR(24) not null;
CREATE TABLE coches(
	Marca VARCHAR(256),
	Modelo VARCHAR(256),
	Color VARCHAR(256),
	Num_bastidor CHAR(17) PRIMARY KEY not null
);
ALTER TABLE coches ADD tipo ENUM('nuevo','usado');
CREATE TABLE coches_nuevos(
	Combustible ENUM('Gasolina','Gasoil','Electrico','Hibrido') not null,
	Num_bastidor CHAR(17) PRIMARY KEY not null,
	CONSTRAINT `nuevos_coches` FOREIGN KEY (Num_bastidor) REFERENCES coches(Num_bastidor)
);
CREATE TABLE coches_usados(
	Num_bastidor CHAR(17) PRIMARY KEY not null,
	Ano_fabricacion INT(4) not null,
	Num_propietarios_previos INT not null,
	Matricula CHAR(7),
	CONSTRAINT `usados_coches` FOREIGN KEY (Num_bastidor) REFERENCES coches(Num_bastidor)
);
CREATE TABLE mecanicos(
	NIF CHAR(9) PRIMARY KEY not null,
	Nombre VARCHAR(256),
	Especialidad VARCHAR(256),
	num_coches_usados INT
);
CREATE TABLE ventas(
	NIF CHAR(9) not null REFERENCES clientes(NIF),
	Num_bastidor CHAR(17) not null REFERENCES coches(Num_bastidor),
	Fecha DATE not null,
	Precio INT,
	PRIMARY KEY (NIF,Num_bastidor,Fecha)
);
CREATE TABLE arreglos(
	NIF_mecanico CHAR(9) REFERENCES mecanicos(NIF),
	Num_bastidor CHAR(17) REFERENCES coches_usados(Num_bastidor),
	PRIMARY KEY(NIF_mecanico,Num_bastidor)
);