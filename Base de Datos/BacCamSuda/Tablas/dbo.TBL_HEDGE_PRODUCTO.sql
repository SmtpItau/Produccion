USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_PRODUCTO]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_PRODUCTO](
	[Codigo_Origen] [char](10) NOT NULL,
	[Codigo] [char](10) NOT NULL,
	[Descripción] [varchar](80) NOT NULL
) ON [PRIMARY]
GO
