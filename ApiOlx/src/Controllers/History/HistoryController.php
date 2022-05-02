<?php namespace App\Controllers\History;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class HistoryController extends BaseController {
    public function getHistory($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("CALL v_sSelectHistorial()");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addHistory($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $N_Pedido = intval($body['N_Pedido']);
            $Cliente = $body['Cliente'];
            $FechaEmision = $body['FechaEmision'];
            $DirecEnvio = $body['DirecEnvio'];
            $SubTotal = floatval($body['SubTotal']);
            $Total = intval($body['Total']);
            $TotalPagar = floatval($body['TotalPagar']);
            $Descuento = intval($body['Descuento']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertHistorialCompra(:N_Pedido,:Cliente,:FechaEmision,:DirecEnvio,:SubTotal,:Total,:TotalPagar,:Descuento)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':N_Pedido',$N_Pedido);
            $stm->bindParam(':Cliente',$Cliente );
            $stm->bindParam(':FechaEmision',$FechaEmision);
            $stm->bindParam(':DirecEnvio',$DirecEnvio);
            $stm->bindParam(':SubTotal',$SubTotal);
            $stm->bindParam(':Total',$Total );
            $stm->bindParam(':TotalPagar',$TotalPagar);
            $stm->bindParam(':Descuento',$Descuento);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyHistory($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $Cliente = $body['Cliente'];
            $FechaEmision = $body['FechaEmision'];
            $DirecEnvio = $body['DirecEnvio'];
            $SubTotal = floatval($body['SubTotal']);
            $Total = intval($body['Total']);
            $TotalPagar = floatval($body['TotalPagar']);
            $Descuento = intval($body['Descuento']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateHistorialCompra(:idNpedido,:Cliente,:FechaEmision,:DirecEnvio,:SubTotal,:Total,:TotalPagar,:Descuento)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idNpedido',$params);
            $stm->bindParam(':Cliente',$Cliente );
            $stm->bindParam(':FechaEmision',$FechaEmision);
            $stm->bindParam(':DirecEnvio',$DirecEnvio);
            $stm->bindParam(':SubTotal',$SubTotal);
            $stm->bindParam(':Total',$Total );
            $stm->bindParam(':TotalPagar',$TotalPagar);
            $stm->bindParam(':Descuento',$Descuento);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteHistory($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteHistorial(:idNpedido)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idNpedido',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getHistoryById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectHistorialId(?)";
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