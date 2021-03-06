USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_DATOS_CONTROL]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_DATOS_CONTROL]
AS 
BEGIN
	DECLARE @iTotAceptadas	SMALLINT
	,		@iTotPendientes	SMALLINT
	
		SET @iTotAceptadas	= (SELECT COUNT(bEstado) 
		                   		 FROM SADP_CUENTA_CAJA scca
		                   		 ,    SADP_Control scc
							    WHERE dFechaSaldo = scc.dFechaProceso 
							      AND  scca.bEstado =1);

		SET @iTotPendientes	= (SELECT COUNT(bEstado) 
		                   		 FROM SADP_CUENTA_CAJA scca
		                   		 ,    SADP_Control scc
							    WHERE dFechaSaldo = scc.dFechaProceso 
							      AND  scca.bEstado =0);
	
	SELECT @iTotAceptadas,@iTotPendientes, dFechaProceso FROM SADP_Control 
	
END 
GO
