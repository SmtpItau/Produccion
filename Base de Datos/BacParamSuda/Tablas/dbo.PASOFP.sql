USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PASOFP]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PASOFP](
	[codigo] [numeric](2, 0) NOT NULL,
	[glosa] [char](30) NOT NULL,
	[perfil] [char](9) NOT NULL,
	[codgen] [numeric](3, 0) NOT NULL,
	[glosa2] [char](8) NOT NULL,
	[cc2756] [char](1) NOT NULL,
	[afectacorr] [char](1) NOT NULL,
	[diasvalor] [numeric](3, 0) NOT NULL,
	[numcheque] [char](1) NOT NULL,
	[ctacte] [char](1) NOT NULL
) ON [PRIMARY]
GO
