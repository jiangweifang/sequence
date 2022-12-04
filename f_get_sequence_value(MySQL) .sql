CREATE DEFINER = CURRENT_USER FUNCTION `f_get_sequence_value`(
	`as_seqname` VARCHAR(50),
	`as_prefix` VARCHAR(20),
	`as_seqcount` INT,
	`as_seqlen` INT,
	`is_date` tinyint
) RETURNS varchar(50) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE _count INT DEFAULT 0;
  DECLARE _tableID INT DEFAULT 0;
  DECLARE _result varchar(50) DEFAULT '';
	-- 初始化 尾数的跨度（可用做随机）
	IF (as_seqcount <= 0) THEN
		SET as_seqcount = 1;
	END IF;
	-- 补位的数量 初始值有多少个0 不可以大于10个
	IF(as_seqlen <= 0) THEN
		SET as_seqlen = 1;
	ELSEIF(as_seqlen >= 10) THEN
		SET as_seqlen = 10;
	END IF;
	-- 转小写
	SET as_seqname = LOWER(as_seqname);
	-- 是否存在这个序列名称的记录
	SELECT COUNT(1) into _count FROM `Table_Serial_Number` t WHERE t.TABNAME = as_seqname;
	
	IF(_count > 0) THEN
			UPDATE `Table_Serial_Number`
				SET `CURRSERIALNUMBER` = `CURRSERIALNUMBER` + as_seqcount
				WHERE `TABNAME` = as_seqname AND ISENABLE = 1;
			SELECT CONCAT(CONVERT(t.CURRSERIALNUMBER,SIGNED)) into _result 
				FROM `Table_Serial_Number` as t
				WHERE t.`TABNAME` = as_seqname AND t.ISENABLE = 1;
	ELSE
		SET _result = CONCAT(RPAD('1',as_seqlen - 1,'0'),1);
		INSERT INTO `Table_Serial_Number`(`TABNAME`,`STARTSERIALNUMBER`,`CURRSERIALNUMBER`,`SERIALNUMBERLEN`,`ISENABLE`,`CREATER`,`CRATTEDATE`)
			VALUES(as_seqname,_result, CAST(_result as DECIMAL) + as_seqcount, as_seqlen, '1', 'f_get_sequence_value' ,NOW());
	END IF;
	
	IF (is_date = 1) THEN
		SET _result = CONCAT(IF(ISNULL(as_prefix),'',as_prefix), DATE_FORMAT(NOW(),'%Y%m%d'), _result);
	ELSE
		SET _result = CONCAT(IF(ISNULL(as_prefix),'',as_prefix), _result);
	END IF;
	
	RETURN _result;
END
