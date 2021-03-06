USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PARAMETROS_OPERADOR]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_PARAMETROS_OPERADOR](
      @USUARIO      CHAR(15)
          )          
AS
BEGIN
 SET NOCOUNT ON
 SELECT Punta                  ,
  Empresa                ,
  Moneda                 ,
  Posicion               ,
  Vb21446                ,
  Cierre_Mesa   ,
  Costo_Fondo   ,
  Supervisor   ,
  Intraday_Minimo        ,
  Intraday_Maximo        ,
  Overnigth_Minimo       ,
  Overnigth_Maximo       ,
  Usuario          ,
  Lineas   ,
  Swift
 FROM  VIEW_PARAMETROS_OPERADORES_SPT
 WHERE  Usuario    =   @USUARIO
 SET NOCOUNT OFF
END
-- SELECT * FROM VIEW_PARAMETROS_OPERADORES_SPT
-- EXECUTE Sp_Trae_Parametros_Operador 'ADMINISTRA'
GO
