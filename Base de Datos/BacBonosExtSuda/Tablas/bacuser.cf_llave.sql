USE [BacBonosExtSuda]
GO
/****** Object:  Table [bacuser].[cf_llave]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[cf_llave](
	[llave] [numeric](16, 0) NOT NULL,
	[monto] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
