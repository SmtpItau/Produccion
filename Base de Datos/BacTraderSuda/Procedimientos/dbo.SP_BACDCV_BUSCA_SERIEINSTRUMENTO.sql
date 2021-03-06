USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDCV_BUSCA_SERIEINSTRUMENTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDCV_BUSCA_SERIEINSTRUMENTO]
                                                (
                                                      @serie             CHAR(12),
                                                      @instrumento       CHAR(12)
                                                )
AS
BEGIN
      SET NOCOUNT ON
            IF @serie <> '' AND @instrumento = '' BEGIN
                  IF EXISTS(SELECT 1 FROM VIEW_SERIE WHERE semascara = @serie) BEGIN     
                        SELECT secodigo FROM VIEW_SERIE WHERE semascara = @serie                  
                   END ELSE BEGIN
                        SELECT 'NO'
                   END
            END
            IF @serie = '' AND @instrumento <> '' BEGIN
                  IF EXISTS(SELECT 1 FROM VIEW_INSTRUMENTO WHERE inserie = @instrumento) BEGIN
                        SELECT incodigo FROM VIEW_INSTRUMENTO WHERE inserie = @instrumento
                  END ELSE BEGIN
                        SELECT 'NO'
                  
                  END
            END
      SET NOCOUNT OFF
END

GO
