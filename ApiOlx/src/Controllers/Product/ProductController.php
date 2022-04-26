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
    public function getProductsByCategory($request,$response,$args){
        try{
            $params = array($args['category']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectProdXCategory(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getProductsByCategoryById($request,$response,$args){
        try{
            $params1 = $request->getAttribute('category');
            $params = $request->getAttribute('id');
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectProdXCategoryandId(?,?)";
            $stm = $conn->prepare($sql);
            $stm->execute(array($params1,$params));
            $result  = $stm->fetchAll();        
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
            $Marca_Product = $body['Marca_Product'];
            $id_SubCategory =intval($body['id_SubCategory']);
            $Descript_Product = $body['Descript_Product'];
            $Precio = floatval($body['Precio']);
            $Stock = intval($body['Stock']);
            $Img1= $body['Img1'];
            $Img2= $body['Img2'];
            $Img3= $body['Img3'];
            $_Status = intval($body['_Status']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertProductos(:Nombre,:Marca,:idSubCategory,:Description,:Precio,:Stock,:Img1,:Img2,:Img3,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Nombre',$Nombre_Product);
            $stm->bindParam(':Marca',$Marca_Product);
            $stm->bindParam(':idSubCategory',$id_SubCategory);
            $stm->bindParam(':Description',$Descript_Product);
            $stm->bindParam(':Precio',$Precio);
            $stm->bindParam(':Stock',$Stock);
            $stm->bindParam(':Img1',$Img1);
            $stm->bindParam(':Img2',$Img2);
            $stm->bindParam(':Img3',$Img3);
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
            $Marca_Product = $body['Marca_Product'];
            $id_SubCategory =intval($body['id_SubCategory']);
            $Descript_Product = $body['Descript_Product'];
            $Precio = floatval($body['Precio']);
            $Stock = intval($body['Stock']);
            $Img1= $body['Img1'];
            $Img2= $body['Img2'];
            $Img3= $body['Img3'];
            $_Status = intval($body['_Status']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateProducto(:idProduct,:Nombre,:Marca,:idSubCategory,:Description,:Precio,:Stock,:Img1,:Img2,:Img3,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProduct',$params);
            $stm->bindParam(':Nombre',$Nombre_Product);
            $stm->bindParam(':Marca',$Marca_Product);
            $stm->bindParam(':idSubCategory',$id_SubCategory);
            $stm->bindParam(':Description',$Descript_Product);
            $stm->bindParam(':Precio',$Precio);
            $stm->bindParam(':Stock',$Stock);
            $stm->bindParam(':Img1',$Img1);
            $stm->bindParam(':Img2',$Img2);
            $stm->bindParam(':Img3',$Img3);
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