USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[graba_anula_dpf]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[graba_anula_dpf](
	[fecha_proc] [datetime] NULL,
	[numero_operacion] [varchar](50) NULL,
	[numero_certificado] [varchar](50) NULL,
	[actualizado] [varchar](1) NULL
) ON [PRIMARY]
GO
