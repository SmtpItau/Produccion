USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_CONEXIONES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_CONEXIONES](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_conexion] [nvarchar](40) NOT NULL,
	[connection] [varchar](255) NOT NULL,
	[provider] [varchar](255) NOT NULL,
	[time_out] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_conexion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_CONEXIONES] ADD  DEFAULT ((30)) FOR [time_out]
GO
