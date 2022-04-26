<?php
declare(strict_types = 1);

namespace App\Entity;

final class Producto
{
    private string $Nombre_Product;
    private string $Marca_Product;
    private int $id_SubCategory;
    private string $Descript_Product;
    private int $Precio;
    private int $Stock;
    private string $Img;
    private int $_Status;

    public function setNombrePro(string $Nombre_Product){
        $this->Nombre_Product = $Nombre_Product;
    }
    public function setMarcaPro(string $Marca_Product){
        $this->Marca_Product =  $Marca_Product;
    }
    public function setIdSubCate(int $id_SubCategory){
        $this->id_SubCategory = $id_SubCategory;
    }
    public function setDescrip(string $Descript_Product){
        $this->Descript_Product = $Descript_Product;;
    }
    public function setPreci(int $Precio){
        $this->Precio = $Precio;
    }
    public function setStock(int $Stock){
        $this->Stock = $Stock;
    }
    public function setImg(string $Img){
        $this->$Img= $Img;
    }
    public function setStatus(int $_Status){
        $this->_Status = $_Status;
    }

    public function StatusOperation(){
        if(
            !empty($this->Nombre_Product) &&
            !empty($this->Marca_Product) &&
            !empty($this->id_SubCategory) &&
            !empty($this->Descript_Product) &&
            !empty($this->Precio) &&
            !empty($this->Stock) &&
            !empty($this->_Status) 
        ){
            
            $add = array(
                "cod_nombreprod" => $this->Nombre_Product,
                "cod_marcaprod" => $this->Marca_Product,
                "cod_idsubcategory" => $this->id_SubCategory,
                "cod_descript" => $this->Descript_Product,
                "cod_precio" => $this->Precio,
                "cod_img" => $this->Img,
                "cod_status" => $this->_Status,
               
            );

            return $add;
        }
        else{
            return array('Error' => 'Error en la operacion.');
        }
    }
}

?>