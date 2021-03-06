USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_ANULA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTRADAY_ANULA]
      (
             @numoper      NUMERIC(9)
      )
AS
BEGIN
   SET NOCOUNT ON
   IF EXISTS(SELECT 1 FROM MFCA WHERE canumoper = @numoper)
   BEGIN
      UPDATE MFCA
         SET caestado = 'A',
             marca    = ''
         WHERE canumoper = @numoper
      UPDATE VIEW_MEMO
         SET moestatus = 'A',
             marca     = ''
         WHERE monumfut = @numoper
       
      SELECT 'ANULADO'
   
   END ELSE BEGIN
      SELECT 'NO EXISTE'
   END 
   SET NOCOUNT OFF
END

GO
