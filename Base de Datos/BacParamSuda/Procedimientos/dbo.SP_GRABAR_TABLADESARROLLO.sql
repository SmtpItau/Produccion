USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_TABLADESARROLLO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Grabar_TablaDesarrollo    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Grabar_TablaDesarrollo    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_GRABAR_TABLADESARROLLO]
                                                      (  @tdmascara1    CHAR      (12)  ,
                              @tdcupon1      NUMERIC (03,0)  , 
                                     @tdfecven1     DATETIME  ,
                                     @tdinteres1  NUMERIC (19,10)  ,
                                     @tdamort1  NUMERIC (19,10)  ,
                                     @tdflujo1      NUMERIC (19,10)  ,
                                     @tdsaldo1      NUMERIC (19,10)  )
AS
BEGIN
     SET NOCOUNT ON   
                
     INSERT INTO TABLA_DESARROLLO   (   tdmascara,   tdcupon,   tdfecven,   tdinteres,   tdamort,   tdflujo,   tdsaldo )
                     VALUES ( @tdmascara1, @tdcupon1, @tdfecven1, @tdinteres1, @tdamort1, @tdflujo1, @tdsaldo1 )
IF @@error <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END
SET NOCOUNT OFF
SELECT 'SI'
END
GO
