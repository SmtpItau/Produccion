USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ARB_FWD_CORRESPONSAL]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARB_FWD_CORRESPONSAL](
	[CoCorrela] [numeric](10, 0) NOT NULL,
	[CoMoneda] [numeric](10, 0) NOT NULL,
	[CoTipo_Op] [char](1) NOT NULL,
	[CoCodigo_Contable] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
