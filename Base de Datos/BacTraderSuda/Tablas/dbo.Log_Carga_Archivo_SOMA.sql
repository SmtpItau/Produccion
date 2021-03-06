USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Log_Carga_Archivo_SOMA]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Carga_Archivo_SOMA](
	[FechaProceso] [datetime] NOT NULL,
	[HoraProceso] [char](15) NOT NULL,
	[Terminal] [char](15) NOT NULL,
	[Usuario] [char](15) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Tipo_Operacion] [char](3) NOT NULL,
	[FolioSOMA] [numeric](9, 0) NOT NULL,
	[CorrelaSOMA] [numeric](3, 0) NOT NULL,
	[Serie] [varchar](20) NOT NULL,
	[Nominal_SOMA] [float] NOT NULL,
	[Nominal_BAC] [float] NOT NULL,
	[Nombre_Archivo] [varchar](50) NOT NULL,
	[Observacion_Carga] [varchar](250) NOT NULL
) ON [PRIMARY]
GO
