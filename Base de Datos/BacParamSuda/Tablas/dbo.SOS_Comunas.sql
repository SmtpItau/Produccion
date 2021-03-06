USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SOS_Comunas]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOS_Comunas](
	[Id] [int] NOT NULL,
	[Comuna] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_SOS_Comunas_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SOS_Comunas] ADD  CONSTRAINT [df_SOS_Comunas_Comuna]  DEFAULT ('') FOR [Comuna]
GO
