USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[REGION]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGION](
	[codigo_region] [numeric](5, 0) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REGION]  WITH CHECK ADD FOREIGN KEY([codigo_pais])
REFERENCES [dbo].[PAIS] ([codigo_pais])
GO
