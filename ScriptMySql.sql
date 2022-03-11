DROP DATABASE IF EXISTS DB_OLX;
CREATE DATABASE DB_OLX;
USE DB_OLX;

DROP TABLE IF EXISTS CLIENTE;  
 CREATE TABLE IF NOT EXISTS CLIENTE (
	id_Cliente int not null auto_increment ,
	Nombre_Cliente varchar(100) not null,
	Apellido_Cliente varchar(100) not null,
	Edad_Cliente smallint,
	Correo varchar(100) not null,
	Contacto char(20),
    PRIMARY KEY (id_Cliente) 
);
DROP TABLE IF EXISTS MEDIOPAGO;
CREATE TABLE IF NOT EXISTS MEDIOPAGO
(
	id_MedioPago int not null,
	id_Cliente int not null,
	MedioPago nvarchar(100) not null,
    PRIMARY KEY(id_MedioPago),
    CONSTRAINT Fk_Mediopago_Cliente
    FOREIGN KEY (id_Cliente) 
    REFERENCES CLIENTE(id_Cliente)
);

DROP TABLE IF EXISTS PAIS;
CREATE TABLE IF NOT EXISTS PAIS
(
	id_Pais int not null auto_increment,
	Uk_Pais nvarchar(100),
    PRIMARY KEY(id_Pais)    
);

DROP TABLE IF EXISTS CIUDAD;
CREATE TABLE IF NOT EXISTS CIUDAD 
(	
	id_Ciudad int not null auto_increment,
	id_Pais int not null,
	Uk_Nombre nvarchar(50) not null,
    PRIMARY KEY(id_Ciudad),
    CONSTRAINT  Fk_Pais_Ciudad 
    FOREIGN KEY (id_Pais) 
    REFERENCES PAIS(id_Pais)
);

DROP TABLE IF EXISTS DIRECCIONES;
CREATE TABLE IF NOT EXISTS DIRECCIONES
(
	id_Direct int not null auto_increment,
	id_Cliente int not null,
	Direccion nvarchar(500) not null,
	id_Ciudad int not null,
    PRIMARY KEY(id_Direct),
	CONSTRAINT Fk_Direcciones_Cliente
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente),
    CONSTRAINT Fk_Direcciones_Ciudad
    FOREIGN KEY (id_Ciudad)
    REFERENCES CIUDAD(id_Ciudad)
);

DROP TABLE IF EXISTS ROLL;
CREATE TABLE IF NOT EXISTS ROLL
(
	id_Roll int not null auto_increment,
	Descript_Roll nvarchar(10),
    PRIMARY KEY(id_Roll)
);

DROP TABLE IF EXISTS USER_;
CREATE TABLE IF NOT EXISTS USER_
(
	id_Cliente int not null,
	id_Roll int not null,
	_Username nvarchar(20),
	_Password nvarchar(100),
	_Status bit,
	CONSTRAINT Fk_User_Cliente
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente),
    CONSTRAINT Fk_User_Roll
    FOREIGN KEY (id_Roll)
    REFERENCES  ROLL(id_Roll)
);

DROP TABLE IF EXISTS CATEGORIA;
CREATE TABLE IF NOT EXISTS CATEGORIA
(
	id_Categoria int not null auto_increment,
	Nom_Category nvarchar(100) not null,
    PRIMARY KEY(id_Categoria)
);

DROP TABLE IF EXISTS SUBCATEGORIAS;
CREATE TABLE IF NOT EXISTS SUBCATEGORIAS
(
	id_SubCategory int not null auto_increment ,
	id_Category int not null,
	Nom_SubCategory nvarchar(100) not null,
    PRIMARY KEY(id_SubCategory),
    CONSTRAINT  Fk_Categoria_SubCategorias
    FOREIGN KEY  (id_Category)
    REFERENCES CATEGORIA (id_Categoria)
);

DROP TABLE IF EXISTS PRODUCTOS;
CREATE TABLE IF NOT EXISTS PRODUCTOS
(
	id_Product int not null auto_increment,
	id_SubCategory int not null,
	Descript_Product nvarchar(500) not null,
	Precio smallint not null,
	Stock smallint not null,
	Img nvarchar(100) not null,
	_Status bit,
    PRIMARY KEY(id_Product),
    CONSTRAINT  Fk_Productos_SubCategoria
    FOREIGN KEY  (id_SubCategory)
    REFERENCES SUBCATEGORIAS (id_SubCategory)
);

DROP TABLE IF EXISTS PEDIDO;
CREATE TABLE IF NOT EXISTS PEDIDO
(
	id_Cliente int not null,
	N_Pedido varchar(10) not null,
	FechaEmision date not null,
	Emp_Envio nvarchar(100) not null,
	Sub_Total smallint not null,
	Diret_Envio nvarchar(100) not null,
	Total smallint not null,
	TotalPagar smallint not null,
	_Status bit,
    primary key (N_Pedido),
	CONSTRAINT Fk_Pedido_Cliente 
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente)
    
);
DROP TABLE IF EXISTS CARRITOCOMPRA;
CREATE TABLE IF NOT EXISTS CARRITOCOMPRA
(
	N_Pedido varchar(10) not null,
	id_Product int not null,
	Car_Cantidad smallint not null,
	Car_Imp1 smallint not null,
	Car_Imp2 smallint not null,
	Car_Total smallint not null,
    CONSTRAINT Fk_CarritoCompra_Productos
    FOREIGN KEY  (id_Product)
    REFERENCES PRODUCTOS(id_Product),
    CONSTRAINT Fk_CarritoCompra_Pedido
    FOREIGN KEY (N_Pedido)
    REFERENCES  PEDIDO(N_Pedido)
##SE RESOLVIO EL PROBLEMA -NO SE CREO EL PRIMARY KEY
    
);
DROP TABLE IF EXISTS HISTORIALCOMPRA;
CREATE TABLE IF NOT EXISTS HISTORIALCOMPRA
(
	N_Pedido smallint not null,
	Cliente nvarchar(100) not null,
	FechaEmision date not null,
	DirecEnvio nvarchar(100) not null,
	SubTotal smallint not null,
	Total smallint not null,
	TotalPagar smallint not null
);
##########################################################
ALTER TABLE CIUDAD ADD CONSTRAINT Uk_Nombre_Ciudad UNIQUE (Uk_Nombre);
ALTER TABLE PAIS ADD CONSTRAINT Uk_Nombre_Pais UNIQUE (Uk_Pais);
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Correo CHECK(Correo like '%[^@]@%[^.].[a-z][a-z][a-z]');
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Telefono CHECK(Contacto like '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%')












