USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ResFusion_CLIENTE_APODERADO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResFusion_CLIENTE_APODERADO](
	[aprutcli] [numeric](9, 0) NOT NULL,
	[apdvcli] [char](1) NULL,
	[apcodcli] [numeric](9, 0) NOT NULL,
	[aprutapo] [numeric](9, 0) NOT NULL,
	[apdvapo] [char](1) NULL,
	[apnombre] [char](40) NULL,
	[apcargo] [char](40) NULL,
	[apfono] [char](15) NULL,
	[apemail] [char](40) NULL,
	[fecha_escritura] [datetime] NOT NULL
) ON [PRIMARY]
GO
