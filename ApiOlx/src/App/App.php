<?php
use Slim\Factory\AppFactory;

require __DIR__ . '/../../vendor/autoload.php';
$aux = new \DI\Container();
AppFactory::setContainer($aux);

$app = AppFactory::create();
$app->setBasePath('/ApiOlx/public');
$container = $app->getContainer();

// $app->add(new \CorsSlim\CorsSlim());
(require __DIR__ . '\Routes.php')($app);
// require __DIR__ . "\Routes.php";
require __DIR__ . "\Configs.php";
require __DIR__ . "\Dependencies.php";

$app->run();

?>