USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DIA_CARTERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_DIA_CARTERA] ( 
	@NUMOPER     CHAR(9) ,
	@CORRELA     CHAR(3)
)
AS
BEGIN

	SET NOCOUNT ON

	SELECT 'Días de Permanencia'   = DATEDIFF(DAY,cpfeccomp,acfecproc) 
      FROM MDCP, mdac
	 WHERE cpnumdocu = @NUMOPER
	   AND cpcorrela = @CORRELA

	SET NOCOUNT OFF

END
GO
