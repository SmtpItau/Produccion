USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_MODULO_FUSION]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_MODULO_FUSION](
	[id_modulo] [int] NOT NULL,
	[modulo] [varchar](20) NOT NULL,
	[modulo_h] [varchar](20) NOT NULL,
	[modulo_desc] [varchar](50) NOT NULL,
	[export_engine] [varchar](12) NOT NULL,
 CONSTRAINT [PK_TBL_MODULO_FUSION] PRIMARY KEY CLUSTERED 
(
	[id_modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Reportes_Data_01]
) ON [Reportes_Data_01]
GO
