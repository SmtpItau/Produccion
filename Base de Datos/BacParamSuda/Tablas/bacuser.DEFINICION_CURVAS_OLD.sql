USE [BacParamSuda]
GO
/****** Object:  Table [bacuser].[DEFINICION_CURVAS_OLD]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[DEFINICION_CURVAS_OLD](
	[CodigoCurva] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[TipoCurva] [char](1) NOT NULL
) ON [PRIMARY]
GO
