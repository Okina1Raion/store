<?php
require 'dbInterface.php';

$login = $_POST['login'];
$email = $_POST['email'];

$connection = new mysqli(dbInterface::DB_PATH, dbInterface::DB_LOGIN, dbInterface::DB_PASSWORD, dbInterface::DB_NAME);

$sql = '';

if($email != null){
        $sql = "SELECT email FROM users WHERE email = '".$email."';";
        $result = $connection->query($sql);
        if($result->num_rows != 0){
            echo true;
        } else{
            echo false;
        }
    } else {
        $sql = "SELECT login FROM users WHERE login = '".$email."';";
        $result = $connection->query($sql);
        if($result->num_rows != 0){
            echo true;
        } else{
            echo false;
        }
    }
?>