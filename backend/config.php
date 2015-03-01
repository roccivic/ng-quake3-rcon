<?php

if (! defined('NGQ3RCON')) {
    die('Illegal execution path');
}

// E_ALL for development, 0 for production
define('CFG_ERROR_LEVEL', 0);

// SERVER LIST
$servers = array(
    'lima' => array(
        'ip' => '31.187.14.201',
        'port' => '27960'
    )
);

?>