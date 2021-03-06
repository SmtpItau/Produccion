USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCGRABAR]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDRCGRABAR]	(	@ncodpro     CHAR(5)
					,	@Id_Sistema  CHAR(3)
					,	@nrut        NUMERIC(9,0)   
					,	@cnombre     CHAR(40) 
					)
AS 
BEGIN
	SET NOCOUNT ON

	IF EXISTS( SELECT rcnombre FROM  TIPO_CARTERA	WHERE	rcsistema = @Id_Sistema     
							AND	rccodpro  = @ncodpro        
							AND	rcrut     = @nrut ) BEGIN

		UPDATE	TIPO_CARTERA 
		SET	rcnombre	= @cnombre
		WHERE	rcsistema	= @Id_Sistema      
		AND	rccodpro	= @ncodpro         
		AND	rcrut		= @nrut
          
	END 
	ELSE BEGIN

		INSERT INTO TIPO_CARTERA 
		(	rcsistema  
		,	rccodpro   
		,	rcrut      
		,	rcdv       
		,	rcnombre   
		,	rcnumcorr
		)
		VALUES
		(	@Id_Sistema
		,	@ncodpro   
		,	@nrut      
		,	''         
		,	@cnombre   
		,	0
		)
	END
   
	SET NOCOUNT OFF

END
GO
