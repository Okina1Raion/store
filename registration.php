<html>
    <head>
        <meta charset="utf-8">
    </head>
</html>
<?php
require 'dbInterface.php';
require 'useful.php';
$connection = new mysqli(dbInterface::DB_PATH, dbInterface::DB_LOGIN, dbInterface::DB_PASSWORD, dbInterface::DB_NAME);

$login = $_POST['login'];
$name = $_POST['name'];
$telephone = $_POST['telephone'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$hash = sha1(useful::hash_generator());

$sql = "INSERT INTO users (name, login, password, telephone, email, hash) VALUES ('".$name."','".$login."','".$password."','".$telephone."','".$email."','".$hash."');";
$sql .= " INSERT INTO isActive (user_id, get_query) VALUES ((SELECT MAX(id_user) FROM users ),'".sha1(useful::hash_generator())."');";
$connection -> multi_query($sql);
$connection->error;

$connection->close();
?>