USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_BUSCA_LAFILIADO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_BUSCA_LAFILIADO] 
     (
     @rutcasamatriz  NUMERIC(9),
     @codigocasamatriz NUMERIC(9)
     )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT 1 FROM LINEA_AFILIADO  WHERE  rutcasamatriz = @rutcasamatriz AND 
       codigocasamatriz = @codigocasamatriz )
 BEGIN
  SELECT
    RutCasaMatriz
   ,CodigoCasaMatriz
   ,TotalAsignado
   ,TotalOcupado
   ,TotalDisponible
   ,TotalExceso
   ,SinRiesgoAsignado
   ,SinRiesgoOcupado
   ,SinRiesgoDisponible
   ,SinRiesgoExceso
   ,ConRiesgoAsignado
   ,ConRiesgoOcupado
   ,ConRiesgoDisponible
   ,ConRiesgoExceso
  FROM LINEA_AFILIADO 
  WHERE  rutcasamatriz = @rutcasamatriz AND 
   codigocasamatriz = @codigocasamatriz 
   
 END
 ELSE BEGIN
  SELECT
    'RutCasaMatriz' =0
   ,'CodigoCasaMatriz' =0
   ,'TotalAsignado' =0
   ,'TotalOcupado'  =0
   ,'TotalDisponible' =0
   ,'TotalExceso'  =0 
   ,'SinRiesgoAsignado' =0
   ,'SinRiesgoOcupado' =0
   ,'SinRiesgoDisponible' =0
   ,'SinRiesgoExceso' =0
   ,'ConRiesgoAsignado' =0
   ,'ConRiesgoOcupado' =0
   ,'ConRiesgoDisponible' =0
   ,'ConRiesgoExceso' =0
 
 END
 
 SET NOCOUNT OFF
END
GO
