USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MONEDA_TASA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA_TASA](
	[sistema] [char](3) NOT NULL,
	[codmon] [int] NOT NULL,
	[codtasa] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tasa] [float] NULL,
	[tasacap] [float] NULL,
	[tasacol] [float] NULL,
	[periodo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sistema] ASC,
	[codmon] ASC,
	[codtasa] ASC,
	[fecha] ASC,
	[periodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MONEDA_TASA] ADD  CONSTRAINT [DF__MONEDA_TAS__tasa__324DF687]  DEFAULT (0) FOR [tasa]
GO
ALTER TABLE [dbo].[MONEDA_TASA] ADD  CONSTRAINT [DF__MONEDA_TA__tasac__33421AC0]  DEFAULT (0) FOR [tasacap]
GO
ALTER TABLE [dbo].[MONEDA_TASA] ADD  CONSTRAINT [DF__MONEDA_TA__tasac__34363EF9]  DEFAULT (0) FOR [tasacol]
GO
