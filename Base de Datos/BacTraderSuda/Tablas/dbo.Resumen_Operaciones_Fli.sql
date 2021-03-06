USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Resumen_Operaciones_Fli]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resumen_Operaciones_Fli](
	[Fecha_Operacion] [datetime] NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Tipo_operacion] [varchar](4) NOT NULL,
	[Total_Operacion] [numeric](21, 0) NOT NULL,
	[Usuario] [varchar](12) NOT NULL,
	[Hora] [varchar](8) NOT NULL,
	[Pago] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_O__Fecha__5D09A51A]  DEFAULT ('') FOR [Fecha_Operacion]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_O__Numer__5DFDC953]  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_O__Tipo___5EF1ED8C]  DEFAULT ('') FOR [Tipo_operacion]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_O__Total__5FE611C5]  DEFAULT (0) FOR [Total_Operacion]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_O__Usuar__60DA35FE]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_Op__Hora__61CE5A37]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[Resumen_Operaciones_Fli] ADD  CONSTRAINT [DF__Resumen_Op__Pago__62C27E70]  DEFAULT (0) FOR [Pago]
GO
