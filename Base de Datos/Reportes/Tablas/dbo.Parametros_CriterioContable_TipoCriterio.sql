USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_CriterioContable_TipoCriterio]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_CriterioContable_TipoCriterio](
	[IdParametros] [int] NOT NULL,
	[IdTipoCriterio] [int] NOT NULL,
 CONSTRAINT [PK_Parametros_CriterioContable_TipoCriterio] PRIMARY KEY CLUSTERED 
(
	[IdParametros] ASC,
	[IdTipoCriterio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Reportes_Data_01]
) ON [Reportes_Data_01]
GO
ALTER TABLE [dbo].[Parametros_CriterioContable_TipoCriterio]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_CriterioContable_TipoCriterio_Parametros_CriterioContable] FOREIGN KEY([IdParametros])
REFERENCES [dbo].[Parametros_CriterioContable] ([IdParametros])
GO
ALTER TABLE [dbo].[Parametros_CriterioContable_TipoCriterio] CHECK CONSTRAINT [FK_Parametros_CriterioContable_TipoCriterio_Parametros_CriterioContable]
GO
ALTER TABLE [dbo].[Parametros_CriterioContable_TipoCriterio]  WITH CHECK ADD  CONSTRAINT [FK_Parametros_CriterioContable_TipoCriterio_Parametros_TipoCriterio] FOREIGN KEY([IdTipoCriterio])
REFERENCES [dbo].[Parametros_TipoCriterio] ([IdTipoCriterio])
GO
ALTER TABLE [dbo].[Parametros_CriterioContable_TipoCriterio] CHECK CONSTRAINT [FK_Parametros_CriterioContable_TipoCriterio_Parametros_TipoCriterio]
GO
