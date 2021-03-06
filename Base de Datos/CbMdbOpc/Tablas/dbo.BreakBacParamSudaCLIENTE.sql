USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BreakBacParamSudaCLIENTE]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BreakBacParamSudaCLIENTE](
	[Clrut] [numeric](9, 0) NOT NULL,
	[Clcodigo] [numeric](9, 0) NOT NULL,
	[clFechaFirma_cond_Opc] [datetime] NOT NULL,
	[clFechaFirma_cond_OpcChk] [numeric](1, 0) NOT NULL,
	[clFechaFirma_Supl_Opc] [datetime] NOT NULL,
	[clFechaFirma_Supl_OpcChk] [numeric](1, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Clrut] ASC,
	[Clcodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
