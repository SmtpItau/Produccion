USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPERACIONES_BTR]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_OPERACIONES_BTR]  
(   @numoper     INT  
,   @numdocu     INT  
,   @numcorrela  INT  
)  
AS  
BEGIN  
  
    SET NOCOUNT ON    
  
    IF EXISTS( SELECT 1 FROM mdvi WHERE vinumoper = @numoper AND vinumdocu = @numdocu AND vicorrela = @numcorrela AND vitipoper = 'cp' AND vinominal > 0)  
    BEGIN  
        SELECT 'SI'   
    END ELSE   
    BEGIN  
        SELECT 'NO'   
    END  
     
END 
GO
