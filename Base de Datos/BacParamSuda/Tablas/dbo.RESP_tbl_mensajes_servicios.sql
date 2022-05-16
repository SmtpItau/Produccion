USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[RESP_tbl_mensajes_servicios]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESP_tbl_mensajes_servicios](
	[idMensaje] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[dTimeStamp] [datetime] NOT NULL,
	[sMensaje] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
