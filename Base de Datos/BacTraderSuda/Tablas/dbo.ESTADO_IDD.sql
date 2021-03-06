USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[ESTADO_IDD]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADO_IDD](
	[N_Operacion] [numeric](10, 0) NOT NULL,
	[Docmumento] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](3, 0) NOT NULL,
	[Num_Idd] [numeric](10, 0) NOT NULL,
	[Usuario_Visador_Idd] [char](10) NOT NULL,
	[Facility_Idd] [float] NOT NULL,
	[Msg_Idd] [varchar](80) NOT NULL,
	[Monto_Util_Idd] [float] NOT NULL,
	[Tipo_Credito] [numeric](5, 0) NOT NULL,
	[Serie] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Estado_Idd] PRIMARY KEY CLUSTERED 
(
	[N_Operacion] ASC,
	[Docmumento] ASC,
	[Correlativo] ASC,
	[Num_Idd] ASC,
	[Usuario_Visador_Idd] ASC,
	[Facility_Idd] ASC,
	[Msg_Idd] ASC,
	[Monto_Util_Idd] ASC,
	[Tipo_Credito] ASC,
	[Serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_N_Operacion]  DEFAULT ((0)) FOR [N_Operacion]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Docmumento]  DEFAULT ((0)) FOR [Docmumento]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Correlativo]  DEFAULT ((0)) FOR [Correlativo]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Num_Idd]  DEFAULT ((0)) FOR [Num_Idd]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Usuario_Visador_Idd]  DEFAULT ('') FOR [Usuario_Visador_Idd]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Facility_Idd]  DEFAULT ((0.0)) FOR [Facility_Idd]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Msg_Idd]  DEFAULT ('') FOR [Msg_Idd]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Monto_Util_Idd]  DEFAULT ((0.0)) FOR [Monto_Util_Idd]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Tipo_Credito]  DEFAULT ((0)) FOR [Tipo_Credito]
GO
ALTER TABLE [dbo].[ESTADO_IDD] ADD  CONSTRAINT [df_Estado_Idd_Serie]  DEFAULT ('') FOR [Serie]
GO
