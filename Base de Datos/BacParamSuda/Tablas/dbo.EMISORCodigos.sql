USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[EMISORCodigos]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMISORCodigos](
	[EmRut] [numeric](9, 0) NOT NULL,
	[EmCod] [char](3) NOT NULL
) ON [PRIMARY]
GO
