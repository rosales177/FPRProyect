<?php namespace App\Controllers\Discount;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class DiscountController extends BaseController {
    public function getDiscount($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectDescuento");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addDiscount($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Product = intval($body['id_Prod uct']);
            $dscto1 = $body['dscto1'];
            $dscto2 = $body['dscto2'];
            $dscto3 = $body['dscto3'];
            $dscto4 = $body['dscto4'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertDescuento(:idProducto,:dscto1,:dscto2,:dscto3,:dscto4)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProducto',$id_Product);
            $stm->bindParam(':dscto1',$dscto1);
            $stm->bindParam(':dscto2',$dscto2);
            $stm->bindParam(':dscto3',$dscto3);
            $stm->bindParam(':dscto4',$dscto4);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyDiscount($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $dscto1 = $body['dscto1'];
            $dscto2 = $body['dscto2'];
            $dscto3 = $body['dscto3'];
            $dscto4 = $body['dscto4'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateDescuento(:idProducto,:dscto1,:dscto2,:dscto3,:dscto4)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProducto',$params);
            $stm->bindParam(':dscto1',$dscto1);
            $stm->bindParam(':dscto2',$dscto2);
            $stm->bindParam(':dscto3',$dscto3);
            $stm->bindParam(':dscto4',$dscto4);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteDiscount($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteDescuento(:idProducto)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProducto',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getDiscountById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectDescuentoId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    

}

?>