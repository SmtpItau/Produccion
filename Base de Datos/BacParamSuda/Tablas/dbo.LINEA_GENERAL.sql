USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_GENERAL]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_GENERAL](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[FechaAsignacion] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[FechaFinContrato] [datetime] NOT NULL,
	[Bloqueado] [varchar](1) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[TotalTraspaso] [numeric](19, 4) NOT NULL,
	[TotalRecibido] [numeric](19, 4) NOT NULL,
	[RutCasaMatriz] [numeric](9, 0) NOT NULL,
	[CodigoCasaMatriz] [numeric](9, 0) NOT NULL,
	[remuneracion_linea] [numeric](10, 4) NOT NULL,
 CONSTRAINT [PK__LINEA_GENERAL__7B7E7B38] PRIMARY KEY CLUSTERED 
(
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Fecha__7C729F71]  DEFAULT (' ') FOR [FechaAsignacion]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Fecha__7D66C3AA]  DEFAULT (' ') FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Fecha__7E5AE7E3]  DEFAULT (' ') FOR [FechaFinContrato]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Bloqu__7F4F0C1C]  DEFAULT (' ') FOR [Bloqueado]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Total__00433055]  DEFAULT (0) FOR [TotalAsignado]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Total__0137548E]  DEFAULT (0) FOR [TotalOcupado]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Total__022B78C7]  DEFAULT (0) FOR [TotalDisponible]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Total__031F9D00]  DEFAULT (0) FOR [TotalExceso]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Total__0413C139]  DEFAULT (0) FOR [TotalTraspaso]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF__LINEA_GEN__Total__0507E572]  DEFAULT (0) FOR [TotalRecibido]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF_LINEA_GENERAL_remunera_linea]  DEFAULT (0) FOR [remuneracion_linea]
GO
ALTER TABLE [dbo].[LINEA_GENERAL]  WITH CHECK ADD  CONSTRAINT [FK__LINEA_GENERAL__05FC09AB] FOREIGN KEY([Rut_Cliente], [Codigo_Cliente])
REFERENCES [dbo].[CLIENTE] ([Clrut], [Clcodigo])
GO
ALTER TABLE [dbo].[LINEA_GENERAL] CHECK CONSTRAINT [FK__LINEA_GENERAL__05FC09AB]
GO
