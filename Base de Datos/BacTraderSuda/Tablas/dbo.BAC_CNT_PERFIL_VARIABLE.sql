USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_PERFIL_VARIABLE]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_PERFIL_VARIABLE](
	[folio_perfil] [numeric](5, 0) NULL,
	[correlativo_perfil] [numeric](3, 0) NULL,
	[valor_dato_campo] [varchar](30) NULL,
	[codigo_cuenta] [char](20) NULL
) ON [PRIMARY]
GO
