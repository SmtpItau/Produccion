USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorTX_TblAmbientes]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorTX_TblAmbientes](
	[idAmbiente] [smallint] NOT NULL,
	[sDescripcion] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idAmbiente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorTX_TblAmbientes] ADD  DEFAULT ((0)) FOR [idAmbiente]
GO
ALTER TABLE [dbo].[MonitorTX_TblAmbientes] ADD  DEFAULT ('') FOR [sDescripcion]
GO
