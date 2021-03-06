USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[Log_Auditoria]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Auditoria](
	[Entidad] [char](2) NOT NULL,
	[FechaProceso] [datetime] NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[HoraProceso] [char](8) NOT NULL,
	[Terminal] [varchar](15) NOT NULL,
	[Usuario] [char](15) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[CodigoMenu] [varchar](12) NOT NULL,
	[Codigo_Evento] [varchar](2) NOT NULL,
	[DetalleTransac] [varchar](250) NOT NULL,
	[Query] [ntext] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Log_Auditoria] ADD  DEFAULT ('') FOR [Query]
GO
