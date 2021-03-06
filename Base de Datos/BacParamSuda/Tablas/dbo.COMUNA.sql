USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[COMUNA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMUNA](
	[codigo_comuna] [numeric](5, 0) NOT NULL,
	[codigo_ciudad] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_comuna] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[COMUNA]  WITH CHECK ADD FOREIGN KEY([codigo_ciudad])
REFERENCES [dbo].[CIUDAD] ([codigo_ciudad])
GO
