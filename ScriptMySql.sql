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
	Img nvarchar(100) null, ##La imagen no es dispensable para agregar el producto
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
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Telefono CHECK(Contacto like '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%');

############################################### PROCEDIMIENTOS ALMACENADOS ##########################################################
####################################  CATEGORIA ############################################
DROP PROCEDURE IF EXISTS sp_InsertCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertCategoria
(IN nom_Category NVARCHAR(100))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA CATEGORIA' as message;
	END;
	IF (LENGTH(nom_Category) = 0 or nom_Category = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
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
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
	IF (LENGTH(nom_Category) = 0 or nom_Category = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
    END IF;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
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
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
    END IF;
	START TRANSACTION;
		DELETE FROM CATEGORIA WHERE `id_Categoria` = id_Category;
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereCategoria;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereCategoria
(
IN id_Category int,
IN nom_Category nvarchar(100)
)
BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
    IF (LENGTH(nom_Category) = 0 or nom_Category = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
    END IF;
    IF (id_Category = 0 OR id_Category is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
    END IF;
	START TRANSACTION;
		SET _consultalike = CONCAT('%',nom_Category,'%');
		SELECT `Nom_Category` as Categoria FROM CATEGORIA WHERE `id_Categoria` = id_Category AND `Nom_Category` like _consultalike;
    COMMIT; 
END;

####################################  SUBCATEGORIA ############################################
DROP PROCEDURE IF EXISTS sp_InsertSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertSubCategoria
(
IN id_Category int,
IN nom_SubCategory nvarchar(100)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
	IF (id_Category = 0 or id_Category is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
    END IF;
    IF (LENGTH(nom_SubCategory) = 0 or nom_SubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
    END IF;
 	START TRANSACTION;
		INSERT INTO SUBCATEGORIAS (`id_Category`,`Nom_SubCategory`) VALUES (id_Category,nom_SubCategory);
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_UpdateSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateSubCategoria
(
IN id_SubCategory int,
IN id_Category int,
IN nom_SubCategory nvarchar(100)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
    END IF;
	IF (id_Category = 0 or id_Category is null)
    THEN
		SELECT 'EL id de la Categoria no puede ser nula o cero.' as message;
    END IF;
    IF (LENGTH(nom_SubCategory) = 0 or nom_SubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
    END IF;
 	START TRANSACTION;
		UPDATE SUBCATEGORIAS SET `id_Category` = id_Category ,  `Nom_SubCategory` = nom_SubCategory WHERE `id_SubCategory` = id_SubCategory ;
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_DeleteSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteSubCategoria
(
IN id_SubCategory int
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
    END IF;
 	START TRANSACTION;
		DELETE FROM SUBCATEGORIAS WHERE `id_SubCategory` = id_SubCategory ;
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereSubCategoria
(
IN id_SubCategory int,
IN consulta nvarchar(50)
)
BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta de la Subcategoria no puede ser nula o con valor en blanco.' as message;
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
#VERIFIQUE VIDE DE YOUTU INDICA QUE CUANDO HACES CONEXIONES DE TABLA NO PUEDE PONER EL END PÓRQUE ESO AFECTA EL CONTENIDO. (SIN END)
############################################################################################################################################

###################################### PAIS #######################################################
DROP PROCEDURE IF EXISTS sp_InsertPais;
DELIMITER $$
CREATE PROCEDURE sp_InsertPais
(IN nom_Pais NVARCHAR(100))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PAIS' as message;
	END;
    IF (LENGTH(nom_Pais) = 0 or nom_Pais = " ")
     THEN 
     	SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
	ELSEIF((EXISTS(SELECT `Uk_Pais` FROM PAIS WHERE  `Uk_Pais`= nom_Pais )))
    THEN
		SELECT 'El nombre del pais ya existente.' as message;
	ELSE
		START TRANSACTION;
			INSERT INTO PAIS (`Uk_Pais`) VALUES (nom_Pais);
		COMMIT; 
     END IF;     	
END;

DROP PROCEDURE IF EXISTS sp_UpdatePais;
DELIMITER $$
CREATE PROCEDURE sp_UpdatePais
(
IN id_Country int,
IN nom_Pais NVARCHAR(100)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UN PAIS' as message;
	END;
	IF (LENGTH(nom_Pais) = 0 or nom_Pais = " ")
    THEN
		SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
    ELSEIF (id_Pai = 0 OR id_Pai is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
	ELSE
	START TRANSACTION;
		UPDATE pais SET Uk_Pais = nom_Pais WHERE id_Pais = id_Country;
    COMMIT; 
    END IF;
    
END;

DROP PROCEDURE IF EXISTS sp_DeletePais;
DELIMITER $$
CREATE PROCEDURE sp_DeletePais
(
IN id_Country int
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UN PAIS' as message;
	END;
    IF (id_Country = 0 OR id_Country is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
	ELSEIF(NOT EXISTS(SELECT id_Pais FROM Pais WHERE id_Pais = id_Country))
    THEN
		SELECT "El id del pais no existente." as message;
	ELSE
		START TRANSACTION;
			DELETE FROM Pais WHERE id_Pais = id_Country;
		COMMIT;
    END IF;
END;

DROP PROCEDURE IF EXISTS sp_SelectWherePais;
DELIMITER $$
CREATE PROCEDURE sp_SelectWherePais
(
IN nom_Pais nvarchar(100)
)
BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE LISTAR PAIS' as message;
	END;
    IF (LENGTH(nom_Pais) = 0 or nom_Pais = " ")
    THEN
		SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
    ELSE
		START TRANSACTION;
		SET _consultalike = CONCAT('%',nom_Pais,'%');
		SELECT `Uk_Pais` as Pais FROM Pais WHERE  `Uk_Pais` like _consultalike;
    COMMIT;
    END IF;
END;

DROP VIEW IF EXISTS v_SelectPais;
DELIMITER $$
CREATE VIEW v_SelectPais
AS
	SELECT `Uk_Pais` as Pais FROM Pais
END;
####################################CIUDAD###################################################
DROP PROCEDURE IF EXISTS sp_InsertCiudad;
DELIMITER $$
CREATE PROCEDURE sp_InsertCiudad
(IN id_Pais int,
IN nom_Ciudad NVARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO CIUDAD' as message;
	END;
    IF ((id_Pais = 0 or id_Pais is null))
     THEN 
     	SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
	ELSEIF
    THEN(LENGTH(nom_Ciudad) = 0 or nom_Ciudad = " ")
		 SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.' as message;
	ELSEIF(( NOT EXISTS(SELECT `id_Pais` FROM pais WHERE  `id_Pais`= id_Pais )))
    THEN
		SELECT 'El nombre del pais no existente para el registro.' as message;
	ELSE
		START TRANSACTION;
			INSERT INTO CIUDAD (`id_Pais`,`Uk_Nombre`) VALUES (id_Pais,Uk_Nombre);
		COMMIT; 
     END IF;     	
END;

DROP PROCEDURE IF EXISTS sp_UpdateCiudad;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCiudad
(
IN id_Ciudad int,
IN id_Pais int,
IN nom_Ciudad NVARCHAR(100)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UNA CIUDAD' as message;
	END;
	IF (LENGTH(id_Ciudad) = 0 or id_Ciudad = " ")
    THEN
		SELECT 'EL id de la Ciudad no puede ser nula o cero.' as message;
	ELSEIF (LENGTH(id_Pais) = 0 or id_Pais = " ")
    THEN
		SELECT 'EL id del Pais no puede ser nula o cero..' as message;
    ELSEIF (LENGTH(nom_Ciudad) = 0 or nom_Ciudad = " ")
    THEN
		SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.'  as message;
	ELSE
	START TRANSACTION;
		UPDATE CIUDAD SET id_Pais = id_Pais , Uk_Nombre = nom_Ciudad  WHERE id_Ciudad= id_Ciudad;
    COMMIT; 
    END IF;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCiudad;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCiudad
(
IN id_Ciudad int
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UNA CIUDAD' as message;
	END;
    IF (id_Ciudad = 0 OR id_Ciudad is null)
    THEN
		SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
	ELSEIF(NOT EXISTS(SELECT `id_Ciudad` FROM CIUDAD WHERE `id_Ciudad` = id_Ciudad))
    THEN
		SELECT "El id de la ciudad no existente." as message;
	ELSE
		START TRANSACTION;
			DELETE FROM CIUDAD WHERE `id_Ciudad` = id_Ciudad;
		COMMIT;
    END IF;
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereCiud;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereCiud
(
IN id_Ciudad int,
IN consulta nvarchar(50)
)
BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
    IF (id_Ciudad  = 0 or id_Ciudad is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
    
    ELSEIF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta de la Subcategoria no puede ser nula o con valor en blanco.' as message;
    ELSE
 	START TRANSACTION;
		SET _consultalike = CONCAT('%',consulta,'%');
        
        SELECT CIU.id_Ciudad as ID ,PS.Uk_Pais AS PAIS,CIU.Uk_Nombre AS CIUDAD FROM Pais AS CIU
        JOIN Pais AS PS
        ON(CIU.id_Pais = PS.id_Pais)
        WHERE CIU.id_Ciudad = id_Ciudad AND PS.Uk_Pais like _consultalike OR CIU.id_Ciudad = id_Ciudad AND  CIU.Uk_Nombre  like _consultalike;
    COMMIT;
    END IF;
    
END;

DROP VIEW IF EXISTS v_sSelectCiudad;
CREATE VIEW v_sSelectCiudad
AS
	SELECT CIU.`id_Ciudad` as ID ,PS.`Uk_Pais` AS PAIS,CIU.`Uk_Nombre` AS CIUDAD FROM CIUDAD AS CIU JOIN PAIS AS PS ON(CIU.`id_Pais` = PS.`id_Pais`) LIMIT 30

####################################  PRODUCTOS ############################################
DROP PROCEDURE IF EXISTS sp_InsertProductos;
DELIMITER $$
CREATE PROCEDURE sp_sp_InsertProductos
(
IN id_SubCategory int,
IN descripcion nvarchar(250),
IN precio numeric(15,4),
IN stock int,
IN image blob, 
IN _Status bit
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PRODUCTO' as message;
	END;
	IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'El id de la subcategoria no puede ser nula o cero.' as message;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
    END IF;
 	START TRANSACTION;
		INSERT INTO PRODUCTOS (`id_SubCategory`,`Descript_Product`,`Precio`,`Stock`,`Img`,`_Status`) VALUES (id_SubCategory,descripcion,precio,stock,image,_Status);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateProducto;
DELIMITER $$
CREATE PROCEDURE sp_UpdateProducto
(
IN id_product int,
IN id_SubCategory int,
IN descripcion nvarchar(250),
IN precio numeric(15,4),
IN stock int,
IN image blob, 
IN _Status bit
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL PRODUCTO' as message;
	END;
    
    IF (id_product = 0 or id_product is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
    END IF;
	IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'El id de la subcategoria no puede ser nula o cero.' as message;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
    END IF;
 	START TRANSACTION;
		UPDATE PRODUCTOS SET `id_SubCategory` = id_SubCategory ,`Descript_Product` = descripcion ,`Precio` = precio ,`Stock` = stock,`Img` = image,`_Status` = _Status WHERE `id_Product` = id_product; 
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_DeleteSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteSubCategoria
(
IN id_product int
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR EL PRODUCTO' as message;
	END;
    IF (id_product = 0 or id_product is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
    END IF;
 	START TRANSACTION;
		DELETE FROM PRODUCTOS WHERE `id_Product` = id_product ;
    COMMIT; 
    
END;

DROP PROCEDURE IF EXISTS sp_SelectWhereProducto;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereProducto
(
IN id_product int,
IN consulta nvarchar(50)
)
BEGIN

	DECLARE _consultalike NVARCHAR(100) ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (id_product = 0 or id_product  is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
    END IF;
    IF (LENGTH(consulta) = 0 or consulta = " ")
    THEN
		SELECT 'La consulta del producto no puede ser nula o con valor en blanco.' as message;
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
        PD.`id_Product` = id_product AND CAT.`Nom_Category` like _consultalike OR
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
############################################################################################################################################







