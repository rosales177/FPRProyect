DROP DATABASE IF EXISTS DB_OLX;
CREATE DATABASE DB_OLX;
USE DB_OLX;
DROP TABLE IF EXISTS CLIENTE;  
 CREATE TABLE IF NOT EXISTS CLIENTE 
 (
	id_Cliente int not null auto_increment ,
	Nombre_Cliente varchar(100) not null,
	Apellido_Cliente varchar(100) not null,
	Edad_Cliente smallint,
	Correo varchar(100) not null,
	Contacto char(20),
    Img nvarchar(250) not null,
    PRIMARY KEY (id_Cliente) 
);
DROP TABLE IF EXISTS MEDIOPAGO;
CREATE TABLE IF NOT EXISTS MEDIOPAGO
(
	id_MedioPago int not null auto_increment,
	id_Cliente int not null,
	MedioPago nvarchar(100) not null,
    NumeroTarjeta char(50) not null,
    CVV char(3) not null,
    FechaVencimiento date not null,
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
	Descript_Roll nvarchar (50) not null,
    _Value char(6) not null,
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
    Nombre_Product nvarchar(500) not null,
    Marca_Product nvarchar(500) not null,
	id_SubCategory int not null,
	Descript_Product nvarchar(1000) not null,
	Precio decimal(7,2) not null,
	Stock smallint not null,
    Unidad nvarchar(10) not null,
    Moneda nvarchar(20) not null,
	Img1 nvarchar(250) not null,
    Img2 nvarchar(250) not null,
    Img3 nvarchar(250) not null,
    Img4 nvarchar(250) not null,
    Img5 nvarchar(250) not null,
    NDescuento smallint not null,
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
	N_Pedido smallint not null,
	FechaEmision date not null,
	Emp_Envio nvarchar(100) not null,
	Sub_Total decimal(7,2) not null,
    Descuento decimal(7,2) not null,
	Diret_Envio nvarchar(100) not null,
	Total smallint not null,
	TotalPagar decimal(7,2) not null,
	_Status bool,
    primary key (N_Pedido),
	CONSTRAINT Fk_Pedido_Cliente 
    FOREIGN KEY (id_Cliente)
    REFERENCES CLIENTE(id_Cliente)
);
DROP TABLE IF EXISTS CARRITOCOMPRA;
CREATE TABLE IF NOT EXISTS CARRITOCOMPRA
(
	N_Pedido smallint not null,
	id_Product int not null,
	Car_Cantidad decimal(7,2) not null,
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
	SubTotal decimal(7,2) not null,
	Total smallint not null,
	TotalPagar decimal(7,2) not null,
    Descuento decimal(7,2) not null
);
DROP TABLE IF EXISTS DESCUENTO;
CREATE TABLE IF NOT EXISTS DESCUENTO
(
	id_Product int not null,
    dscto1 smallint not null,
    dscto2 smallint not null,
    dscto3 smallint not null,
    dscto4 smallint not null,
    CONSTRAINT Fk_Descuento_Productos
    FOREIGN KEY  (id_Product)
    REFERENCES productos(id_Product)
);
DROP TABLE IF EXISTS CARACTERISTICAS;
CREATE TABLE IF NOT EXISTS CARACTERISTICAS
(
	id_Product int not null,
    Caracteristicas_product nvarchar(1500),
    CONSTRAINT Fk_Caracterisitcas_Productos
    FOREIGN KEY (id_Product)
    REFERENCES productos(id_Product)
);
#################################################################################################################################
#ALTER TABLE CIUDAD DROP CONSTRAINT Uk_Nombre_Ciudad;
ALTER TABLE CIUDAD ADD CONSTRAINT Uk_Nombre_Ciudad UNIQUE (Uk_Nombre);
#ALTER TABLE PAIS DROP CONSTRAINT Uk_Nombre_Pais;
ALTER TABLE PAIS ADD CONSTRAINT Uk_Nombre_Pais UNIQUE (Uk_Pais);
#ALTER TABLE CLIENTE DROP CONSTRAINT Chk_Correo;
ALTER TABLE CLIENTE ADD CONSTRAINT Chk_Correo CHECK(Correo like '__%@__%.%___');
###############################################PROCEDIMIENTOSALMACENADOS##########################################################
################################################CATEGORIA#########################################################################	
DROP PROCEDURE IF EXISTS sp_InsertCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertCategoria
(IN nomCategory VARCHAR(100))
sp: BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        rollback;
        SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA CATEGORIA' as message;
    END;
    IF (LENGTH(nomCategory) = 0 or nomCategory = " ")
    THEN
        SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    START TRANSACTION;
        INSERT INTO CATEGORIA (`Nom_Category`) VALUES (nomCategory);
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_UpdateCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCategoria
(
IN idCategory int,
IN nomCategory NVARCHAR(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UNA CATEGORIA' as message;
	END;
	IF (LENGTH(nomCategory) = 0 or nomCategory = " ")
    THEN
		SELECT 'EL nombre de la categoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idCategory = 0 OR idCategory is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		UPDATE CATEGORIA SET `Nom_Category`= nomCategory WHERE `id_Categoria` = idCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteCategoria;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCategoria
(
IN categoriaid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UNA CATEGORIA' as message;
	END;
    IF (categoriaid = 0 or categoriaid is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Categoria FROM categoria WHERE id_Categoria= categoriaid))
    THEN
		SELECT 'No existente Id Categoria para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) join caracteristicas CAR on(CAR.id_Product = P.id_Product) where C.id_Categoria = categoriaid;
		DELETE DE from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) join descuento DE on(DE.id_Product = P.id_Product) where C.id_Categoria = categoriaid;
		DELETE CA from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) join carritocompra CA on(CA.id_Product = P.id_Product) where C.id_Categoria = categoriaid;
		DELETE P from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) join productos P on(P.id_SubCategory = S.id_SubCategory) where C.id_Categoria = categoriaid; 
		DELETE S from subcategorias S join categoria C on(S.id_Category = C.id_Categoria) where C.id_Categoria = categoriaid;
		DELETE C FROM categoria C WHERE C.`id_Categoria` = categoriaid;
    COMMIT; 
    
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCategoryId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCategoryId
(
IN idCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR CATEGORIA' as message;
	END;
    IF (idCategory = 0 OR idCategory is null)
    THEN
		SELECT 'EL id de la categoria no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		SELECT CA.`id_Categoria` ,CA.`Nom_Category` FROM CATEGORIA AS CA  WHERE CA.`id_Categoria` = idCategory;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadCategory;
CREATE VIEW v_sCantidadCategory
AS SELECT COUNT(*) CANTIDAD_CATEGORY FROM categoria;

DROP VIEW IF EXISTS v_sSelectCategoria;
CREATE VIEW v_sSelectCategoria
AS SELECT CA.`id_Categoria`,CA.`Nom_Category` FROM CATEGORIA AS CA  LIMIT 30
#######################################################SUBCATEGORIA ###########################################################################
DROP PROCEDURE IF EXISTS sp_InsertSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_InsertSubCategoria
(
IN idCategory int,
IN nomSubCategory nvarchar(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA SUBCATEGORIA' as message;
	END;
	IF (idCategory = 0 or idCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(nomSubCategory) = 0 or nomSubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO SUBCATEGORIAS (`id_Category`,`Nom_SubCategory`) VALUES (idCategory,nomSubCategory);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateSubCategoria;
DELIMITER $$
CREATE PROCEDURE sp_UpdateSubCategoria
(
IN idSubCategory int,
IN idCategory int,
IN NombreSubCategory nvarchar(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE SUBCATEGORIA' as message;
	END;
    IF (idSubCategory = 0 or idSubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (idCategory = 0 or idCategory is null)
    THEN
		SELECT 'EL id de la Categoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NombreSubCategory) = 0 or NombreSubCategory = " ")
    THEN
		SELECT 'EL nombre de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		UPDATE subcategorias SET id_Category = idCategory ,Nom_SubCategory =NombreSubCategory WHERE id_SubCategory = idSubCategory;
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
		SELECT 'A OCURRIDO UN ERROR AL DELETE UNA SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_SubCategory FROM subcategorias WHERE id_SubCategory= SubCategory))
    THEN
		SELECT 'No existente Id SubCategoria para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) join caracteristicas CAR on(CAR.id_Product = P.id_Product) where S.`id_SubCategory` = SubCategory;
		DELETE DE from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) join descuento DE on(DE.id_Product = P.id_Product) where S.`id_SubCategory` = SubCategory;
		DELETE CA from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) join carritocompra CA on(CA.id_Product = P.id_Product) where S.`id_SubCategory` = SubCategory;
		DELETE P from subcategorias S join productos P on(P.id_SubCategory = S.id_SubCategory) where S.`id_SubCategory` = SubCategory;
		DELETE S from  subcategorias S WHERE S.`id_SubCategory` = SubCategory;
    COMMIT; 
    
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectSubCategoryId;
DELIMITER $$
CREATE PROCEDURE sp_SelectSubCategoryId
(
IN SubCategory int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR UNA SUBCATEGORIA' as message;
	END;
    IF (SubCategory = 0 or SubCategory is null)
    THEN
		SELECT 'EL id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT SUB.`id_SubCategory`,CAT.`Nom_Category` ,SUB.`Nom_SubCategory` FROM SUBCATEGORIAS AS SUB
        JOIN CATEGORIA AS CAT
        ON(SUB.`id_Category` = CAT.`id_Categoria`)
        WHERE SUB.`id_SubCategory` = SubCategory;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectSubCategoryXCategory;
DELIMITER $$
CREATE PROCEDURE sp_SelectSubCategoryXCategory
(
IN category nvarchar(50)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(category) = 0 or category = " ")
    THEN
		SELECT 'La category de la Subcategoria no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT_WS(' ',category);
        SET a = ( SELECT count(*) from SUBCATEGORIAS SUB JOIN CATEGORIA CA ON(SUB.id_Category = CA.id_Categoria) WHERE CA.Nom_Category = _consultalike);
        IF (a>0)
        THEN
			SELECT SUB.id_SubCategory,SUB.Nom_SubCategory
            FROM SUBCATEGORIAS SUB JOIN CATEGORIA CA
            ON(SUB.id_Category = CA.id_Categoria)
            WHERE CA.Nom_Category = _consultalike
            GROUP BY SUB.Nom_SubCategory;
        ELSEIF(a=0)THEN 
			SELECT 'No encontrado registro de SubCategorias de la Categoria.' as message;
        END IF;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadSubCategory;
CREATE VIEW v_sCantidadSubCategory
AS SELECT COUNT(*) CANTIDAD_SUBCATEGORY FROM subcategorias;

DROP VIEW IF EXISTS v_sSelectSubCategoria;
CREATE VIEW v_sSelectSubCategoria
AS SELECT SUB.`id_SubCategory`,CAT.`Nom_Category`,SUB.`Nom_SubCategory` FROM
SUBCATEGORIAS AS SUB JOIN CATEGORIA AS CAT ON(SUB.`id_Category` = CAT.`id_Categoria`) LIMIT 30
###########################################################PRODUCTOS#####################################################################
DROP PROCEDURE IF EXISTS sp_InsertProductos;
DELIMITER $$
CREATE PROCEDURE sp_InsertProductos
(
IN NombreProduct nvarchar(100),
IN MarcaProduct nvarchar(100),
IN id_SubCategory int,
IN descripcion nvarchar(500),
IN precio decimal(7,2),
IN stock smallint,
IN unidad nvarchar(10),
IN moneda nvarchar(20),
IN image1 nvarchar(250),
IN image2 nvarchar(250),
IN image3 nvarchar(250), 
IN image4 nvarchar(250), 
IN image5 nvarchar(250), 
IN NDescuento smallint,
IN _Status bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO PRODUCTO' as message;
	END;
    IF (LENGTH(NombreProduct) = 0 or NombreProduct= " ")
    THEN
		SELECT 'El nombre del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(MarcaProduct) = 0 or MarcaProduct= " ")
    THEN
		SELECT 'La marca del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'El id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NDescuento = 0 or NDescuento is null)
    THEN
		SELECT 'El NDescuento del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SET precio = 0;
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SET stock = 0;
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(unidad) = 0 or unidad= " ")
    THEN
		SELECT 'La unidad del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(moneda) = 0 or moneda= " ")
    THEN
		SELECT 'La moneda del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        SELECT 'El Status del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO PRODUCTOS (`Nombre_Product`,`Marca_Product`,`id_SubCategory`,`Descript_Product`,`Precio`,`Stock`,`Unidad`,`Moneda`,`Img1`,`Img2`,`Img3`,`Img4`,`Img5`,`NDescuento`,`_Status`) VALUES (NombreProduct,MarcaProduct,id_SubCategory,descripcion,precio,stock,unidad,moneda,image1,image2,image3,image4,image5,NDescuento,_Status);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateProducto;
DELIMITER $$
CREATE PROCEDURE sp_UpdateProducto
(
IN idproduct int,
IN NombreProduct nvarchar(100),
IN MarcaProduct nvarchar(100),
IN id_SubCategory int,
IN descripcion nvarchar(500),
IN precio decimal(7,2),
IN stock smallint,
IN unidad nvarchar(10),
IN moneda nvarchar(20),
IN image1 nvarchar(250),
IN image2 nvarchar(250),
IN image3 nvarchar(250), 
IN image4 nvarchar(250), 
IN image5 nvarchar(250),
IN NDescuento smallint,
IN _Status bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR UN NUEVO PRODUCTO' as message;
	END;
    IF (LENGTH(NombreProduct) = 0 or NombreProduct= " ")
    THEN
		SELECT 'El nombre del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(MarcaProduct) = 0 or MarcaProduct= " ")
    THEN
		SELECT 'La marca del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
	IF (id_SubCategory = 0 or id_SubCategory is null)
    THEN
		SELECT 'El id de la Subcategoria no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NDescuento = 0 or NDescuento is null)
    THEN
		SELECT 'El NDescuento del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(descripcion) = 0 or descripcion= " ")
    THEN
		SELECT 'La descripción del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (precio < 0 or precio is null)
    THEN
		SET precio = 0;
		SELECT 'El precio del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (stock < 0 or stock is null)
    THEN
		SET stock = 0;
		SELECT 'El stock del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(unidad) = 0 or unidad= " ")
    THEN
		SELECT 'La unidad del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(moneda) = 0 or moneda= " ")
    THEN
		SELECT 'La moneda del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        SELECT 'El Status del producto no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE Productos SET `Nombre_Product`=NombreProduct,`Marca_Product`=MarcaProduct,`id_SubCategory`=id_SubCategory,`Descript_Product`=descripcion,`Precio`=precio,`Stock`=stock,`Unidad`=unidad,`Moneda`=moneda,`Img1`=image1,`Img2`=image2,`Img3`=image3,`Img4`=image4,`Img5`=image5,`NDescuento` = NDescuento ,`_Status` = _Status WHERE `id_Product` = idproduct; 
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
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UN PRODUCTO' as message;
	END;
    IF (idproduct = 0 or idproduct is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Product FROM productos WHERE id_Product= idproduct))
    THEN
		SELECT 'No existente Id Producto para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE CAR from productos P join caracteristicas CAR on(CAR.id_Product = P.id_Product) where P.`id_Product` = idproduct;
		DELETE DE from productos P join descuento DE on(DE.id_Product = P.id_Product) where P.`id_Product` = idproduct;
		DELETE CA from productos P join carritocompra CA on(CA.id_Product = P.id_Product) where P.`id_Product` = idproduct;
		DELETE P FROM productos AS P WHERE P.`id_Product` = idproduct;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectProductoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectProductoId
(
IN idproducto int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR PRODUCTO' as message;
	END;
    IF (idproducto = 0 OR idproducto is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT PD.`id_Product`,PD.Nombre_Product,PD.Marca_Product,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`,CAR.`Caracteristicas_product`
		FROM PRODUCTOS as PD
		JOIN SUBCATEGORIAS as SUB
		ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
		JOIN CATEGORIA AS CAT
		ON(SUB.`id_Category` = CAT.`id_Categoria`)
        JOIN DESCUENTO AS DE
        ON(DE.id_Product = PD.id_Product)
        JOIN caracteristicas AS CAR
        ON(CAR.id_Product = PD.id_Product)
        WHERE PD.`id_Product`=idproducto;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectProdXSubCategory;
DELIMITER $$
CREATE PROCEDURE sp_SelectProdXSubCategory
(
IN subcategory nvarchar(50)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(subcategory) = 0 or subcategory = " ")
    THEN
		SELECT 'La subcategory del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT_WS(' ',subcategory);
        SET a = (select count(*) from productos PRO JOIN SUBCATEGORIAS SUB ON(PRO.id_SubCategory = SUB.id_SubCategory)  WHERE SUB.Nom_SubCategory = _consultalike); 
        IF (a>0)
        THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,PD.Marca_Product,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT
			ON(SUB.`id_Category` = CAT.`id_Categoria`)JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product)
            WHERE SUB.Nom_SubCategory = _consultalike
			GROUP BY PD.Nombre_Product;
		ELSEIF(a=0)THEN 
			SELECT 'No encontrado registro de Productos de la SubCategoria' as message;
        END IF;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectProdXSubCategoryXPrecio;
DELIMITER $$
CREATE PROCEDURE sp_SelectProdXSubCategoryXPrecio
(
IN subcategory nvarchar(50),
IN precio decimal(7,2) 
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(subcategory) = 0 or subcategory = " ")
    THEN
		SELECT 'La subcategory del producto no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT_WS(' ',subcategory);
        SET a = (select count(*) from productos PRO JOIN SUBCATEGORIAS SUB ON(PRO.id_SubCategory = SUB.id_SubCategory)  WHERE SUB.Nom_SubCategory = _consultalike and PRO.Precio = precio); 
        IF (a>0)
        THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,PD.Marca_Product,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT
			ON(SUB.`id_Category` = CAT.`id_Categoria`)JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product)
            WHERE SUB.Nom_SubCategory = _consultalike AND PD.Precio = precio
			GROUP BY PD.Nombre_Product;
		ELSEIF(a=0)THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,PD.Marca_Product,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT
			ON(SUB.`id_Category` = CAT.`id_Categoria`)JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product)
            WHERE SUB.Nom_SubCategory = _consultalike 
			GROUP BY PD.Nombre_Product;
        END IF;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_SelectConsultaProd;
DELIMITER $$
CREATE PROCEDURE sp_SelectConsultaProd
(
IN consulta nvarchar(500)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(500) ;
    DECLARE a INT;
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
        SET a =(select count(*) from productos PRO JOIN SUBCATEGORIAS SUB ON(PRO.id_SubCategory = SUB.id_SubCategory) JOIN CATEGORIA CA ON(SUB.id_Category = CA.id_Categoria) WHERE CA.Nom_Category like _consultalike or SUB.Nom_SubCategory like _consultalike or PRO.Nombre_Product like _consultalike or PRO.Marca_Product like _consultalike or PRO.Descript_Product like _consultalike);
        IF (a>0)
        THEN
			SELECT PD.`id_Product`,PD.Nombre_Product,PD.Marca_Product,PD.`Descript_Product`,PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`,DE.`dscto1`,DE.`dscto2`,DE.`dscto3`,DE.`dscto4`
			FROM PRODUCTOS as PD
			JOIN SUBCATEGORIAS as SUB
			ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
			JOIN CATEGORIA AS CAT 
			ON(SUB.`id_Category` = CAT.`id_Categoria`)
            JOIN DESCUENTO AS DE
			ON(DE.id_Product = PD.id_Product)
            WHERE CAT.Nom_Category like _consultalike OR
			SUB.Nom_SubCategory like _consultalike OR
			PD.Nombre_Product like _consultalike OR
            PD.Marca_Product like _consultalike OR
            PD.Descript_Product like _consultalike 
            limit 30;
		ELSEIF(a=0)THEN 
			SELECT 'SIN SUGERENCIAS' as message;
        END IF;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadProduct;
CREATE VIEW v_sCantidadProduct
AS SELECT COUNT(*) CANTIDAD_PRODUCTOS FROM productos;

DROP VIEW IF EXISTS v_sSelectProducto;
CREATE VIEW v_sSelectProducto
AS 	SELECT PD.`id_Product`,PD.Nombre_Product,PD.Marca_Product,PD.`Descript_Product`,
	PD.`Precio`,PD.`Stock`,PD.`Unidad`,PD.`Moneda`,SUB.`Nom_SubCategory`,CAT.`Nom_Category`,
    PD.`Img1`,PD.`Img2`,PD.`Img3`,PD.`Img4`,PD.`Img5`,PD.`NDescuento`,PD.`_Status`
	FROM PRODUCTOS as PD JOIN SUBCATEGORIAS as SUB ON (PD.`id_SubCategory` = SUB.`id_SubCategory`)
	JOIN CATEGORIA AS CAT ON(SUB.`id_Category` = CAT.`id_Categoria`) JOIN DESCUENTO AS DE ON(DE.id_Product = PD.id_Product) LIMIT 30;
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
IN idCountry int,
IN nomCountry NVARCHAR(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UN PAIS' as message;
	END;
	IF (LENGTH(nomCountry) = 0 or nomCountry = " ")
    THEN
		SELECT 'EL nombre del pais no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
    IF (idCountry = 0 OR idCountry is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
        LEAVE sp;
    END IF;
	START TRANSACTION;
		UPDATE pais SET Uk_Pais = nomCountry WHERE id_Pais = idCountry;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeletePais;
DELIMITER $$
CREATE PROCEDURE sp_DeletePais
(
IN Countryid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UN PAIS' as message;
	END;
    IF (Countryid = 0 OR Countryid is null)
    THEN
		SELECT 'EL id del pais no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;
    IF (not exists(SELECT id_Pais FROM PAIS WHERE id_Pais= Countryid))
    THEN
		SELECT 'No existente Id Pais para el Delete.' as message;
        LEAVE sp;
	END IF;
    START TRANSACTION;
		DELETE D from PAIS P JOIN CIUDAD C ON(C.id_Pais = P.id_Pais) JOIN DIRECCIONES D ON(D.id_Ciudad =C.id_Ciudad) WHERE P.`id_Pais` = Countryid;
		DELETE C from PAIS P JOIN CIUDAD C ON(C.id_Pais = P.id_Pais) WHERE P.`id_Pais` = Countryid;
		DELETE P from PAIS P WHERE P.`id_Pais` = Countryid;
	COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectPaisId;
DELIMITER $$
CREATE PROCEDURE sp_SelectPaisId
(
IN paisid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECIONAR COUNTRY' as message;
	END;
    IF (paisid = 0 or paisid is null)
    THEN
		SELECT 'EL id del country no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT id_Pais,Uk_Pais FROM PAIS WHERE id_Pais = paisid;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadCountry;
CREATE VIEW v_sCantidadCountry AS SELECT COUNT(*) CANTIDAD_COUNTRY FROM pais;

DROP VIEW IF EXISTS v_SelectPais;
CREATE VIEW v_SelectPais
AS SELECT PS.id_Pais,PS.`Uk_Pais` FROM PAIS AS PS LIMIT 30;
###########################################################CIUDAD############################################################################################
DROP PROCEDURE IF EXISTS sp_InsertCiudad;
DELIMITER $$
CREATE PROCEDURE sp_InsertCiudad
(IN idPais int,
IN nomCiudad NVARCHAR(100)
)
sp:BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO CIUDAD' as message;
	END;
    IF ((idPais = 0 or idPais is null))
     THEN 
     	SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;  
	IF (LENGTH(nomCiudad) = 0 or nomCiudad = " ")
    THEN
		 SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.' as message;
         LEAVE sp;
	END IF; 	
	START TRANSACTION;
		INSERT INTO CIUDAD (`id_Pais`,`Uk_Nombre`) VALUES (idPais,nomCiudad);
	COMMIT;    	
END;

DROP PROCEDURE IF EXISTS sp_UpdateCiudad;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCiudad
(
IN idCiudad int,
IN idPais int,
IN nomCiudad NVARCHAR(100)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE UNA CIUDAD' as message;
	END;
	IF (LENGTH(idCiudad) = 0 or idCiudad = " ")
    THEN
		SELECT 'EL id de la Ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
	END IF;
	IF (LENGTH(idPais) = 0 or idPais = " ")
    THEN
		SELECT 'EL id del Pais no puede ser nula o cero..' as message;
        LEAVE sp;
	END IF;
    IF (LENGTH(nomCiudad) = 0 or nomCiudad = " ")
    THEN
		SELECT 'EL nombre de la ciudad no puede ser nula o con valor en blanco.'  as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		UPDATE CIUDAD SET id_Pais = idPais , Uk_Nombre = nomCiudad  WHERE id_Ciudad= idCiudad;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteCiudad;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCiudad
(
IN idCiudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE DELETE UNA CIUDAD' as message;
	END;
    IF (idCiudad = 0 OR idCiudad is null)
    THEN
		SELECT 'EL id de la ciudad no puede ser nula o igual a cero.' as message;
        LEAVE sp;
	END IF;
     IF (not exists(SELECT id_Ciudad FROM CIUDAD WHERE id_Ciudad = idCiudad))
    THEN
		SELECT 'No existente id Ciudad para el Delete.' as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		DELETE D from CIUDAD C JOIN DIRECCIONES D ON(D.id_Ciudad =C.id_Ciudad) WHERE C.`id_Ciudad` = idCiudad;
		DELETE C from CIUDAD C WHERE C.`id_Ciudad` = idCiudad;
	COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCiudadId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCiudadId
(
IN ciudadid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR UNA CIUDAD' as message;
	END;
    IF (ciudadid= 0 or ciudadid  is null)
    THEN
		SELECT 'EL id de la Ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        select C.id_Ciudad,P.Uk_Pais,C.Uk_Nombre
        from ciudad C join pais P on(C.id_Pais = P.id_Pais) WHERE id_Ciudad = ciudadid;
    COMMIT; 
END;
    
DROP PROCEDURE IF EXISTS sp_SelectCiudadesXPais;
DELIMITER $$
CREATE PROCEDURE sp_SelectCiudadesXPais
(
IN NombreCountry nvarchar(100)
)
sp:BEGIN
	DECLARE _consultalike NVARCHAR(100) ;
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA' as message;
	END;
    IF (LENGTH(NombreCountry) = 0 or NombreCountry = " ")
    THEN
		SELECT 'El Nombre del country no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SET _consultalike = CONCAT_WS(' ',NombreCountry);
        SET a = ( select count(*) from ciudad CI JOIN pais P ON(CI.id_Pais = P.id_Pais) WHERE P.Uk_Pais = _consultalike);
        IF (a>0)
        THEN
			SELECT CI.id_Ciudad,CI.Uk_Nombre FROM 
            ciudad CI JOIN pais P ON(CI.id_Pais = P.id_Pais) WHERE P.Uk_Pais =  _consultalike
			GROUP BY CI.Uk_Nombre;
		ELSEIF(a=0)THEN 
			SELECT 'No encontrado registro de Ciudades del Country' as message;
        END IF;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadCity;
CREATE VIEW v_sCantidadCity AS SELECT COUNT(*) CANTIDAD_CITY FROM ciudad;

DROP VIEW IF EXISTS v_sSelectCiudad;
CREATE VIEW v_sSelectCiudad
AS SELECT CIU.`id_Ciudad`,PS.`Uk_Pais`,CIU.`Uk_Nombre` FROM CIUDAD AS CIU JOIN PAIS AS PS ON(CIU.`id_Pais` = PS.`id_Pais`) LIMIT 30
###############################################CLIENTE###############################################################################
DROP PROCEDURE IF EXISTS sp_InsertCliente;
DELIMITER $$
CREATE PROCEDURE sp_InsertCliente
(
IN Nombre_Cliente nvarchar(250),
IN Apellido_Cliente nvarchar(250),
IN Edad_Cliente smallint,
IN Correo nvarchar(250),
IN Contacto char(20),
IN Img nvarchar(250) 
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
		INSERT INTO CLIENTE(`Nombre_Cliente`,`Apellido_Cliente`,`Edad_Cliente`,`Correo`,`Contacto`,`Img`) VALUES (Nombre_Cliente,Apellido_Cliente,Edad_Cliente,Correo,Contacto,Img);
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
IN Contacto char(20),
IN Img nvarchar(250) 
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
		UPDATE CLIENTE SET `Nombre_Cliente`=NombreCliente,`Apellido_Cliente`=ApellidoCliente,`Edad_Cliente`= EdadCliente,`Correo`= Correo,`Contacto`= Contacto,`Img` = Img WHERE `id_Cliente` = idCliente;
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
			DELETE S FROM CLIENTE C JOIN PEDIDO P ON(P.id_Cliente= C.id_Cliente) JOIN CARRITOCOMPRA S ON(S.N_Pedido = P.N_Pedido) WHERE C.id_Cliente = idCliente;
			DELETE P FROM CLIENTE C JOIN PEDIDO P ON(P.id_Cliente= C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE M FROM CLIENTE C JOIN MEDIOPAGO M ON(M.id_Cliente= C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE U FROM CLIENTE C JOIN USER_ U ON(U.id_Cliente = C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE D FROM CLIENTE C JOIN DIRECCIONES D ON(D.id_Cliente = C.id_Cliente) WHERE C.id_Cliente = idCliente;
			DELETE C FROM CLIENTE C WHERE C.id_Cliente = idCliente;
	COMMIT;
END;
set SQL_SAFE_UPDATES = 0;

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
        SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL.`Edad_Cliente`,CL.`Correo`,CL.`Contacto`,CL.`Img`
        FROM CLIENTE AS CL
        WHERE CL.`id_Cliente` = idCliente;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sCantidadClients;
CREATE VIEW v_sCantidadClients AS SELECT COUNT(*) CANTIDAD_CLIENTE FROM cliente;

DROP VIEW IF EXISTS v_sSelectCliente;
CREATE VIEW v_sSelectCliente
AS 	SELECT CL.`id_Cliente`,CL.`Nombre_Cliente`,CL.`Apellido_Cliente`,CL.`Edad_Cliente`,
	CL.`Correo`,CL.`Contacto`,CL.Img FROM CLIENTE AS CL	LIMIT 30	
#################################################################### DIRECCIONES ############################################################################
DROP PROCEDURE IF EXISTS sp_InsertDireccion;
DELIMITER $$
CREATE PROCEDURE sp_InsertDireccion
(
IN idCliente int,
IN Direccion nvarchar(50),
IN idCiudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UNA NUEVA DIRECCIÓN' as message;
	END;
	IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Direccion) = 0 or Direccion= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idCiudad = 0 or idCiudad is null)
    THEN
		SELECT 'El id de la ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO DIRECCIONES (`id_Cliente`,`Direccion`,`id_Ciudad`) VALUES (idCliente,Direccion,idCiudad);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateDireccion;
DELIMITER $$
CREATE PROCEDURE sp_UpdateDireccion
(
IN idDirec int,
IN idCliente int,
IN Direccion nvarchar(50),
IN idCiudad int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE LA DIRECCIÓN' as message;
	END;
    IF (idDirec = 0 or idDirec is null)
    THEN
		SELECT 'El id de la direccion no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
	IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Direccion) = 0 or Direccion= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idCiudad = 0 or idCiudad is null)
    THEN
		SELECT 'El id de la ciudad no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE DIRECCIONES SET `id_Cliente` = idCliente ,`Direccion` = Direccion ,`id_Ciudad` = idCiudad  WHERE `id_Direct` = idDirec; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteDireccion;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDireccion
(
IN idDirect int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DELETE UNA DIRECCION' as message;
	END;
    IF (idDirect = 0 or idDirect is null)
    THEN
		SELECT 'EL id de la direccion no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Direct FROM direcciones WHERE id_Direct = idDirect))
    THEN
		SELECT 'No existente id Direccion para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM DIRECCIONES WHERE `id_Direct` = idDirect ;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectDireccionId;
DELIMITER $$
CREATE PROCEDURE sp_SelectDireccionId
(
IN idDirect int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR DIRECCION' as message;
	END;
    IF (idDirect = 0 or idDirect is null)
    THEN
		SELECT 'EL id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT DIR.`id_Direct`,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) AS Cliente,DIR.`Direccion`,CIU.`Uk_Nombre`,PS.`Uk_Pais` 
		FROM DIRECCIONES as DIR
		JOIN CLIENTE as CLI
		ON (DIR.`id_Cliente` = CLI.`id_Cliente`)
		JOIN CIUDAD AS CIU
		ON(DIR.`id_Ciudad` = CIU.`id_Ciudad`)
		JOIN PAIS AS PS
		ON(CIU.id_Pais  = PS.`id_Pais`)
        WHERE DIR.`id_Direct` = idDirect ;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectDireccion;
CREATE VIEW v_sSelectDireccion
AS
	SELECT DIR.`id_Direct`,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) AS Cliente,
    DIR.`Direccion`,CIU.`Uk_Nombre` Ciudad,PS.`Uk_Pais` Pais
	FROM DIRECCIONES as DIR JOIN CLIENTE as CLI ON (DIR.`id_Cliente` = CLI.`id_Cliente`)
	JOIN CIUDAD AS CIU ON(DIR.`id_Ciudad` = CIU.`id_Ciudad`) JOIN PAIS AS PS
	ON(CIU.id_Pais  = PS.`id_Pais`) LIMIT 30;
    
DROP VIEW IF EXISTS v_sCantidadDireccion;
CREATE VIEW v_sCantidadDireccion
AS SELECT COUNT(*) CANTIDAD_DIRECCION FROM direcciones;
###################################################################ROL##############################################################################
DROP PROCEDURE IF EXISTS sp_InsertRoll;
DELIMITER $$
CREATE PROCEDURE sp_InsertRoll
(
IN DescriptRoll nvarchar(50),
IN Value_ char(6)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN NUEVO ROL' as message;
	END;
    IF (LENGTH(DescriptRoll) = 0 or DescriptRoll= " ")
    THEN
		SELECT 'La descripcion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Value_) = 0 or Value_= " ")
    THEN
		SELECT 'El Valor no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO ROLL (`Descript_Roll`,`_Value`) VALUES (DescriptRoll,Value_);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateRoll;
DELIMITER $$
CREATE PROCEDURE sp_UpdateRoll
(
IN idRoll int,
IN DescriptRoll nvarchar(50),
IN Value_ char(6)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE UPDATE EL ROLL' as message;
	END;
    IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'El id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(DescriptRoll) = 0 or DescriptRoll=" ")
    THEN
		SELECT 'La descripcion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Value_) = 0 or Value_= " ")
    THEN
		SELECT 'El Valor no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE ROLL SET `Descript_Roll` = DescriptRoll,`_Value` = Value_  WHERE `id_Roll` = idRoll; 
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_DeleteRoll;
DELIMITER $$
CREATE PROCEDURE sp_DeleteRoll
(
IN idRoll int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR UN ROL' as message;
	END;
    IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'EL id del rol no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Roll FROM ROLL WHERE id_Roll = idRoll))
    THEN
		SELECT 'No existente id Roll.' as message;
        LEAVE sp;
	END IF;
	START TRANSACTION;
		DELETE U FROM ROLL R JOIN USER_ U ON(U.id_Roll = R.id_Roll) WHERE R.id_Roll = idRoll;
		DELETE R FROM ROLL R WHERE R.`id_Roll` = idRoll;
	COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectWhereRollId;
DELIMITER $$
CREATE PROCEDURE sp_SelectWhereRollId
(
IN idRoll int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR ROL' as message;
	END;
    IF (idRoll = 0 or idRoll is null)
    THEN
		SELECT 'EL id del roll no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT RL.id_Roll,RL.Descript_Roll,RL._Value
        FROM ROLL as RL
        WHERE RL.`id_Roll` = idRoll;
    COMMIT;     
END;

CREATE VIEW v_sCantidadRol
AS SELECT COUNT(*) CANTIDAD_ROL FROM ROLL;

DROP VIEW IF EXISTS v_sSelectRoll;
CREATE VIEW v_sSelectRoll
AS SELECT RL.id_Roll,RL.Descript_Roll,RL._Value FROM ROLL as RL LIMIT 30;
####################################################################USER###################################################################
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
    IF (_Status < 0 or _Status is null)
    THEN
		SET _Status = 0;
        SELECT 'El Status del User no puede ser nula o menor a cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Cliente FROM user_ WHERE id_Cliente = idCliente))
    THEN
		SELECT 'Cliente Existente en el User .' as message;
        LEAVE sp;
	END IF;
    IF (exists(SELECT _Username FROM user_ WHERE _Username = Username))
    THEN
		SELECT 'Username Existente .' as message;
        LEAVE sp;
	END IF;
    IF (LENGTH(_Password)<7)
    THEN
		SELECT 'Password debe contener 7 caracteres .' as message;
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
    IF (LENGTH(_Password) = 0 or _Password = " ")
    THEN
		SELECT 'El password no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(_Password)<7)
    THEN
		SELECT 'Password debe contener 7 caracteres .' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		UPDATE USER_ SET `_Password` = _Password  WHERE `id_Cliente` = idCliente;
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
	IF (not exists(SELECT id_Cliente FROM User_ WHERE id_Cliente =  idCliente))
    THEN
		SELECT 'No existente id User para el Delete.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM USER_ WHERE `id_Cliente` = idCliente;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectUserId;
DELIMITER $$
CREATE PROCEDURE sp_SelectUserId
(
IN idCliente int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE REALIZAR LA BUSQUEDA USER' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT CLI.id_Cliente,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) Cliente ,Descript_Roll,US._Username,US._Password,US._Status
		FROM USER_ as US
		JOIN CLIENTE as CLI
		ON (US.`id_Cliente` = CLI.`id_Cliente`)
		JOIN ROLL AS RL
		ON(US.`id_Cliente`= RL.`id_Roll`)
        WHERE  CLI.`id_Cliente` = idCliente;
    COMMIT; 
END;

CREATE VIEW v_sCantidadUser
AS SELECT COUNT(*) CANTIDAD_USER FROM USER_;

DROP VIEW IF EXISTS v_sSelectUser;
CREATE VIEW v_sSelectuser
AS
	SELECT CLI.id_Cliente,CONCAT_WS(' ',CLI.Nombre_Cliente,CLI.Apellido_Cliente) Cliente ,RL.Descript_Roll,US._Username,US._Password,US._Status
	FROM USER_ as US JOIN CLIENTE as CLI ON (US.`id_Cliente` = CLI.`id_Cliente`) JOIN ROLL AS RL
	ON(US.`id_Cliente`= RL.`id_Roll`) LIMIT 30;
##############################################################MEDIODEPAGO###############################################################
DROP PROCEDURE IF EXISTS sp_InsertMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_InsertMedioPago
(
IN idCliente int,
IN MedioPago nvarchar(250),
IN NumeroTarjeta char(50),
IN CVV char(3),
IN FechaVencimiento date
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR UN MEDIO DE PAGO' as message;
	END;
    IF (idCliente = 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(MedioPago) = 0 or MedioPago= " ")
    THEN
		SELECT 'El medio de pago no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NumeroTarjeta) = 0 or NumeroTarjeta= " ")
    THEN
		SELECT 'El numero de tarjeta no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(CVV) = 0 or CVV = " ")
    THEN
		SELECT 'El CVV no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		INSERT INTO MEDIOPAGO (`id_Cliente`,`MedioPago`,`NumeroTarjeta`,`CVV`,`FechaVencimiento`) VALUES (idCliente,MedioPago,NumeroTarjeta,CVV,FechaVencimiento);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_UpdateMedioPago
(
IN idMedioPago int,
IN NumeroTarjeta char(50),
IN CVV char(3),
IN FechaVencimiento date
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL PEDIO DE PAGO' as message;
	END;
    IF (idMedioPago= 0 or idMedioPago is null)
    THEN
		SELECT 'El id del medio de pago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(NumeroTarjeta) = 0 or NumeroTarjeta= " ")
    THEN
		SELECT 'El numero de tarjeta no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(CVV) = 0 or CVV = " ")
    THEN
		SELECT 'El CVV no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE MEDIOPAGO SET `NumeroTarjeta`=NumeroTarjeta,`CVV` = CVV,`FechaVencimiento`=FechaVencimiento  WHERE `id_MedioPago` = idMedioPago;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteMedioPago;
DELIMITER $$
CREATE PROCEDURE sp_DeleteMedioPago
(
IN idMedioPago int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR MEDIO DE PAGO' as message;
	END;
    IF (idMedioPago= 0 or idMedioPago is null)
    THEN
		SELECT 'El id del medio de pago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_MedioPago FROM mediopago WHERE id_MedioPago =  idMedioPago))
    THEN
		SELECT 'No existente id MedioPago.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM MEDIOPAGO WHERE `id_MedioPago` = idMedioPago ;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectMedioPagoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectMedioPagoId
(
IN pagoid int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE BUSCAR' as message;
	END;
    IF (pagoid= 0 or pagoid  is null)
    THEN
		SELECT 'EL id del mediopago no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT M.id_MedioPago,C.Nombre_Cliente,C.Apellido_Cliente,C.Edad_Cliente,C.Correo,C.Contacto,M.MedioPago,M.NumeroTarjeta,M.CVV,M.FechaVencimiento
        FROM mediopago M JOIN cliente C on(M.id_Cliente = C.id_Cliente)
        where M.id_MedioPago = pagoid;
    COMMIT; 
END;

CREATE VIEW v_sCantidadPayment
AS SELECT COUNT(*) CANTIDAD_PAYMENT FROM  mediopago;

DROP VIEW IF EXISTS v_sSelectMedioPago;
CREATE VIEW v_sSelectMedioPago
AS SELECT M.id_MedioPago,C.Nombre_Cliente,C.Apellido_Cliente,C.Edad_Cliente,
		C.Correo,C.Contacto,M.MedioPago,M.NumeroTarjeta,M.CVV,M.FechaVencimiento
		FROM mediopago M JOIN cliente C on(M.id_Cliente = C.id_Cliente) LIMIT 30;
#################################################PEDIDO#################################################################
DROP PROCEDURE IF EXISTS sp_InsertPedido;
DELIMITER $$
CREATE PROCEDURE sp_InsertPedido
(
IN idCliente smallint,
IN NPedido smallint,
IN FeEmision date,
IN EmpEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Descuento decimal(7,2),
IN DiretEnvio nvarchar(100),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Statu bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR PEDIDO' as message;
	END;
    IF (idCliente= 0 or idCliente is null)
    THEN
		SELECT 'El id del cliente no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF  (char_length(FeEmision )=0 or isnull(FeEmision))
    THEN
		SELECT 'La fecha de Emision no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(EmpEnvio) = 0 or EmpEnvio= " ")
    THEN
		SELECT 'La empresa no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (SubTotal = 0 or SubTotal is null)
    THEN
		SELECT 'El subtotal no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(DiretEnvio) = 0 or DiretEnvio= " ")
    THEN
		SELECT 'La direccion no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (Total= 0 or Total is null)
    THEN
		SELECT 'El total no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (TotalPagar= 0 or TotalPagar is null)
    THEN
		SELECT 'El total a pagar no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El pedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
	END IF;
	IF (Statu< 0 or Statu is null)
    THEN
		SET Statu = 0;
        LEAVE sp;
    END IF;
    IF (Descuento= 0 or Descuento is null)
    THEN
		SELECT 'El descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT N_Pedido FROM pedido WHERE N_Pedido =  NPedido))
    THEN
		SELECT 'Existente NPedido.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		INSERT INTO PEDIDO(id_Cliente,N_Pedido,FechaEmision,Emp_Envio,Sub_Total,Descuento,Diret_Envio,Total,TotalPagar,_Status)VALUES(idCliente,NPedido,FeEmision,EmpEnvio,SubTotal,Descuento,DiretEnvio,Total,TotalPagar,Statu);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdatePedido;
DELIMITER $$
CREATE PROCEDURE sp_UpdatePedido
(
IN NPedido smallint,
IN FeEmision date,
IN EmpEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Descuento decimal(7,2),
IN DiretEnvio nvarchar(100),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Statu bool
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL PEDIDO' as message;
	END;
 	START TRANSACTION;
		UPDATE pedido SET `FechaEmision` = FeEmision,`Emp_Envio`= EmpEnvio,`Sub_Total` = SubTotal,`Descuento`=Descuento,`Diret_Envio` = DiretEnvio,`Total` = Total ,`TotalPagar` = TotalPagar,`_Status` = Statu WHERE `N_Pedido` = NPedido;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeletePedido;
DELIMITER $$
CREATE PROCEDURE sp_DeletePedido
(
IN NPedido smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR PEDIDO' as message;
	END;
    IF (NPedido= 0 or NPedido is null)
    THEN
		SELECT 'El N_Pedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Cliente FROM pedido WHERE N_Pedido = NPedido))
    THEN
		SELECT 'No existente N_Pedido.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE C FROM pedido P JOIN carritocompra C on(C.N_Pedido = P.N_Pedido) WHERE P.N_Pedido = NPedido;
		DELETE P FROM pedido P WHERE P.N_Pedido = NPedido;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectPedidoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectPedidoId
(
IN NPedido smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE BUSCAR' as message;
	END;
    IF (NPedido= 0 or NPedido is null)
    THEN
		SELECT 'EL NPedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT C.id_Cliente,C.Nombre_Cliente,C.Apellido_Cliente,C.Edad_Cliente,C.Correo,C.Contacto,P.N_Pedido,
        P.FechaEmision,P.Sub_Total,P.Total,P.TotalPagar,P.Emp_Envio,P.Diret_Envio,P._Status
        FROM PEDIDO P JOIN CLIENTE C ON(P.id_Cliente = C.id_Cliente)
        where P.N_Pedido = NPedido;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectPedido;
CREATE VIEW v_sSelectPedido
AS SELECT C.id_Cliente,C.Nombre_Cliente,C.Apellido_Cliente,C.Edad_Cliente,C.Correo,C.Contacto,P.N_Pedido,
        P.FechaEmision,P.Sub_Total,P.Total,P.TotalPagar,P.Emp_Envio,P.Diret_Envio,P._Status 
        FROM PEDIDO P JOIN CLIENTE C ON(P.id_Cliente = C.id_Cliente)  LIMIT 30
        
CREATE VIEW v_sCantidadPedido
AS SELECT COUNT(*) CANTIDAD_PEDIDO FROM  PEDIDO;
################################################################CARRITOCOMPRA############################################
DROP PROCEDURE IF EXISTS sp_InsertCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_InsertCarritoCompra
(
IN NPedido smallint,
IN idProduct smallint,
IN CarCantidad decimal(7,2)
)
sp:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INGRESAR AL CARRITO DE COMPRA' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idProduct = 0 or idProduct is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (CarCantidad = 0 or CarCantidad is null)
    THEN
		SELECT 'La Cantidad del CarritoCompra no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Product FROM CARRITOCOMPRA WHERE id_Product= idProduct and N_Pedido=NPedido))
    THEN
		SELECT 'Existente en el Carrito Compra.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		INSERT INTO CARRITOCOMPRA(N_Pedido,id_Product,Car_Cantidad)VALUES(NPedido,idProduct,CarCantidad);
    COMMIT; 
END;
DROP PROCEDURE IF EXISTS sp_UpdateCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCarritoCompra
(
IN NPedido smallint,
IN idProduct smallint,
IN CarCantidad decimal(7,2)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL CARRITO DE COMPRA' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idProduct = 0 or idProduct is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (CarCantidad = 0 or CarCantidad is null)
    THEN
		SELECT 'La Cantidad del CarritoCompra no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE carritocompra SET `Car_Cantidad` = CarCantidad WHERE `id_Product` = idProduct and `N_Pedido` = NPedido ;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCarritoCompra
(
IN NPedido smallint,
IN idProduct smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR CARRITO DE COMPRA' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (idProduct = 0 or idProduct is null)
    THEN
		SELECT 'El id del producto no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT * FROM carritocompra WHERE id_Product =  idProduct and N_Pedido = NPedido))
    THEN
		SELECT 'No existente en el carrito de compra.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM carritocompra WHERE `id_Product` = idProduct and N_Pedido = NPedido ;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCarritoCompra;
DELIMITER $$
CREATE PROCEDURE sp_SelectCarritoCompra
(
IN NPedido int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE BUSCAR' as message;
	END;
    IF (NPedido = 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
        SELECT C.N_Pedido,P.Nombre_Product,P.Marca_Product,P.Descript_Product,P.Precio,P.Img1,C.Car_Cantidad
		FROM CARRITOCOMPRA C JOIN PRODUCTOS P ON(C.id_Product = P.id_Product) join descuento as D
		on(P.id_Product=D.id_Product) JOIN PEDIDO AS PA
		on(PA.N_Pedido = C.N_Pedido)
        where C.N_Pedido = NPedido;
    COMMIT; 
END;
        
DROP PROCEDURE IF EXISTS v_sSelectCarritoCompra;
DELIMITER $$
CREATE PROCEDURE v_sSelectCarritoCompra
()
sp:BEGIN
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR' as message;
	END;
 	START TRANSACTION;
        SET a = (select count(*) from CARRITOCOMPRA); 
        IF (a>0)
        THEN
			SELECT C.N_Pedido,P.Nombre_Product,P.Marca_Product,P.Descript_Product,P.Precio,P.Img1,C.Car_Cantidad
			FROM CARRITOCOMPRA C JOIN PRODUCTOS P ON(C.id_Product = P.id_Product) join descuento as D
			on(P.id_Product=D.id_Product) JOIN PEDIDO AS PA
            on(PA.N_Pedido = C.N_Pedido);
		ELSEIF(a=0)THEN 
			SELECT 'No contiene producto' as message;
        END IF;
    COMMIT; 
END;
#################################HistorialdeCompra###############################################################
DROP PROCEDURE IF EXISTS sp_InsertHistorialCompra
DELIMITER $$
CREATE PROCEDURE sp_InsertHistorialCompra
(
IN NPedido smallint,
IN Cliente nvarchar(100),
IN FeEmision date,
IN DirecEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Descuento decimal(7,2)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR HISTORIAL PEDIDO' as message;
	END;
    IF (exists(SELECT N_Pedido FROM historialcompra WHERE N_Pedido = NPedido ))
    THEN
		SELECT 'Ya existente N_Pedido.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		INSERT INTO historialcompra(N_Pedido,Cliente,FechaEmision,DirecEnvio,SubTotal,Total,TotalPagar,Descuento)VALUES(NPedido,Cliente,FeEmision,DirecEnvio,SubTotal,Total,TotalPagar,Descuento);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateHistorialCompra;
DELIMITER $$
CREATE PROCEDURE sp_UpdateHistorialCompra
(
IN NPedido smallint,
IN Clien nvarchar(100),
IN FeEmision date,
IN DirecEnvio nvarchar(100),
IN SubTotal decimal(7,2),
IN Total smallint,
IN TotalPagar decimal(7,2),
IN Descuento decimal(7,2)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL HISTORIAL PEDIDO' as message;
	END;
 	START TRANSACTION;
		UPDATE historialcompra SET Cliente=Clien,FechaEmision=FeEmision,DirecEnvio= DirecEnvio,SubTotal=SubTotal,Total=Total,TotalPagar=TotalPagar,Descuento=Descuento WHERE N_Pedido = NPedido;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteHistorial;
DELIMITER $$
CREATE PROCEDURE sp_DeleteHistorial
(
IN NPedido smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR HISTORIAL PEDIDO' as message;
	END;
    IF (NPedido= 0 or NPedido is null)
    THEN
		SELECT 'El NPedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT N_Pedido FROM historialcompra WHERE N_Pedido =  NPedido))
    THEN
		SELECT 'No existente id N_PEDIDO.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM historialcompra WHERE N_Pedido = NPedido;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectHistorialId;
DELIMITER $$
CREATE PROCEDURE sp_SelectHistorialId
(
IN NPedido int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR HISTORIAL' as message;
	END;
    IF (NPedido= 0 or NPedido  is null)
    THEN
		SELECT 'EL NPedido no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT H.N_Pedido,H.Cliente,H.FechaEmision,H.DirecEnvio,H.SubTotal,H.Total,H.TotalPagar
		FROM HISTORIALCOMPRA H 
        where H.N_Pedido = NPedido;
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS v_sSelectHistorial;
DELIMITER $$
CREATE PROCEDURE v_sSelectHistorial
()
sp:BEGIN
    DECLARE a INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR' as message;
	END;
 	START TRANSACTION;
        SET a = (select count(*) from historialcompra); 
        IF (a>0)
        THEN
			SELECT H.N_Pedido,H.Cliente,H.FechaEmision,H.DirecEnvio,H.SubTotal,H.Total,H.TotalPagar
			FROM HISTORIALCOMPRA H ;
		ELSEIF(a=0)THEN 
			SELECT 'No contiene compras' as message;
        END IF;
    COMMIT; 
END;
##################################################DESCUENTO############################################################
DROP PROCEDURE IF EXISTS sp_InsertDescuento
DELIMITER $$
CREATE PROCEDURE sp_InsertDescuento
(
IN idProduct smallint,
IN dscto1 smallint,
IN dscto2 smallint,
IN dscto3 smallint,
IN dscto4 smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR DESCUENTO' as message;
	END;
    IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto1= 0 or dscto1 is null)
    THEN
		SELECT 'El dscto1 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto2= 0 or dscto2 is null)
    THEN
		SELECT 'El dscto2 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto3= 0 or dscto3 is null)
    THEN
		SELECT 'El dscto3 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto4= 0 or dscto4 is null)
    THEN
		SELECT 'El dscto4 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Product FROM descuento  WHERE id_Product = idProduct))
    THEN
		SELECT '  Descuento Existente del Producto.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		INSERT INTO descuento(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(idProduct,dscto1,dscto2,dscto3,dscto4);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateDescuento;
DELIMITER $$
CREATE PROCEDURE sp_UpdateDescuento
(
IN idProduct smallint,
IN dscto1 float,
IN dscto2 float,
IN dscto3 float,
IN dscto4 float
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR EL DESCUENTO' as message;
	END;
     IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto de descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto1= 0 or dscto1 is null)
    THEN
		SELECT 'El dscto1 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto2= 0 or dscto2 is null)
    THEN
		SELECT 'El dscto2 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto3= 0 or dscto3 is null)
    THEN
		SELECT 'El dscto3 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (dscto4= 0 or dscto4 is null)
    THEN
		SELECT 'El dscto4 del descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE descuento SET dscto1=dscto1 ,dscto2=dscto2 ,dscto3=dscto3,dscto4=dscto4  WHERE id_Product = idProduct ;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteDescuento;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDescuento
(
IN idProduct smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR DESCUENTO' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Product FROM DESCUENTO WHERE id_Product =  idProduct))
    THEN
		SELECT 'No existente IdProducto del Descuento.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM DESCUENTO WHERE id_Product = idProduct;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectDescuentoId;
DELIMITER $$
CREATE PROCEDURE sp_SelectDescuentoId
(
IN idProduct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR DESCUENTO' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de descuento no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT P.id_Product,P.Nombre_Product,P.Marca_Product,S.Nom_SubCategory,CA.Nom_Category,D.dscto1,D.dscto2,D.dscto3,D.dscto4
        FROM DESCUENTO D JOIN 
        PRODUCTOS P ON(P.id_Product =D.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA
        ON(CA.id_Categoria = S.id_Category)
        where D.id_Product = idProduct;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectDescuento;
CREATE VIEW v_sSelectDescuento
AS
		SELECT P.id_Product,P.Nombre_Product,P.Marca_Product,S.Nom_SubCategory,CA.Nom_Category,D.dscto1,D.dscto2,D.dscto3,D.dscto4
        FROM DESCUENTO D JOIN PRODUCTOS P ON(P.id_Product =D.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA ON(CA.id_Categoria = S.id_Category)LIMIT 30
#####################################################CARACTERISTICAS############################################################################
DROP PROCEDURE IF EXISTS sp_InsertCaracteristicas
DELIMITER $$
CREATE PROCEDURE sp_InsertCaracteristicas
(
IN idProduct smallint,
IN Caracteristicas nvarchar(1500)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE INSERTAR CARACTERISTICAS' as message;
	END;
    IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Caracteristicas) = 0 or Caracteristicas= " ")
    THEN
		SELECT 'La caracteristicas no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
    IF (exists(SELECT id_Product FROM caracteristicas WHERE id_Product = idProduct))
    THEN
		SELECT 'Caracteristicas Existente del Producto.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		INSERT INTO caracteristicas(id_Product,Caracteristicas_product)VALUES(idProduct,Caracteristicas);
    COMMIT; 
END;

DROP PROCEDURE IF EXISTS sp_UpdateCaracteristicas;
DELIMITER $$
CREATE PROCEDURE sp_UpdateCaracteristicas
(
IN idProduct smallint,
IN Caracteristicas nvarchar(1500)
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ACTUALIZAR LA CARACTERISTICASS' as message;
	END;
    IF (idProduct= 0 or idProduct is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (LENGTH(Caracteristicas) = 0 or Caracteristicas= " ")
    THEN
		SELECT 'La caracteristicas no puede ser nula o con valor en blanco.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		UPDATE caracteristicas SET Caracteristicas_product=Caracteristicas  WHERE id_Product = idProduct ;
    COMMIT;
END;

DROP PROCEDURE IF EXISTS sp_DeleteCaracteristicas;
DELIMITER $$
CREATE PROCEDURE sp_DeleteCaracteristicas
(
IN idProduct smallint
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE ELIMINAR CARACTERISTICAS' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
    IF (not exists(SELECT id_Product FROM caracteristicas WHERE id_Product =  idProduct))
    THEN
		SELECT 'No existente IdProducto de la Caracteristicas.' as message;
        LEAVE sp;
	END IF;
 	START TRANSACTION;
		DELETE FROM caracteristicas WHERE id_Product = idProduct;
    COMMIT; 
END;
set SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS sp_SelectCaracteristicasId;
DELIMITER $$
CREATE PROCEDURE sp_SelectCaracteristicasId
(
IN idProduct int
)
sp:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		rollback;
		SELECT 'A OCURRIDO UN ERROR AL TRATAR DE SELECCIONAR CARACTERISTICAS' as message;
	END;
    IF (idProduct = 0 or idProduct  is null)
    THEN
		SELECT 'El id del producto de la caracteristicas no puede ser nula o cero.' as message;
        LEAVE sp;
    END IF;
 	START TRANSACTION;
		SELECT P.id_Product,C.Caracteristicas_product
        FROM CARACTERISTICAS C JOIN 
        PRODUCTOS P ON(P.id_Product =C.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA
        ON(CA.id_Categoria = S.id_Category)
        where C.id_Product = idProduct;
    COMMIT; 
END;

DROP VIEW IF EXISTS v_sSelectCaracteristicas;
CREATE VIEW v_sSelectCaracteristicas
AS
		SELECT P.id_Product,C.Caracteristicas_product
        FROM CARACTERISTICAS C JOIN  PRODUCTOS P ON(P.id_Product =C.id_Product) JOIN SUBCATEGORIAS S
        ON(S.id_SubCategory = P.id_SubCategory) JOIN CATEGORIA CA ON(CA.id_Categoria = S.id_Category)LIMIT 30
####################################################################################################################
CALL sp_InsertCategoria('Computación')
CALL sp_InsertCategoria('ElectroHogar')
CALL sp_InsertCategoria('Moda Mujer')
CALL sp_InsertCategoria('Moda Hombre')
CALL sp_InsertSubCategoria(1,'Tablets')
CALL sp_InsertSubCategoria(1,'Laptops')
CALL sp_InsertSubCategoria(4,'Poleras')
CALL sp_InsertProductos('Laptop Huawei MateBook D15 15.6 FHD IPS i5-10210U 512GB SSD 8GB RAM Windows Home + Antivirus','Huawei',2,'Antivirus Norton de Regalo - se enviará un correo electrónico con el código para activar la licencia de 60 días totalmente gratis. Condiciones: la activación debe ser durante los 7 primeros días de la recepción del correo, caso contrario se inactivará y se considerará en desuso.',2399.00,100,'UND','SOL','imagen1.png','imagen2.png','imagen3.png','imagen4.png','imagen5.png',1,1)
CALL sp_InsertProductos('HP 15.6" FHD, Ryzen 5-5500U, 8GB RAM, 256GB SSD, SPRUCE BLUE, Windows 11','HP',2,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home',1899.00,100,'UND','SOL','imagen1.png','imagen2.png','imagen3.png','imagen4.png','imagen5.png',1,1)
CALL sp_InsertProductos('Cortavientos impermeable Hombre - Ciclismo - Ropa Deportiva - Alpha Fit','Alpha Fit ',3,'Tejido impermeable: Te mantendrá seco bajo la lluvia.Forro interno de malla: Te mantendrá abrigado durante el frío.Ideal para entrenarEl modelo mide 1.72m, pesa 74kg y usa talla M',98.10,100,'UND','SOL','imagen1.png','imagen2.png','imagen3.png','imagen4.png','imagen5.png',1,1)
CALL sp_InsertPais('Perú')
CALL sp_InsertPais('Argentina')
CALL sp_InsertCiudad(1,'Arequipa')
CALL sp_InsertCiudad(1,'Trujillo')
CALL sp_InsertCiudad(2,'Rosario')
CALL sp_InsertCliente('Maria Juana','Oscar Jara',30,'Jara1233@gmail.com',956412374,'imagen.png')
CALL sp_InsertCliente('Marco Jerson','Quispe Mamani',40,'123Quispe@gmail.com',964578941,'imagen.png')
CALL sp_InsertDireccion(1,'Calle Palmeras 123',2)
CALL sp_InsertDireccion(2,'Calle Pinos 45',3)
CALL sp_InsertRoll('Administrador','ADM')
CALL sp_InsertRoll('Usuario','USU')
CALL sp_InsertUser(1,1,'Mallqui123','jjpld6pl9yiy',1)
CALL sp_InsertUser(2,2,'Quispe123','jlosertiser123',1)
CALL sp_InsertMedioPago(1,'Visa','1234-4564-7894-4561','456','2027-01-31')
SELECT * FROM PEDIDO
CALL sp_InsertPedido(1,1,'2022-01-31','EmpresaOlx',2399,1.199,'Calle Palmeras 123',1,1.200,1)
CALL sp_InsertCarritoCompra(1,1,1)
INSERT INTO DESCUENTO(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(1,50,10,15,20)
INSERT INTO DESCUENTO(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(2,80,30,10,30)
INSERT INTO DESCUENTO(id_Product,dscto1,dscto2,dscto3,dscto4)VALUES(3,60,20,40,30)
CALL sp_InsertCaracteristicas(1,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home')
CALL sp_InsertCaracteristicas(2,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home')
CALL sp_InsertCaracteristicas(3,'Windows 11 with 6-core AMD Ryzen 5 5500U ProcessorFast charge laptop computer for school or home')
CALL sp_InsertHistorialCompra(1,'Torres Miguel','2022-06-04','DirecEnvio',10000,1,1000,10)
#################################################################################################################################
CALL sp_SelectProdXSubCategory('Laptops')
CALL sp_SelectProdXSubCategoryXPrecio('Laptops',1899)
cALL sp_SelectConsultaProd('Huawei')
CALL sp_SelectCiudadesXPais('Perú')
#https://www.linio.com.pe/c/portatiles/laptops?price=1000-37539
#https://www.coolbox.pe/radiosfsfssfsfsddffsfsfsfdsf?_q=radiosfsfssfsfsddffsfsfsfdsf&map=ft

