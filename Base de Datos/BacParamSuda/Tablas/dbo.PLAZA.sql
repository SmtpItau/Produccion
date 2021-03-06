USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PLAZA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAZA](
	[codigo_plaza] [numeric](5, 0) NOT NULL,
	[glosa] [varchar](10) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_plaza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PLAZA]  WITH CHECK ADD FOREIGN KEY([codigo_pais])
REFERENCES [dbo].[PAIS] ([codigo_pais])
GO
