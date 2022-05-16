USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_CABECERA_FLUJOS_STANDBY]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CABECERA_FLUJOS_STANDBY](
	[Cf_Rut_Cli] [numeric](9, 0) NOT NULL,
	[Cf_Dv] [char](1) NOT NULL,
	[Cf_Nombre] [varchar](60) NOT NULL,
	[Cf_Nombre2] [varchar](18) NOT NULL,
	[Cf_ApePtn] [char](15) NOT NULL,
	[Cf_ApeMtn] [char](15) NOT NULL,
	[Cf_Credito] [numeric](10, 0) NOT NULL,
	[Cf_Condicion] [char](1) NOT NULL,
	[Cf_Usuario_Lock] [char](15) NOT NULL,
 CONSTRAINT [PK__TBL_CABECERA_FLU__3163F3EF] PRIMARY KEY CLUSTERED 
(
	[Cf_Rut_Cli] ASC,
	[Cf_Credito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CABECERA_FLUJOS_STANDBY] ADD  DEFAULT ('') FOR [Cf_Nombre]
GO
ALTER TABLE [dbo].[TBL_CABECERA_FLUJOS_STANDBY] ADD  DEFAULT ('') FOR [Cf_Nombre2]
GO
ALTER TABLE [dbo].[TBL_CABECERA_FLUJOS_STANDBY] ADD  DEFAULT (0) FOR [Cf_Credito]
GO
ALTER TABLE [dbo].[TBL_CABECERA_FLUJOS_STANDBY] ADD  DEFAULT ('N') FOR [Cf_Condicion]
GO
ALTER TABLE [dbo].[TBL_CABECERA_FLUJOS_STANDBY] ADD  DEFAULT ('') FOR [Cf_Usuario_Lock]
GO
