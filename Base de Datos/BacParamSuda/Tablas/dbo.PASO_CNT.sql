USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PASO_CNT]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PASO_CNT](
	[ID_sistema] [char](3) NOT NULL,
	[usuario] [char](20) NOT NULL,
	[FILA] [numeric](18, 0) NOT NULL,
	[VALOR] [char](30) NOT NULL,
	[CUENTA] [char](30) NOT NULL,
	[DESCRIPCION] [char](70) NOT NULL,
	[perfil] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
