USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TIPO_CARTERA]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_CARTERA](
	[rcsistema] [char](3) NOT NULL,
	[rccodpro] [char](5) NOT NULL,
	[rcrut] [numeric](5, 0) NOT NULL,
	[rcdv] [char](1) NULL,
	[rcnombre] [varchar](50) NULL,
	[rcnumcorr] [numeric](9, 0) NULL,
	[rcCarteraSbif] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK__TIPO_CARTERA__715DB21C] PRIMARY KEY CLUSTERED 
(
	[rcsistema] ASC,
	[rccodpro] ASC,
	[rcrut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TIPO_CARTERA] ADD  DEFAULT ((0)) FOR [rcCarteraSbif]
GO
