<meta charset="utf-8">
<meta http-equiv="refresh" content="10; url=<?php echo $_SERVER['PHP_SELF']; ?>"/>
<?php
include "config.php";

/* А сервертэй холбогдох */
$connA = connA();
/* хамгийн сүүлд sync хийсэн ID-г авах */
$select = mysqli_query($connA, 'SELECT log_id FROM `table_log_sync` order by id DESC LIMIT 1');
$log_id = mysqli_fetch_object($select);
$last_log_id = $log_id->log_id;
/* хамгийн сүүлийн table log  хийсэн ID-г авах */
$select = mysqli_query($connA, "SELECT max(id) as maxid FROM table_logs");
$max_log_id = mysqli_fetch_object($select);
$max_log_id = $max_log_id->maxid;
if ($last_log_id != $max_log_id) {
    /* А серверлүү хуулж эхлэх */
    $select = mysqli_query($connA, 'SELECT id, action, table_name, table_id FROM table_logs WHERE id>=' . $last_log_id . ' ORDER BY id ASC');
    while ($row = mysqli_fetch_assoc($select)) {
        $last_log_id = $row['id'];
        if (!action($row)) {
            break;
        }
    }
}
/* хамгийн сүүлд sync хийсэн ID-г хадгалах */
$last_query = "insert into table_log_sync(`id`, `log_id`, `date`) values(NULL, '" . $last_log_id . "', NOW())";
mysqli_query($connA, $last_query);
$id = mysqli_insert_id($connA);
mysqli_query($connA, 'delete from table_log_sync where id!=' . $id);
/* холболтоо салгах */
mysqli_close($connA);

/*action function*/
function action($row)
{
    if ($row['action'] == 'insert') {
        if (!insert($row['table_name'], $row['table_id'])) {
            return false;
        }
    } elseif ($row['action'] == 'update') {
        if (!update($row['table_name'], $row['table_id'], $row['id'])) {
            return false;
        }
    } elseif ($row['action'] == 'delete') {
        if (!delete($row['table_name'], $row['table_id'])) {
            return false;
        }
    }
    return true;
}

/*insert function*/
function insert($table, $id)
{
    global $connA;

    $select = "select * from " . $table . " where id=" . $id;
    $query = mysqli_query($connA, $select);
    if (!$query) { return true; }
    $row = mysqli_fetch_assoc($query);

    if (is_null($row)) { return true; }
    if($id>=100000000000) { $servers = findServer(floor($id/100000000000)); insert_image($table, $row, $servers[0]);  return true; }
    foreach ($row as $k => $v) {if (is_null($v)) { unset($row[$k]); } }
    $insert = "insert into `" . $table . "`( `" . implode('`, `', array_keys($row)) . "`) values('" . implode("', '", $row) . "')";

    if(array_key_exists('org_id', $row)){ $servers= findServer($row['org_id']); }
    else { $servers=findServer(0); }

    foreach ($servers as $server ){
        $connB=connB($server);
        if(not_inserted($table, $id, $connB)){
            if (!mysqli_query($connB, $insert)) {
                return false;
                mysqli_query($connA, "insert into table_log_error(text) VALUES ('" . str_replace("'", "\'", $insert) . "')");
            }
        }
        mysqli_close($connB);
    }
    return true;
}

/*update function*/
function update($table, $id, $log_id)
{
    global $connA;

    $select = "select * from " . $table . " where id=" . $id;
    $query = mysqli_query($connA, $select);
    if (!$query or is_null($query)) { return true; }
    $row = mysqli_fetch_assoc($query);
    if (is_null($row))  { return true; }

    if($id>=100000000000){
          $servers = findServer(floor($id/100000000000));
        insert_image($table, $row, $servers[0]);
    } else {
        if(array_key_exists('org_id', $row)){ $servers= findServer($row['org_id']); }
        else { $servers=findServer(0); }
    }
    unset($row['id']);
    $update = "update " . $table . " set ";
    foreach ($row as $k => $v) {
        if (!is_null($v)) {
            $update .= "`" . $k . "`='" . $v . "', ";
        } else {
            $update .= "`" . $k . "`= NULL, ";
        }
    }
    $update .= "id=" . $id . " ";
    $update .= "where id=" . $id;

    foreach ($servers as $server ){
        $connB=connB($server);
        $queryB=mysqli_query($connB, $select);
        $rowB=mysqli_fetch_assoc($queryB);

        if(implode(',',$row)!=implode(',',$rowB)){
            if (!mysqli_query($connB, $update)) {

                mysqli_query($connA, "insert into table_log_error(text) VALUES ('" . str_replace("'", "\'", $update) . "')");
                return false;
            }
        } else {
            mysqli_query($connA, "delete form table_logs where id=".$log_id);
            return true;
        }
        mysqli_close($connB);
    }
    return true;

}

/*delete function*/
function delete($table, $id)
{
    global $connA;
    $select = "select * from " . $table . " where id=" . $id;
    $query = mysqli_query($connA, $select);
    if (!$query or is_null($query)) { return true; }
    $row = mysqli_fetch_assoc($query);
    if (is_null($row)) { return true; }
    if($id>=100000000000){
        $servers = findServer(floor($id/100000000000));
    } else {
        if(array_key_exists('org_id', $row)){ $servers= findServer($row['org_id']); }
        else { $servers=findServer(0); }
    }

    $delete = "delete from " . $table . " where id='" . $id . "'";

    foreach ($servers as $server ) {
        $connB = connB($server);
        if (!mysqli_query($connB, $delete)) {
            return false;
            mysqli_query($connA, "insert into table_log_error(text) VALUES ('" . str_replace("'", "\'", $delete) . "')");
        }
        mysqli_close($connB);
    }
    return true;
}

function findServer($orgID = 0)
{
    global $connA;
    $where = "";
    if ($orgID != 0) { $where = "where id=" . $orgID; }
    $select = "select outlet_server_ip from organization " . $where;
    $query = mysqli_query($connA, $select);
    $return = [];
    while ($row = mysqli_fetch_object($query)){
        $return[] =$row->outlet_server_ip;
    }
    return $return;
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