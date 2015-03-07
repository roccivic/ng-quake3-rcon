<?php

if (! defined('NGQ3RCON')) {
    die('Illegal execution path');
}

// E_ALL for development, 0 for production
define('CFG_ERROR_LEVEL', 0);
// true for development, false for production
define('CFG_CORS', true);
// List of allowed CORS origins
define('CFG_CORS_ORIGIN', array('http://127.0.0.1/'));

// SERVER LIST
$servers = array(
    'Test Server' => array(
        'ip' => '127.0.0.1',
        'port' => '27960'
    )
);

?>