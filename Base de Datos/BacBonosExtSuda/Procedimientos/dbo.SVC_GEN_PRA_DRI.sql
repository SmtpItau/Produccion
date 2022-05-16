USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_PRA_DRI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_PRA_DRI] 
AS
BEGIN
set nocount on


	SELECT 	acsw_pd		,	-- Sw Inicio de Día		1
		acsw_co         ,	-- Contabilización Automatica	2
		acsw_dv         ,	-- Devengamiento		3
		acsw_mesa       ,	-- Cierre de mesa		4
		acsw_fd         ,	-- Fin de día			5
		acsw_tm         	-- Ajuste Mercado		6
	FROM 	text_arc_ctl_dri

set nocount off
END

GO
