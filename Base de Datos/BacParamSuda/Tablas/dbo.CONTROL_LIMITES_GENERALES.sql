USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CONTROL_LIMITES_GENERALES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROL_LIMITES_GENERALES](
	[Codigo_Tipo_Limite] [decimal](18, 0) NOT NULL,
	[Codigo_Limite] [decimal](18, 0) NOT NULL,
	[Descripcion_Limite] [char](30) NOT NULL,
	[Numero_operacion] [decimal](18, 0) NOT NULL,
	[Tipo_Operacion] [char](10) NOT NULL,
	[Serie] [char](60) NULL,
	[Monto_Operacion] [float] NOT NULL,
	[Monto_Linea] [float] NOT NULL,
	[Exceso] [float] NOT NULL,
	[Fecha_Exceso] [datetime] NOT NULL,
	[Plazo] [decimal](18, 0) NOT NULL,
	[Trader] [char](30) NOT NULL,
	[Trader_Autorizador] [char](30) NOT NULL,
	[Rut_Cliente] [decimal](9, 0) NOT NULL,
	[Codigo_Cliente] [decimal](9, 0) NOT NULL,
	[id_sistema] [char](3) NULL
) ON [PRIMARY]
GO
