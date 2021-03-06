USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_LIMITE_TASA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_LIMITE_TASA]
     (
     @cTipo  CHAR (3) ,
     @nMoneda NUMERIC (3) ,
     @nTasa  NUMERIC (19,4) ) 
AS
BEGIN
 SET NOCOUNT ON
 IF @nTasa=0
 BEGIN
  SELECT 'OK'
  RETURN
 END
 DECLARE @nTasa_inferior NUMERIC (19,4) ,
  @nTasa_superior NUMERIC (19,4)
 SELECT @nTasa_inferior = 0 ,
  @nTasa_superior = 0
 SELECT @nTasa_inferior = tasa_inf ,
  @nTasa_superior = tasa_sup
 FROM VIEW_LIMITES_TASAS
 WHERE operacion=@cTipo AND moneda=@nMoneda
 IF @nTasa_inferior>@nTasa AND @nTasa_inferior<>0
 BEGIN
  SELECT 'NO','Valor de Tasa Menor al Minimo'
  RETURN
 END  
 IF @nTasa_superior<@nTasa AND @nTasa_superior<>0
 BEGIN
  SELECT 'NO','Valor de Tasa Mayor al Maximo'
  RETURN
 END  
 SELECT 'OK'
 SET NOCOUNT OFF
END


GO
