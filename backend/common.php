<?php

if (! defined('NGQ3RCON')) {
    die('Illegal execution path');
}

error_reporting(CFG_ERROR_LEVEL);
date_default_timezone_set("Europe/Dublin");
// CORS headers
if (CFG_CORS) {
    $http_origin = empty($_SERVER['HTTP_ORIGIN']) ? '' : $_SERVER['HTTP_ORIGIN'];
    if (in_array($http_origin, $CFG_CORS_ORIGINS)) {
        header("Access-Control-Allow-Origin: $http_origin");
    } else {
        header("Access-Control-Allow-Origin: http://localhost:9000");
    }
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Allow-Methods: PUT, DELETE, POST, PATCH, GET, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');
}
header('Content-type: application/json');
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    die();
}

function checkRequest($post) {
    if (empty($post->ip)) {
        error(400, 'No server IP address');
    } else if (empty($post->port)) {
        error(400, 'No server port');
    } else if (empty($post->password)) {
        error(400, 'No server password');
    }
}

function connect($post) {
    $rcon = new q3query($post->ip, $post->port, $post->password);
    if ($rcon->isError()) {
        $error = $rcon->getError();
        error(500, 'Cannot connect to server: ('.$error['no'].') '.$error['str']);
    }
    return $rcon;
}

function response($response) {
    if ($response === null) {
        error(500, 'Invalid server response');
    } else {
        echo json_encode($response);
    }
}

function error($code, $message= '') {
    $errors = array(
        400 => 'Bad Request',
        401 => 'Not Authorized',
        404 => 'Not Found',
        405 => 'Request Method Not Supported',
        500 => 'Internal Server Error'
    );
    if (empty($errors[$code])) {
        $code = 500;
    }
    $error = $errors[$code];
    $errorString = $code . ' ' . $error;
    header('HTTP/1.0 ' . $errorString);
    die(
        json_encode(
            array(
                'error_string' => $errorString,
                'message' => $message
            )
        )
    );
}

?>