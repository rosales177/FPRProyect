<?php
define('CLIENTEID','AfgNgBX5YnrkDjQbYB91GA8QyEnmlchIkltKzAp8_VDrSLsNrujNOEGFfPInAH5yXtX0aY9O15wBUl5W');
define('CLIENTE_SECRET','EG1V-gXAA3tPC9nSbD7GMqkxHVa5HcZJOFlRbrssQOt2O6oCbMf0Seb_U57yd2Zq0fIFYu9yY3Mg7siK');
define('PAYPAL_API','https://api-m.sandbox.paypal.com');


function body(){
    $cuerpo = array(
        'intent' => 'CAPTURE',
        'purchase_units' => array(array(
            'amount' => array(
                'current_code' => 'USD',
                'value' => '0.01'
            ))
        ),
        'application_context' => array(
            'brand_name' => 'Mi empresa',
            'landing_page' => 'NO_PREFERENCE',
            'user_action' => 'PAY_NOW',
            'return_url' => 'http://localhost:3000',
            'cancel_url' => 'http://localhost:3000'

        )
    );

    return $cuerpo;
}

?>