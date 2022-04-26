<?php
declare(strict_types = 1);

namespace App\Entity;

final class User
{
    private string $nombre;
    private string $apellido;
    private string $edad;
    private string $correo;
    private string $contacto;

    public function setNombre(string $nombre)
    {
        $this->nombre = $nombre;
    }

    public function setApellido(string $apellido)
    {
        $this->apellido = $apellido;
    }

    public function setEdad(string $edad)
    {
        $this->edad = $edad;
    }

    public function setCorreo(string $correo)
    {
        $this->correo = $correo;
    }

    public function setContacto(string $contacto)
    {
        $this->contacto = $contacto;
    }
    public function StatusOperation(){
        if(
            empty($this->nombre) ||
            empty($this->apellido) ||
            empty($this->edad) ||
            empty($this->correo) ||
            empty($this->contacto))
        {
            return array('Es nesesario ingresar los parametros');
        }
        else{
            return array('Operación realizada correctamente.');
        }
    }
}

?>