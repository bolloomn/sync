<?php
set_time_limit(0);

function connB($ip){
    $connB = mysqli_connect($ip, 'root', '', 'outlet') or die("Error " . mysqli_error($connB));
    mysqli_set_charset($connB,"utf8");
return $connB;
}

function connA(){
    $connA=mysqli_connect('192.168.0.107', 'root', '', 'tunglok_hq') or die("Error " . mysqli_error($connA));
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
    //if(!file_exists($saveto)){ unlink($saveto); }
    $fp = fopen($saveto,'x');
    fwrite($fp, $raw);
    fclose($fp);

}




function insert_image($table, $row, $ip){
//    $url='http://192.168.2.178/uat/uploads/';
//    $dir="C:\xampp\htdocs\iRestaurant_v4\uploads\/";
    $url='http://'.$ip.'/outlet/iRestaurant_v4/';
    $dir="/Applications/XAMPP/xamppfiles/htdocs/uat/iRestaurant_v4/uploads/";


    if($table=='item'){

        if(!is_null($row['image'])){
            grab_image($url.'item_thumb/'.$row['image'], $dir.'item_thumb/'.$row['image']);
        }

    } elseif($table=='product' or $table=='set_menu') {

        if(!is_null($row['image'])){
            grab_image($url.'product/'.$row['image'], $dir.'product/'.$row['image']);
            grab_image($url.'product/thumbs/'.$row['image'], $dir.'product/thumbs/'.$row['image']);
        }

    } elseif ($table=='organization'){

        if(!is_null($row['order_screen_image'])){
            grab_image($url.'order_screen/'.$row['order_screen_image'], $dir.'order_screen/'.$row['order_screen_image']);
        }
        if(!is_null($row['shift_screen_image'])){
            grab_image($url.'shift_screen/'.$row['shift_screen_image'], $dir.'shift_screen/'.$row['shift_screen_image']);
        }
        if(!is_null($row['logo_image'])){
            grab_image($url.'logo/'.$row['logo_image'], $dir.'logo/'.$row['logo_image']);
        }
    }
}

?>