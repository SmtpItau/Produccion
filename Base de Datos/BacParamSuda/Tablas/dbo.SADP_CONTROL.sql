USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_CONTROL]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_CONTROL](
	[dFechaAnterior] [datetime] NOT NULL,
	[dFechaProceso] [datetime] NOT NULL,
	[dFechaProxima] [datetime] NOT NULL,
	[bSwCargaFFMM] [bit] NOT NULL,
	[bSwCargaCDB] [bit] NOT NULL,
	[bEnvioLBTR] [bit] NOT NULL,
	[bEnvioVVista] [bit] NOT NULL,
	[bEnvioCtaCte] [bit] NOT NULL,
	[idTx_Manual] [numeric](15, 0) NOT NULL,
	[bConeccionListener] [bit] NOT NULL,
	[iRut_FFMM] [numeric](10, 0) NOT NULL,
	[cDv_FFMM] [varchar](1) NOT NULL,
	[Nombre_FFMM] [varchar](50) NOT NULL,
	[iRut_Agencia] [numeric](10, 0) NOT NULL,
	[cDv_Agencia] [varchar](1) NOT NULL,
	[Nombre_Agencai] [varchar](50) NOT NULL,
	[iRut_CDB] [numeric](10, 0) NOT NULL,
	[cDv_CDB] [varchar](1) NOT NULL,
	[Nombre_CDB] [varchar](50) NOT NULL,
	[IBS_H36USERID] [varchar](10) NOT NULL,
	[IBS_E36TRACAN] [varchar](4) NOT NULL,
	[IBS_ATCANAL] [varchar](4) NOT NULL,
	[IBS_ATTRANS_EMPR] [varchar](4) NOT NULL,
	[IBS_ATTRANS_NATU] [varchar](4) NOT NULL,
	[IBS_E36TRA_PAR] [varchar](4) NOT NULL,
	[IBS_E36TRATYP] [varchar](3) NOT NULL,
	[COD_FFMM] [varchar](10) NULL,
	[COD_AGENCIA] [varchar](10) NULL,
	[COD_CDB] [varchar](10) NULL,
	[cod_RolEmail] [smallint] NULL,
	[sUser_H01USERID] [varchar](15) NULL,
	[iNumMovCDB] [numeric](10, 0) NULL,
	[bInicioDia] [bit] NULL,
	[bCierreDia] [bit] NULL
) ON [PRIMARY]
GO
