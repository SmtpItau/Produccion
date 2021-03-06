USE [BacParamSuda]
GO
/****** Object:  Table [bacuser].[RESPALDO_LOG_AUDITORIA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[RESPALDO_LOG_AUDITORIA](
	[Entidad] [char](2) NOT NULL,
	[FechaProceso] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[HoraProceso] [char](8) NOT NULL,
	[Terminal] [char](15) NOT NULL,
	[Usuario] [char](15) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[CodigoMenu] [varchar](12) NOT NULL,
	[Codigo_Evento] [varchar](2) NOT NULL,
	[DetalleTransac] [varchar](250) NOT NULL,
	[TablaInvolucrada] [varchar](50) NOT NULL,
	[ValorAntiguo] [ntext] NULL,
	[ValorNuevo] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
