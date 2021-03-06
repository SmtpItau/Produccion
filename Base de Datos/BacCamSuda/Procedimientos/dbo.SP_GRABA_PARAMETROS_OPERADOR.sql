USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PARAMETROS_OPERADOR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_PARAMETROS_OPERADOR]
      (
           @PUNTA         NUMERIC(19,2)
         , @EMPRE         NUMERIC(19,2)
         , @ARBIT         NUMERIC(19,2)
         , @POSIC         NUMERIC(19,2)
         , @CAPIT         NUMERIC(19,2)
         , @CMESA         CHAR(1)
         , @FONDO         CHAR(1)
         , @SUPER         CHAR(1)
         , @INTRA_MIN     NUMERIC(19,2)
         , @INTRA_MAX     NUMERIC(19,2)
         , @OVERN_MIN     NUMERIC(19,2)
         , @OVERN_MAX     NUMERIC(19,2)
         , @USUAR         CHAR(15)
      )
AS
BEGIN
SET NOCOUNT ON
IF NOT EXISTS( SELECT 1 
             FROM PARAMETROS_OPERADORES_SPT 
            WHERE Usuario    =       @USUAR      )
BEGIN
       INSERT PARAMETROS_OPERADORES_SPT
            (
               Punta                 
             , Empresa               
             , Moneda                
             , Posicion              
             , Vb21446               
             , Cierre_Mesa 
             , Costo_Fondo 
             , Supervisor 
             , Intraday_Minimo       
             , Intraday_Maximo       
             , Overnigth_Minimo      
             , Overnigth_Maximo      
             , Usuario            
           )
       VALUES
           (
             @PUNTA
           , @EMPRE
           , @ARBIT
           , @POSIC
           , @CAPIT
           , @CMESA
           , @FONDO
           , @SUPER
           , @INTRA_MIN
           , @INTRA_MAX
           , @OVERN_MIN
           , @OVERN_MAX
           , @USUAR
          )
         IF @@ERROR <> 0
         BEGIN
            SELECT 0, 'ERROR EN LA GRABACION'
            SET NOCOUNT OFF
            RETURN
         END ELSE 
         BEGIN
            SELECT 1, 'GABACION EXITOSA'
            SET NOCOUNT OFF
            RETURN
         END
END ELSE 
BEGIN
        UPDATE PARAMETROS_OPERADORES_SPT 
           SET Punta              =    @PUNTA
             , Empresa            =    @EMPRE
             , Moneda             =    @ARBIT
             , Posicion           =    @POSIC
             , Vb21446            =    @CAPIT
             , Cierre_Mesa        =    @CMESA
             , Costo_Fondo        =    @FONDO
             , Supervisor         =    @SUPER
             , Intraday_Minimo    =    @INTRA_MIN
             , Intraday_Maximo    =    @INTRA_MAX
             , Overnigth_Minimo   =    @OVERN_MIN
             , Overnigth_Maximo   =    @OVERN_MAX
         WHERE Usuario            =    @USUAR     
         IF @@ERROR <> 0
         BEGIN
            SELECT 0, 'ERROR EN LA ACTUALIZACION'
            SET NOCOUNT OFF
            RETURN
         END ELSE 
         BEGIN
            SELECT 1, 'ACTUALIZACION EXITOSA'
            SET NOCOUNT OFF
            RETURN
         END
END
END

GO
