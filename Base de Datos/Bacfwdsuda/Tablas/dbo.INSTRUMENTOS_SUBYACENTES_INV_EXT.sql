USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[INSTRUMENTOS_SUBYACENTES_INV_EXT]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INSTRUMENTOS_SUBYACENTES_INV_EXT](
	[Cod_Familia] [numeric](4, 0) NULL,
	[Cod_Nemo] [char](20) NULL,
	[Fecha_Vcto] [datetime] NULL
) ON [PRIMARY]
GO
