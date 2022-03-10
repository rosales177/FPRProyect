USE master
Go

DROP DATABASE IF EXISTS DB_OLX
GO
CREATE DATABASE DB_OLX
ON PRIMARY    
(
	NAME = DBOLX_dat,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbolxdat.mdf',
	SIZE = 20MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB 
)
LOG ON    
(
	NAME = DBOLX_log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbolxlog.ldf',
	SIZE = 5MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB
)
go

USE DB_OLX
GO

DROP TABLE IF EXISTS CLIENTE
GO
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

DROP TABLE IF EXISTS MEDIOPAGO
GO
CREATE TABLE MEDIOPAGO
(
	id_MedioPago int not null identity(1,1),
	id_Cliente int not null,
	MedioPago nvarchar(100) not null
)
GO



DROP TABLE IF EXISTS DIRECCIONES
GO
CREATE TABLE DIRECCIONES
(
	id_Direct int not null identity(1,1),
	id_Cliente int not null,
	Direccion nvarchar(max),
	id_Ciudad int not null
)
GO

DROP TABLE IF EXISTS CIUDAD
GO
CREATE TABLE CIUDAD 
(	
	id_Ciudad int not null identity(1,1),
	id_Pais int not null,
	Uk_Nombre nvarchar(50),	
)
GO

DROP TABLE IF EXISTS PAIS
GO
CREATE TABLE PAIS
(
	id_Pais int not null identity(1,1),
	Uk_Pais nvarchar(100) 
)
GO

DROP TABLE IF EXISTS USER_
GO
CREATE TABLE USER_
(
	id_Cliente int not null,
	id_Roll int not null,
	_Username nvarchar(20),
	_Password nvarchar(max),
	_Status bit
)
GO

DROP TABLE IF EXISTS ROLL
GO
CREATE TABLE ROLL
(
	id_Roll int not null identity(1,1),
	Descript_Roll nvarchar(10)
)
GO

/*************************************TABLAS MIGUEL**********************************************************/

DROP TABLE IF EXISTS PRODUCTOS
GO
CREATE TABLE PRODUCTOS
(
	id_Product int not null identity(1,1),
	id_SubCategory int not null,
	Descript_Product nvarchar(max) not null,
	Precio smallint not null,
	Stock smallint not null,
	Img nvarchar(max) not null,
	_Status bit
)
GO


DROP TABLE IF EXISTS SUBCATEGORIAS
GO
CREATE TABLE SUBCATEGORIAS
(
	id_SubCategory int not null identity(1,1),
	id_Category int not null,
	Nom_SubCategory nvarchar(100) not null,
)
GO

DROP TABLE IF EXISTS CATEGORIA
GO
CREATE TABLE CATEGORIA
(
	id_Categoria int not null identity(1,1),
	Nom_Category nvarchar(100) not null,
)
GO



DROP TABLE IF EXISTS PEDIDO
GO
CREATE TABLE PEDIDO
(
	id_Cliente int not null,
	N_Pedido varchar(10) not null,
	FechaEmision date not null,
	Emp_Envio nvarchar(100) not null,
	Sub_Total smallint not null,
	Diret_Envio nvarchar(100) not null,
	Total smallint not null,
	TotalPagar smallint not null,
	_Status bit
)
GO

DROP TABLE IF EXISTS CARRITOCOMPRA
GO
CREATE TABLE CARRITOCOMPRA
(
	N_Pedido varchar(10) not null,
	id_Product int not null,
	Car_Cantidad smallint not null,
	Car_Imp1 smallint not null,
	Car_Imp2 smallint not null,
	Car_Total smallint not null
)
GO


DROP TABLE IF EXISTS HISTORIALCOMPRA
Go
CREATE TABLE HISTORIALCOMPRA
(
	N_Pedido smallint not null,
	Cliente nvarchar(100) not null,
	FechaEmision date not null,
	DirecEnvio nvarchar(100) not null,
	SubTotal smallint not null,
	Total smallint not null,
	TotalPagar smallint not null,
)
GO

/**************************************CREACION DE PRIMARY KEY***********************************************/
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
ALTER TABLE PAIS ADD CONSTRAINT Pk_Pais PRIMARY KEY (id_Pais)
GO

ALTER TABLE ROLL DROP CONSTRAINT IF EXISTS Pk_Roll
ALTER TABLE ROLL ADD CONSTRAINT Pk_Roll PRIMARY KEY (id_Roll)
GO

ALTER TABLE  MEDIOPAGO DROP CONSTRAINT IF EXISTS Pk_Medio_Pago
ALTER TABLE  MEDIOPAGO ADD CONSTRAINT Pk_Medio_Pago PRIMARY KEY (id_MedioPago)
Go

ALTER TABLE PRODUCTOS DROP CONSTRAINT IF EXISTS Pk_Productos
ALTER TABLE PRODUCTOS ADD CONSTRAINT Pk_Productos PRIMARY KEY (id_Product)
Go

ALTER TABLE SUBCATEGORIAS DROP CONSTRAINT IF EXISTS Pk_SubCategoria
ALTER TABLE SUBCATEGORIAS ADD CONSTRAINT Pk_SubCategoria PRIMARY KEY (id_SubCategory)
GO

ALTER TABLE CATEGORIA DROP CONSTRAINT IF EXISTS Pk_Categoria
ALTER TABLE CATEGORIA ADD CONSTRAINT Pk_Categoria PRIMARY KEY(id_Categoria)
GO

ALTER TABLE PEDIDO DROP CONSTRAINT IF EXISTS Pk_Pedido
ALTER TABLE PEDIDO ADD CONSTRAINT Pk_Pedido PRIMARY KEY (N_Pedido)
GO

/**************************************CREACION DE FOREIGN KEY***********************************************/

ALTER TABLE MEDIOPAGO DROP CONSTRAINT IF EXISTS Fk_Mediopago_Cliente
ALTER TABLE MEDIOPAGO ADD CONSTRAINT Fk_Mediopago_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_Cliente)
GO

ALTER TABLE DIRECCIONES DROP CONSTRAINT IF EXISTS Fk_Direcciones_Cliente
ALTER TABLE DIRECCIONES ADD CONSTRAINT Fk_Direcciones_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTE (id_Cliente)
GO

ALTER TABLE DIRECCIONES DROP CONSTRAINT IF EXISTS Fk_Direcciones_Ciudad
ALTER TABLE DIRECCIONES ADD CONSTRAINT Fk_Direcciones_Ciudad FOREIGN KEY (id_Ciudad) REFERENCES CIUDAD (id_Ciudad)
GO

ALTER TABLE CIUDAD DROP CONSTRAINT IF EXISTS Fk_Pais_Ciudad 
ALTER TABLE CIUDAD ADD CONSTRAINT Fk_Pais_Ciudad FOREIGN KEY (id_Pais) REFERENCES PAIS (id_Pais)
GO

ALTER TABLE USER_ DROP CONSTRAINT IF EXISTS Fk_User_Cliente
ALTER TABLE USER_ ADD CONSTRAINT Fk_User_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTE (id_Cliente)
Go

ALTER TABLE USER_ DROP CONSTRAINT IF EXISTS Fk_User_Roll
ALTER TABLE USER_ ADD CONSTRAINT Fk_User_Roll FOREIGN KEY (id_Roll) REFERENCES ROLL(id_Roll)
GO

ALTER TABLE SUBCATEGORIAS DROP CONSTRAINT IF EXISTS Fk_Categoria_SubCategorias
ALTER TABLE SUBCATEGORIAS ADD CONSTRAINT Fk_Categoria_SubCategorias FOREIGN KEY (id_Category) REFERENCES CATEGORIA (id_Categoria)
GO

ALTER TABLE PRODUCTOS DROP CONSTRAINT IF EXISTS Fk_Productos_SubCategoria
ALTER TABLE PRODUCTOS ADD CONSTRAINT Fk_Productos_SubCategoria FOREIGN KEY (id_SubCategory) REFERENCES SUBCATEGORIAS (id_SubCategory)
Go

ALTER TABLE CARRITOCOMPRA DROP CONSTRAINT IF EXISTS Fk_CarritoCompra_Productos
ALTER TABLE CARRITOCOMPRA ADD CONSTRAINT Fk_CarritoCompra_Productos FOREIGN KEY (id_Product) REFERENCES PRODUCTOS (id_Product)
Go

ALTER TABLE CARRITOCOMPRA DROP CONSTRAINT IF EXISTS Fk_CarritoCompra_Pedido
ALTER TABLE CARRITOCOMPRA ADD CONSTRAINT Fk_CarritoCompra_Pedido FOREIGN KEY (N_Pedido) REFERENCES PEDIDO (N_Pedido)
Go

ALTER TABLE PEDIDO DROP CONSTRAINT IF EXISTS Fk_Pedido_Cliente
ALTER TABLE PEDIDO ADD CONSTRAINT Fk_Pedido_Cliente FOREIGN KEY (id_Cliente) REFERENCES CLIENTE (id_Cliente)
Go
/**************************************CREACION DE UNIQUE***********************************************/

ALTER TABLE CIUDAD DROP CONSTRAINT IF EXISTS Uk_Nombre_Ciudad
ALTER TABLE CIUDAD ADD CONSTRAINT Uk_Nombre_Ciudad UNIQUE (Uk_Nombre)
GO

ALTER TABLE PAIS DROP CONSTRAINT IF EXISTS Uk_Nombre_Pais
ALTER TABLE PAIS ADD CONSTRAINT Uk_Nombre_Pais UNIQUE (Uk_Pais)
GO

/**************************************CREACION DE CHECK***********************************************/
ALTER TABLE CLIENTE DROP CONSTRAINT IF EXISTS Chk_Correo
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Correo CHECK(Correo like '%[^@]@%[^.].[a-z][a-z][a-z]')
GO
ALTER TABLE CLIENTE DROP CONSTRAINT IF EXISTS Chk_Telefono 
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Telefono CHECK(Contacto like '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%')