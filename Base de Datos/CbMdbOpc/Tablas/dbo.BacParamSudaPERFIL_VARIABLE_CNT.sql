USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaPERFIL_VARIABLE_CNT]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaPERFIL_VARIABLE_CNT](
	[folio_perfil] [numeric](5, 0) NOT NULL,
	[correlativo_perfil] [numeric](3, 0) NOT NULL,
	[valor_dato_campo] [varchar](30) NOT NULL,
	[codigo_cuenta] [char](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[folio_perfil] ASC,
	[correlativo_perfil] ASC,
	[valor_dato_campo] ASC,
	[codigo_cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
