<?php
//Database credentials
$servername = "localhost";
$username = "root";//Default username for XAMPP
$password = "";//default password for XAMPP
$dbname = "final_year_project";

//create a connection to the database
$conn=new mysqli($servername, $username, $password, $dbname);

//check connection
if($conn->connect_error){
    die("Connection failed: ". $conn->connect_error);
}
