USE [MDPasivo]
GO
/****** Object:  Table [dbo].[LOG_AUDITORIA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG_AUDITORIA](
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
	[ValorAntiguo] [varchar](250) NOT NULL,
	[ValorNuevo] [varchar](250) NOT NULL,
	[Correlativo] [numeric](21, 0) IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
