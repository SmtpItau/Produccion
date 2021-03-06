USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BenchMark]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenchMark](
	[BenchMarkCod] [numeric](5, 0) NOT NULL,
	[BenchMarkDescripcion] [varchar](40) NOT NULL,
	[BenchMarkHora] [datetime] NULL,
	[BenchEditable] [varchar](1) NULL,
	[BenchMdaCodValorDef] [numeric](5, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[BenchMarkCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
