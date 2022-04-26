<?php namespace App\Controllers\SubCategory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class SubCategoryController extends BaseController {
    public function getAllSubCategory($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectSubCategoria");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addSubCategory($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Category =intval($body['id_Category']);
            $Nom_SubCategory = $body['Nom_SubCategory'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertSubCategoria(:IdCategory,:NomSubCategory)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':IdCategory',$id_Category);
            $stm->bindParam(':NomSubCategory',$Nom_SubCategory);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifySubCategory($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $id_Category =intval($body['id_Category']);
            $Nom_SubCategory = $body['Nom_SubCategory'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateSubCategoria(:IdSubCategory,:IdCategory,:NomSubCategory)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':IdSubCategory',$params);
            $stm->bindParam(':IdCategory',$id_Category);
            $stm->bindParam(':NomSubCategory',$Nom_SubCategory);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteSubCategory($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteSubCategoria(:idSubCategory)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idSubCategory',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getSubCategoryById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectSubCategoryId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountSubCategory($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadSubCategory");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }

    public function getSubCategoryXCategory($request,$response,$args){
        try{
            $params =$args['category'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectSubCategoryXCategory(:category)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':category',$params);
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