USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Respaldo_Perfil_Variable_Cnt]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Respaldo_Perfil_Variable_Cnt](
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[correlativo_perfil] [numeric](3, 0) NOT NULL,
	[valor_dato_campo] [varchar](30) NOT NULL,
	[codigo_cuenta] [char](20) NOT NULL
) ON [PRIMARY]
GO
