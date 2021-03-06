USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PivotalProductoAG]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivotalProductoAG](
	[Producto] [nvarchar](50) NOT NULL,
	[AG] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
