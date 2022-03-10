
CREATE TABLE CLIENTE 
(
	id_Cliente int not null identity(100,1),
	Nombre_Cliente nvarchar(100) not null,
	Apellido_Cliente nvarchar(100) not null,
	Edad_Cliente smallint,
	Correo nvarchar(100) not null,
	Contacto char(20),
)
GO

CREATE TABLE DIRECCIONES
(
	id_Direct int not null identity(1,1),
	id_Cliente int not null,
	Direccion nvarchar(max),
	Ciudad int not null
)
GO

CREATE TABLE CIUDAD 
(	
	id_Ciudad int not null identity(1,1),
	id_Pais int not null,
	Uk_Nombre nvarchar(50),	
)
GO

CREATE TABLE PAIS
(
	id_Pais int not null identity(1,1),
	Uk_Pais nvarchar(100) 
)
GO

CREATE TABLE USER_
(
	id_Clinte int not null,
	id_Rol int not null,
	_Username nvarchar(20),
	_Password nvarchar(max),
	_Status bit
)
GO

CREATE TABLE ROL
(
	id_Rol int not null identity(1,1),
	Descript_Rol nvarchar(10)
)
GO


ALTER TABLE CLIENTE DROP CONSTRAINT IF EXISTS Pk_Cliente
ALTER TABLE CLIENTE ADD CONSTRAINT Pk_Cliente PRIMARY KEY (id_Cliente)
GO

ALTER TABLE DIRECCIONES DROP CONSTRAINT IF EXISTS Pk_Direct
ALTER TABLE DIRECCIONES ADD CONSTRAINT Pk_Direct PRIMARY KEY (id_Direct)
GO

ALTER TABLE CIUDAD DROP CONSTRAINT IF EXISTS Pk_Ciudad
ALTER TABLE CIUDAD ADD CONSTRAINT Pk_Ciudad PRIMARY KEY (id_Ciudad)
Go

ALTER TABLE PAIS DROP CONSTRAINT IF EXISTS Pk_Pais 