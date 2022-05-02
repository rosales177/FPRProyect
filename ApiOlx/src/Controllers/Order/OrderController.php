<?php namespace App\Controllers\Order;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;

class OrderController extends BaseController {
    public function getOrder($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("SELECT * FROM  v_sSelectPedido");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addOrder($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $id_Cliente =intval($body['id_Cliente']);
            $N_Pedido =intval($body['N_Pedido']);
            $FechaEmision = $body['FechaEmision'];
            $Emp_Envio = $body['Emp_Envio'];
            $Sub_Total= floatval($body['Sub_Total']);
            $Descuento = floatval($body['Descuento']);
            $Diret_Envio = $body['Diret_Envio'];
            $Total = intval($body['Total']);
            $TotalPagar = floatval($body['TotalPagar']);
            $_Status = $body['_Status'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertPedido(:idCliente,:Npedido,:FechaEmision,:EmpresaEnvio,:SubTotal,:Descuento,:DireEnvio,:Total,:TotalPagar,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':idCliente',$id_Cliente);
            $stm->bindParam(':Npedido',$N_Pedido);
            $stm->bindParam(':FechaEmision',$FechaEmision);
            $stm->bindParam(':EmpresaEnvio',$Emp_Envio);
            $stm->bindParam(':SubTotal',$Sub_Total);
            $stm->bindParam(':Descuento',$Descuento);
            $stm->bindParam(':DireEnvio',$Diret_Envio);
            $stm->bindParam(':Total',$Total);
            $stm->bindParam(':TotalPagar',$TotalPagar);
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
    public function modifyOrder($request,$response,$args){
        try{
            $params =intval($args['id']);
            $body = json_decode($request->getBody(), true);
            $FechaEmision = $body['FechaEmision'];
            $Emp_Envio = $body['Emp_Envio'];
            $Sub_Total= floatval($body['Sub_Total']);
            $Descuento = floatval($body['Descuento']);
            $Diret_Envio = $body['Diret_Envio'];
            $Total = intval($body['Total']);
            $TotalPagar = floatval($body['TotalPagar']);
            $_Status = $body['_Status'];
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdatePedido(:Npedido,:FechaEmision,:EmpresaEnvio,:SubTotal,:Descuento,:DireEnvio,:Total,:TotalPagar,:Status)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Npedido',$params);
            $stm->bindParam(':FechaEmision',$FechaEmision);
            $stm->bindParam(':EmpresaEnvio',$Emp_Envio);
            $stm->bindParam(':SubTotal',$Sub_Total);
            $stm->bindParam(':Descuento',$Descuento);
            $stm->bindParam(':DireEnvio',$Diret_Envio);
            $stm->bindParam(':Total',$Total);
            $stm->bindParam(':TotalPagar',$TotalPagar);
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
    public function deleteOrder($request,$response,$args){
        try{
            $params =intval($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeletePedido(:Npedido)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Npedido',$params);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getOrderById($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectPedidoId(?)";
            $stm = $conn->prepare($sql);
            $stm->execute($params);
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getCountOrder($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare( "SELECT * FROM v_sCantidadPedido");
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