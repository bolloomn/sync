<meta charset="utf-8">
<meta http-equiv="refresh" content="10; url=<?php echo $_SERVER['PHP_SELF']; ?>" />
<?php
include "config.php";
$AID=orgID()*100000000000;

/* B сервертэй холбогдох */
$connB=connOutlet();

/* А сервертэй холбогдох */
$connA=connHq();
/* хамгийн сүүлд sync хийсэн ID-г авах */
$select=mysqli_query($connB, 'SELECT log_id FROM `table_log_sync` order by id DESC LIMIT 1');
$log_id=mysqli_fetch_object($select);
$last_log_id=$log_id->log_id;

/* хамгийн сүүлийн table log  хийсэн ID-г авах */
$select = mysqli_query($connB, "SELECT max(id) as maxid FROM table_logs");
$max_log_id=mysqli_fetch_object($select);
$max_log_id=$max_log_id->maxid;

if($last_log_id!=$max_log_id) {
    /* А серверлүү хуулж эхлэх */
    $select = mysqli_query($connB, 'SELECT id, action, table_name, table_id FROM table_logs WHERE id>=' . $last_log_id . ' ORDER BY id ASC ');
    while ($row = mysqli_fetch_assoc($select)) {
        $last_log_id = $row['id'];
        if(!action($row)){ break; }
    }
}

/* хамгийн сүүлд sync хийсэн ID-г хадгалах */
$last_query="insert into table_log_sync(`id`, `log_id`, `date`) values(NULL, '".$last_log_id."', NOW())";
mysqli_query($connB,$last_query);
$id=mysqli_insert_id($connB);
mysqli_query($connB, 'delete from table_log_sync where id!='.$id);

/* холболтоо салгах */
mysqli_close($connB);
mysqli_close($connA);


/*action function*/
function action($row){

    if($row['action']=='insert'){

        if(!insert($row['table_name'], $row['table_id'])) {
            return false;
        }
    }
    elseif($row['action']=='update') {
        if(!update($row['table_name'], $row['table_id'], $row['id'])){
            return false;
        }
    }
    elseif($row['action']=='delete'){
        if(!delete($row['table_name'], $row['table_id'])){
            return false;
        }
    }
    return true;
}

/*insert function*/
function insert($table, $id){

	global $connB, $connA, $AID;
	$select="select * from ".$table." where id=".$id;
	$query=mysqli_query($connB, $select);
	if(!$query) {  return true; }
    $row=mysqli_fetch_assoc($query);
    if(is_null($row)) { return true; }

    if($id<100000000000){ insert_image($table, $row); return true; }

    foreach($row as $k=>$v) { if(is_null($v)) { unset($row[$k]); } }
    $query=" insert into `".$table."`(`".implode('`, `',array_keys($row))."`) values('".implode("', '",$row)."')";
    if(!not_inserted($table, $id, $connA)) { return true; }
    if(mysqli_query($connA, $query)){
        return true;
    } else {
        mysqli_query($connB, "insert into table_log_error(text) VALUES ('".str_replace("'", "\'", $query)."')");
        return false;
    }
}

/*update function*/
function update($table, $id, $log_id){
	global $connB, $connA;

	$select="select * from ".$table." where id=".$id;
	$query=mysqli_query($connB, $select);
    if(is_null($query)) { return true; }
    $row=mysqli_fetch_assoc($query);
    if(is_null($row)) { return true; }

    $queryA=mysqli_query($connA, $select);
    $rowA=mysqli_fetch_assoc($queryA);
    if(implode(',',$row)==implode(',',$rowA)){ mysqli_query($connB, "delete form table_logs where id=".$log_id); return true; }
    insert_image($table, $row);
    unset($row['id']);
    $query = "update " . $table . " set ";
    foreach ($row as $k => $v) {
        if (!is_null($v)) { $query .= "`" . $k . "`='" . $v . "', "; }
        else { $query .= "`" . $k . "`= NULL, "; }
    }
    $query .= " id=".$id."  where id=" . $id ;

    if (mysqli_query($connA, $query)) {
        return true;
    } else {
        mysqli_query($connB, "insert into table_log_error(text) VALUES ('" . str_replace("'", "\'", $query) . "')");
        return false;
    }
}

/*delete function*/
function delete($table, $id){
	global $connB, $connA;
    $query="delete from ".$table." where id='".$id."'";
	if(mysqli_query($connA, $query)){
        return true;
    } else {
        mysqli_query($connB, "insert into table_log_error(text) VALUES ('".str_replace("'", "\'", $query)."')");
        return false;
    }
}

function not_inserted($table, $id, $connB){
    $select = "SELECT count(0) as cnt FROM `".$table."` WHERE id=" . $id;
    $query = mysqli_query($connB, $select);
    $row = mysqli_fetch_object($query);
    if($row->cnt==0) {
        return true;
    } else {
        return false;
    }
}



?>