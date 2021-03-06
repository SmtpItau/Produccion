USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_EXPOSICION_MAX]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_EXPOSICION_MAX]
   (   @Usuario	CHAR(15)   )
AS
BEGIN
  SET NOCOUNT ON
      SELECT 'Moneda' 	        = '   ' --> VM.mnnemo
      ,      'Grupo'  	        = Grup.descripcion
      ,      'MontoInicial' 	= totalposicion
      ,      'MontoUtilizado'	= totalocupado
      ,      'PorcentaUtili'    = ROUND(( totalocupado    * 100) / totalposicion, 2)
      ,      'MontoDisponible'  = totaldisponible
      ,      'PorcentaDispo'    = ROUND(( totaldisponible * 100) / totalposicion, 2)
      ,      'Hora'		= CONVERT(CHAR(10), getdate(), 108)
      ,	     'FechaRepo'	= acfecproc	
      ,      'Usuario' 	        = @Usuario
      FROM    BacTraderSuda.dbo.MDAC		
      ,       GRUPO_POSICION   Grup
               INNER JOIN POSICION_GRUPO Posi ON Grup.codigo_grupo = Posi.codigo_grupo
END
GO
