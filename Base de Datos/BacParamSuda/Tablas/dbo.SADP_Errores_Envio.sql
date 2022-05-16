USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_Errores_Envio]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_Errores_Envio](
	[FechaSistema] [datetime] NULL,
	[FechaProceso] [datetime] NULL,
	[sistema] [varchar](5) NULL,
	[operacion] [numeric](10, 0) NULL,
	[codError] [int] NULL,
	[msjError] [varchar](255) NULL
) ON [PRIMARY]
GO
