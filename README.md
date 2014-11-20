This is a puppet module for installing phantomjs version 1.9.2. This was written
back when apt-get did not have this version of phantomjs.

To install phantomjs with this file, place this file in your modules directory
in a phantomjs folder. Then in your main init.pp file, add the following:

`class {"phantomjs":}`
