USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CLIENTE_APODERADO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_APODERADO](
	[aprutcli] [numeric](9, 0) NOT NULL,
	[apdvcli] [char](1) NULL,
	[apcodcli] [numeric](9, 0) NOT NULL,
	[aprutapo] [numeric](9, 0) NOT NULL,
	[apdvapo] [char](1) NULL,
	[apnombre] [char](40) NULL,
	[apcargo] [char](40) NULL,
	[apfono] [char](15) NULL,
	[apemail] [char](40) NOT NULL
) ON [PRIMARY]
GO
