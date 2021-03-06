<?php namespace App\Controllers\Users;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;

class UserController extends BaseController {
    public function getUser($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectuser");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addUser($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Cliente =intval($body['id_Cliente']);
            $id_Roll = intval($body['id_Roll']);
            $_Username = $body['_Username'];
            $_Password = $body['_Password'];
            $_Status = intval($body['_Status']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertUser(:idCliente,:idRoll,:Username,:Password,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCliente',$id_Cliente);
            $stm->bindParam(':idRoll',$id_Roll);
            $stm->bindParam(':Username',$_Username);
            $stm->bindParam(':Password',$_Password);
            $stm->bindParam(':Status',$_Status);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyUser($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $_Password = $body['_Password'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateUser(:idCliente,:Password)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCliente',$params);
            $stm->bindParam(':Password',$_Password);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteUser($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteUser(:idCliente)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCliente',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getUserById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectUserId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountUser($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadUser");
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