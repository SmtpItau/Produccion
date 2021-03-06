USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbXMLOperacion]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbXMLOperacion](
	[dcSistema] [char](3) NOT NULL,
	[dfOperacion] [datetime] NOT NULL,
	[dnOperacion] [numeric](7, 0) NOT NULL,
	[swEnviada] [char](1) NULL,
 CONSTRAINT [pk_tbXmlOperacion] PRIMARY KEY CLUSTERED 
(
	[dcSistema] ASC,
	[dfOperacion] ASC,
	[dnOperacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
