USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_INTRADAY]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACTUALIZA_INTRADAY]
      (
             @NUMOPER      NUMERIC(9),
             @TERMINAL     VARCHAR(30)
      )
AS
BEGIN
   DECLARE @MARCADO VARCHAR(30)
   SET NOCOUNT ON
   IF EXISTS(   SELECT 1 FROM MEMO WHERE monumope = @NUMOPER   )
   BEGIN
      SELECT @MARCADO = (   SELECT MARCA FROM MEMO WHERE monumope = @NUMOPER   )
   END ELSE BEGIN
      SELECT 'NO EXISTE'
      SET NOCOUNT OFF      
      RETURN
   END
   IF @MARCADO = ''
   BEGIN
      
      UPDATE MEMO
         SET marca = @TERMINAL
         WHERE monumope = @NUMOPER
      SELECT 'MARCADO'
   
   END ELSE IF @MARCADO = @TERMINAL
   BEGIN
      UPDATE MEMO
         SET marca = ''
         WHERE monumope = @NUMOPER
      SELECT 'DESMARCADO'
   END ELSE BEGIN
      
      SELECT 'OCUPADO'
   
   END
   SET NOCOUNT OFF
END



GO
