USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SOS_Pais]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOS_Pais](
	[Codigo] [int] NOT NULL,
	[Nemo] [char](2) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_SOS_Pais_Codigo] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SOS_Pais] ADD  CONSTRAINT [df_SOS_Pais_Codigo]  DEFAULT ((-1)) FOR [Codigo]
GO
ALTER TABLE [dbo].[SOS_Pais] ADD  CONSTRAINT [df_SOS_Pais_Nemo]  DEFAULT ('--') FOR [Nemo]
GO
ALTER TABLE [dbo].[SOS_Pais] ADD  CONSTRAINT [df_SOS_Pais_Nombre]  DEFAULT ('Sin Informacion') FOR [Nombre]
GO
