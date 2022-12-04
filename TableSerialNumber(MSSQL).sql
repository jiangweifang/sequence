
-- ----------------------------
-- Table structure for TableSerialNumber
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[TableSerialNumber]') AND type IN ('U'))
	DROP TABLE [dbo].[TableSerialNumber]
GO

CREATE TABLE [dbo].[TableSerialNumber] (
  [TABID] int  IDENTITY(1,1) NOT NULL,
  [TABNAME] nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [STARTSERIALNUMBER] decimal(16)  NOT NULL,
  [CURRSERIALNUMBER] decimal(16)  NOT NULL,
  [SERIALNUMBERLEN] decimal(9)  NOT NULL,
  [ISENABLE] bit  NOT NULL,
  [CREATER] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [CRATTEDATE] datetime  NULL
)
GO


-- ----------------------------
-- Auto increment value for TableSerialNumber
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[TableSerialNumber]', RESEED, 7)
GO


-- ----------------------------
-- Primary Key structure for table TableSerialNumber
-- ----------------------------
ALTER TABLE [dbo].[TableSerialNumber] ADD CONSTRAINT [PK__TableSer__06E5D919AAC9F931] PRIMARY KEY CLUSTERED ([TABID])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

