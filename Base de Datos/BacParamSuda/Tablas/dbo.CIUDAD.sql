USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CIUDAD]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIUDAD](
	[codigo_ciudad] [numeric](5, 0) NOT NULL,
	[codigo_region] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_ciudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CIUDAD]  WITH CHECK ADD FOREIGN KEY([codigo_region])
REFERENCES [dbo].[REGION] ([codigo_region])
GO
