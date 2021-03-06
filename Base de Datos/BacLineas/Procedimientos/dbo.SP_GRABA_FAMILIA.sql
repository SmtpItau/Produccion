USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FAMILIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GRABA_FAMILIA    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_GRABA_FAMILIA    fecha de la secuencia de comandos: 14/02/2001 09:58:26 ******/
CREATE PROCEDURE [dbo].[SP_GRABA_FAMILIA]
                                       (@xSerie  CHAR(12) ,
     @xGlosa  CHAR(40) ,
     @xCodigo  NUMERIC(3) ,
     @xProg  CHAR(8)  ,
     @xRefNom  CHAR(1)  ,
     @xRutemi  NUMERIC(9) ,
     @xMonemi  NUMERIC(3) ,
     @xBasemi  NUMERIC(3) ,
     @xTasaEst  NUMERIC(3) ,
     @xTipo   CHAR(3)  ,
     @xMdSe  CHAR(1)  ,
     @xMdPr  CHAR(1)  ,
     @xMdTd  CHAR(1)  ,
     @XTipoFec  NUMERIC(1) ,
     @xEmision  CHAR(3)  ,
     @xEleg   CHAR(1)  ,
     @xContab  CHAR(1)  ,
     @xTotalEmitido          FLOAT           ,
     @xSecurityType          CHAR(2)         ,
     @xintiporig             CHAR(3)  ) 
AS
BEGIN
      SET NOCOUNT ON
  IF EXISTS(SELECT 1 FROM INSTRUMENTO WHERE inserie = @xSerie) 
                      UPDATE instrumento SET inglosa  = @xGlosa  ,
    incodigo = @xCodigo  ,
    inprog  = @xProg  ,
    inrefnomi = @xRefNom  ,
    inrutemi =  @xRutemi  ,
    inmonemi = @xMonemi  ,
    inbasemi = @xBasemi  ,
    intasest = @xTasaEst  ,
    intipo  = @xTipo   ,
    inmdse  = @xMdSe  ,
    inmdpr  = @xMdPr  ,
    inmdtd  = @xMdTd  ,
    intipfec  = @xTipoFec  ,
    inemision = @xEmision  ,
    ineleg  = @xEleg   ,
    incontab = @xContab                ,
    intotalemitido  =       @xTotalEmitido          ,
    insecuritytype  =       @xSecurityType          ,
    intiporig       =       @xintiporig            
 
    WHERE inserie = @xSerie
  ELSE
            INSERT INTO INSTRUMENTO ( inserie      ,
    inglosa      ,
    incodigo     ,
    inprog      ,
    inrefnomi     ,
    inrutemi     ,
    inmonemi     ,
    inbasemi     ,
    intasest     ,
    intipo      ,
    inmdse      ,
    inmdpr      ,
    inmdtd      ,
    intipfec      ,
    inemision     ,
    ineleg      ,
    incontab     ,
    intotalemitido                                  ,
    insecuritytype                                  ,
    intiporig )
 VALUES  ( @xSerie     ,
    @xGlosa     ,
    @xCodigo     ,
    @xProg     ,
    @xRefNom     ,
    @xRutemi     ,
    @xMonemi     ,
    @xBasemi     ,
    @xTasaEst     ,
    @xTipo      ,
    @xMdSe     ,
    @xMdPr     ,
    @xMdTd     ,
    @xTipoFec     ,
    @xEmision     ,
    @xEleg      ,
    @xContab      ,
    @xTotalEmitido                                  ,
    @xSecurityType                                 ,
    @xintiporig)
IF @@error <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END
SET NOCOUNT OFF
SELECT 'SI'
END
--sp_help mdin
GO
