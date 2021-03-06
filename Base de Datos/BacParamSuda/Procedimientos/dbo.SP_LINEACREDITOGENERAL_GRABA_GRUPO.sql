USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABA_GRUPO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABA_GRUPO]
 @totalasignado  numeric(19,4),
 @totalocupado  numeric(19,4),
 @totaldisponible numeric(19,4),
 @totalexceso  numeric(19,4),
 @rutcasamatriz  numeric(9),
 @codigocasamatriz numeric(9),
 @SinRiesgoAsignado numeric(19,4),
 @ConRiesgoAsignado numeric(19,4)
AS
BEGIN
SET NOCOUNT ON
 BEGIN
 IF EXISTS(SELECT 1 FROM LINEA_AFILIADO  WHERE rutcasamatriz  = @rutcasamatriz and
         codigocasamatriz = @codigocasamatriz)
  BEGIN
   SELECT 'EXISTS'
   UPDATE LINEA_AFILIADO SET 
    totalasignado  = @totalasignado,
    totalocupado  = @totalocupado,
    totaldisponible  = @totaldisponible,
    totalexceso  = @totalexceso,
    rutcasamatriz  = @rutcasamatriz,
    codigocasamatriz = @codigocasamatriz,
    SinRiesgoAsignado =  @SinRiesgoAsignado,
    ConRiesgoAsignado =  @ConRiesgoAsignado
    WHERE rutcasamatriz  = @rutcasamatriz and
          codigocasamatriz = @codigocasamatriz
    IF @@ERROR<>0 
       BEGIN
     SELECT 'NO ACTUALIZADO'
              END 
   END
  ELSE
   BEGIN
    SELECT 'NO EXISTS'
    INSERT INTO LINEA_AFILIADO
           (
     totalasignado,
     totalocupado,
     totaldisponible,
     totalexceso,
     rutcasamatriz,
     codigocasamatriz,
     SinRiesgoAsignado,
     ConRiesgoAsignado
     )
    VALUES
           (
     @totalasignado,
     @totalocupado,
     @totaldisponible,
     @totalexceso,
     @rutcasamatriz,
     @codigocasamatriz,
     @SinRiesgoAsignado,
     @ConRiesgoAsignado
     )
    IF @@ERROR<>0 
       BEGIN
      SELECT 'NO INSERTADO'
                     END
    ELSE
       BEGIN
      SELECT 'INSERTADO'
   
                  END
   END
 END
END
-- select * from LINEA_AFILIADO

GO
