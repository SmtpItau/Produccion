USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblSeparadores]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblSeparadores](
	[idSeparador] [smallint] NOT NULL,
	[sDescripcion] [varchar](100) NOT NULL,
	[iCodSeparador] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idSeparador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MonitorFX_TblSeparadores] ADD  DEFAULT ((0)) FOR [idSeparador]
GO
ALTER TABLE [dbo].[MonitorFX_TblSeparadores] ADD  DEFAULT ('') FOR [sDescripcion]
GO
ALTER TABLE [dbo].[MonitorFX_TblSeparadores] ADD  DEFAULT ('') FOR [iCodSeparador]
GO
