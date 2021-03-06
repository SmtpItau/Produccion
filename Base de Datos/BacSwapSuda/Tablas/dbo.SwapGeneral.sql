USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[SwapGeneral]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwapGeneral](
	[entidad] [char](2) NOT NULL,
	[codigo] [char](3) NOT NULL,
	[nombre] [char](45) NOT NULL,
	[rut] [numeric](9, 0) NOT NULL,
	[direccion] [char](50) NOT NULL,
	[comuna] [char](20) NOT NULL,
	[ciudad] [char](20) NOT NULL,
	[telefono] [char](10) NOT NULL,
	[fax] [char](15) NOT NULL,
	[fechaant] [datetime] NOT NULL,
	[fechaproc] [datetime] NOT NULL,
	[fechaprox] [datetime] NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[rutbcch] [numeric](9, 0) NOT NULL,
	[iniciodia] [numeric](1, 0) NOT NULL,
	[libor] [numeric](1, 0) NOT NULL,
	[paridad] [numeric](1, 0) NOT NULL,
	[tasamtm] [numeric](1, 0) NOT NULL,
	[tasas] [numeric](1, 0) NOT NULL,
	[findia] [numeric](1, 0) NOT NULL,
	[cierreMesa] [char](1) NOT NULL,
	[codigobanco] [numeric](3, 0) NOT NULL,
	[devengo] [numeric](1, 0) NOT NULL,
	[contabilidad] [numeric](1, 0) NOT NULL,
	[Vencimientos] [int] NOT NULL,
	[ActTasaVarVcto] [int] NOT NULL,
	[AcTicketMesa] [numeric](10, 0) NULL,
	[MargenVcto] [int] NOT NULL,
 CONSTRAINT [PK_SwapGeneral] PRIMARY KEY NONCLUSTERED 
(
	[entidad] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__entid__53B8409C]  DEFAULT (' ') FOR [entidad]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__codig__54AC64D5]  DEFAULT (' ') FOR [codigo]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__nombr__55A0890E]  DEFAULT (' ') FOR [nombre]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGeneral__rut__5694AD47]  DEFAULT (0) FOR [rut]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__direc__5788D180]  DEFAULT (' ') FOR [direccion]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__comun__587CF5B9]  DEFAULT (' ') FOR [comuna]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__ciuda__597119F2]  DEFAULT (' ') FOR [ciudad]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__telef__5A653E2B]  DEFAULT (' ') FOR [telefono]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGeneral__fax__5B596264]  DEFAULT (' ') FOR [fax]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__fecha__5C4D869D]  DEFAULT (' ') FOR [fechaant]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__fecha__5D41AAD6]  DEFAULT (' ') FOR [fechaproc]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__fecha__5E35CF0F]  DEFAULT (' ') FOR [fechaprox]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__numer__5F29F348]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__rutbc__601E1781]  DEFAULT (0) FOR [rutbcch]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__inici__61123BBA]  DEFAULT (0) FOR [iniciodia]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__libor__62065FF3]  DEFAULT (0) FOR [libor]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__parid__62FA842C]  DEFAULT (0) FOR [paridad]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__tasam__63EEA865]  DEFAULT (0) FOR [tasamtm]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__tasas__64E2CC9E]  DEFAULT (0) FOR [tasas]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__findi__65D6F0D7]  DEFAULT (0) FOR [findia]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__cierr__66CB1510]  DEFAULT (' ') FOR [cierreMesa]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__SwapGener__codig__67BF3949]  DEFAULT (0) FOR [codigobanco]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__swapgener__deven__614745E4]  DEFAULT (0) FOR [devengo]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [DF__swapgener__conta__623B6A1D]  DEFAULT (0) FOR [contabilidad]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [dfswapgeneral_Vencimientos]  DEFAULT (0) FOR [Vencimientos]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  CONSTRAINT [df_SwapGeneral_ActTasaVarVcto]  DEFAULT (0) FOR [ActTasaVarVcto]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  DEFAULT (0) FOR [AcTicketMesa]
GO
ALTER TABLE [dbo].[SwapGeneral] ADD  DEFAULT ((0)) FOR [MargenVcto]
GO
