USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_JOBS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_JOBS](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_job] [int] NOT NULL,
	[TYPE] [varchar](100) NULL,
	[method] [varchar](50) NULL,
	[arguments] [varchar](50) NULL,
	[is_active] [bit] NOT NULL,
	[is_statusbar] [bit] NOT NULL,
	[width_percent] [smallint] NULL,
	[align] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_job] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_JOBS] ADD  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[FWK_JOBS] ADD  DEFAULT ((0)) FOR [is_statusbar]
GO
