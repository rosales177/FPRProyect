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
	_Status bool,
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
	Img mediumblob not null, 
	_Status bool,
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
	_Status bool,
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
#################################################################################################################################
#ALTER TABLE  CIUDAD DROP CONSTRAINT Uk_Nombre_Ciudad;
ALTER TABLE CIUDAD ADD CONSTRAINT Uk_Nombre_Ciudad UNIQUE (Uk_Nombre);
#ALTER TABLE   PAIS DROP CONSTRAINT Uk_Nombre_Pais;
ALTER TABLE PAIS ADD CONSTRAINT Uk_Nombre_Pais UNIQUE (Uk_Pais);
#ALTER TABLE CLIENTE DROP CONSTRAINT Chk_Correo;
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Correo CHECK(Correo like '%@%.%___');
############################################### PROCEDIMIENTOS ALMACENADOS ##########################################################
################################################CATEGORIA#########################################################################
select * from Categoria
insert into Categoria(Nom_Category)values('Blanco')
select * from subcategorias
insert into subcategorias(id_Category,Nom_SubCategory)values(1,'Zapatilla')
select * from productos
insert into productos(id_SubCategory,Descript_Product,Precio,Stock,Img,_Status)values(1,'Zapatilla Blanca',80,20,'zapatilla.png',1)

DROP PROCEDURE IF EXISTS sp_InsertCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertCategoria
(IN nom_Category VARCHAR(100))
sp: BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        rollback;
        SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA CATEGORIA' as message;
    END;
    IF (LENGTH(nom_Category) = 0 or nom_Category = " ")
    THEN
        SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    START TRANSACTION;
        INSERT INTO CATEGORIA (`Nom_Category`) VALUES (nom_Category);
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_UpdateCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCategoria
(
IN id_Category int,
IN nom_Category NVARCHAR(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
	IF (LENGTH(nom_Category) = 0 or nom_Category = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		UPDATE CATEGORIA SET `Nom_Category`= nom_Category WHERE `id_Categoria` = id_Category;
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_DeleteCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCategoria
(
IN id_Category int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		DELETE FROM CATEGORIA WHERE `id_Categoria` = id_Category;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectId;
DELIMITER $$
CREATE PROCEDURE sp_SelectId
(
IN id_Category int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR POR ID' as message;
	END;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(select id_Categoria from categoria where id_Categoria = id_Category ))
    THEN
		SELECT 'El id no existente.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SELECT CA.`id_Categoria` ,CA.`Nom_Category` FROM CATEGORIA AS CA  WHERE CA.`id_Categoria` = id_Category;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereCategoria;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereCategoria
(
IN id_Category int,
IN nom_Category nvarchar(100)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
    IF (LENGTH(nom_Category) = 0 or nom_Category = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SET _consultalike = CONCAT('%',nom_Category,'%');
		SELECT CA.`id_Categoria` AS ID,CA.`Nom_Category` AS CATEGORIA FROM CATEGORIA AS CA  WHERE CA.`id_Categoria` = id_Category or CA.`Nom_Category` like _consultalike;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectCategoria;
CREATE VIEW v_sSelectCategorIA
AS
	SELECT CA.`id_Categoria` AS ID,CA.`Nom_Category` AS CATEGORIA FROM CATEGORIA AS CA  LIMIT 30
SELECT * FROM v_sSelectCategoria
#######################################################  SUBCATEGORIA ###########################################################################
DROP PROCEDURE IF EXISTS sp_InsertSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertSubCategoria
(
IN id_Category int,
IN nom_SubCategory nvarchar(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
	IF (id_Category = 0 or id_Category is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(nom_SubCategory) = 0 or nom_SubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO SUBCATEGORIAS (`id_Category`,`Nom_SubCategory`) VALUES (id_Category,nom_SubCategory);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateSubCategoria
(
IN SubCategory int,
IN Category int,
IN NoSubCategory nvarchar(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (Category = 0 or Category is null)
    THEN
		SELECT 'EL id de la Categoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NoSubCategory) = 0 or NoSubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		UPDATE subcategorias SET id_Category = Category ,Nom_SubCategory =NoSubCategory WHERE id_SubCategory = SubCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteSubCategoria
(
IN SubCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM SUBCATEGORIAS WHERE `id_SubCategory` = SubCategory;
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereId;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereId
(
IN SubCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NOT EXISTS(SELECT `id_SubCategory` FROM SUBCATEGORIAS WHERE `id_SubCategory` = SubCategory))
    THEN
		SELECT 'EL id de la Subcategoria no existente.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT SUB.`id_SubCategory`,CAT.`Nom_Category` ,SUB.`Nom_SubCategory` FROM SUBCATEGORIAS AS SUB
        JOIN CATEGORIA AS CAT
        ON(SUB.`id_Category` = CAT.`id_Categoria`)
        WHERE SUB.`id_SubCategory` = SubCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereSubCategoria
(
IN id_SubCategory int,
IN consulta nvarchar(50)
)
sp:BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT SUB.`id_SubCategory` as ID ,CAT.`Nom_Category`,SUB.`Nom_SubCategory` AS SubCategoria FROM SUBCATEGORIAS AS SUB
        JOIN CATEGORIA AS CAT
        ON(SUB.`id_Category` = CAT.`id_Categoria`)
        WHERE `id_SubCategory` = id_SubCategory AND CAT.`Nom_Category` like _consultalike OR `id_SubCategory` = id_SubCategory AND   `Nom_SubCategory` like _consultalike;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectSubCategoria;
CREATE VIEW v_sSelectSubCategorIA
AS
	SELECT SUB.`id_SubCategory` as ID ,CAT.`Nom_Category`,SUB.`Nom_SubCategory` AS SubCategoria FROM SUBCATEGORIAS AS SUB JOIN CATEGORIA AS CAT ON(SUB.`id_Category` = CAT.`id_Categoria`) LIMIT 30
    
###########################################################  PRODUCTOS #####################################################################
DROP PROCEDURE IF EXISTS sp_InsertProductos;
DELIMITER $$
CREATE PROCEDURE sp_InsertProductos
(
IN id_SubCategory int,
IN descripcion nvarchar(250),
IN precio numeric(15,4),
IN stock int,
IN image blob, 
IN _Status bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PRODUCTO' as message;
	END;
	IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'El id de la subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO PRODUCTOS (`id_SubCategory`,`Descript_Product`,`Precio`,`Stock`,`Img`,`_Status`) VALUES (id_SubCategory,descripcion,precio,stock,image,_Status);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateProducto;
DELIMITER $$
CREATE PROCEDURE sp_UpdateProducto
(
IN idproduct int,
IN idSubCatego int,
IN descrip nvarchar(250),
IN preci numeric(15,4),
IN stock int,
IN imag blob, 
IN _Statu bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UN NUEVO PRODUCTO' as message;
	END;
    IF (idproduct = 0 or idproduct is null)
    THEN
		SELECT 'El id de la categoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (idSubCatego = 0 or idSubCatego is null)
    THEN
		SELECT 'El id de la subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(descrip) = 0 or descrip= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (preci < 0 or preci is null)
    THEN
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (_Statu < 0 or _Statu is null)
    THEN
		SET _Statu = 0;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE Productos SET `id_SubCategory`=idSubCatego,`Descript_Product`=descrip,`Precio`=preci,`Stock`=stock,`Img`= imag,`_Status` = _Statu WHERE `id_Product` = idproduct; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteProducto;
DELIMITER $$
CREATE PROCEDURE sp_DeleteProducto
(
IN idproduct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR EL PRODUCTO' as message;
	END;
    IF (idproduct = 0 or idproduct is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM PRODUCTOS WHERE `id_Product` = idproduct ;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereId;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereId
(
IN id_produ int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR POR ID' as message;
	END;
    IF (id_produ = 0 OR id_produ is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(select id_Product from PRODUCTOS where id_Product = id_produ ))
    THEN
		SELECT 'El id no existente.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT PD.`id_Product`, SUB.`Nom_SubCategory` ,CAT.`Nom_Category` ,PD.`Descript_Product` ,PD.`Precio`,PD.`Stock`,PD.`Img`,PD.`_Status`
		FROM PRODUCTOS as PD
		JOIN SUBCATEGORIAS as SUB
		ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
		JOIN CATEGORIA AS CAT
		ON(SUB.`id_Category` = CAT.`id_Categoria`) WHERE PD.`id_Product` = id_produ;
    COMMIT; 
END;
################DOS-SELECIONES###########
DROP PROCEDURE IF EXISTS sp_SelectConsultaProd;
DELIMITER $$
CREATE PROCEDURE sp_SelectConsultaProd
(
IN consulta nvarchar(50)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
		SELECT PD.`id_Product`, SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Img`,PD.`_Status` 
        FROM PRODUCTOS as PD
        JOIN SUBCATEGORIAS as SUB
        ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
        JOIN CATEGORIA AS CAT
        ON(SUB.`id_Category` = CAT.`id_Categoria`)
        WHERE  CAT.`Nom_Category` like _consultalike or
		SUB.`Nom_SubCategory` like _consultalike or
        PD.`Descript_Product` like _consultalike or
		PD.`_Status` like _consultalike
        LIMIT 30;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereProducto;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereProducto
(
IN id_product int,
IN consulta nvarchar(50)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (id_product = 0 or id_product  is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT PD.`id_Product`, SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Img`,PD.`_Status` 
        FROM PRODUCTOS as PD
        JOIN SUBCATEGORIAS as SUB
        ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
        JOIN CATEGORIA AS CAT
        ON(SUB.`id_Category` = CAT.`id_Categoria`)
        WHERE PD.`id_Product` = id_product AND CAT.`Nom_Category` like _consultalike OR
        PD.`id_Product` = id_product AND SUB.`Nom_SubCategory` like _consultalike OR
        PD.`id_Product` = id_product AND PD.`Descript_Product` like _consultalike OR
        PD.`id_Product` = id_product AND PD.`Status` like _consultalike
        LIMIT 30;
    COMMIT; 
END;
DROP VIEW IF EXISTS v_sSelectProducto;
CREATE VIEW v_sSelectProducto
AS
	SELECT PD.`id_Product`, SUB.`Nom_SubCategory` AS SubCategoria ,CAT.`Nom_Category` AS Categoria ,PD.`Descript_Product` AS Descripcion ,PD.`Precio`,PD.`Stock`,PD.`Img`,PD.`_Status` as Estado 
	FROM PRODUCTOS as PD
	JOIN SUBCATEGORIAS as SUB
	ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
	JOIN CATEGORIA AS CAT
	ON(SUB.`id_Category` = CAT.`id_Categoria`)
    LIMIT 30;

############################################################ PAIS ################################################################################################
DROP PROCEDURE IF EXISTS sp_InsertPais;
DELIMITER $$
CREATE PROCEDURE sp_InsertPais
(IN nom_Pais NVARCHAR(100))
sp:BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PAIS' as message;
	END;
    IF (LENGTH(nom_Pais) = 0 or nom_Pais = " ")
     THEN 
     	SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF; 
    START TRANSACTION;
		INSERT INTO PAIS (`Uk_Pais`) VALUES (nom_Pais);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdatePais;
DELIMITER $$
CREATE PROCEDURE sp_UpdatePais
(
IN id_Country int,
IN nom_Pais NVARCHAR(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UN PAIS' as message;
	END;
	IF (LENGTH(nom_Pais) = 0 or nom_Pais = " ")
    THEN
		SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
    IF (id_Pai = 0 OR id_Pai is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		UPDATE pais SET Uk_Pais = nom_Pais WHERE id_Pais = id_Country;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeletePais;
DELIMITER $$
CREATE PROCEDURE sp_DeletePais
(
IN id_Country int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UN PAIS' as message;
	END;
    IF (id_Country = 0 OR id_Country is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;
    START TRANSACTION;
		DELETE FROM Pais WHERE id_Pais = id_Country;
	COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_SelectWherePais;
DELIMITER $$
CREATE PROCEDURE sp_SelectWherePais
(
IN id_Pais int,
IN consulta nvarchar(100)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE LISTAR PAIS' as message;
	END;
    IF (id_Pais = 0 or id_Pais  is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o cero.' as message;
        LEAVE sp;
	END IF;
	IF (LENGTH(consulta) = 0 or consulta = " " )
    THEN
		SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
		SELECT PS.`id_Pais` AS ID ,PS.`Uk_Pais` AS PAIS FROM PAIS AS PS WHERE PS.`id_Pais`=id_Pais AND PS.`Uk_Pais` like _consultalike;
    COMMIT;
END;
DROP VIEW IF EXISTS v_SelectPais;
DELIMITER $$
CREATE VIEW v_SelectPais
AS
	SELECT PS.id_Pais as ID ,PS.`Uk_Pais` as PAIS FROM PAIS AS PS
############################################################CIUDAD############################################################################################
DROP PROCEDURE IF EXISTS sp_InsertCiudad;
DELIMITER $$
CREATE PROCEDURE sp_InsertCiudad
(IN id_Pais int,
IN nom_Ciudad NVARCHAR(100)
)
sp:BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO CIUDAD' as message;
	END;
    IF ((id_Pais = 0 or id_Pais is null))
     THEN 
     	SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;  
	IF (LENGTH(nom_Ciudad) = 0 or nom_Ciudad = " ")
    THEN
		 SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.' as message;
         LEAVE sp;
	END IF; 	
	START TRANSACTION;
		INSERT INTO CIUDAD (`id_Pais`,`Uk_Nombre`) VALUES (id_Pais,Uk_Nombre);
	COMMIT;    	
END;

DROP PROCEDURE IF EXISTS sp_UpdateCiudad;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCiudad
(
IN id_Ciudad int,
IN id_Pais int,
IN nom_Ciudad NVARCHAR(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UNA CIUDAD' as message;
	END;
	IF (LENGTH(id_Ciudad) = 0 or id_Ciudad = " ")
    THEN
		SELECT 'EL id de la Ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
	END IF;
	IF (LENGTH(id_Pais) = 0 or id_Pais = " ")
    THEN
		SELECT 'EL id del Pais no puede ser nula o cero..' as message;
        LEAVE sp;
	END IF;
    IF (LENGTH(nom_Ciudad) = 0 or nom_Ciudad = " ")
    THEN
		SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.'  as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		UPDATE CIUDAD SET id_Pais = id_Pais , Uk_Nombre = nom_Ciudad  WHERE id_Ciudad= id_Ciudad;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteCiudad;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCiudad
(
IN id_Ciudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UNA CIUDAD' as message;
	END;
    IF (id_Ciudad = 0 OR id_Ciudad is null)
    THEN
		SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		DELETE FROM CIUDAD WHERE `id_Ciudad` = id_Ciudad;
	COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereCiud;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereCiud
(
IN id_Ciudad int,
IN consulta nvarchar(50)
)
sp:BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (id_Ciudad  = 0 or id_Ciudad is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
	END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT CIU.id_Ciudad as ID ,PS.Uk_Pais AS PAIS,CIU.Uk_Nombre AS CIUDAD FROM Pais AS CIU
        JOIN Pais AS PS
        ON(CIU.id_Pais = PS.id_Pais)
        WHERE CIU.id_Ciudad = id_Ciudad AND PS.Uk_Pais like _consultalike OR CIU.id_Ciudad = id_Ciudad AND  CIU.Uk_Nombre  like _consultalike;
    COMMIT;
END;

DROP VIEW IF EXISTS v_sSelectCiudad;
CREATE VIEW v_sSelectCiudad
AS
	SELECT CIU.`id_Ciudad` as ID ,PS.`Uk_Pais` AS PAIS,CIU.`Uk_Nombre` AS CIUDAD FROM CIUDAD AS CIU JOIN PAIS AS PS ON(CIU.`id_Pais` = PS.`id_Pais`) LIMIT 30
#################################################################### DIRECCIONES ############################################################################
DROP PROCEDURE IF EXISTS sp_InsertDireccion;
DELIMITER $$
CREATE PROCEDURE sp_InsertDireccion
(
IN id_Cliente int,
IN Direccion nvarchar(50),
IN id_Ciudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA DIRECCIÓN' as message;
	END;
	IF (id_Cliente = 0 or id_Cliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Direccion) = 0 or Direccion= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (id_Ciudad = 0 or id_Ciudad is null)
    THEN
		SELECT 'El id de la ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF ((NOT EXISTS(SELECT `id_Cliente` FROM CLIENTE WHERE  `id_Cliente` = id_Cliente )))
    THEN
		SELECT 'El cliente no existente para el registro.' as message;
        LEAVE sp;
    END IF;
    IF((NOT EXISTS(SELECT `id_Ciudad` FROM  CIUDAD WHERE  `id_Ciudad` = id_Ciudad )))
    THEN
		SELECT 'La ciudad no existente para el registro.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO DIRECCIONES (`id_Cliente`,`Direccion`,`id_Ciudad`) VALUES (id_Cliente,Direccion,id_Ciudad);
    COMMIT; 
END;

select * from categoria
select * from subcategorias
INSERT INTO subcategorias(`id_Category`,`Nom_SubCategory`) VALUES (5,'Ropa');
DROP PROCEDURE IF EXISTS sp_UpdateDireccion;
DELIMITER $$
CREATE PROCEDURE sp_UpdateDireccion
(
IN id_Direc int,
IN id_Cliente int,
IN Direccion nvarchar(50),
IN id_Ciudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE LA DIRECCIÓN' as message;
	END;
    IF (id_Direc = 0 or id_Direc is null)
    THEN
		SELECT 'El id de la direccion no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (id_Cliente = 0 or id_Cliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Direccion) = 0 or Direccion= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (id_Ciudad = 0 or id_Ciudad is null)
    THEN
		SELECT 'El id de la ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE DIRECCIONES SET `id_Cliente` = id_Cliente ,`Direccion` = Direccion ,`id_Ciudad` = id_Ciudad  WHERE `id_Direct` = id_Direc; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteDireccion;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDireccion
(
IN id_Direct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR UNA DIRECCION' as message;
	END;
    IF (id_Direct = 0 or id_Direct is null)
    THEN
		SELECT 'EL id de la direccion no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM DIRECCIONES WHERE `id_Direct` = id_Direct ;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereDireccion;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereDireccion
(
IN id_Direct int,
IN consulta nvarchar(50)
)
sp:BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (id_Direct = 0 or id_Direct is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta de la direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT DIR.`id_Direct` AS ID, CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) AS CLIENTE,DIR.`Direccion` AS DIRECCION,CIU.`Uk_Nombre` AS CIUDAD,PS.`Uk_Pais` AS PAIS 
        FROM DIRECCIONES as DIR
        JOIN CLIENTE as CLI
        ON (DIR.`id_Cliente` = CLI.`id_Cliente`)
        JOIN CIUDAD AS CIU
        ON(DIR.`id_Ciudad` = CIU.`id_Ciudad`)
        JOIN PAIS AS PS
        ON(CIU.id_Pais  = PS.`id_Pais`)
        WHERE DIR.`id_Direct` = id_Direct AND CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) like _consultalike OR
        PD.`id_Direct` = id_Direct AND CIU.`Uk_Nombre` like _consultalike OR
        PD.`id_Direct` = id_Direct AND PS.`Uk_Pais` like _consultalike OR
        PD.`id_Direct` = id_Direct AND DIR.`Direccion` like _consultalike
        LIMIT 30;
        
    COMMIT; 
END;
DROP VIEW IF EXISTS v_sSelectDireccion;
CREATE VIEW v_sSelectDireccion
AS
	SELECT DIR.`id_Direct` AS ID, CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) AS CLIENTE,DIR.`Direccion` AS DIRECCION,CIU.`Uk_Nombre` AS CIUDAD,PS.`Uk_Pais` AS PAIS 
	FROM DIRECCIONES as DIR
	JOIN CLIENTE as CLI
	ON (DIR.`id_Cliente` = CLI.`id_Cliente`)
	JOIN CIUDAD AS CIU
	ON(DIR.`id_Ciudad` = CIU.`id_Ciudad`)
	JOIN PAIS AS PS
	ON(CIU.id_Pais  = PS.`id_Pais`)
    LIMIT 30;
################################################################### ROL ##############################################################################
DROP PROCEDURE IF EXISTS sp_InsertRoll;
DELIMITER $$
CREATE PROCEDURE sp_InsertRoll
(
IN Descript_Roll nvarchar(50)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO ROL' as message;
	END;
    IF (LENGTH(Descript_Roll) = 0 or Descript_Roll= " ")
    THEN
		SELECT 'La descripcion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO ROLL (`Descript_Roll`) VALUES (Descript_Roll);
    COMMIT; 
END;
CALL sp_InsertRoll ('User')
select * from Roll
DROP PROCEDURE IF EXISTS sp_UpdateRoll;
DELIMITER $$
CREATE PROCEDURE sp_UpdateRoll
(
IN id_Roll int,
IN Descript_Roll nvarchar(50)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE EL ROLL' as message;
	END;
    IF (id_Roll = 0 or id_Roll is null)
    THEN
		SELECT 'El id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Descript_Roll) = 0 or Descript_Roll=" ")
    THEN
		SELECT 'La descripcion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE ROLL SET `Descript_Roll` = Descript_Roll  WHERE `id_Roll` = id_Roll; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteRoll;
DELIMITER $$
CREATE PROCEDURE sp_DeleteRoll
(
IN id_Roll int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR UN ROL' as message;
	END;
    IF (id_Roll = 0 or id_Roll is null)
    THEN
		SELECT 'EL id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM ROLL WHERE `id_Roll` = id_Roll ;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereRoll;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereRoll
(
IN id_Roll int,
IN consulta nvarchar(50)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (id_Roll = 0 or id_Roll is null)
    THEN
		SELECT 'EL id del roll no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta deL roll no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT RL.id_Roll,RL.Descript_Roll
        FROM ROLL as RL
        WHERE RL.`id_Roll` = id_Roll AND RL.`Descript_Roll` like _consultalike 
        LIMIT 30;
    COMMIT;     
END;

DROP VIEW IF EXISTS v_sSelectRoll;
CREATE VIEW v_sSelectRoll
AS
	 SELECT RL.id_Roll,RL.Descript_Roll FROM ROLL as RL LIMIT 30;
     
SELECT * FROM v_sSelectRoll;	
####################################################################USER###################################################################

INSERT INTO ROLL(Descript_Roll)VALUES("Usuario")
DROP PROCEDURE IF EXISTS sp_InsertUser;
DELIMITER $$
CREATE PROCEDURE sp_InsertUser
(
IN idCliente int,
IN idRoll int,
IN Username nvarchar(250),
IN _Password nvarchar(250),
IN _Status bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    
	IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'El id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Username) = 0 or Username= " ")
    THEN
		SELECT 'El username no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Password) = 0 or _Password = " ")
    THEN
		SELECT 'El password no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF ((_Status < 0 or _Status > 1) or _Status is null)
    THEN
		SET _Status = 0;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO USER_ (`id_Cliente`,`id_Roll`,`_Username`,`_Password`,`_Status`) VALUES (idCliente,idRoll,Username,_Password,_Status);
    COMMIT; 
END;
DROP PROCEDURE IF EXISTS sp_UpdateUser;
DELIMITER $$
CREATE PROCEDURE sp_UpdateUser
(
IN idCliente int,
IN _Username nvarchar(250),
IN _Password nvarchar(250)

)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Username) = 0 or _Username= " ")
    THEN
		SELECT 'El username no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Password) = 0 or _Password = " ")
    THEN
		SELECT 'El password no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE USER_ SET  `_Username` = _Username,`_Password` = _Password  WHERE `id_Cliente` = idCliente;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteUser;
DELIMITER $$
CREATE PROCEDURE sp_DeleteUser
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM USER_ WHERE `id_Cliente` = idCliente;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectIdCliente;
DELIMITER $$
CREATE PROCEDURE sp_SelectIdCliente
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT CLI.Nombre_Cliente,CLI.Apellido_Cliente,RL.Descript_Roll,US._Username,US._Password,US._Status
		FROM USER_ as US
		JOIN CLIENTE as CLI
		ON (US.`id_Cliente` = CLI.`id_Cliente`)
		JOIN ROLL AS RL
		ON(US.`id_Cliente`= RL.`id_Roll`)
        WHERE  CLI.`id_Cliente` = idCliente;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereUser;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereUser
(
IN consulta nvarchar(50)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT CLI.Nombre_Cliente,CLI.Apellido_Cliente,RL.Descript_Roll AS ROLL,US._Username,US._Password,US._Status
		FROM USER_ as US
		JOIN CLIENTE as CLI
		ON (US.`id_Cliente` = CLI.`id_Cliente`)
		JOIN ROLL AS RL
		ON(US.`id_Cliente`= RL.`id_Roll`)
        WHERE  CLI.Nombre_Cliente like _consultalike OR
												CLI.Apellido_Cliente like _consultalike OR
												RL.`Descript_Roll` like _consultalike OR
												US.`_Username` like _Username OR
												US.`_Status` like _consultalike LIMIT 30;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectUser;
CREATE VIEW v_sSelectuser
AS
	SELECT CLI.Nombre_Cliente,CLI.Apellido_Cliente ,Descript_Roll,US._Username,US._Password,US._Status
	FROM USER_ as US
	JOIN CLIENTE as CLI
	ON (US.`id_Cliente` = CLI.`id_Cliente`)
	JOIN ROLL AS RL
	ON(US.`id_Cliente`= RL.`id_Roll`)
    LIMIT 30;
select * from v_sSelectUser
DELETE FROM USER_ WHERE id_Cliente= 1


##############################################################MEDIODEPAGO###############################################################
DROP PROCEDURE IF EXISTS sp_InsertMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_InsertMedioPago
(
IN id_Cliente int,
IN MedioPago nvarchar(250)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN MEDIO DE PAGO' as message;
	END;
    IF (id_Cliente = 0 or id_Cliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(MedioPago) = 0 or MedioPago= " ")
    THEN
		SELECT 'El medio de pago no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO MEDIOPAGO (`id_Cliente`,`MedioPago`) VALUES (id_Cliente,MedioPago);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_UpdateMedioPago
(
IN id_MedioPago int,
IN id_Cliente int,
IN MedioPago nvarchar(250)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL PEDIO DE PAGO' as message;
	END;
    IF (id_MedioPago= 0 or id_MedioPago is null)
    THEN
		SELECT 'El id del medio de pago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (id_Cliente = 0 or id_Cliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(MedioPago) = 0 or MedioPago= " ")
    THEN
		SELECT 'El medio de pago no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE MEDIOPAGO SET `id_Cliente` = id_Cliente,`MedioPago`= MedioPago WHERE `id_MedioPago` = d_MedioPago;
    COMMIT;
END;


DROP PROCEDURE IF EXISTS sp_DeleteMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_DeleteMedioPago
(
IN id_MedioPago int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR MEDIO DE PAGO' as message;
	END;
    IF (id_MedioPago= 0 or id_MedioPago is null)
    THEN
		SELECT 'El id del medio de pago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM MEDIOPAGO WHERE `id_MedioPago` = id_MedioPago ;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereMedioPago
(
IN id_MedioPago int,
IN consulta nvarchar(50)
)
sp:BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR UNA BUSQUEDA' as message;
	END;
    IF (id_MedioPago = 0 or id_MedioPago is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del medio de pago no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT MP.`id_MedioPago` AS ID, CONCAT_WS(' ',CL.Nombre_Cliente,CL.Apellido_Cliente) AS CLIENTE ,MP.`MedioPago` AS MEDIOPAGO FROM MEDIOPAGO AS MP
        JOIN CLIENTE AS CL
        ON(MP.`id_Cliente` = CL.`id_Cliente`)
        WHERE MP.`id_MedioPago` = id_MedioPago AND CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) like _consultalike OR 
        MP.`id_MedioPago` = id_MedioPago AND  `MedioPago` like _consultalike;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectMedioPago;
CREATE VIEW v_sSelectMedioPago
AS
		SELECT MP.`id_MedioPago` AS ID, CONCAT_WS(' ',CL.Nombre_Cliente,CL.Apellido_Cliente) AS CLIENTE ,MP.`MedioPago` AS MEDIOPAGO FROM MEDIOPAGO AS MP
		JOIN CLIENTE AS CL
        ON(MP.`id_Cliente` = CL.`id_Cliente`)

###############################################CLIENTE###############################################################################
DROP PROCEDURE IF EXISTS sp_InsertCliente;
DELIMITER $$
CREATE PROCEDURE sp_InsertCliente
(
IN Nombre_Cliente nvarchar(250),
IN Apellido_Cliente nvarchar(250),
IN Edad_Cliente smallint,
IN Correo nvarchar(250),
IN Contacto char(20)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR CLIENTE' as message;
	END;
    IF (LENGTH(Nombre_Cliente) = 0 or Nombre_Cliente= " ")
    THEN
		SELECT 'El nombre del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
     IF (LENGTH(Apellido_Cliente) = 0 or Apellido_Cliente= " ")
    THEN
		SELECT 'El apellido del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (Edad_Cliente= 0 or Edad_Cliente is null)
    THEN
		SELECT 'La edad del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Contacto) = 0 or Contacto= " ")
    THEN
		SELECT 'El contacto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO CLIENTE(`Nombre_Cliente`,`Apellido_Cliente`,`Edad_Cliente`,`Correo`,`Contacto`) VALUES (Nombre_Cliente,Apellido_Cliente,Edad_Cliente,Correo,Contacto );
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateCliente;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCliente
(
IN idCliente int,
IN NombreCliente nvarchar(250),
IN ApellidoCliente nvarchar(250),
IN EdadCliente smallint,
IN Correo nvarchar(250),
IN Contacto char(20)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR CLIENTE' as message;
	END;
    IF (idCliente= 0 or idCliente is null)
    THEN
		SELECT 'EL id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NombreCliente) = 0 or NombreCliente= " ")
    THEN
		SELECT 'El nombre del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
     IF (LENGTH(ApellidoCliente) = 0 or ApellidoCliente= " ")
    THEN
		SELECT 'El apellido del cliente no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (EdadCliente= 0 or EdadCliente is null)
    THEN
		SELECT 'La edad del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Contacto) = 0 or Contacto= " ")
    THEN
		SELECT 'El contacto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		UPDATE CLIENTE SET `Nombre_Cliente`=NombreCliente,`Apellido_Cliente`=ApellidoCliente,`Edad_Cliente`= EdadCliente,`Correo`= Correo,`Contacto`= Contacto WHERE `id_Cliente` = idCliente;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCliente;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCliente
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR CLIENTE' as message;
	END;
    IF (idCliente= 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		DELETE FROM CLIENTE WHERE `id_Cliente` = idCliente;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectClientsId;
DELIMITER $$
CREATE PROCEDURE sp_SelectClientsId
(
IN idCliente int
)
sp:BEGIN
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'EL id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL.`Edad_Cliente`,CL.`Correo`,CL.`Contacto`
        FROM CLIENTE AS CL
        WHERE CL.`id_Cliente` = idCliente;
			
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereCliente;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereCliente
(
IN idCliente int,
IN consulta nvarchar(50)
)
sp:BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR UNA BUSQUEDA' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'EL id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del medio de pago no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL`Edad_Cliente`,CL`Correo`,CL`Contacto`
        FROM CLIENTE AS CL
        WHERE CL.`id_Cliente` = idCliente AND CL.`Nombre_Cliente` like _consultalike OR 
			CL.`id_Cliente` = idCliente AND  CL.`Apel_Usernamelido_Cliente` like _consultalike OR 
			CL.`id_Cliente` = idCliente AND  CL.`Correo` like _consultalike OR 
			CL.`id_Cliente` = idCliente AND  CL.`Contacto` like _consultalike;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectCliente;
CREATE VIEW v_sSelectCliente
AS
	SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL.`Edad_Cliente`,CL.`Correo`,CL.`Contacto` FROM CLIENTE AS CL		

SELECT * FROM v_sSelectCliente




