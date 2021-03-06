USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CODIGO_PLANILLA_AUTOMATICA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_PLANILLA_AUTOMATICA](
	[fecha] [datetime] NOT NULL,
	[tipo_documento] [numeric](1, 0) NOT NULL,
	[tipo_operacion_cambio] [numeric](3, 0) NOT NULL,
	[comercio] [char](6) NOT NULL,
	[concepto] [char](3) NOT NULL,
	[condicion] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
