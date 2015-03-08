# ng-quake3-rcon
Rcon web interface for Quake 3 arena

# Prerequisintes for installing / running
* apache2 https://httpd.apache.org/
* PHP5 http://php.net/
* imagemagick http://www.imagemagick.org/
* a bash shell https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29

# Prerequisites for Building
* node.js http://nodejs.org/
* grunt http://gruntjs.com/
* bower http://bower.io/
* coffeescript http://coffeescript.org/

# Before building (Ubuntu)
`sudo apt-get install nodejs-legacy npm`

`sudo npm install grunt grunt-cli bower`

`wget https://github.com/roccivic/ng-quake3-rcon/archive/master.zip`

`unzip master.zip`

`cd ng-quake3-rcon-master/frontend`

`npm install && bower install`

# Building (Ubuntu)
* change the path to the backend in `frontend/app/scripts/services/serverurl.coffee`
* change required directives in `backend/config.php`

* `grunt serve` command from the `frontend` folder to start a new development server

run `grunt build` command from the `frontend` folder to create a deployable build
the output of the build will be located in the `dist` folder
