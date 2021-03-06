USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABA]
 @rut_cliente  numeric(9),
 @codigo_cliente  numeric(9),
 @fechaasignacion datetime,
 @fechavencimiento datetime, 
 @fechafincontrato datetime,
 @bloqueado  char(1),
 @totalasignado  numeric(19,4),
 @totalocupado  numeric(19,4),
 @totaldisponible numeric(19,4),
 @totalexceso  numeric(19,4),
 @totaltraspaso  numeric(19,4),
 @totalrecibido  numeric(19,4),
 @rutcasamatriz  numeric(9),
 @codigocasamatriz numeric(9)
AS
BEGIN
SET NOCOUNT ON
 BEGIN
 IF EXISTS(SELECT 1 FROM LINEA_GENERAL WHERE rut_cliente=@rut_cliente
       AND codigo_cliente=@codigo_cliente)
  BEGIN
  SELECT 'EXISTS'
  UPDATE LINEA_GENERAL SET 
   --Rut_Cliente  = @Rut_Cliente,
   --Codigo_Cliente = @Codigo_Cliente,
   fechaasignacion  = @fechaasignacion,
   fechavencimiento = @fechavencimiento,
   fechafincontrato = @fechafincontrato,
   bloqueado  = @bloqueado,
   totalasignado  = @totalasignado,
   totalocupado  = @totalocupado,
   totaldisponible  = @totaldisponible,
   totalexceso  = @totalexceso,
   totaltraspaso  = @totaltraspaso,
   totalrecibido  = @totalrecibido,
   rutcasamatriz  = @rutcasamatriz,
   codigocasamatriz = @codigocasamatriz
   WHERE rut_cliente = @rut_cliente and
         codigo_cliente = @codigo_cliente
   IF @@ERROR<>0 
      BEGIN
    SELECT 'NO ACTUALIZADO'
             END
   ELSE
      BEGIN
    SELECT 'ACTUALIZADO'
    DELETE FROM LINEA_SISTEMA WHERE rut_cliente=@rut_cliente and codigo_cliente=@codigo_cliente
             END
   --END
  END
 ELSE
  BEGIN
  SELECT 'NO EXISTS'
  INSERT INTO LINEA_GENERAL
         (rut_cliente,
   codigo_cliente,
   fechaasignacion,
   fechavencimiento,
   fechafincontrato,
   bloqueado,
   totalasignado,
   totalocupado,
   totaldisponible,
   totalexceso,
   totaltraspaso,
   totalrecibido,
   rutcasamatriz,
   codigocasamatriz)
  VALUES
         (@rut_cliente,
   @codigo_cliente,
   @fechaasignacion,
   @fechavencimiento,
   @fechafincontrato,
   @bloqueado,
   @totalasignado,
   @totalocupado,
   @totaldisponible,
   @totalexceso,
   @totaltraspaso,
   @totalrecibido,
   @rutcasamatriz,
   @codigocasamatriz)
   IF @@ERROR<>0 
      BEGIN
    SELECT 'NO INSERTADO'
             END
   ELSE
      BEGIN
    SELECT 'INSERTADO'
   
             END
   --END
  END
 END
END

GO
