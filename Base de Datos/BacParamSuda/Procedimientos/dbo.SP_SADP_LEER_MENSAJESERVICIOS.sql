USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_MENSAJESERVICIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_MENSAJESERVICIOS](  @idMensaje NUMERIC(10) )
AS
BEGIN
	
	SELECT TOP 15 idMensaje, dTimeStamp, sMensaje, (SELECT MAX(idMensaje) 
	                                           FROM  tbl_mensajes_servicios 
	                                          WHERE idmensaje >= @idMensaje) AS idDespues 
	  FROM tbl_mensajes_servicios, SADP_CONTROL sc 
	 WHERE SUBSTRING(CONVERT(VARCHAR(10),dtimestamp,103),1,10) =SUBSTRING(CONVERT(VARCHAR(10),GETDATE(),103),1,10)
	   AND idmensaje >= @idMensaje
	ORDER BY idMensaje ASC 
	   		  
		
END
GO
