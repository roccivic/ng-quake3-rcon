<?php

if (! defined('NGQ3RCON')) {
    die('Illegal execution path');
}

// E_ALL for development, 0 for production
define('CFG_ERROR_LEVEL', 0);
// true for development, false for production
define('CFG_CORS', true);

// SERVER LIST
$servers = array(
    'Lima' => array(
        'ip' => '31.187.14.201',
        'port' => '27960'
    ),
    'Test Server' => array(
        'ip' => '123.123.123.123',
        'port' => '27960'
    )
);

?>