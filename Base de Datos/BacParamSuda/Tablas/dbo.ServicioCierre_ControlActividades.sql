USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ServicioCierre_ControlActividades]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioCierre_ControlActividades](
	[Id] [int] NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Estado] [int] NOT NULL,
	[HoraInicio] [char](8) NOT NULL,
	[HoraTermino] [char](8) NOT NULL,
	[Orden] [int] NOT NULL,
 CONSTRAINT [Pk_ServicioCierre_ControlActividades_IdModulo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServicioCierre_ControlActividades] ADD  CONSTRAINT [df_ServicioCierre_ControlActividades_Modulo]  DEFAULT ('---') FOR [Modulo]
GO
ALTER TABLE [dbo].[ServicioCierre_ControlActividades] ADD  CONSTRAINT [df_ServicioCierre_ControlActividades_Descripcion]  DEFAULT ('Actividad No Valida') FOR [Descripcion]
GO
ALTER TABLE [dbo].[ServicioCierre_ControlActividades] ADD  CONSTRAINT [df_ServicioCierre_ControlActividades_Estado]  DEFAULT ('-1') FOR [Estado]
GO
ALTER TABLE [dbo].[ServicioCierre_ControlActividades] ADD  CONSTRAINT [df_ServicioCierre_ControlActividades_HoraInicio]  DEFAULT ('00:00:00') FOR [HoraInicio]
GO
ALTER TABLE [dbo].[ServicioCierre_ControlActividades] ADD  CONSTRAINT [df_ServicioCierre_ControlActividades_HoraTermino]  DEFAULT ('00:00:00') FOR [HoraTermino]
GO
ALTER TABLE [dbo].[ServicioCierre_ControlActividades] ADD  CONSTRAINT [df_ServicioCierre_ControlActividades_Orden]  DEFAULT ((-1)) FOR [Orden]
GO
