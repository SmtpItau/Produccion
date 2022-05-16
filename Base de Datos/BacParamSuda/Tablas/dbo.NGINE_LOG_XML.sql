USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[NGINE_LOG_XML]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NGINE_LOG_XML](
	[log_fecha] [datetime] NULL,
	[log_hora] [time](7) NULL,
	[log_metodo] [varchar](50) NULL,
	[log_xml] [varchar](4000) NULL
) ON [PRIMARY]
GO
