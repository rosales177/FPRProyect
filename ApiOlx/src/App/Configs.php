<?php
    $container->set('db_settings',function(){
        return (object)[
            "DB_NAME"=>"DB_OLX",
            "DB_PASS"=>"MIKI1",
            "DB_CHAR"=>"utf8",
            "DB_HOST"=>"127.0.0.1:3307",
            "DB_USER"=>"root",
        ];
    });
?>