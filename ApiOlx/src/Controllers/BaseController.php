<?php 


namespace App\Controllers;

use Psr\Container\ContainerInterface;
use Psr\Http\Message\ResponseInterface as Response;
class BaseController{
    protected $container;

    public function __construct(ContainerInterface $c){
        $this->container = $c;
    }
    
    /**
     * @param array|object|null $message
     */

    protected function jsonResponse(
        $response,
        $status,
        $message,
        $code
    ){
        $result = [
            'code' => $code,
            'status' => $status,
            'length' => count($message),
            'message' => $message,
        ];
        $response->getBody()->write(json_encode($result));
        return $response
            ->withHeader('Content-Type','application/json')
            ->withStatus($code);
    }

    function SelectTable($table,$columns,$columnsfilter,$params,$clause,$expretion)
    {
        $columnas = '';
        $columnasfilter = '';
        if(count($columns) === 0)
        {
            $columnas = '*';
        }else{
            for ($i=0; $i < count($columns); $i++) { 
                if(empty($columnas))
                {
                    $columnas = $columns[$i];
                }else{
                    $columnas = $columnas.', '.$columns[$i];
                }
            }
        }
        if(count($columnsfilter) === count($params))
        {
            for ($i=0; $i < count($columnsfilter) ; $i++) { 
                $columnasfilter = $columnsfilter[$i].' = \''.$params[$i].'\'';
            }
        }
        if(empty($columnasfilter) || empty($params)){
            $sql = 'SELECT '. $columnas .' FROM '.$table  ;
        }
        else{
            $sql = 'SELECT '. $columnas .' FROM '.$table.' WHERE '.$columnasfilter;
        }
        if(!empty($clause) and count($expretion) > 0){
            $sql = $sql.' '.$clause.' ';   
            for ($i=0; $i < count($expretion)-1 ; $i++) { 
                $sql = $sql . $expretion[$i] ;
            }
            $sql= $sql .' '. end($expretion);
        }

        return $sql;
    }

    

}

?>