<?php
include 'dbInterface.php';
$connect = mysql_connect(dbInterface::DB_PATH,dbInterface::DB_LOGIN, dbInterface::DB_PASSWORD) OR DIE("cannot connect to server".mysql_error());
mysql_select_db('mydb') OR DIE('cannot choose db'.mysql_error());

?>