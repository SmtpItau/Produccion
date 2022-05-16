USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[FMUTUO_SERIE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FMUTUO_SERIE](
	[serie] [char](12) NOT NULL,
	[rut_cliente] [numeric](9, 0) NULL,
	[codigo_cliente] [numeric](9, 0) NULL,
	[codigo_moneda] [numeric](5, 0) NULL,
	[Descripcion] [varchar](60) NULL,
	[Codigo_familia] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
