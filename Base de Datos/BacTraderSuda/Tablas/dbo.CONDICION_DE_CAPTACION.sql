USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CONDICION_DE_CAPTACION]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONDICION_DE_CAPTACION](
	[codigo] [numeric](9, 0) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_Condicion_de_Captacion] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CONDICION_DE_CAPTACION] ADD  CONSTRAINT [df_condiciondecaptacion_codigo]  DEFAULT ((0)) FOR [codigo]
GO
ALTER TABLE [dbo].[CONDICION_DE_CAPTACION] ADD  CONSTRAINT [df_condiciondecaptacion_descripcion]  DEFAULT ('') FOR [descripcion]
GO
