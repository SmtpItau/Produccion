USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_PASO]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_PASO](
	[ID_SISTEMA] [char](3) NOT NULL,
	[USUARIO] [char](20) NOT NULL,
	[FILA] [numeric](18, 0) NOT NULL,
	[VALOR] [char](30) NOT NULL,
	[CUENTA] [char](30) NOT NULL,
	[DESCRIPCION] [char](70) NOT NULL,
	[perfil] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
