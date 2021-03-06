USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_MEMO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_MEMO]
AS
BEGIN
	DECLARE @nOperacion 	NUMERIC(10)
	DECLARE @Usuario 	CHAR(15)
	DECLARE @Codigo 	CHAR(20)
	DECLARE @FECHAPROC 	DATETIME
	DECLARE @FECHA 		CHAR(8)

	SET NOCOUNT ON	

	SELECT 	@fechaproc	= acfecpro  			,
		@fecha		= CONVERT(CHAR(8),acfecpro,112)
	FROM 	meac

	DECLARE Online_Cursor CURSOR FOR SELECT  CODIGO FROM TBTXONLINE	WHERE  Estado= 'E' AND CONVERT(CHAR(8),FECHA,112)=CONVERT(CHAR(8),@FECHAPROC,112) and Operacion=0

	OPEN Online_Cursor

	FETCH NEXT FROM Online_Cursor INTO @Codigo

	WHILE @@FETCH_STATUS = 0
	BEGIN


	SELECT 	@nOperacion = operacion,
	       	@Usuario    = Usuario	 
	FROM 	tbtxonline	
	WHERE 	CODIGO = @Codigo AND  Estado IN ( 'A' , 'P' ) 

	EXECUTE Sp_Elimina_Operacion	@nOperacion, @Usuario	
	EXECUTE Sp_lineas_anula	@fecha, 'BCC' , @nOperacion

	UPDATE tbtxonline SET operacion = @nOperacion WHERE Estado= 'E'	AND codigo = @Codigo

    	FETCH NEXT FROM Online_Cursor INTO @Codigo
	END
	CLOSE Online_Cursor
	DEALLOCATE Online_Cursor
	SET NOCOUNT OFF	

END
GO
