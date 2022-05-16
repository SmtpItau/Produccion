USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PERIODO_TASA_BIDASK]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERIODO_TASA_BIDASK](
	[pecodigo] [numeric](3, 0) NOT NULL,
	[peperiodo] [char](6) NOT NULL,
	[penumero] [numeric](4, 0) NOT NULL,
	[petipo] [char](1) NOT NULL,
	[peglosa] [char](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pecodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
