USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[ttab_ofi]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttab_ofi](
	[ofi_cod] [smallint] NULL,
	[ofi_idr_vgt] [char](2) NULL,
	[ofi_idr_ctg] [char](2) NULL,
	[ofi_loc_sup] [int] NULL,
	[ofi_nom] [char](40) NULL,
	[ofi_nom_crt] [char](15) NULL,
	[tip_ofi_cod] [char](3) NULL,
	[ofi_cmn_cod] [smallint] NULL,
	[ofi_pza_cod] [smallint] NULL,
	[ofi_rgn_cod] [smallint] NULL,
	[ofi_cod_sub_rgn] [smallint] NULL,
	[ofi_dir] [char](60) NULL,
	[ofi_fon_1] [char](7) NULL,
	[ofi_fon_2] [char](7) NULL,
	[ofi_anx_1] [smallint] NULL,
	[ofi_anx_2] [smallint] NULL,
	[ofi_ano_cra] [smallint] NULL,
	[ofi_mes_cra] [smallint] NULL,
	[ofi_dia_cra] [smallint] NULL,
	[ofi_ano_crr] [smallint] NULL,
	[ofi_mes_crr] [smallint] NULL,
	[ofi_dia_crr] [smallint] NULL,
	[ofi_por_asg_zna] [decimal](5, 2) NULL,
	[ofi_idr_sep_ggs] [char](2) NULL,
	[ofi_cod_ofi_jri] [smallint] NULL
) ON [PRIMARY]
GO
