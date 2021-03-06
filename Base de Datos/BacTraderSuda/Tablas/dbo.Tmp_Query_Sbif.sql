USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Tmp_Query_Sbif]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmp_Query_Sbif](
	[Operacion] [varchar](41) NULL,
	[Documento] [varchar](41) NULL,
	[Correlativo] [varchar](41) NULL,
	[Direccion] [varchar](4) NOT NULL,
	[FechaInicioPacto] [char](10) NULL,
	[FechaTerminoPacto] [char](10) NULL,
	[TipoContraparte] [int] NOT NULL,
	[TipoColateral] [int] NOT NULL,
	[Denominacion] [int] NOT NULL,
	[MontoOperacion] [numeric](19, 4) NULL,
	[MonedaColateral] [int] NOT NULL,
	[EscalaRiesgo] [varchar](8) NOT NULL,
	[RiesgoColateral] [varchar](10) NULL,
	[MadurezPromedio] [float] NULL,
	[TasaPacto] [numeric](9, 4) NOT NULL,
	[BasePacto] [int] NOT NULL,
	[AgenteCalculoInicio] [int] NOT NULL,
	[AgenteCalculo] [int] NOT NULL,
	[SpreadTasaMercado] [numeric](21, 4) NULL,
	[Custodia] [int] NOT NULL,
	[Sustitucion] [int] NOT NULL,
	[Derechos] [int] NULL,
	[RutEmisor] [numeric](9, 0) NOT NULL,
	[Serie] [char](12) NOT NULL,
	[IdCorrela] [bigint] NULL
) ON [PRIMARY]
GO
