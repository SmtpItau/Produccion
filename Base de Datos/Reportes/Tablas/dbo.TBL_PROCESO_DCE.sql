USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_PROCESO_DCE]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_PROCESO_DCE](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dce_linea] [int] NOT NULL,
	[dce_tipo] [varchar](10) NOT NULL,
	[dce_contrato] [varchar](50) NOT NULL,
	[dce_contrato_dce] [varchar](30) NOT NULL,
	[dce_archivo] [varchar](500) NOT NULL,
	[dce_fecarchivo] [datetime] NOT NULL,
	[dce_estado] [char](1) NOT NULL,
	[dce_fecins] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_PROCESO_DCE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
