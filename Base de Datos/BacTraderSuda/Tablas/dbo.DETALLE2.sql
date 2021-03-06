USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[DETALLE2]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE2](
	[folio_perfil] [numeric](5, 0) NULL,
	[codigo_campo] [numeric](3, 0) NULL,
	[tipo_movimiento_cuenta] [char](1) NULL,
	[perfil_fijo] [char](1) NULL,
	[codigo_cuenta] [char](20) NULL,
	[correlativo_perfil] [numeric](3, 0) NULL,
	[codigo_campo_variable] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
