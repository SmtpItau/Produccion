USE [MDPasivo]
GO
/****** Object:  Table [dbo].[FORWARD_RUTINAS]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORWARD_RUTINAS](
	[Codigo_Producto] [varchar](5) NOT NULL,
	[Codigo_Subproducto] [varchar](15) NOT NULL,
	[IndicadoCP] [varchar](1) NOT NULL,
	[Rutina] [varchar](50) NULL
) ON [PRIMARY]
GO
