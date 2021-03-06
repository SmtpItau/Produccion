USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MECUPO]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MECUPO](
	[cupnumope] [numeric](7, 0) NOT NULL,
	[cuptipope] [char](1) NOT NULL,
	[cupmtousd] [numeric](17, 4) NOT NULL,
	[cupprecio] [numeric](7, 4) NOT NULL,
	[cupnomcli] [char](35) NOT NULL,
	[cuprutcli] [numeric](9, 0) NOT NULL,
	[cuptcamco] [numeric](12, 4) NOT NULL,
	[cupfpmxco] [numeric](3, 0) NOT NULL,
	[cupfpmnco] [numeric](3, 0) NOT NULL,
	[cuptcamve] [numeric](12, 4) NOT NULL,
	[cupfpmxve] [numeric](3, 0) NOT NULL,
	[cupfpmnve] [numeric](3, 0) NOT NULL,
	[cupfecha] [datetime] NOT NULL
) ON [PRIMARY]
GO
