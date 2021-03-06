USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEATA]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEATA](
	[motipmer] [char](4) NOT NULL,
	[monumope] [numeric](7, 0) NOT NULL,
	[motipope] [char](1) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[monomcli] [char](35) NOT NULL,
	[mocodmon] [char](3) NOT NULL,
	[momonmo] [numeric](17, 4) NOT NULL,
	[moticam] [numeric](10, 4) NOT NULL,
	[mopar30] [numeric](10, 4) NOT NULL,
	[moparme] [numeric](10, 4) NOT NULL,
	[motctra] [numeric](10, 4) NOT NULL,
	[mopartr] [numeric](10, 4) NOT NULL,
	[mouss30] [numeric](17, 4) NOT NULL,
	[moussme] [numeric](17, 4) NOT NULL,
	[mousstr] [numeric](17, 4) NOT NULL,
	[mopmeco] [numeric](9, 4) NOT NULL,
	[mopmeve] [numeric](9, 4) NOT NULL,
	[mototco] [numeric](17, 4) NOT NULL,
	[mototve] [numeric](17, 4) NOT NULL,
	[mototcom] [numeric](17, 4) NOT NULL,
	[mototvem] [numeric](17, 4) NOT NULL,
	[momonpe] [numeric](17, 4) NOT NULL,
	[moentre] [numeric](2, 0) NOT NULL,
	[morecib] [numeric](2, 0) NOT NULL,
	[movamos] [numeric](1, 0) NOT NULL,
	[motlxp1] [numeric](2, 0) NOT NULL,
	[motlxp2] [numeric](2, 0) NOT NULL,
	[mocencos] [char](35) NOT NULL,
	[mounidad] [char](35) NOT NULL,
	[mooper] [char](10) NOT NULL,
	[moterm] [char](12) NOT NULL,
	[mohora] [char](8) NOT NULL,
	[mofech] [datetime] NOT NULL,
	[mocodoma] [numeric](3, 0) NOT NULL,
	[moestatus] [char](1) NOT NULL,
	[moimpreso] [char](1) NOT NULL,
	[mocodejec] [numeric](3, 0) NOT NULL,
	[mogrpgen] [numeric](3, 0) NOT NULL,
	[mogrppro] [numeric](3, 0) NOT NULL,
	[mocorres] [numeric](7, 0) NOT NULL,
	[moejecuti] [char](7) NOT NULL,
	[movaluta1] [datetime] NOT NULL,
	[movaluta2] [datetime] NOT NULL,
	[mopcierre] [char](1) NOT NULL,
	[morentab] [numeric](3, 0) NOT NULL,
	[motcfin] [numeric](19, 4) NOT NULL,
	[moparfi] [numeric](19, 4) NOT NULL,
	[moaprob] [char](1) NOT NULL,
	[moalinea] [char](1) NOT NULL
) ON [PRIMARY]
GO
