<?php
return array(
    'url_base' => 'http://'.$_SERVER['SERVER_NAME'].'/xhprof/',
    'url_static' => null, // When undefined, it defaults to $config['url_base'] . 'public/'. This should be absolute URL.
    'pdo' => new PDO('mysql:dbname=xhprof;host='.getenv("MYSQL_SERVER_HOST").';charset=utf8', 'root', 'docker'),
    'tmp_table_engine' => 'Memory', // MySQL Table Engine used for temporary tables
    'cache_expiration' => '60', // How many seconds a browser allowed to cache profilling results
    'profiler_enabled' => true // Global switch to disable the profiler by default
);
