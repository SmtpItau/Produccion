USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEMR]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMR](
	[mrcodigo] [numeric](3, 0) NULL,
	[mrposini] [numeric](17, 4) NULL,
	[mrmonpeini] [numeric](17, 4) NULL,
	[mrposic] [numeric](17, 4) NULL,
	[mrpmeco] [numeric](17, 4) NULL,
	[mrpmeve] [numeric](17, 4) NULL,
	[mrpmecopo] [numeric](17, 4) NULL,
	[mrpmevepo] [numeric](17, 4) NULL,
	[mrtotco] [numeric](17, 4) NULL,
	[mrtotve] [numeric](17, 4) NULL,
	[mrtotcope] [numeric](17, 4) NULL,
	[mrtotvepe] [numeric](17, 4) NULL,
	[mrutili] [numeric](17, 4) NULL,
	[mrutilipo] [numeric](17, 4) NULL,
	[mrprecie] [numeric](17, 4) NULL,
	[mrpreini] [numeric](17, 4) NULL,
	[mrprefin] [numeric](17, 4) NULL,
	[glosa] [char](30) NULL
) ON [PRIMARY]
GO
