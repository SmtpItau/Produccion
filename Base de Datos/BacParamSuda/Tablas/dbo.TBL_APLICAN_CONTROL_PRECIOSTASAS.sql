USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_APLICAN_CONTROL_PRECIOSTASAS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_APLICAN_CONTROL_PRECIOSTASAS](
	[codSistema] [char](3) NOT NULL,
	[codProducto] [char](5) NOT NULL,
	[aplicaControl] [char](1) NOT NULL
) ON [PRIMARY]
GO
