<?php namespace App\Controllers\Line;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;

class LineController extends BaseController{
    public function getAllLine($request,$response,$args){
        $sql = $this->SelectTable('product',['cod_lnea_producto'],[],[],'GROUP BY',['cod_linea_producto']);
        try{
            $conn = $this->container->get('db');
            $stm = $conn->prepare($sql);
            $stm->execute();
            $result = $stm->fetchAll();
            return $this->jsonResponse($response,'success',$result,200);
        }
        catch(PDOException $e)
        {
            $result = array($e->getMessage());
            return $this->jsonResponse($response,'error',$result,400);
        }
    }
}

?>