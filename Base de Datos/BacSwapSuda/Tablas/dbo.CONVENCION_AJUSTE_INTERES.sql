USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[CONVENCION_AJUSTE_INTERES]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONVENCION_AJUSTE_INTERES](
	[Tipo_Tasa] [int] NOT NULL,
	[Nombre_Tipo] [varchar](20) NOT NULL,
	[Base] [int] NOT NULL,
	[Ajuste_Pasivo] [numeric](21, 4) NOT NULL,
	[Ajuste_Activo] [numeric](21, 4) NOT NULL,
	[Glosa_Base] [varchar](20) NOT NULL,
 CONSTRAINT [Pk_Convencion_Ajuste_Interes] PRIMARY KEY CLUSTERED 
(
	[Tipo_Tasa] ASC,
	[Base] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CONVENCION_AJUSTE_INTERES] ADD  CONSTRAINT [df_convencion_ajuste_interes_Tipo_Tasa]  DEFAULT (0) FOR [Tipo_Tasa]
GO
ALTER TABLE [dbo].[CONVENCION_AJUSTE_INTERES] ADD  CONSTRAINT [df_convencion_ajuste_interes_Nombre_Tipo]  DEFAULT ('-') FOR [Nombre_Tipo]
GO
ALTER TABLE [dbo].[CONVENCION_AJUSTE_INTERES] ADD  CONSTRAINT [df_convencion_ajuste_interes_Base]  DEFAULT (0) FOR [Base]
GO
ALTER TABLE [dbo].[CONVENCION_AJUSTE_INTERES] ADD  CONSTRAINT [df_convencion_ajuste_interes_Ajuste_Pasivo]  DEFAULT (0.0) FOR [Ajuste_Pasivo]
GO
ALTER TABLE [dbo].[CONVENCION_AJUSTE_INTERES] ADD  CONSTRAINT [df_convencion_ajuste_interes_Ajuste_Activo]  DEFAULT (0.0) FOR [Ajuste_Activo]
GO
ALTER TABLE [dbo].[CONVENCION_AJUSTE_INTERES] ADD  CONSTRAINT [df_convencion_ajuste_interes_Glosa_Base]  DEFAULT ('-') FOR [Glosa_Base]
GO
