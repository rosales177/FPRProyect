<?php namespace App\Controllers\Payment;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;

class PaymentController extends BaseController {
    public function getPayment($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM v_sSelectMedioPago");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addPayment($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Cliente =intval($body['id_Cliente']);
            $MedioPago = $body['MedioPago'];
            $NumeroTarjeta = $body['NumeroTarjeta'];
            $CVV = $body['CVV'];
            $FechaVencimiento = $body['FechaVencimiento'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertMedioPago(:idCliente,:MedioPago,:NumeroTarjeta,:CVV,:FechaVencimiento)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCliente',$id_Cliente);
            $stm->bindParam(':MedioPago',$MedioPago);
            $stm->bindParam(':NumeroTarjeta',$NumeroTarjeta);
            $stm->bindParam(':CVV',$CVV);
            $stm->bindParam(':FechaVencimiento',$FechaVencimiento);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyPayment($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $NumeroTarjeta = $body['NumeroTarjeta'];
            $CVV = $body['CVV'];
            $FechaVencimiento = $body['FechaVencimiento'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateMedioPago(:idMedioPago,:NumeroTarjeta,:CVV,:FechaVencimiento)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idMedioPago',$params);
            $stm->bindParam(':NumeroTarjeta',$NumeroTarjeta);
            $stm->bindParam(':CVV',$CVV);
            $stm->bindParam(':FechaVencimiento',$FechaVencimiento);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deletePayment($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteMedioPago(:idMedioPago)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idMedioPago',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getPaymentById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectMedioPagoId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountPayment($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadPayment");
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