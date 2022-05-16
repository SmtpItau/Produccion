USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbInstrumentoDerivado]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbInstrumentoDerivado](
	[codigo_numerico] [numeric](9, 0) NULL,
	[codigo_caracter] [char](10) NULL,
	[glosa] [char](50) NULL
) ON [PRIMARY]
GO
