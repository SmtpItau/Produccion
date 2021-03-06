USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_ALERTAS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_ALERTAS](
	[id_Alertas] [smallint] IDENTITY(1,1) NOT NULL,
	[sNombre_Alerta] [varchar](40) NOT NULL,
	[sEstado] [varchar](1) NOT NULL,
	[cHora] [smalldatetime] NOT NULL,
	[dFecha_Desde] [datetime] NOT NULL,
	[dFecha_Hasta] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Alertas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SADP_ALERTAS] ADD  DEFAULT ('') FOR [sEstado]
GO
ALTER TABLE [dbo].[SADP_ALERTAS] ADD  DEFAULT ('') FOR [cHora]
GO
ALTER TABLE [dbo].[SADP_ALERTAS] ADD  DEFAULT ('') FOR [dFecha_Desde]
GO
ALTER TABLE [dbo].[SADP_ALERTAS] ADD  DEFAULT ('') FOR [dFecha_Hasta]
GO
