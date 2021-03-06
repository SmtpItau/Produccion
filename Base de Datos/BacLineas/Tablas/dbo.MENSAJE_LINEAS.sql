USE [BacLineas]
GO
/****** Object:  Table [dbo].[MENSAJE_LINEAS]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENSAJE_LINEAS](
	[Sistema] [char](3) NOT NULL,
	[NumOper] [numeric](10, 0) NOT NULL,
	[RutCli] [numeric](9, 0) NOT NULL,
	[CodCli] [numeric](9, 0) NOT NULL,
	[Mensaje] [varchar](255) NULL,
	[Glosa] [varchar](255) NULL,
 CONSTRAINT [PK_MENSAJE_LINEAS] PRIMARY KEY NONCLUSTERED 
(
	[Sistema] ASC,
	[NumOper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
