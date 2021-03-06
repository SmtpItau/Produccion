USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACUTALIZAMESA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACUTALIZAMESA]( @xValor CHAR(1) )
AS
BEGIN

SET NOCOUNT ON

IF @xValor = '1'
BEGIN
   IF (SELECT COUNT(monumoper) FROM MDMO WHERE mostatreg = 'P' and SorteoLchr = 'N') > 0
   BEGIN
      SELECT 'APROB'
      GOTO Fin_AcutalizaMesa
   END
END

UPDATE MDAC SET acsw_mesa = @xValor
            
IF @@ERROR <> 0 
   SELECT 'ERROR'
ELSE              
   SELECT 'OK'      

Fin_AcutalizaMesa:

SET NOCOUNT OFF

END

GO
