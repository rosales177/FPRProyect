<?php namespace App\Controllers\Rol;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class RolController extends BaseController {
    public function getRol($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectRoll");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addRol($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $Descript_Roll =$body['Descript_Roll'];
            $_Value = $body['_Value'];
            $conn = $this->container->get('db');    
            $sql = "CALL sp_InsertRoll(:Roll,:Value)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Roll',$Descript_Roll);
            $stm->bindParam(':Value',$_Value);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyRol($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $Descript_Roll =$body['Descript_Roll'];
            $_Value = $body['_Value'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateRoll(:idRoll,:Roll,:Value)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idRoll',$params);
            $stm->bindParam(':Roll',$Descript_Roll);
            $stm->bindParam(':Value',$_Value);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteRol($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteRoll(:idRoll)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idRoll',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getRolById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectWhereRollId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountRol($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadRol");
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