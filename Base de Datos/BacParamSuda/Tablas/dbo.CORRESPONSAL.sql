USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CORRESPONSAL]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CORRESPONSAL](
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[codigo_plaza] [numeric](5, 0) NOT NULL,
	[codigo_swift] [varchar](11) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[cuenta_corriente] [varchar](30) NOT NULL,
	[swift_santiago] [varchar](10) NOT NULL,
	[banco_central] [char](1) NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[codigo_corres] [numeric](8, 0) NULL,
	[codigo_contable] [char](4) NULL,
	[cod_corresponsal] [numeric](5, 0) NOT NULL,
	[Rut_Corresponsal] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CORRESPONSAL] ADD  CONSTRAINT [DF__CORRESPON__codig__5B526E1F]  DEFAULT (' ') FOR [codigo_contable]
GO
ALTER TABLE [dbo].[CORRESPONSAL] ADD  CONSTRAINT [DF__correspon__cod_c__3C98DCD5]  DEFAULT (0) FOR [cod_corresponsal]
GO
ALTER TABLE [dbo].[CORRESPONSAL] ADD  CONSTRAINT [DF__correspon__Rut_C__11997037]  DEFAULT (0) FOR [Rut_Corresponsal]
GO
