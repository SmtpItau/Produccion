USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABALINEASISTEMA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LineaCreditoGeneral_GrabaLineaSistema    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABALINEASISTEMA]
(
 @rut_cliente   numeric(9),
 @codigo_cliente  numeric(9),
 @id_sistema   char(3),
 @fechaasignacion datetime,
 @fechavencimiento datetime,
 @fechafincontrato datetime,
 @realizatraspaso char(1),
 @bloqueado  char(1),
 @compartido  char(1),
 @controlaplazo  char(1),
 @totalasignado  numeric(19,4),
 @totalocupado  numeric(19,4),
 @totaldisponible numeric(19,4),
 @totalexceso  numeric(19,4),
 @totaltraspaso  numeric(19,4),
 @totalrecibido  numeric(19,4),
 @sinriesgoasignado numeric(19,4),
 @sinriesgoocupado numeric(19,4),
 @sinriesgodisponible numeric(19,4),
 @sinriesgoexceso numeric(19,4),
 @conriesgoasignado numeric(19,4),
 @conriesgoocupado numeric(19,4),
 @conriesgodisponible numeric(19,4),
 @conriesgoexceso     numeric(19,4)
)
AS
BEGIN
SET NOCOUNT ON
 
  IF EXISTS(SELECT DISTINCT rut_cliente,
     id_sistema,
     codigo_producto 
     FROM LINEA_TRANSACCION
     where @rut_cliente=rut_cliente
      and @id_sistema=id_sistema)
   BEGIN
   SELECT 'EXISTS'
   UPDATE LINEA_SISTEMA SET 
    --Rut_Cliente  = @Rut_Cliente,
    --Codigo_Cliente  = @Codigo_Cliente,
    --id_sistema  = @id_sistema,
    fechaasignacion  = @fechaasignacion,
    fechavencimiento = @fechavencimiento,
    fechafincontrato = @fechafincontrato,
    realizatraspaso  = @realizatraspaso,
    bloqueado  = @bloqueado,
    compartido  = @compartido,
    controlaplazo  = @controlaplazo,
    totalasignado  = @totalasignado,
    totalocupado  = @totalocupado,
    totaldisponible  = @totaldisponible,
    totalexceso  = @totalexceso,
    totaltraspaso  = @totaltraspaso,
    totalrecibido  = @totalrecibido,
    sinriesgoasignado = @sinriesgoasignado,
    sinriesgoocupado = @sinriesgoocupado,
    sinriesgodisponible = @sinriesgodisponible,
    sinriesgoexceso  = @sinriesgoexceso,
    conriesgoasignado = @conriesgoasignado,
    conriesgoocupado = @conriesgoocupado,
    conriesgodisponible = @conriesgodisponible,
    conriesgoexceso  =     @conriesgoexceso
    WHERE  rut_cliente = @rut_cliente   and
     codigo_cliente = @codigo_cliente and
     id_sistema = @id_sistema
    IF @@ERROR<>0 
       BEGIN
     SELECT 'NO ACTUALIZADO'
                       END
    ELSE
       BEGIN
        SELECT 'ACTUALIZADO'
       END
              RETURN
    --END
  END
  
  SELECT 'NO EXISTS'
  INSERT INTO LINEA_SISTEMA
         (rut_cliente,
   codigo_cliente,
   id_sistema,
   fechaasignacion,
   fechavencimiento,
   fechafincontrato,
   realizatraspaso,
   bloqueado,
   compartido,
   controlaplazo,
   totalasignado,
   totalocupado,
   totaldisponible,
   totalexceso,
   totaltraspaso,
   totalrecibido,
   sinriesgoasignado,
   sinriesgoocupado,
   sinriesgodisponible,
   sinriesgoexceso,
   conriesgoasignado,
   conriesgoocupado,
   conriesgodisponible,
   conriesgoexceso    )
  VALUES
         (@rut_cliente,
   @codigo_cliente,
   @id_sistema,
   @fechaasignacion,
   @fechavencimiento,
   @fechafincontrato,
   @realizatraspaso,
   @bloqueado,
   @compartido,
   @controlaplazo,
   @totalasignado,
   @totalocupado,
   @totaldisponible,
   @totalexceso,
   @totaltraspaso,
   @totalrecibido,
   @sinriesgoasignado,
   @sinriesgoocupado,
   @sinriesgodisponible,
   @sinriesgoexceso,
   @conriesgoasignado,
   @conriesgoocupado,
   @conriesgodisponible,
   @conriesgoexceso)
   IF @@ERROR<>0 
      BEGIN
    SELECT 'NO INSERTADO'
             END
   ELSE
      BEGIN
    SELECT 'INSERTADO'
             END
SET NOCOUNT OFF 
END

GO
