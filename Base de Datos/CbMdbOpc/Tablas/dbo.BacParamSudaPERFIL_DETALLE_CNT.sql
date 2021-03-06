USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaPERFIL_DETALLE_CNT]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaPERFIL_DETALLE_CNT](
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[codigo_campo] [numeric](3, 0) NULL,
	[tipo_movimiento_cuenta] [char](1) NULL,
	[perfil_fijo] [char](1) NULL,
	[codigo_cuenta] [char](20) NULL,
	[correlativo_perfil] [numeric](3, 0) NOT NULL,
	[codigo_campo_variable] [numeric](3, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[folio_perfil] ASC,
	[correlativo_perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
