USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Agencias_Clasificadoras]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agencias_Clasificadoras](
	[Id] [int] NOT NULL,
	[Agencia] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_Agencias_Clasificadoras] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Agencias_Clasificadoras] ADD  CONSTRAINT [df_Agencias_Clasificadoras_Agencia]  DEFAULT ('') FOR [Agencia]
GO
