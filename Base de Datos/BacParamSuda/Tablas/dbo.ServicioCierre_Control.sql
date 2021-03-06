USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ServicioCierre_Control]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioCierre_Control](
	[Estado] [int] NOT NULL,
	[SwForward] [int] NOT NULL,
	[SwSwap] [int] NOT NULL,
	[SwBonex] [int] NOT NULL,
	[SwOpciones] [int] NOT NULL,
	[HoraInicio] [char](8) NOT NULL,
	[HoraTermino] [char](8) NOT NULL,
	[ProximaFecha] [datetime] NOT NULL,
 CONSTRAINT [Pk_ServicioCierre_Control_Estado] PRIMARY KEY CLUSTERED 
(
	[Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_SwForward]  DEFAULT ((0)) FOR [SwForward]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_SwSwap]  DEFAULT ((0)) FOR [SwSwap]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_SwBonex]  DEFAULT ((0)) FOR [SwBonex]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_SwOpciones]  DEFAULT ((0)) FOR [SwOpciones]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_HoraInicio]  DEFAULT ('00:00:00') FOR [HoraInicio]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_HoraTermino]  DEFAULT ('00:00:00') FOR [HoraTermino]
GO
ALTER TABLE [dbo].[ServicioCierre_Control] ADD  CONSTRAINT [df_ServicioCierre_Control_ProximaFecha]  DEFAULT ('19000101') FOR [ProximaFecha]
GO
