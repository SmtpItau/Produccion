USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_mensajes_servicios]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_mensajes_servicios](
	[idMensaje] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[dTimeStamp] [datetime] NOT NULL,
	[sMensaje] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_mensajes_servicios] ADD  DEFAULT (getdate()) FOR [dTimeStamp]
GO
ALTER TABLE [dbo].[tbl_mensajes_servicios] ADD  DEFAULT ('') FOR [sMensaje]
GO
