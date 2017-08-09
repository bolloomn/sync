<?php
include "../config.php";
$conn_b = connA();



/* Бүх тавле дээр триггэр үүсгэх */
$query_table_list=mysqli_query($conn_b, 'show tables');

while($table = mysqli_fetch_row($query_table_list)){

    $not= array('table_logs', 'table_log_sync', 'table_log_error', 'employee_sessions', 'table_log_error', 'hq_user' , 'ci_sessions');

    if(!in_array( $table[0],  $not)){

	mysqli_query($conn_b, "DROP TRIGGER IF EXISTS `trigger_".$table[0]."_insert_id`");
	//ID TOOTSOOLOH
	$trigger = "
	CREATE  TRIGGER `trigger_".$table[0]."_insert_id` 
	BEFORE INSERT ON `".$table[0]."` 
	FOR EACH ROW BEGIN 
		IF((SELECT COUNT(0) FROM ".$table[0]." WHERE id<100000000000)=0) THEN 
			SET NEW.id=1; 
		ELSEIF(NEW.id is NULL) THEN 
			SET NEW.id = (SELECT MAX(id) + 1 FROM ".$table[0]." WHERE id <100000000000); 
		END IF; 
	END
	";
	echo $trigger.'<br><br>';
	mysqli_query($conn_b, $trigger);
   echo "created trigger trigger_".$table[0]."_insert_id <br>";

     insert trigger
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