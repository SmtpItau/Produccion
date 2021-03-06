USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CURVAS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURVAS](
	[FechaGeneracion] [datetime] NOT NULL,
	[CodigoCurva] [varchar](20) NOT NULL,
	[Dias] [numeric](9, 0) NOT NULL,
	[ValorBid] [float] NOT NULL,
	[ValorAsk] [float] NOT NULL,
	[Tipo] [varchar](5) NOT NULL,
	[Origen] [char](2) NOT NULL,
 CONSTRAINT [Pk_Curvas] PRIMARY KEY CLUSTERED 
(
	[FechaGeneracion] ASC,
	[CodigoCurva] ASC,
	[Dias] ASC,
	[Tipo] ASC,
	[Origen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Fecha]  DEFAULT ('') FOR [FechaGeneracion]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Curva]  DEFAULT ('') FOR [CodigoCurva]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Dias]  DEFAULT (0) FOR [Dias]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Compras]  DEFAULT (0.0) FOR [ValorBid]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Ventas]  DEFAULT (0.0) FOR [ValorAsk]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Tipo]  DEFAULT ('') FOR [Tipo]
GO
ALTER TABLE [dbo].[CURVAS] ADD  CONSTRAINT [dfCurvas_Origen]  DEFAULT ('') FOR [Origen]
GO
