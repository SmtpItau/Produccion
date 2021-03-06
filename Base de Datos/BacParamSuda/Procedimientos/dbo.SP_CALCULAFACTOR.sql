USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULAFACTOR]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_CALCULAFACTOR]  
 (  @numdocu NUMERIC(9,0)  
  ,@correla NUMERIC(5)  
  ,@cInstrum CHAR(12)  
  ,@vNominal NUMERIC(19,4)  
  ,@factor NUMERIC(19,4) OUTPUT  
 )  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @folio NUMERIC(9,0),  
  @NominalGtias NUMERIC(19,4)  
  
 IF @vNominal IS NULL  
 BEGIN  
  SELECT @factor = 1.0000  
  RETURN  
 END  
  
 IF @vNominal = 0.0000  
 BEGIN  
  SELECT @factor = 1.0000  
  RETURN  
 END  
  
 SELECT @NominalGtias=ISNULL(SUM(Nominal),1) FROM tbl_Garantias_Otorgadas_Detalle  
 WHERE Numdocu = @numdocu   
 AND  Correlativo = @correla  
 AND   Nemotecnico = @cInstrum  
  
       IF NOT EXISTS( SELECT 1 FROM TBL_GARANTIAS_OTORGADAS_DETALLE WHERE Numdocu = @numdocu AND Correlativo = @correla AND Nemotecnico = @cInstrum )  
       BEGIN  
           SELECT @factor = 1  
       END ELSE   
       BEGIN  
           SELECT @factor = ( @NominalGtias/@vNominal )   
       END  
  
 SET NOCOUNT OFF  
END
GO
