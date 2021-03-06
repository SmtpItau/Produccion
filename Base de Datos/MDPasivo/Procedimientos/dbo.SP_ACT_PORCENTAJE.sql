USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PORCENTAJE]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ACT_PORCENTAJE] (@fecha_inicio CHAR(10)) 
 AS
 BEGIN
	SET NOCOUNT ON 
	SET DATEFORMAT DMY
/*
	 SELECT porcentaje
	 FROM MATRIZ_RIESGO a, LINEA_TRANSACCION b
	 WHERE a.codigo_grupo  = b.codigo_grupo
	 AND   a.codigo_moneda = b.codigo_moneda
	 AND   DATEDIFF(day,FechaInicio,FechaVencimiento) BETWEEN a.dias_desde AND a.dias_hasta   
         AND   FechaInicio >= @fecha_inicio    
	 AND   activo   = 'S'
*/
	 UPDATE LINEA_TRANSACCION
	 SET  MatrizRiesgo = 0
	 WHERE FechaInicio >= @fecha_inicio    
	 AND   activo   = 'S'



 END


 

---SP_ACT_PORCENTAJE '20040813'



GO
