USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_CONTROL_BLOQUEO_GARANTIAS_OTORGADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_CONTROL_BLOQUEO_GARANTIAS_OTORGADAS]
   		(   	@iAction	INTEGER		--> {1}:Consulta ; {2}:Grabar ; {3}:DesMarcar
		,	@nNumdocu	NUMERIC(10,0)
   		,   	@nCorrelativo	NUMERIC(5)
   		,   	@hWnd         	NUMERIC(9)
		,	@sUsuario	VARCHAR(15)
   )
AS
BEGIN

	SET NOCOUNT ON				;	

	DECLARE @sResultado	VARCHAR(2)	;
       	    SET @sResultado	= 'DS'		;

	IF @iAction = 1  --> Verifica si es posible bloquear el instrumento
	BEGIN


		SET @sResultado	= ISNULL((SELECT 'ND' AS Estatus
					    FROM bactradersuda.dbo.MDBL 
			    	           WHERE blnumdocu	= @nNumdocu 
	 		      	  	     AND blcorrela	= @nCorrelativo 
				  	     AND blusuario = @sUsuario
			      	  	     AND blhwnd    = @hWnd ),'DS')		;


	   --> Revisa si esta tomado por otro usuario 
		SET @sResultado	= CASE WHEN @sResultado = 'ND' THEN 'ND' 
				       ELSE ISNULL((SELECT TOP 1 'OU' AS Estatus 
					    	      FROM bactradersuda.dbo.MDBL 
			    	           	     WHERE blnumdocu	= @nNumdocu 
	 		      	  	     	       AND blcorrela	= @nCorrelativo 
					  	       AND blusuario <>  @sUsuario
			      	  	     	       AND blhwnd    <> @hWnd ),'DS') END ;

	END

	IF @iAction = 2 
	BEGIN
		INSERT INTO bactradersuda.dbo.MDBL(	
			blrutcart   
		,	blnumdocu    
		,	blcorrela 
		,	blhwnd       
		,	blusuario      )
		VALUES ( 
			 97023000
		,	@nNumDocu
         	,	@nCorrelativo
         	,   	@hWnd
         	,   	@sUsuario ) ;
	
		SET @sResultado = 'OK'	;
   	END

	IF @iAction = 3 
	BEGIN
      		DELETE 
		  FROM bactradersuda.dbo.MDBL 
		 WHERE blnumdocu	= @nNumdocu 
		   AND blcorrela	= @nCorrelativo 
		   AND blusuario = @sUsuario
		   AND blhwnd    = @hWnd ;

		SET @sResultado = 'OK'	;
	END

--	SELECT @sResultado as Resultado
	IF @sResultado = 'OU'
		SELECT -1, 'El instrumento se encuentra ocupado por otro usuario.'
	ELSE
		SELECT @sResultado AS Resultado
END
GO
