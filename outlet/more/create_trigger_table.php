<?php
include "../config.php";
$conn_b = connOutlet();
$conn_a=connHq();

$select="SELECT max(id)+1 as id FROM `organization`";
$query=mysqli_query($conn_a, $select);
$row=mysqli_fetch_object($query);
if(is_null($row->id)){ $AID=100000000000; }
else { $AID=$row->id.'00000000001'; }
mysqli_close($conn_a);



/* Бүх тавле дээр триггэр үүсгэх */
$query_table_list=mysqli_query($conn_b, 'show tables');

while($table = mysqli_fetch_row($query_table_list)){



    $not= array('table_logs', 'table_log_sync', 'brand', 'employee_sessions', 'table_log_error', 'hq_user' , 'ci_sessions',  'organization_type', 'user_group');

    if(!in_array( $table[0],  $not)) {

    mysqli_query($conn_b, 'ALTER TABLE ' . $table[0] . ' AUTO_INCREMENT=' . $AID);
    echo "created " . $table[0] . " AUTO_INCREMENT <br>";

	//insert trigger
	mysqli_query($conn_b, "
	CREATE TRIGGER `trigger_".$table[0]."_insert`
	AFTER INSERT ON `".$table[0]."`
	FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'insert', '".$table[0]."', new.id, CURRENT_TIMESTAMP)"
	);
        mysqli_error($conn_b);
	echo "created trigger trigger_".$table[0]."_insert <br>";

	//update trigger
	mysqli_query($conn_b, "
	CREATE TRIGGER `trigger_".$table[0]."_update`
	BEFORE UPDATE ON ".$table[0]."
	FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'update', '".$table[0]."', new.id, CURRENT_TIMESTAMP)");
	echo "created trigger trigger_".$table[0]."_update <br>";

	//delete tirrger
	mysqli_query($conn_b, "
	CREATE TRIGGER `trigger_".$table[0]."_delete`
	BEFORE DELETE ON ".$table[0]."
	FOR EACH ROW INSERT INTO `table_logs`
	(`id`, `action`, `table_name`, `table_id`, `time`)
	VALUES (NULL, 'delete', '".$table[0]."', OLD.id, CURRENT_TIMESTAMP)");
	echo "created trigger trigger_".$table[0]."_delete <br>";
    }

}
mysqli_close($conn_b);
?>