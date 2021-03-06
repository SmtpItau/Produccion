USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLIENTE_APODERADO]    Script Date: 13-05-2022 10:58:09 ******/
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
	[apemail] [char](40) NULL,
	[fecha_escritura] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[aprutcli] ASC,
	[apcodcli] ASC,
	[aprutapo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  CONSTRAINT [DF__CLIENTE_A__Apdvc__20B95631]  DEFAULT ('') FOR [apdvcli]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  CONSTRAINT [DF__CLIENTE_A__Apdva__21AD7A6A]  DEFAULT ('') FOR [apdvapo]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  CONSTRAINT [DF__CLIENTE_A__Apnom__22A19EA3]  DEFAULT ('') FOR [apnombre]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  CONSTRAINT [DF__CLIENTE_A__Apcar__2395C2DC]  DEFAULT ('') FOR [apcargo]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  CONSTRAINT [DF__CLIENTE_A__Apfon__2489E715]  DEFAULT ('') FOR [apfono]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  CONSTRAINT [DF_CLIENTE_APODERADO_apemail]  DEFAULT ('') FOR [apemail]
GO
ALTER TABLE [dbo].[CLIENTE_APODERADO] ADD  DEFAULT ('') FOR [fecha_escritura]
GO
