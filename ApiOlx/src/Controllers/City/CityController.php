<?php namespace App\Controllers\City;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class CityController extends BaseController {
    public function getCity($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectCiudad");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addCity($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Pais =intval($body['id_Pais']);
            $Uk_Nombre = $body['Uk_Nombre'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertCiudad(:idPais,:NombreCiudad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idPais',$id_Pais);
            $stm->bindParam(':NombreCiudad',$Uk_Nombre);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyCity($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $id_Pais =intval($body['id_Pais']);
            $Uk_Nombre = $body['Uk_Nombre'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateCiudad(:idCiudad,:idPais,:NombreCiudad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCiudad',$params);
            $stm->bindParam(':idPais',$id_Pais);
            $stm->bindParam(':NombreCiudad',$Uk_Nombre);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteCity($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteCiudad(:idCiudad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCiudad',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCityById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectCiudadId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountCity($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM  v_sCantidadCity");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }

    public function getCiudadesXCountry($request,$response,$args){
        try{
            $params = $args['Country'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectCiudadesXPais(:Country)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Country',$params);
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