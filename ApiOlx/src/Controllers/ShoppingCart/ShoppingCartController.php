<?php namespace App\Controllers\ShoppingCart;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;
use \Exception;
class ShoppingCartController extends BaseController {
    public function getShoppingCart($request,$response,$args){
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare("CALL v_sSelectCarritoCompra()");
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function addShoppingCart($request,$response,$args){
        try{
            $body = json_decode($request->getBody(), true);
            $N_Pedido = intval($body['N_Pedido']);
            $id_Product= intval($body['id_Product']);
            $Car_Cantidad= floatval($body['Car_Cantidad']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_InsertCarritoCompra(:NPedido,:idProducto,:CarCantidad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':NPedido',$N_Pedido);
            $stm->bindParam(':idProducto',$id_Product);
            $stm->bindParam(':CarCantidad',$Car_Cantidad);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function modifyShoppingCart($request,$response,$args){
        try{
            $paramsNpedido =intval($args['Npedido']);
            $paramsIdProduct =intval($args['IdProduct']);
            $body = json_decode($request->getBody(), true);
            $Car_Cantidad= floatval($body['Car_Cantidad']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_UpdateCarritoCompra(:Npedido,:idProduct,:CarCantidad)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Npedido',$paramsNpedido);
            $stm->bindParam(':idProduct',$paramsIdProduct);
            $stm->bindParam(':CarCantidad',$Car_Cantidad);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function deleteShoppingCart($request,$response,$args){
        try{
            $paramsNpedido =intval($args['Npedido']);
            $paramsIdProduct =intval($args['IdProduct']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_DeleteCarritoCompra(:Npedido,:idProduct)";
            $stm = $conn->prepare($sql);
            $stm->bindParam(':Npedido',$paramsNpedido);
            $stm->bindParam(':idProduct',$paramsIdProduct);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }catch(Exception $e){
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
    public function getShoppingCartByPedido($request,$response,$args){
        try{
            $params = array($args['id']);
            $conn = $this->container->get('db');
            $sql = "CALL sp_SelectCarritoCompra(?)";
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