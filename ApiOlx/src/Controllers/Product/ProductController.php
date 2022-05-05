<?php namespace App\Controllers\Product;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
USE Psr\Http\Message\StreamInterface;
USE App\Entity\Producto;
USE \Exception;

class ProductController extends BaseController {
    public function getProduct($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sSelectProducto");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getProductById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "call sp_SelectProductoId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getProductsBySubCategory($request,$response,$args){
        try{
            $params = array($args['subcategory']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectProdXSubCategory(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getProductsBySubCategoryandPrecio($request,$response,$args){
        try{
            $subcategory =$args['subcategory'];
            $precio = floatval($args['precio']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectProdXSubCategoryXPrecio(:Subcategory,:Precio)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Subcategory',$subcategory);
            $stm->bindParam(':Precio',$precio);
            $stm->execute();
            $result  = $stm->fetchAll();        
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }

    public function getProductsByConsulta($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $consulta =  $body['consulta'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectConsultaProd(:Consulta)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Consulta',$consulta);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }

    public function addProduct($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $Nombre_Product = $body['Nombre_Product'];
            $id_Marca = intval($body['id_Marca']);
            $id_SubCategory =intval($body['id_SubCategory']);
            $Descript_Product = $body['Descript_Product'];
            $Precio = floatval($body['Precio']);
            $Stock = intval($body['Stock']);
            $Unidad = ($body['Unidad']);
            $Moneda = ($body['Moneda']);
            $Img1= $body['Img1'];
            $Img2= $body['Img2'];
            $Img3= $body['Img3'];
            $Img4= $body['Img4'];
            $Img5= $body['Img5'];
            $NDescuento = intval($body['NDescuento']);
            $_Status = intval($body['_Status']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertProductos(:Nombre,:idMarca,:idSubCategory,:Description,:Precio,:Stock,:Unidad,:Moneda,:Img1,:Img2,:Img3,:Img4,:Img5,:Descuento,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Nombre',$Nombre_Product);
            $stm->bindParam(':idMarca',$id_Marca);
            $stm->bindParam(':idSubCategory',$id_SubCategory);
            $stm->bindParam(':Description',$Descript_Product);
            $stm->bindParam(':Precio',$Precio);
            $stm->bindParam(':Stock',$Stock);
            $stm->bindParam(':Unidad',$Unidad);
            $stm->bindParam(':Moneda',$Moneda);
            $stm->bindParam(':Img1',$Img1);
            $stm->bindParam(':Img2',$Img2);
            $stm->bindParam(':Img3',$Img3);
            $stm->bindParam(':Img4',$Img4);
            $stm->bindParam(':Img5',$Img5);
            $stm->bindParam(':Descuento',$NDescuento);
            $stm->bindParam(':Status',$_Status);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyProduct($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $Nombre_Product = $body['Nombre_Product'];
            $id_Marca = intval($body['id_Marca']);
            $id_SubCategory =intval($body['id_SubCategory']);
            $Descript_Product = $body['Descript_Product'];
            $Precio = floatval($body['Precio']);
            $Stock = intval($body['Stock']);
            $Unidad = ($body['Unidad']);
            $Moneda = ($body['Moneda']);
            $Img1= $body['Img1'];
            $Img2= $body['Img2'];
            $Img3= $body['Img3'];
            $Img4= $body['Img4'];
            $Img5= $body['Img5'];
            $NDescuento = intval($body['NDescuento']);
            $_Status = intval($body['_Status']);
            $_Status = intval($body['_Status']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateProducto(:idProduct,:Nombre,:idMarca,:idSubCategory,:Description,:Precio,:Stock,:Unidad,:Moneda,:Img1,:Img2,:Img3,:Img4,:Img5,:Descuento,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProduct',$params);
            $stm->bindParam(':Nombre',$Nombre_Product);
            $stm->bindParam(':idMarca',$id_Marca);
            $stm->bindParam(':idSubCategory',$id_SubCategory);
            $stm->bindParam(':Description',$Descript_Product);
            $stm->bindParam(':Precio',$Precio);
            $stm->bindParam(':Stock',$Stock);
            $stm->bindParam(':Unidad',$Unidad);
            $stm->bindParam(':Moneda',$Moneda);
            $stm->bindParam(':Img1',$Img1);
            $stm->bindParam(':Img2',$Img2);
            $stm->bindParam(':Img3',$Img3);
            $stm->bindParam(':Img4',$Img4);
            $stm->bindParam(':Img5',$Img5);
            $stm->bindParam(':Descuento',$NDescuento);
            $stm->bindParam(':Status',$_Status);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteProduct($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteProducto(:idProduct)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProduct',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountProduct($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadProduct");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }











}

?>