USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GBR_CLS_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVA_GBR_CLS_INS]
	(@cod_nemo		CHAR(20)
	,@Agencia		INT = 0
	,@Clasificacion  VARCHAR(20)  = ''
	)
AS

SET NOCOUNT ON

BEGIN

	 IF EXISTS( SELECT 1 FROM Tbl_Clasificacion_Instrumento WHERE Nemo = @cod_nemo )  
	 BEGIN 


		UPDATE Tbl_Clasificacion_Instrumento  
		SET  Clasificacion	= @Clasificacion  
			,Agencia		= @Agencia  
		WHERE Nemo			= @cod_nemo  
	 END 
	 ELSE  
	 BEGIN  

		INSERT INTO Tbl_Clasificacion_Instrumento  
		SELECT Nemo			= @cod_nemo  
			, Agencia		= @Agencia  
			, Clasificacion = @Clasificacion  
	 END  
 
END

SET NOCOUNT OFF

GO
