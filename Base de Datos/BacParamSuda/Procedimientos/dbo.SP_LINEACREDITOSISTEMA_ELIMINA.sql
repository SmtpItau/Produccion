USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOSISTEMA_ELIMINA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOSISTEMA_ELIMINA] 
       (@rut_cliente numeric(9),
 @codigo_cliente numeric(9),
 @sw char(3)='')
AS
BEGIN 
 SET NOCOUNT ON
 IF @sw ='1'
 BEGIN
  SELECT DISTINCT
   A.* 
  INTO #TEMP
  FROM LINEA_SISTEMA A,
   LINEA_TRANSACCION B
  WHERE A.rut_cliente = @rut_cliente
  AND A.rut_cliente = B.rut_cliente
  AND A.id_sistema  <> B.id_sistema
  IF EXISTS(SELECT  * FROM #TEMP) 
  BEGIN
   DELETE A
   FROM LINEA_SISTEMA A,
    #TEMP B
   WHERE A.rut_cliente    = @rut_cliente
   AND A.codigo_cliente = @codigo_cliente
   AND B.id_sistema  = A.id_sistema 
   AND a.TotalOcupado  = 0
  END
  DROP TABLE #TEMP
 
         RETURN 0
         END
 DELETE FROM LINEA_SISTEMA
 WHERE rut_cliente     = @rut_cliente
 and codigo_cliente  = @codigo_cliente
 AND TotalOcupado = 0          
 SET NOCOUNT OFF
END
-- SELECT * FROM LINEA_SISTEMA
GO
