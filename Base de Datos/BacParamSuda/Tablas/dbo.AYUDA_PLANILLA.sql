USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[AYUDA_PLANILLA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AYUDA_PLANILLA](
	[codigo_tabla] [numeric](3, 0) NOT NULL,
	[codigo_numerico] [numeric](10, 0) NOT NULL,
	[codigo_caracter] [char](10) NOT NULL,
	[glosa] [char](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_tabla] ASC,
	[codigo_numerico] ASC,
	[codigo_caracter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AYUDA_PLANILLA] ADD  CONSTRAINT [DF__AYUDA_PLA__Glosa__461FE50A]  DEFAULT ('') FOR [glosa]
GO
