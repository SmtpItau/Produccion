USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_SELECCION_MARCA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_SELECCION_MARCA]( @numdocu NUMERIC, @correla NUMERIC )
AS
BEGIN
 SET NOCOUNT ON
 --desbloqueo el papel
 DELETE FROM mdbl
 WHERE blnumdocu = @numdocu
 AND blcorrela = @correla
 
 --acrualizo cartera
 UPDATE  mdcp
 SET cpreserva_tecnica = 'M'
 WHERE cpnumdocu = @numdocu
 AND cpcorrela = @correla
  
 SET NOCOUNT OFF
END

GO
