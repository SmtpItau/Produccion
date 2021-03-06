USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DJB_BALANCE_IBS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DJB_BALANCE_IBS](
	[COD_EMP] [char](20) NOT NULL,
	[BalFechaProc] [datetime] NOT NULL,
	[BalFechaGen] [datetime] NULL,
	[BalHoraGen] [varchar](8) NULL,
	[BalCtaBac] [varchar](16) NOT NULL,
	[BalCtaCod] [varchar](16) NULL,
	[BalCtaDes] [varchar](100) NULL,
	[BalSldDebe] [numeric](20, 2) NULL,
	[BalSldHaber] [numeric](20, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[COD_EMP] ASC,
	[BalFechaProc] ASC,
	[BalCtaBac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
