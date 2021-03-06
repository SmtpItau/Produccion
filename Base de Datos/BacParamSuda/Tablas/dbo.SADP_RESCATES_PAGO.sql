USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_RESCATES_PAGO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_RESCATES_PAGO](
	[idRescatePago] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[idFolio] [numeric](10, 0) NULL,
	[secuencia] [numeric](10, 0) NULL,
	[codFondo] [smallint] NULL,
	[Monto] [numeric](21, 0) NULL,
	[Estado] [varchar](1) NULL,
	[sNumTransferencia] [varchar](20) NULL,
	[sUsuario] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idRescatePago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SADP_RESCATES_PAGO] ADD  DEFAULT ('') FOR [sUsuario]
GO
