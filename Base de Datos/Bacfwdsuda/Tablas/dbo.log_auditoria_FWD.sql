USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[log_auditoria_FWD]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_auditoria_FWD](
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
