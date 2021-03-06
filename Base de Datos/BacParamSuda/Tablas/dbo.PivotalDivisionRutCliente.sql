USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PivotalDivisionRutCliente]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivotalDivisionRutCliente](
	[Division] [nvarchar](50) NOT NULL,
	[RutCliente] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Division] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
