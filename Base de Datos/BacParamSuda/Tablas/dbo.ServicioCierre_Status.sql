USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ServicioCierre_Status]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioCierre_Status](
	[Id] [int] NOT NULL,
	[Glosa] [varchar](50) NULL,
	[Mensaje] [varchar](50) NULL,
 CONSTRAINT [Pk_ServicioCierre_Status_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServicioCierre_Status] ADD  CONSTRAINT [df_ServicioCierre_Status_Glosa]  DEFAULT ('Sin Estado') FOR [Glosa]
GO
ALTER TABLE [dbo].[ServicioCierre_Status] ADD  CONSTRAINT [df_ServicioCierre_Status_Mensaje]  DEFAULT ('Esperando hora de cierre') FOR [Mensaje]
GO
