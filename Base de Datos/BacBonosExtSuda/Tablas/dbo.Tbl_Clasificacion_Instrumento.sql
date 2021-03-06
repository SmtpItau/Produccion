USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[Tbl_Clasificacion_Instrumento]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Clasificacion_Instrumento](
	[Nemo] [char](20) NOT NULL,
	[Agencia] [int] NOT NULL,
	[Clasificacion] [varchar](10) NOT NULL,
 CONSTRAINT [Pk_Tbl_Clasificacion_Instrumento_Nemo] PRIMARY KEY CLUSTERED 
(
	[Nemo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Clasificacion_Instrumento] ADD  CONSTRAINT [df_Clasificacion_Instrumento_Agencia]  DEFAULT ((0)) FOR [Agencia]
GO
ALTER TABLE [dbo].[Tbl_Clasificacion_Instrumento] ADD  CONSTRAINT [df_Clasificacion_Instrumento_Clasificacion]  DEFAULT ('') FOR [Clasificacion]
GO
