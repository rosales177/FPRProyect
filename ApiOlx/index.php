<?php
include 'src/Services/APIPaypal/Paypal.php';

// echo json_encode(body()) .'</br>';



$con = new PDO('mysql:host=localhost;port=3306;dbname=tellnova','root','');

// SELECT * FROM `product` as p WHERE p.cod_linea_producto = '';
// SELECT * FROM `product` as p WHERE p.cod_categoria = '';
// SELECT * FROM `product` as p WHERE p.cod_marca= '';
// SELECT * FROM `product` as p WHERE p.cod_unidad_venta = 'UND';

// echo SelectTable('product',[],['cod_linea_producto'],['UND'],'',[]) . '</br>';
// echo SelectTable('product',[],['cod_categoria'],[],'',[]). '</br>';
// echo SelectTable('product',[],['cod_marca'],[],'',[]). '</br>';
// echo SelectTable('product',[],['cod_unidad_venta'],[],'ORDER BY',['cod_categoria','desc']). '</br>';
// echo SelectTable('user',[],[],[],'',[]) .'<br/>';

echo SelectTable('product',[],['id_Product','cod_categoria'],['0','1'],'',[]) . '<br/>';
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
            $columnasfilter = $columnasfilter . $columnsfilter[$i].' = \''.$params[$i].'\'';
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


?>