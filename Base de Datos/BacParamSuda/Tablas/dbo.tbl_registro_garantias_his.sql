USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_registro_garantias_his]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_registro_garantias_his](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL,
	[CodCliente] [numeric](5, 0) NOT NULL,
	[Sistema] [varchar](3) NOT NULL,
	[OperacionSistema] [numeric](10, 0) NOT NULL,
	[FechaRespaldo] [datetime] NULL
) ON [PRIMARY]
GO
