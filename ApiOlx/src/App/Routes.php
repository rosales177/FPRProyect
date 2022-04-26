<?php
use Slim\Routing\RouteCollectorProxy;

return function ($app) {

    /*$app->group('/api/product', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Product\ProductController:getProduct');
        $group->get('/id/{id}','App\Controllers\Product\ProductController:getProductById');
        $group->get('/{category}','App\Controllers\Product\ProductController:getProductsByCategory');
        $group->get('/{category}/{id}','App\Controllers\Product\ProductController:getProductsByCategoryById');
        $group->post('/add','App\Controllers\Product\ProductController:addProduct');
    });
    $app->group('/api/user', function(RouteCollectorProxy $group) use ($app): void {
        $group->get('/all','App\Controllers\Users\UserController:getAll');
    });
    $app->group('/api/category', function(RouteCollectorProxy $group) use ($app): void {
        $group->get('/all','App\Controllers\Category\CategoryController:getAllCategory');
    });
    $app->group('/api/linea', function(RouteCollectorProxy $group) use ($app): void {
        $group->get('/all','App\Controllers\Line\LineController:getAllLine');
    });*/
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

    #ultimo producto
    $app->group('/api/product', function(RouteCollectorProxy $group) use ($app): void{
        $group->get('/all','App\Controllers\Product\ProductController:getProduct');
        $group->get('/count','App\Controllers\Product\ProductController:getCountProduct');
        $group->get('/id/{id}','App\Controllers\Product\ProductController:getProductById');
        $group->get('/{category}','App\Controllers\Product\ProductController:getProductsByCategory');
        $group->get('/{category}/{id}','App\Controllers\Product\ProductController:getProductsByCategoryById');
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

    




    
    return $app;
}

?>