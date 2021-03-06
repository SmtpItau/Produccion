USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDCV_ACTUALDCV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDCV_ACTUALDCV]
                           (    @secodigo  NUMERIC (5) ,
    @semascara CHAR    (12)
                            )  
AS
BEGIN
  SET NOCOUNT ON 
         IF @secodigo <> 0 AND @semascara <> '' BEGIN
            IF EXISTS(SELECT 1 FROM MDCP WHERE (cpcodigo  = @secodigo AND cpinstser = @semascara) ) BEGIN
  SELECT cpnumdocu  ,
   cpcorrela  ,
   cpinstser  ,
   cptircomp  ,
   ISNULL(cpdcv,'N')
  FROM MDCP 
                
                WHERE   
                        (cpcodigo  = @secodigo       
                        AND cpinstser = @semascara) 
             ORDER BY cpinstser
            
            END ELSE BEGIN 
            
                  SELECT 'NO'
            END
         END
         IF @secodigo <> 0 AND @semascara = '' BEGIN
            IF EXISTS(SELECT 1 FROM MDCP WHERE (cpcodigo  = @secodigo) ) BEGIN
  SELECT cpnumdocu  ,
   cpcorrela  ,
   cpinstser  ,
   cptircomp  ,
   ISNULL(cpdcv,'N')
  FROM MDCP 
                
                WHERE   
                        (cpcodigo  = @secodigo) 
             ORDER BY cpinstser
            
            END ELSE BEGIN 
            
                  SELECT 'NO'
            END
         END
            
         IF @secodigo = 0 AND @semascara <> '' BEGIN
            IF EXISTS(SELECT 1 FROM MDCP WHERE (cpinstser = @semascara) ) BEGIN
  SELECT cpnumdocu  ,
   cpcorrela  ,
   cpinstser  ,
   cptircomp  ,
   ISNULL(cpdcv,'N')
  FROM MDCP 
                
                WHERE   
                        (cpinstser = @semascara) 
             ORDER BY cpinstser
            
            END ELSE BEGIN 
            
                  SELECT 'NO'
            END
         END
   SET NOCOUNT OFF
END

GO
