USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CIUDAD_COMUNA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIUDAD_COMUNA](
	[cod_pai] [numeric](6, 0) NOT NULL,
	[cod_ciu] [numeric](6, 0) NOT NULL,
	[cod_com] [numeric](6, 0) NOT NULL,
	[nom_ciu] [char](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_pai] ASC,
	[cod_ciu] ASC,
	[cod_com] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CIUDAD_COMUNA] ADD  CONSTRAINT [DF__CIUDAD_CO__Nom_C__509D737D]  DEFAULT ('') FOR [nom_ciu]
GO
