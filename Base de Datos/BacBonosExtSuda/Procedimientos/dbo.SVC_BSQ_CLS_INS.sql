USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_BSQ_CLS_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_BSQ_CLS_INS]
	(@cod_nemo		CHAR(20)
	)
AS

SET NOCOUNT ON

BEGIN

	 IF EXISTS( SELECT 1 FROM Tbl_Clasificacion_Instrumento (NOLOCK) WHERE Nemo = @cod_nemo )  
	 BEGIN 


		SELECT 'Agencia'		= isnull(Agencia,0)  
			,'Clasificacion'	= isnull(Clasificacion, '')
		FROM Tbl_Clasificacion_Instrumento  (NOLOCK) 
		WHERE Nemo			= @cod_nemo  
	 END 
	 ELSE  
	 BEGIN  
		SELECT 0,''

	 END  
 
END

SET NOCOUNT OFF

GO
