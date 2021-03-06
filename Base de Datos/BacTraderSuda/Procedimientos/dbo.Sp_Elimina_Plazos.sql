USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Plazos]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Elimina_Plazos]
                        (
                         @Cartera        NUMERIC(01,00),
                         @Instrumento    CHAR(10)
                         )
AS

BEGIN

SET NOCOUNT ON

    DELETE FROM TBLimper    
    WHERE  cartera = @Cartera
    AND    instrumento = @Instrumento

      IF @@ERROR <> 0
     BEGIN
          SELECT @@ERROR,'Instrumento' + @Instrumento + 'NO pudo ser Eliminado'
          RETURN
     END

    DELETE FROM TBLimper_pre_aprobado  
    WHERE  cartera = @Cartera
    AND    instrumento = @Instrumento

     IF @@ERROR <> 0
     BEGIN
          SELECT @@ERROR,'Instrumento' + @Instrumento + 'NO pudo ser Eliminado'
          RETURN
     END

SET NOCOUNT OFF

END
                                        
GO
