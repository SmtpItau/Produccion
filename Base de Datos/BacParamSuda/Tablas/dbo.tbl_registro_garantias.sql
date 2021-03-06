USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_registro_garantias]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_registro_garantias](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL,
	[CodCliente] [numeric](5, 0) NOT NULL,
	[Sistema] [varchar](3) NOT NULL,
	[OperacionSistema] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_registro_garantias]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Registro_Garantias_tbl_Mov_Garantia] FOREIGN KEY([NumeroOperacion])
REFERENCES [dbo].[tbl_Mov_Garantia] ([NumeroOperacion])
GO
ALTER TABLE [dbo].[tbl_registro_garantias] CHECK CONSTRAINT [FK_tbl_Registro_Garantias_tbl_Mov_Garantia]
GO
