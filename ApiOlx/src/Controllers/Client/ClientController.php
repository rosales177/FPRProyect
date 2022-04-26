<?php namespace App\Controllers\Client;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class ClientController extends BaseController {
    public function getClient($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectCliente");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addClient($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $Nombre_Cliente =$body['Nombre_Cliente'];
            $Apellido_Cliente = $body['Apellido_Cliente'];
            $Edad_Cliente = intval($body['Edad_Cliente']);
            $Correo = $body['Correo'];
            $Contacto = $body['Contacto'];
            $Img = $body['Img'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertCliente(:NombreClient,:ApellidoClient,:EdadClient,:CorreoClient,:ContactoClient,:ImgClient)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':NombreClient',$Nombre_Cliente);
            $stm->bindParam(':ApellidoClient',$Apellido_Cliente);
            $stm->bindParam(':EdadClient',$Edad_Cliente);
            $stm->bindParam(':CorreoClient',$Correo);
            $stm->bindParam(':ContactoClient',$Contacto);
            $stm->bindParam(':ImgClient',$Img);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyClient($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $Nombre_Cliente =$body['Nombre_Cliente'];
            $Apellido_Cliente = $body['Apellido_Cliente'];
            $Edad_Cliente = intval($body['Edad_Cliente']);
            $Correo = $body['Correo'];
            $Contacto = $body['Contacto'];
            $Img = $body['Img'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateCliente(:IdClient,:NombreClient,:ApellidoClient,:EdadClient,:CorreoClient,:ContactoClient,:ImgClient)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':IdClient',$params);
            $stm->bindParam(':NombreClient',$Nombre_Cliente);
            $stm->bindParam(':ApellidoClient',$Apellido_Cliente);
            $stm->bindParam(':EdadClient',$Edad_Cliente);
            $stm->bindParam(':CorreoClient',$Correo);
            $stm->bindParam(':ContactoClient',$Contacto);
            $stm->bindParam(':ImgClient',$Img);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteClient($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteCliente(:IdClient)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':IdClient',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getClientById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectClientsId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountClient($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM  v_sCantidadClients");
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