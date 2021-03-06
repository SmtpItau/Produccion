USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_CONTROLREP_FUSION]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CONTROLREP_FUSION](
	[id_controlrep] [int] IDENTITY(1,1) NOT NULL,
	[id_reporte] [int] NOT NULL,
	[controlrep_nombre] [varchar](20) NOT NULL,
	[controlrep_desc] [varchar](50) NOT NULL,
	[semilla] [bigint] NOT NULL,
	[semilla_fecupd] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_CONTROLREP_FUSION] PRIMARY KEY CLUSTERED 
(
	[id_controlrep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
