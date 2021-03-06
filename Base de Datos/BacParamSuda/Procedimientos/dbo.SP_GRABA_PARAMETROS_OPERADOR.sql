USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PARAMETROS_OPERADOR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_PARAMETROS_OPERADOR]
      (
           @punta         NUMERIC(19,2)
         , @empre         NUMERIC(19,2)
         , @arbit         NUMERIC(19,2)
         , @posic         NUMERIC(19,2)
         , @capit         NUMERIC(19,2)
         , @cmesa         CHAR(1)
         , @fondo         CHAR(1)
         , @super         CHAR(1)
         , @intra_min     NUMERIC(19,2)
         , @intra_max     NUMERIC(19,2)
         , @overn_min     NUMERIC(19,2)
         , @overn_max     NUMERIC(19,2)
         , @usuar         CHAR(15)
  , @linea   CHAR(1)
  , @swift   CHAR(1)
      )
AS
BEGIN
 SET NOCOUNT ON
 IF NOT EXISTS(  SELECT 1 
   FROM VIEW_PARAMETROS_OPERADORES_SPT 
   WHERE Usuario    =       @USUAR      )
  BEGIN
   INSERT VIEW_PARAMETROS_OPERADORES_SPT( Punta    ,                
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
        Overnigth_Maximo    ,
        Lineas     ,
        Usuario   ,
        Swift
                   )
   VALUES( @punta  ,
    @empre  ,
    @arbit  ,
    @posic  ,
    @capit  ,
    @cmesa  ,
    @fondo  ,
    @super  ,
    @intra_min ,
    @intra_max ,
    @overn_min ,
    @overn_max ,
    @linea  ,
    @usuar  ,
    @swift
                )
   IF @@ERROR <> 0
    BEGIN
     SELECT 0, 'ERROR EN LA GRABACION'
     SET NOCOUNT OFF
     RETURN
    END 
   ELSE 
    BEGIN
     SELECT 1, 'GABACION EXITOSA'
     SET NOCOUNT OFF
     RETURN
    END
  END 
 ELSE 
  BEGIN
   UPDATE  VIEW_PARAMETROS_OPERADORES_SPT 
   SET  Punta              =    @punta  ,
    Empresa            =    @empre  ,
    Moneda             =    @arbit  ,
    Posicion           =    @posic  ,
    Vb21446            =    @capit  ,
    Cierre_Mesa        =    @cmesa  ,
    Costo_Fondo        =    @fondo  ,
    Supervisor         =    @super  ,
    Intraday_Minimo    =    @intra_min ,
    Intraday_Maximo    =    @intra_max ,
    Overnigth_Minimo   =    @overn_min ,
    Overnigth_Maximo   =    @overn_max ,
    Lineas     = @linea  ,
    Swift     = @swift  
   WHERE  Usuario            =    @usuar
   IF @@ERROR <> 0
    BEGIN
     SELECT 0, 'ERROR EN LA ACTUALIZACION'
     SET NOCOUNT OFF
     RETURN
    END 
   ELSE 
    BEGIN
     SELECT 1, 'ACTUALIZACION EXITOSA'
     SET NOCOUNT OFF
     RETURN
    END
  END
END
GO
