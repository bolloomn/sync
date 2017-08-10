<?php
set_time_limit(0);
function orgID(){
    return 1;
}

function connOutlet(){
    $connB = mysqli_connect('localhost', 'root', '', 'tunglok_outlet') or die("Error " . mysqli_error($connB));
    mysqli_set_charset($connB,"utf8");
return $connB;
}

function connHq(){
    $connA=mysqli_connect('116.14.130.119', 'root', 'vantage1011', 'tunglok_hq') or die("Error " . mysqli_error($connA));
    mysqli_set_charset($connA,"utf8");
    return $connA;
}


function grab_image($url,$saveto){
    $ch = curl_init ($url);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
    $raw=curl_exec($ch);
    curl_close ($ch);
   // if(!file_exists($saveto)){ unlink($saveto); }
    $fp = fopen($saveto,'x');
    fwrite($fp, $raw);
    fclose($fp);

}

function insert_image($table, $row){
    $url='http://eisol.co:8080/uat/iRestaurant_v4/uploads/';
    $dir="/Applications/XAMPP/xamppfiles/htdocs/iRestaurant_v4/uploads/";

    if($table=='item'){
        if(!is_null($row['image'])){
            grab_image($url.'item_thumb/'.$row['image'], $dir.'item_thumb/'.$row['image']);
        }
    } elseif($table=='product' or $table=='set_menu') {
        if(!is_null($row['image'])){
            grab_image($url.'product/'.$row['image'], $dir.'product/'.$row['image']);
        }
    } elseif($table=='addons'){
        if(!is_null($row['image'])){
            grab_image($url.'addons/'.$row['image'], $dir.'addons/'.$row['image']);
        }
    } elseif($table=='employee'){
        if(!is_null($row['avatar'])){
            grab_image($url.'avatar/'.$row['avatar'], $dir.'avatar/'.$row['avatar']);
        }
        if(!is_null($row['pass_image'])){
            grab_image($url.'pass/'.$row['pass_image'], $dir.'pass/'.$row['pass_image']);
        }
    }

}




?>