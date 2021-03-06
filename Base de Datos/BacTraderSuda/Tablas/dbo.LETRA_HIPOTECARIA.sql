USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[LETRA_HIPOTECARIA]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETRA_HIPOTECARIA](
	[codigo_planilla] [numeric](10, 0) NOT NULL,
	[fecha_ingreso] [datetime] NOT NULL,
	[letra_serie] [varchar](15) NOT NULL,
	[fecha_emision_nominal] [datetime] NOT NULL,
	[fecha_emision_material] [datetime] NOT NULL,
	[letra_tipo] [char](1) NOT NULL,
	[letra_nemotecnico] [varchar](10) NOT NULL,
	[codigo_moneda] [numeric](3, 0) NOT NULL,
	[letra_nominal] [numeric](19, 4) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[rut_emisor] [numeric](9, 0) NOT NULL,
	[codigo_emisor] [numeric](9, 0) NOT NULL,
	[codigo_sucursal] [varchar](5) NOT NULL,
	[letra_condicion] [char](1) NOT NULL,
	[codigo_obligacion] [varchar](15) NOT NULL,
	[observacion] [varchar](60) NOT NULL,
	[letra_estado] [char](1) NOT NULL,
	[usuario] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_planilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__fecha__79E116E0]  DEFAULT ('') FOR [fecha_emision_nominal]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__fecha__7AD53B19]  DEFAULT ('') FOR [fecha_emision_material]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__letra__7BC95F52]  DEFAULT ('') FOR [letra_tipo]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__letra__7CBD838B]  DEFAULT ('') FOR [letra_nemotecnico]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__codig__7DB1A7C4]  DEFAULT (0) FOR [codigo_moneda]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__letra__7EA5CBFD]  DEFAULT (0) FOR [letra_nominal]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__rut_c__7F99F036]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__codig__008E146F]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__rut_e__018238A8]  DEFAULT (0) FOR [rut_emisor]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__codig__02765CE1]  DEFAULT (0) FOR [codigo_emisor]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__codig__036A811A]  DEFAULT ('') FOR [codigo_sucursal]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__letra__045EA553]  DEFAULT ('') FOR [letra_condicion]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__codig__0552C98C]  DEFAULT ('') FOR [codigo_obligacion]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__obser__0646EDC5]  DEFAULT ('') FOR [observacion]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__letra__073B11FE]  DEFAULT ('') FOR [letra_estado]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA] ADD  CONSTRAINT [DF__LETRA_HIP__usuar__082F3637]  DEFAULT ('') FOR [usuario]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA]  WITH CHECK ADD FOREIGN KEY([letra_serie])
REFERENCES [dbo].[LETRA_HIPOTECARIA_SERIE] ([letra_serie])
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA]  WITH CHECK ADD FOREIGN KEY([rut_cliente], [codigo_cliente])
REFERENCES [dbo].[LETRA_HIPOTECARIA_CLIENTE] ([rut_cliente], [codigo_cliente])
GO
