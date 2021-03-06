USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_CUENTASCORRIENTES]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_CUENTASCORRIENTES](
	[id_CtaCte] [int] NOT NULL,
	[iRutCliente] [int] NOT NULL,
	[iCodCliente] [smallint] NOT NULL,
	[id_banco] [smallint] NOT NULL,
	[sCuentaCorriente] [varchar](40) NOT NULL,
	[iCodMoneda] [smallint] NOT NULL,
	[sBeneficiario] [varchar](70) NOT NULL,
	[bPrincipal] [bit] NOT NULL
) ON [PRIMARY]
GO
