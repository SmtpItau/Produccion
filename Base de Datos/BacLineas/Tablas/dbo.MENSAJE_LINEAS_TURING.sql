USE [BacLineas]
GO
/****** Object:  Table [dbo].[MENSAJE_LINEAS_TURING]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENSAJE_LINEAS_TURING](
	[Sistema] [char](3) NOT NULL,
	[NumOper] [numeric](10, 0) NOT NULL,
	[RutCli] [numeric](9, 0) NOT NULL,
	[CodCli] [numeric](9, 0) NOT NULL,
	[TipoMensaje] [varchar](255) NOT NULL,
	[Glosa] [varchar](1000) NULL,
 CONSTRAINT [PK_MENSAJE_LINEAS_TURING] PRIMARY KEY CLUSTERED 
(
	[Sistema] ASC,
	[NumOper] ASC,
	[TipoMensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
