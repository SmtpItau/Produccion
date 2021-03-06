USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOLINEA_ELIMINA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOLINEA_ELIMINA]
 (@rutcliente numeric(9),
  @codcliente numeric(9),
  @id_sistema char(3)='')
AS
BEGIN
 SET NOCOUNT ON
 IF @id_sistema=''
 BEGIN
  DELETE FROM LINEA_POR_PLAZO
  WHERE rut_cliente=@rutcliente
  AND codigo_cliente=@codcliente
  AND  TotalOcupado = 0
         RETURN
 END
 IF EXISTS( SELECT  DISTINCT
    rut_cliente,
    id_sistema,
    codigo_producto 
   FROM LINEA_TRANSACCION
   WHERE rut_cliente= @rutcliente
   and id_sistema= @id_sistema)
 BEGIN
  SELECT 'NO'
  RETURN
 END
 
 
 DELETE FROM LINEA_POR_PLAZO
 WHERE rut_cliente=@rutcliente 
 and codigo_cliente=@codcliente
 and id_sistema= @id_sistema
 AND  TotalOcupado = 0
 SET NOCOUNT OFF
END
-- SELECT * FROM LINEA_POR_PLAZO

GO
