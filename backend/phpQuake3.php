<?php

if (! defined('NGQ3RCON')) {
    die('Illegal execution path');
}

/*
PHP Quake 3 Library
Copyright (C) 2006-2007 Gerald Kaszuba

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

class q3query {

    private $rconpassword;
    private $fp;
    private $cmd;
    private $lastcmd;
    private $errno;
    private $errstr;

    public function __construct($address, $port, $password) {
        $this->cmd = str_repeat(chr(255), 4);
        $this->fp = fsockopen("udp://$address", $port, $this->errno, $this->errstr, 30);
        $this->rconpassword = $password;
    }

    public function isError() {
        return !$this->fp;
    }

    public function getError() {
        return array(
            'no' => $this->errno,
            'str' => $this->errstr
        );
    }

    public function rcon($s, $timeout=5) {
        if ($this->fp) {
            $this->send('rcon '.$this->rconpassword.' '.$s);
            $response = $this->get_response($timeout);
            if (preg_match("@^Bad rconpassword.$@", $response)) {
                return null;
            } else {
                return $response;
            }
        } else {
            return null;
        }
    }

    public function status($timeout=5) {
        $result = $this->rcon('status', $timeout);
        if ($result !== null) {
            $response = array();
            $result = explode("\n", $result);
            $map = array_shift($result); // 1st line : map q3wcp9
            $response['map'] = substr($map, 5);
            array_shift($result); // 2nd line : col headers
            array_shift($result); // 3rd line : -- ------ ----
            array_pop($result);
            array_pop($result); // two empty lines at the end
            $response['players'] = array();
            foreach ($result as $line) {
                $player = $line;
                preg_match_all(
                    "/^\s*(\d+)\s*(\d+)\s*(\d+)(.*?)(\d*)\s*(\S*)\s*(\d*)\s*(\d*)\s*$/",
                    $player,
                    $out
                );
                $num = $out[1][0];
                $score = $out[2][0];
                $ping = $out[3][0];
                $name = trim($out[4][0]);
                $lastmsg = $out[5][0];
                $address = $out[6][0];
                if ($address != 'bot') {
                    $address = preg_replace("/:.*$/", "", $address);
                }
                $qport = $out[7][0];
                $rate = $out[8][0];
                $response['players'][] = array(
                    'num' => intval($num),
                    'score' => intval($score),
                    'ping' => intval($ping),
                    'name' => $name,
                    'lastmsg' => $lastmsg,
                    'address' => $address,
                    'qport' => $qport,
                    'rate' => $rate
                );
            }
        } else {
            $response = null;
        }
        return $response;
    }

    private function get_response($timeout) {
        $s = '';
        $bang = time() + $timeout;
        while (!strlen($s) and time() < $bang) {
            usleep(500000);
            $s = $this->recv();
        }
        if (substr($s, 0, 4) === $this->cmd) {
            $s = preg_replace("/^....print\n/", "", $s);
            return $this->stripcolors($s);
        } else {
            return null;
        }
    }

    private function send($string) {
        fwrite($this->fp, $this->cmd . $string . "\n");
    }

    private function recv() {
        return fread($this->fp, 9999);
    }

    private function stripcolors($quoi) {
        // remove OSP's colors (^Xrrggbb)
        $quoi = preg_replace("/\^x....../i", "", $quoi);
        // remove Q3 colors (^2) or OSP control (^N, ^B etc..)
        return preg_replace("/\^./", "", $quoi);
    }
}

?>