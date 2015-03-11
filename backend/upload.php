<?php

define('NGQ3RCON', true);

require_once 'common.php';
require_once 'Flow/Autoloader.php';

if (empty($_REQUEST['uploadQueue']) || ! preg_match("@^\w+$@", $_REQUEST['uploadQueue'])) {
    error(400);
} else {
    $uploadQueue = $_REQUEST['uploadQueue'];
    if (! is_dir(CFG_UPLOAD_PATH . '/' . $uploadQueue)) {
        mkdir(CFG_UPLOAD_PATH . '/' . $uploadQueue);
    }
}

\Flow\Autoloader::register();

$config = new \Flow\Config(array(
   'tempDir' => CFG_TEMP_PATH
));
$request = new \Flow\Request();
if (empty($request->getFileName()) || ! preg_match("@^\w+$@", $request->getFileName())) {
    error(400);
}
$path = CFG_UPLOAD_PATH . '/' . $uploadQueue . '/' . $request->getFileName();
if (\Flow\Basic::save($path, $config, $request)) {
  echo 'File was saved in ' . $path;
}

?>