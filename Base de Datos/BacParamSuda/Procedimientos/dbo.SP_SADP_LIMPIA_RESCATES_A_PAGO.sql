USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LIMPIA_RESCATES_A_PAGO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LIMPIA_RESCATES_A_PAGO]
AS 
BEGIN
	
	DELETE FROM dbo.SADP_RESCATES_PAGO WHERE fecha = (SELECT sc.dFechaProceso
	                                               FROM dbo.SADP_CONTROL sc)
										 AND estado = 'P' 													
END	 
GO
