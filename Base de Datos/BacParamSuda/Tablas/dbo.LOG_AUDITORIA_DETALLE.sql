USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LOG_AUDITORIA_DETALLE]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG_AUDITORIA_DETALLE](
	[Correlativo] [numeric](18, 0) NOT NULL,
	[Fecha_Transaccion] [datetime] NOT NULL,
	[Valor_Antiguo] [char](250) NULL,
	[Valor_Nuevo] [char](250) NULL
) ON [PRIMARY]
GO
