USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ACTUALIZA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ACTUALIZA]
AS
BEGIN
 SET NOCOUNT ON
 UPDATE INVERSION_EXTERIOR
 SET ArbSpo_Disponible = 0,
  ArbSpo_Exceso  = 0,
  ArbFwd_Disponible = 0,
  ArbFwd_Exceso  = 0,
  InvExt_Disponible = 0,
  ArbExt_Exceso  = 0
 UPDATE INVERSION_EXTERIOR
 SET ArbSpo_Disponible = ArbSpo_Total - ArbSpo_ocupado,
  ArbFwd_Disponible = ArbFwd_Total - ArbFwd_ocupado,
  InvExt_Disponible = InvExt_Total - InvExt_Ocupado
 UPDATE RIESGO_PAIS
 SET totaldisponible = 0,
  totalexceso = 0
 UPDATE RIESGO_PAIS
 SET totaldisponible = totalasignado - totalocupado
/*
 UPDATE MARGEN_INVERSION_GLOBAL
 SET totaldisponible = 0,
  totalexceso = 0
 UPDATE MARGEN_INVERSION_GLOBAL
 SET totaldisponible = totalasignado - totalocupado
 UPDATE MARGEN_INVERSION_INSTRUMENTO
 SET totaldisponible = 0,
  totalexceso = 0
 UPDATE MARGEN_INVERSION_INSTRUMENTO
 SET totaldisponible = totalasignado - totalocupado
*/
 UPDATE LINEA_AFILIADO
 SET totaldisponible  = 0,
  totalexceso  = 0,
  ConRiesgodisponible = 0,
  ConRiesgoexceso  = 0,
  SinRiesgodisponible = 0,
  SinRiesgoexceso  = 0
 UPDATE LINEA_AFILIADO
 SET totaldisponible = totalasignado - totalocupado
 WHERE totalasignado > totalocupado
 UPDATE LINEA_AFILIADO
 SET ConRiesgodisponible = ConRiesgoasignado - ConRiesgoocupado
 WHERE ConRiesgoasignado > ConRiesgoocupado
 UPDATE LINEA_AFILIADO
 SET SinRiesgodisponible = SinRiesgoasignado - SinRiesgoocupado
 WHERE SinRiesgoasignado > SinRiesgoocupado
 UPDATE LINEA_AFILIADO
 SET totalexceso  = ( totalasignado - totalocupado ) * -1
 WHERE totalasignado < totalocupado
 UPDATE LINEA_AFILIADO
 SET ConRiesgoexceso = ( ConRiesgoasignado - ConRiesgoocupado ) * -1
 WHERE ConRiesgoasignado < ConRiesgoocupado
 UPDATE LINEA_AFILIADO
 SET SinRiesgoexceso = ( SinRiesgoasignado - SinRiesgoocupado ) * -1
 WHERE SinRiesgoasignado < SinRiesgoocupado
 UPDATE LINEA_GENERAL
 SET totaldisponible = 0 ,
  totalexceso = 0
 UPDATE LINEA_GENERAL
 SET totaldisponible = totalasignado + totalrecibido - totalocupado
 WHERE totalasignado + totalrecibido > totalocupado
 UPDATE LINEA_GENERAL
 SET totalexceso  = ( totalasignado + totalrecibido - totalocupado ) * -1
 WHERE totalasignado + totalrecibido < totalocupado
 UPDATE LINEA_SISTEMA
 SET totaldisponible = 0 ,
  totalexceso = 0
 UPDATE LINEA_SISTEMA
 SET totaldisponible = totalasignado + totalrecibido - totalocupado
 WHERE totalasignado + totalrecibido > totalocupado
 UPDATE LINEA_SISTEMA
 SET totalexceso  = ( totalasignado + totalrecibido - totalocupado ) * -1
 WHERE totalasignado + totalrecibido < totalocupado
 UPDATE LINEA_POR_PLAZO
 SET totaldisponible = 0 ,
  totalexceso = 0
 UPDATE LINEA_POR_PLAZO
 SET totaldisponible = totalasignado + totalrecibido - totalocupado
 WHERE totalasignado + totalrecibido > totalocupado
 UPDATE LINEA_POR_PLAZO
 SET totalexceso  = ( totalasignado + totalrecibido - totalocupado ) * -1
 WHERE totalasignado + totalrecibido < totalocupado
 SET NOCOUNT OFF
END
-- select * from INVERSION_EXTERIOR

GO
