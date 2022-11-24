CREATE TABLE Director(
	NIF CHAR(9) not null,
	Fecha_inicio DATE,
	PRIMARY KEY (NIF)
);
CREATE TABLE Sucursales(
	Codigo INT(9) Auto_increment not null,
	Direccion VARCHAR(256),
	Poblacion INT,
	Telefono INT,
	NIF_director CHAR(9),
	PRIMARY KEY (Codigo),
	CONSTRAINT `Director_fk` FOREIGN KEY (NIF_director) REFERENCES Director(NIF)
);
CREATE TABLE Clientes(
	NIF CHAR(9) not null,
	Nombre VARCHAR(256),
	Direccion VARCHAR(256),
	PRIMARY KEY (NIF)
);
CREATE TABLE Cuentas(
	Codigo CHAR(24) not null,
	Saldo DECIMAL(10,2),
	Tipo ENUM('Ahorro','Corriente'),
	Fecha_creacion DATE  not null,
	Fecha_cierre DATE,
	Cliente CHAR(9),
	Sucursal INT(9),
	PRIMARY KEY(Codigo),
	CONSTRAINT `Cuenta_sucursal_fk` FOREIGN KEY (Sucursal) REFERENCES Sucursales(Codigo),
	CONSTRAINT `Cuenta_cliente_fk` FOREIGN KEY (Cliente) REFERENCES Clientes(NIF)
 );
CREATE TABLE Movimientos_cuentas(
	Codigo INT(9) Auto_increment not null,
	Cuenta CHAR(24),
	Fecha DATE  not null,
	Concepto VARCHAR(256),
	Cantidad DOUBLE default 1 not null,
	Tipo ENUM('CobroTarjeta','ReciboDomiciliado','EmbargoJudicial','Transferencia','Reintegro'),
	PRIMARY KEY (Codigo,Cuenta),
	CONSTRAINT `Mov_cuenta_fk` FOREIGN KEY (Cuenta) REFERENCES Cuentas(Codigo)
);
CREATE TABLE Cuenta_ahorro(
	Tipo_intereses VARCHAR(256) not null,
	Codigo CHAR(24),
	PRIMARY KEY (Codigo),
	CONSTRAINT `ahorro_fk` FOREIGN KEY (Codigo) REFERENCES Cuentas(Codigo)
);
CREATE TABLE Cuenta_corriente(
	Cantidad_al_descubierto DECIMAL(10,2) not null,
	Cod_cuenta CHAR(24),
	PRIMARY KEY (Cod_cuenta),
	CONSTRAINT `corriente_fk` FOREIGN KEY (Cod_cuenta) REFERENCES Cuentas(Codigo)
);
CREATE TABLE Empleados(
	Cod_empleado INT(9) Auto_increment not null,
	NIF CHAR(9) not null,
	Nombre VARCHAR(256),
	Apellidos VARCHAR(256),
	Sucursal INT(9),
	PRIMARY KEY (Cod_empleado,NIF),
	CONSTRAINT `empleados_fk` FOREIGN KEY (Sucursal) REFERENCES Sucursales(Codigo)
);

ALTER TABLE Empleados ADD Director CHAR(9);
ALTER TABLE Empleados ADD CONSTRAINT `empleados_director_fk` FOREIGN KEY (Director) REFERENCES Director(NIF);
