<?php namespace App\Controllers\Features;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class FeaturesController extends BaseController {
    public function getFeatures($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectCaracteristicas");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addFeatures($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Product = intval($body['id_Product']);
            $Caracteristicas_product = $body['Caracteristicas_product'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertCaracteristicas(:idProduct,:Caracteristicas)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProduct',$id_Product);
            $stm->bindParam(':Caracteristicas',$Caracteristicas_product);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyFeatures($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $Caracteristicas_product = $body['Caracteristicas_product'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateCaracteristicas(:idProduct,:Caracteristicas)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idProduct',$params);
            $stm->bindParam(':Caracteristicas',$Caracteristicas_product);    
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteFeatures($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteCaracteristicas(:idProduct)";
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
    public function getFeaturesById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectCaracteristicasId(?)";
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