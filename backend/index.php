<?php

define('NGQ3RCON', true);

require_once 'config.php';
require_once 'common.php';
require_once 'phpQuake3.php';

$_POST = json_decode(file_get_contents('php://input'));

if (empty($_POST)) {
    error(400, 'Invalid request payload');
} else if (empty($_POST->action)) {
    error(400, 'Invalid request action');
}

if ($_POST->action === 'servers') {
    response($servers);
} else if ($_POST->action === 'status') {
    checkRequest($_POST);
    $rcon = connect($_POST);
    response($rcon->status());
} else if ($_POST->action === 'command') {
    checkRequest($_POST);
    if (empty($_POST->command)) {
        error(400, 'No server command');
    }
    $rcon = connect($_POST);
    response($rcon->rcon($_POST->command));
} else {
    error(400, 'Invalid action');
}

?>