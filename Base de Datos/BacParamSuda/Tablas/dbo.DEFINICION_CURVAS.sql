USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DEFINICION_CURVAS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEFINICION_CURVAS](
	[CodigoCurva] [varchar](20) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[TipoCurva] [char](1) NOT NULL,
	[CurvaLocal] [char](1) NULL,
 CONSTRAINT [Pk_Definicion_Curvas] PRIMARY KEY NONCLUSTERED 
(
	[CodigoCurva] ASC,
	[TipoCurva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DEFINICION_CURVAS] ADD  CONSTRAINT [dfDefCurvas_Curva]  DEFAULT ('') FOR [CodigoCurva]
GO
ALTER TABLE [dbo].[DEFINICION_CURVAS] ADD  CONSTRAINT [dfDefCurvas_Glosa]  DEFAULT ('') FOR [Descripcion]
GO
ALTER TABLE [dbo].[DEFINICION_CURVAS] ADD  CONSTRAINT [dfDefCurvas_Tipo]  DEFAULT ('') FOR [TipoCurva]
GO
