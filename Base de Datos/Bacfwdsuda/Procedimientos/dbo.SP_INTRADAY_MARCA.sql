USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_MARCA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_INTRADAY_MARCA]
      (
             @numoper      NUMERIC(9),
             @terminal     VARCHAR(30)
      )
AS
BEGIN
   DECLARE @marca VARCHAR(30)
   SET NOCOUNT ON
   IF EXISTS(SELECT 1 FROM MFCA WHERE canumoper = @numoper)
   BEGIN
      SELECT @marca = (SELECT marca FROM MFCA WHERE canumoper = @numoper)
   END ELSE BEGIN
      SELECT 'NO EXISTE'
      SET NOCOUNT OFF      
      RETURN
   END
  
   SELECT @marca = ISNULL(@marca,'')
   IF @marca = '' 
   BEGIN
      
      UPDATE MFCA
         SET marca = @terminal
         WHERE canumoper = @numoper
      SELECT 'MARCADO'
   
   END ELSE IF @marca = @terminal
   BEGIN
      UPDATE MFCA
         SET marca = ''
         WHERE canumoper = @numoper
      SELECT 'DESMARCADO'
   END ELSE BEGIN
      
      SELECT 'OCUPADO'
   
   END
   SET NOCOUNT OFF
END

GO
