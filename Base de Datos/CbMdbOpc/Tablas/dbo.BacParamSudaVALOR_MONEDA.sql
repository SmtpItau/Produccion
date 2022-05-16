USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaVALOR_MONEDA]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaVALOR_MONEDA](
	[vmcodigo] [numeric](5, 0) NOT NULL,
	[vmvalor] [float] NOT NULL,
	[vmptacmp] [float] NOT NULL,
	[vmptavta] [float] NOT NULL,
	[vmfecha] [datetime] NOT NULL,
	[vmtipo] [char](1) NOT NULL,
	[vmparidad] [numeric](19, 4) NOT NULL,
	[vmparmer] [numeric](9, 4) NOT NULL,
	[vmposini] [numeric](19, 4) NOT NULL,
	[vmprecoi] [numeric](9, 4) NOT NULL,
	[vmparini] [numeric](9, 4) NOT NULL,
	[vmprecoc] [numeric](9, 4) NOT NULL,
	[vmparidc] [numeric](9, 4) NOT NULL,
	[vmposic] [numeric](19, 4) NOT NULL,
	[vmpreco] [numeric](9, 4) NOT NULL,
	[vmpreve] [numeric](9, 4) NOT NULL,
	[vmpmeco] [numeric](9, 4) NOT NULL,
	[vmpmeve] [numeric](9, 4) NOT NULL,
	[vmtotco] [numeric](19, 4) NOT NULL,
	[vmtotve] [numeric](19, 4) NOT NULL,
	[vmutili] [numeric](19, 0) NOT NULL,
	[vmparco] [numeric](19, 4) NOT NULL,
	[vmparve] [numeric](19, 4) NOT NULL,
	[vmorden] [numeric](3, 0) NOT NULL,
	[vmctacmb] [numeric](19, 0) NOT NULL,
	[vmcmbini] [numeric](19, 0) NOT NULL,
	[vmreval] [char](1) NOT NULL,
	[vmarbit] [char](1) NOT NULL,
	[vmparmer1] [numeric](12, 4) NOT NULL,
	[vmnumstgo] [numeric](3, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[vmcodigo] ASC,
	[vmfecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
