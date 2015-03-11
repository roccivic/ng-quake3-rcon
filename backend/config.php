<?php

if (! defined('NGQ3RCON')) {
    die('Illegal execution path');
}

// Path to baseq3 folder
define('CFG_BASEQ3_PATH', '/usr/share/games/quake3/baseq3');
// Path to backend cache folder
define('CFG_CACHE_PATH', './cache');
// Folder with bash scripts for map management
define('CFG_SCRIPT_PATH','./scripts');
// Temporary folder for uploads
define('CFG_TEMP_PATH','./temp');
// Final folder for uploads
define('CFG_UPLOAD_PATH', './uploads');
// E_ALL for development, 0 for production
define('CFG_ERROR_LEVEL', 0);
// true for development, false for production
define('CFG_CORS', true);
// List of allowed CORS origins
$CFG_CORS_ORIGINS = array('http://localhost:9000');

// SERVER LIST
$servers = array(
    'Test Server' => array(
        'ip' => '127.0.0.1',
        'port' => '27960'
    )
);

?>
