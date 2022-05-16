USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PERFIL_VARIABLE_CNT_RESP2209]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFIL_VARIABLE_CNT_RESP2209](
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[correlativo_perfil] [numeric](3, 0) NOT NULL,
	[valor_dato_campo] [varchar](30) NOT NULL,
	[codigo_cuenta] [char](20) NOT NULL
) ON [PRIMARY]
GO
