USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_APLICACIONES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_APLICACIONES](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[descripcion] [nvarchar](100) NOT NULL,
	[mode] [nvarchar](3) NOT NULL,
	[separador_decimal] [varchar](1) NOT NULL,
	[separador_miles] [varchar](1) NOT NULL,
	[separador_fecha] [varchar](1) NOT NULL,
	[decimal_places] [smallint] NOT NULL,
	[duration_password] [smallint] NOT NULL,
	[inactivity_time] [smallint] NOT NULL,
	[fixed_role] [nvarchar](30) NULL,
	[fixed_user] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_APLICACIONES] ADD  DEFAULT ((0)) FOR [decimal_places]
GO
ALTER TABLE [dbo].[FWK_APLICACIONES] ADD  DEFAULT ((60)) FOR [duration_password]
GO
ALTER TABLE [dbo].[FWK_APLICACIONES] ADD  DEFAULT ((3)) FOR [inactivity_time]
GO
