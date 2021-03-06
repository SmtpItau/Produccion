USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABALINEAPLAZO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABALINEAPLAZO]
  @rut_cliente   numeric(9),
  @codigo_cliente   numeric(9),
  @id_sistema    char(3),
  @plazodesde   numeric(5),
  @plazohasta   numeric(5),
  @porcentaje   numeric(8,4),
  @totalasignado   numeric(19,4),
  @totalocupado   numeric(19,4),
  @totaldisponible numeric(19,4),
  @totalexceso  numeric(19,4),
  @totaltraspaso  numeric(19,4),
  @totalrecibido  numeric(19,4)
AS BEGIN
SET NOCOUNT ON
/* IF EXISTS( SELECT  DISTINCT
    rut_cliente,
    id_sistema
   FROM LINEA_POR_PLAZO
   WHERE @rut_cliente  = rut_cliente
   AND @codigo_cliente = codigo_cliente
   AND @id_sistema = id_sistema)
 BEGIN
  SELECT 'EXISTS'
  UPDATE LINEA_POR_PLAZO
  SET plazodesde      = @plazodesde,
   plazohasta      = @plazohasta,
   porcentaje      = @porcentaje,
   totalasignado   = @totalasignado,
   totalocupado    = @totalocupado,
   totaldisponible = @totaldisponible,
   totalexceso     = @totalexceso,
   totaltraspaso   = @totaltraspaso,
   totalrecibido   = @totalrecibido    
  WHERE @rut_cliente  = rut_cliente
  and @codigo_cliente = codigo_cliente
  and @id_sistema = id_sistema
  IF @@ERROR<>0 
   SELECT 'NO ACTUALIZADO'
  ELSE
  BEGIN
      SELECT 'ACTUALIZADO'
   RETURN
  END
 END
*/
  
 SELECT 'NO EXISTS'
 INSERT INTO LINEA_POR_PLAZO
        (rut_cliente,
  codigo_cliente,
  id_sistema,
  plazodesde,
  plazohasta,
  porcentaje,
  totalasignado,
  totalocupado,
  totaldisponible,
  totalexceso,
  totaltraspaso,
  totalrecibido)
 VALUES( @rut_cliente,
  @codigo_cliente,
  @id_sistema,
  @plazodesde,
  @plazohasta,
  @porcentaje,
  @totalasignado,
  @totalocupado,
  @totaldisponible,
  @totalexceso,
  @totaltraspaso,
  @totalrecibido) 
 IF @@ERROR<>0 
  SELECT 'NO INSERTADO'
 ELSE
  SELECT 'INSERTADO'
 SET NOCOUNT OFF
END
--SP_HELP LINEA_POR_PLAZO

GO
