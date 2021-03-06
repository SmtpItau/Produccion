USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_ATRIBUCIONES_POR_OPERADOR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_INF_ATRIBUCIONES_POR_OPERADOR]
		(
		@Usuario	CHAR(15)
		)
AS
BEGIN

 IF EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO MP
		    ,	 GRUPO_PRODUCTO  	       VP
	   WHERE MP.Id_Sistema 		= VP.Id_Sistema
	     AND MP.Codigo_Producto	= VP.Codigo_grupo
	     AND MP.Usuario		= @Usuario)
  BEGIN

  SELECT DISTINCT 
	'Operador'    = MP.Usuario
  ,	 'Producto'    = VP.glosa_grupo
  ,	 'TramoPlazo1' = MP.Plazo_Desde 
  ,	 'TramoPlazo2' = MP.Plazo_Hasta
  ,	 'Moneda'      = 'CLP'
  ,	 'TotalMaxOper'= MP.Monto_Maximo_Operacion
  ,	 'TotalMaxDia' = MP.Acumulado_Diario
  ,	 'Hora'	       = CONVERT(CHAR(10),GETDATE(),108)
  ,	 'FechaRepo'   = MA.acfecproc
  ,	 'Usuario'     = @Usuario
  ,	 'Acumulado'   = MP.Monto_Maximo_Acumulado
    FROM MATRIZ_ATRIBUCION_INSTRUMENTO MP
    ,	 GRUPO_PRODUCTO  	       VP
    ,    VIEW_MDAC		       MA
   WHERE MP.Id_Sistema 		= VP.Id_Sistema
     AND MP.Codigo_Producto	= VP.Codigo_grupo
     AND MP.Usuario		= @Usuario



  END
 ELSE
  BEGIN
  SELECT 'Operador'    = ' '
  ,	 'Producto'    = ' '
  ,	 'TramoPlazo1' = 0
  ,	 'TramoPlazo2' = 0
  ,	 'Moneda'      = ' '
  ,	 'TotalMaxOper'= 0
  ,	 'TotalMaxDia' = 0
  ,	 'Hora'	       = CONVERT(CHAR(10),GETDATE(),108)
  ,	 'FechaRepo'   = acfecproc
  ,	 'Usuario'     = @Usuario
  ,	 'Acumulado'   = 0
    FROM VIEW_MDAC

  END
END








GO
