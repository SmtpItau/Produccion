USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_fml_inm]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_fml_inm](
	[Cod_familia] [numeric](4, 0) NOT NULL,
	[Nom_Familia] [char](20) NOT NULL,
	[Descrip_familia] [char](50) NOT NULL,
	[Base_calculo] [numeric](3, 0) NOT NULL,
	[MNCODMON] [int] NOT NULL,
	[MNCODMONPAG] [int] NOT NULL,
	[MODIFICA] [bit] NOT NULL,
	[RUT_EMISOR] [numeric](18, 0) NOT NULL,
	[COD_EMISOR] [int] NOT NULL,
	[SeriadoSN] [varchar](1) NOT NULL,
	[UsaIdInternacionalSN] [varchar](1) NOT NULL,
	[Tipo_Precio_PrcSN] [varchar](1) NOT NULL,
	[ISIN_Pais] [varchar](5) NOT NULL,
	[ISIN_Emisor] [varchar](10) NOT NULL,
	[ISIN_Inst] [varchar](5) NOT NULL,
	[UsaBaseFamiliaSN] [varchar](1) NOT NULL,
	[ConvFamilia] [varchar](5) NOT NULL,
	[ModificarMdaSN] [varchar](1) NOT NULL,
	[ModificarMdaPagSN] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Cod_familia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  CONSTRAINT [DF__text_fml___Cod_f__50FB042B]  DEFAULT (0) FOR [Cod_familia]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  CONSTRAINT [DF__text_fml___Nom_F__51EF2864]  DEFAULT ('') FOR [Nom_Familia]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  CONSTRAINT [DF__text_fml___Descr__52E34C9D]  DEFAULT ('') FOR [Descrip_familia]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  CONSTRAINT [DF__text_fml___Base___53D770D6]  DEFAULT (0) FOR [Base_calculo]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ((0)) FOR [MNCODMON]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ((0)) FOR [MNCODMONPAG]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ((0)) FOR [MODIFICA]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ((0)) FOR [RUT_EMISOR]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ((0)) FOR [COD_EMISOR]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('N') FOR [SeriadoSN]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('N') FOR [UsaIdInternacionalSN]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('N') FOR [Tipo_Precio_PrcSN]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('') FOR [ISIN_Pais]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('') FOR [ISIN_Emisor]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('') FOR [ISIN_Inst]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('N') FOR [UsaBaseFamiliaSN]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('') FOR [ConvFamilia]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('N') FOR [ModificarMdaSN]
GO
ALTER TABLE [dbo].[text_fml_inm] ADD  DEFAULT ('N') FOR [ModificarMdaPagSN]
GO
