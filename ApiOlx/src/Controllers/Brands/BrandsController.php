<?php namespace App\Controllers\Brands;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class BrandsController extends BaseController {
    public function getBrands($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectMarca");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addBrands($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $Nom_Marca =$body['Nom_Marca'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertMarca(:NombreMarca)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':NombreMarca',$Nom_Marca);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyBrands($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $Nom_Marca =$body['Nom_Marca'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateMarca(:idMarca,:NombreMarca)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idMarca',$params);
            $stm->bindParam(':NombreMarca',$Nom_Marca);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteBrands($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteMarca(:idMarca)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idMarca',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getBrandsById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectMarcaId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountBrands($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadMarca");
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