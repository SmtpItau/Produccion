USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Aprobacion_hedge]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aprobacion_hedge](
	[Tipo_Operacion] [char](10) NOT NULL,
	[Monto_Operacion] [numeric](21, 4) NOT NULL,
	[Tipo_Cambio] [numeric](21, 4) NOT NULL,
	[Mercado] [char](4) NOT NULL,
	[Usuario] [char](15) NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Autoriza] [char](15) NOT NULL,
	[Aprobado] [numeric](1, 0) NOT NULL,
	[Producto] [char](30) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Tipo___3FBE96EC]  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Monto__40B2BB25]  DEFAULT (0) FOR [Monto_Operacion]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Tipo___41A6DF5E]  DEFAULT (0) FOR [Tipo_Cambio]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Merca__429B0397]  DEFAULT ('') FOR [Mercado]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Usuar__438F27D0]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Siste__44834C09]  DEFAULT ('') FOR [Sistema]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Autor__45777042]  DEFAULT ('') FOR [Autoriza]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF__Aprobacio__Aprob__466B947B]  DEFAULT (0) FOR [Aprobado]
GO
ALTER TABLE [dbo].[Aprobacion_hedge] ADD  CONSTRAINT [DF_Aprobacion_hedge_Producto]  DEFAULT (' ') FOR [Producto]
GO
