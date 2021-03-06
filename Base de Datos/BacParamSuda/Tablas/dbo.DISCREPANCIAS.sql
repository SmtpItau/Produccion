USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DISCREPANCIAS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DISCREPANCIAS](
	[Codigo] [numeric](9, 0) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [pk_primaryKey_Discrepancias] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DISCREPANCIAS] ADD  CONSTRAINT [df_Discrepancias_codigo]  DEFAULT (0) FOR [Codigo]
GO
ALTER TABLE [dbo].[DISCREPANCIAS] ADD  CONSTRAINT [df_Discrepancias_Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
