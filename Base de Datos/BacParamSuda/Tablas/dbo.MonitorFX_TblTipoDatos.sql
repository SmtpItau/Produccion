USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblTipoDatos]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblTipoDatos](
	[idTipoDato] [smallint] NOT NULL,
	[sDescripcion] [varchar](20) NOT NULL,
 CONSTRAINT [PK_dbo.MonitorFX_TblTipoDatos] PRIMARY KEY CLUSTERED 
(
	[idTipoDato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
