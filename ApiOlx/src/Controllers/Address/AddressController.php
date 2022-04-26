<?php namespace App\Controllers\Address;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class AddressController extends BaseController {
    public function getAddress($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectDireccion");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addAddress($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Cliente =intval($body['id_Cliente']);
            $Direccion = $body['Direccion'];
            $id_Ciudad = intval($body['id_Ciudad']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertDireccion(:idCliente,:Direccion,:idCiudad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCliente',$id_Cliente);
            $stm->bindParam(':Direccion',$Direccion);
            $stm->bindParam(':idCiudad',$id_Ciudad);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyAddress($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $id_Cliente =intval($body['id_Cliente']);
            $Direccion = $body['Direccion'];
            $id_Ciudad = intval($body['id_Ciudad']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateDireccion(:idDireccion,:idCliente,:Direccion,:idCiudad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idDireccion',$params);
            $stm->bindParam(':idCliente',$id_Cliente);
            $stm->bindParam(':Direccion',$Direccion);
            $stm->bindParam(':idCiudad',$id_Ciudad);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteAddress($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteDireccion(:idDireccion)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idDireccion',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getAddressById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectDireccionId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountAddress($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadDireccion");
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