ALTER PROCEDURE [dbo].[f_get_sequence_value]
    (
      @as_seqname VARCHAR(50) ,
      @as_prefix VARCHAR(20) ,
			@as_seqcount INT,
			@as_seqlen INT,
			@is_date BIT,
			@result VARCHAR(50) OUTPUT
    )
AS 
    BEGIN
        DECLARE @_count INT = 0;
        DECLARE @tableID INT = 0;
        DECLARE @initial DECIMAL = 0;
		-- 初始化 尾数的跨度（可用做随机）
		IF(@as_seqcount <= 0)
			BEGIN
				SET @as_seqcount = 1;
			END
		-- 补位的数量 初始值有多少个0 不可以大于10个
		IF(@as_seqlen <= 0)
			BEGIN
				SET @as_seqlen = 1;
			END
		ELSE IF(@as_seqlen >= 10)
			BEGIN
				SET @as_seqlen = 10;
			END
		-- 转小写
		SET @as_seqname = LOWER(@as_seqname);
		-- 是否存在这个序列名称的记录
		SELECT  @_count = COUNT(1) FROM [dbo].[TableSerialNumber] t WHERE   t.TABNAME = @as_seqname;

		IF ( @_count > 0 ) 
			BEGIN
				UPDATE  t1
                SET     t1.CURRSERIALNUMBER = t1.CURRSERIALNUMBER + @as_seqcount
                FROM    [dbo].[TableSerialNumber] AS t1
                WHERE   t1.TABNAME = @as_seqname AND t1.ISENABLE = 1;

                SELECT  @result = CONVERT(VARCHAR(30), t.CURRSERIALNUMBER)
                FROM    [dbo].[TableSerialNumber] t
                WHERE   t.TABNAME = @as_seqname AND t.ISENABLE = 1;
			END
		ELSE
			BEGIN
			-- 这里在前面补位1 所以要-1 这样在查询的时候才可以补回来
				SET @result = CONCAT(1,REPLICATE('0',@as_seqlen - 1),1);
				INSERT INTO [dbo].[TableSerialNumber] ([TABNAME],[STARTSERIALNUMBER],[CURRSERIALNUMBER],[SERIALNUMBERLEN],[ISENABLE],[CREATER],[CRATTEDATE])
				       VALUES (@as_seqname, @result, CAST(@result as DECIMAL)+@as_seqcount, @as_seqlen, '1', 'f_get_sequence_value', GETDATE());
			END

		IF (@is_date = 1)
			BEGIN
				set @result = concat(ISNULL(@as_prefix,''), CONVERT(varchar(100), GETDATE(), 112), @result);
			END
		ELSE
			BEGIN
				set @result = CONCAT(ISNULL(@as_prefix,''), @result);
			END
    END