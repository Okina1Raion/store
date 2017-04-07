<?php
include 'dbInterface.php';
analiseSearch();
function analiseSearch(){
	$strings = explode(" ", $_GET["s"]);
	for($i = 0; $i<count($strings); $i++){
		echo $strings[$i];
	}
}

?>