USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_ALERTAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_ALERTAS]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT sa.id_Alertas
	,	   sa.sNombre_Alerta
	,	   sa.sEstado
	,	   sea.sDescripcion		
	,	   sa.dFecha_Desde
	,	   sa.dFecha_Hasta
	,	   sa.cHora
	  FROM SADP_Alertas sa	 
		   INNER JOIN SADP_EstadoAlertas sea ON sea.sEstado=sa.sEstado;   
END 
GO
