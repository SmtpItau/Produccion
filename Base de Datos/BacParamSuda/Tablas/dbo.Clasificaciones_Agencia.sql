USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Clasificaciones_Agencia]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clasificaciones_Agencia](
	[IdAgencia] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[CortoPlazo] [varchar](10) NOT NULL,
	[LargoPlazo] [varchar](10) NOT NULL,
	[Transfronterizo] [char](2) NOT NULL,
 CONSTRAINT [Pk_Clasificaciones_Agencia] PRIMARY KEY CLUSTERED 
(
	[IdAgencia] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clasificaciones_Agencia] ADD  CONSTRAINT [df_Clasificaciones_Agencia_CortoPlazo]  DEFAULT ('') FOR [CortoPlazo]
GO
ALTER TABLE [dbo].[Clasificaciones_Agencia] ADD  CONSTRAINT [df_Clasificaciones_Agencia_LargoPlazo]  DEFAULT ('') FOR [LargoPlazo]
GO
ALTER TABLE [dbo].[Clasificaciones_Agencia] ADD  CONSTRAINT [df_Clasificaciones_Agencia_Transfronterizo]  DEFAULT ('') FOR [Transfronterizo]
GO
