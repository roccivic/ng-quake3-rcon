<?php

define('NGQ3RCON', true);

require_once 'phpQuake3.php';

$rcon = new q3query('31.187.14.201', 27960, 'password');
$response = $rcon->status();
echo json_encode($response);

?>