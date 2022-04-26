<?php namespace App\Controllers\Users;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
USE App\Controllers\BaseController;

class UserController extends BaseController {
    public function getAll($request,$response,$args){
        $sql = $this->SelectTable('cliente',[],[],[],'',[]);
        $conn = $this->container->get('db');
        $stm = $conn->prepare($sql);
        $stm->execute();
        $result = $stm->fetchAll();
        return $this->jsonResponse($response,'success',$result,200);
    }
}

?>