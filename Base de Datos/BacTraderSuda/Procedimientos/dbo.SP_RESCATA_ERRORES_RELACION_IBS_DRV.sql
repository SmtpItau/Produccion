USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESCATA_ERRORES_RELACION_IBS_DRV]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RESCATA_ERRORES_RELACION_IBS_DRV]
    (   @dFecha   DATETIME   )
AS
BEGIN    

   SET NOCOUNT ON

    SELECT DISTINCT 
      err.Modulo
    , err.NumPrestamo
    , err.NumDerivado
    , err.Mensaje
    , err.Evento      
    , 'Firma'  = 'Administrador de Eventos.'    
    INTO #TEMP_RESULTADO
    FROM dbo.TBL_ERRORES_RELACION_PAE                     err
        , BacParamSuda.dbo.CONFIGURACION_MENSAJE          conf
        , BacparamSuda.dbo.TABLA_ROLES_USUARIOS           rol
    WHERE  err.Evento    =  conf.Evento
    AND    Estado    = 1
    AND    FechaProceso  = @dFecha
    AND    conf.Rol  =  rol.Rol
    AND    Modulo <> 'ANT' 

    IF @@ROWCOUNT <> 0         
        SELECT *  FROM #TEMP_RESULTADO
    ELSE 
 
        SELECT  -1


    
END
GO
