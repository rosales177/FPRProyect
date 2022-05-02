<?php
use Slim\Routing\RouteCollectorProxy;

return function ($app) {

    $app->group('/api/category', function(RouteCollectorProxy $group) use ($app): void {
        $group->get('/all','App\Controllers\Category\CategoryController:getAllCategory');
        $group->get('/id/{id}','App\Controllers\Category\CategoryController:getCategoryById');
        $group->post('/add','App\Controllers\Category\CategoryController:addCategory');
        $group->put('/modify/{id}','App\Controllers\Category\CategoryController:modifyCategory');
        $group->delete('/delete/{id}','App\Controllers\Category\CategoryController:deleteCategory');
        $group->get('/count','App\Controllers\Category\CategoryController:getCountCategory');
    });     

    $app->group('/api/subcategory', function(RouteCollectorProxy $group) use ($app): void {
        $group->get('/all','App\Controllers\SubCategory\SubCategoryController:getAllSubCategory');
        $group->get('/id/{id}','App\Controllers\SubCategory\SubCategoryController:getSubCategoryById');
        $group->post('/add','App\Controllers\SubCategory\SubCategoryController:addSubCategory');
        $group->put('/modify/{id}','App\Controllers\SubCategory\SubCategoryController:modifySubCategory');
        $group->delete('/delete/{id}','App\Controllers\SubCategory\SubCategoryController:deleteSubCategory');
        $group->get('/count','App\Controllers\SubCategory\SubCategoryController:getCountSubCategory');
        $group->get('/filter/{category}','App\Controllers\SubCategory\SubCategoryController:getSubCategoryXCategory');
    });

    $app->group('/api/product', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Product\ProductController:getProduct');
        $group->get('/count','App\Controllers\Product\ProductController:getCountProduct');
        $group->get('/id/{id}','App\Controllers\Product\ProductController:getProductById');
        $group->get('/{subcategory}','App\Controllers\Product\ProductController:getProductsBySubCategory');
        $group->get('/{subcategory}/{precio}','App\Controllers\Product\ProductController:getProductsBySubCategoryandPrecio');
        $group->post('/consult','App\Controllers\Product\ProductController:getProductsByConsulta');
        $group->post('/add','App\Controllers\Product\ProductController:addProduct');
        $group->put('/modify/{id}','App\Controllers\Product\ProductController:modifyProduct');
        $group->delete('/delete/{id}','App\Controllers\Product\ProductController:deleteProduct');
    });

    $app->group('/api/country', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Country\CountryController:getCountry');
        $group->get('/id/{id}','App\Controllers\Country\CountryController:getCountryById');
        $group->post('/add','App\Controllers\Country\CountryController:addCountry');
        $group->put('/modify/{id}','App\Controllers\Country\CountryController:modifyCountry');
        $group->delete('/delete/{id}','App\Controllers\Country\CountryController:deleteCountry');
        $group->get('/count','App\Controllers\Country\CountryController:getCountCountry');
    });

    $app->group('/api/city', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\City\CityController:getCity');
        $group->get('/id/{id}','App\Controllers\City\CityController:getCityById');
        $group->post('/add','App\Controllers\City\CityController:addCity');
        $group->put('/modify/{id}','App\Controllers\City\CityController:modifyCity');
        $group->delete('/delete/{id}','App\Controllers\City\CityController:deleteCity');
        $group->get('/count','App\Controllers\City\CityController:getCountCity');
        $group->get('/filter/{Country}','App\Controllers\City\CityController:getCiudadesXCountry');   
    });

    $app->group('/api/client', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Client\ClientController:getClient');
        $group->get('/id/{id}','App\Controllers\Client\ClientController:getClientById');
        $group->post('/add','App\Controllers\Client\ClientController:addClient');
        $group->put('/modify/{id}','App\Controllers\Client\ClientController:modifyClient');
        $group->delete('/delete/{id}','App\Controllers\Client\ClientController:deleteClient');
        $group->get('/count','App\Controllers\Client\ClientController:getCountClient');
    });

    $app->group('/api/address', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Address\AddressController:getAddress');
        $group->post('/add','App\Controllers\Address\AddressController:addAddress');
        $group->put('/modify/{id}','App\Controllers\Address\AddressController:modifyAddress');
        $group->delete('/delete/{id}','App\Controllers\Address\AddressController:deleteAddress');
        $group->get('/id/{id}','App\Controllers\Address\AddressController:getAddressById');
        $group->get('/count','App\Controllers\Address\AddressController:getCountAddress');
    });


    $app->group('/api/rol', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Rol\RolController:getRol');
        $group->post('/add','App\Controllers\Rol\RolController:addRol');
        $group->put('/modify/{id}','App\Controllers\Rol\RolController:modifyRol');
        $group->delete('/delete/{id}','App\Controllers\Rol\RolController:deleteRol');
        $group->get('/id/{id}','App\Controllers\Rol\RolController:getRolById');
        $group->get('/count','App\Controllers\Rol\RolController:getCountRol');
    });

    $app->group('/api/user', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Users\UserController:getUser');
        $group->post('/add','App\Controllers\Users\UserController:addUser');
        $group->put('/modify/{id}','App\Controllers\Users\UserController:modifyUser');
        $group->delete('/delete/{id}','App\Controllers\Users\UserController:deleteUser');
        $group->get('/id/{id}','App\Controllers\Users\UserController:getUserById');
        $group->get('/count','App\Controllers\Users\UserController:getCountUser');
    });

    $app->group('/api/payment', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Payment\PaymentController:getPayment');
        $group->post('/add','App\Controllers\Payment\PaymentController:addPayment');
        $group->put('/modify/{id}','App\Controllers\Payment\PaymentController:modifyPayment');
        $group->delete('/delete/{id}','App\Controllers\Payment\PaymentController:deletePayment');
        $group->get('/id/{id}','App\Controllers\Payment\PaymentController:getPaymentById');
        $group->get('/count','App\Controllers\Payment\PaymentController:getCountPayment');
    });

    $app->group('/api/order', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Order\OrderController:getOrder');
        $group->post('/add','App\Controllers\Order\OrderController:addOrder');
        $group->put('/modify/{id}','App\Controllers\Order\OrderController:modifyOrder');
        $group->delete('/delete/{id}','App\Controllers\Order\OrderController:deleteOrder');
        $group->get('/id/{id}','App\Controllers\Order\OrderController:getOrderById');
        $group->get('/count','App\Controllers\Order\OrderController:getCountOrder');
    });

    $app->group('/api/shoppingcart', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\ShoppingCart\ShoppingCartController:getShoppingCart');
        $group->post('/add','App\Controllers\ShoppingCart\ShoppingCartController:addShoppingCart');
        $group->put('/modify/{Npedido}/{IdProduct}','App\Controllers\ShoppingCart\ShoppingCartController:modifyShoppingCart');
        $group->delete('/delete/{Npedido}/{IdProduct}','App\Controllers\ShoppingCart\ShoppingCartController:deleteShoppingCart');
        $group->get('/id/{id}','App\Controllers\ShoppingCart\ShoppingCartController:getShoppingCartByPedido');
    });

    $app->group('/api/history', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\History\HistoryController:getHistory');
        $group->post('/add','App\Controllers\History\HistoryController:addHistory');
        $group->put('/modify/{id}','App\Controllers\History\HistoryController:modifyHistory');
        $group->delete('/delete/{id}','App\Controllers\History\HistoryController:deleteHistory');
        $group->get('/id/{id}','App\Controllers\History\HistoryController:getHistoryById');
    });

    $app->group('/api/discount', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Discount\DiscountController:getDiscount');
        $group->get('/id/{id}','App\Controllers\Discount\DiscountController:getDiscountById');
        $group->post('/add','App\Controllers\Discount\DiscountController:addDiscount');
        $group->put('/modify/{id}','App\Controllers\Discount\DiscountController:modifyDiscount');
        $group->delete('/delete/{id}','App\Controllers\Discount\DiscountController:deleteDiscount');
        
    });

    $app->group('/api/features', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Features\FeaturesController:getFeatures');
        $group->post('/add','App\Controllers\Features\FeaturesController:addFeatures');
        $group->put('/modify/{id}','App\Controllers\Features\FeaturesController:modifyFeatures');
        $group->delete('/delete/{id}','App\Controllers\Features\FeaturesController:deleteFeatures');
        $group->get('/id/{id}','App\Controllers\Features\FeaturesController:getFeaturesById');
        
    });
    /*
    $app->group('/api/linea', function(RouteCollectorProxy $group) use ($app): void {
        $group->get('/all','App\Controllers\Line\LineController:getAllLine');
    });*/
    return $app;
}

?>