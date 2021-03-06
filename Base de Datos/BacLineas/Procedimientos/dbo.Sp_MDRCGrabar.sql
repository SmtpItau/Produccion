USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCGrabar]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDRCGrabar] 
       (
        @ncodpro     CHAR(5)        ,
        @Id_Sistema  CHAR(3)        ,
        @nrut        NUMERIC(9,0)   ,
        @cnombre     CHAR(40) 	    ,
        @hedge	     CHAR(1)	    
       )
AS 
BEGIN
	SET NOCOUNT ON

	IF EXISTS(
			SELECT	rcnombre
			FROM  	TIPO_CARTERA 
			WHERE 	rcsistema = @Id_Sistema     AND
				rccodpro  = @ncodpro        AND
				rcrut     = @nrut
		) 
		BEGIN
			UPDATE	tipo_cartera 
			SET	rcnombre  = @cnombre	,
				rcnumcorr = ( CASE @hedge WHEN 'X' THEN 1 ELSE 0 END )       -- Utilizado para determinar si afecta Hedge 1 ó 0
			WHERE	rcsistema = @Id_Sistema      AND
				rccodpro  = @ncodpro         AND
				rcrut     = @nrut
          
		END 
	ELSE 
		BEGIN
			INSERT INTO TIPO_CARTERA (	rcsistema  ,
							rccodpro   ,
							rcrut      , 
							rcdv       ,
							rcnombre   ,
							rcnumcorr
						)
			VALUES      ( 	@Id_Sistema,  -- Forward
					@ncodpro   ,
					@nrut      ,
					''         ,
					@cnombre   ,
					( CASE @hedge WHEN 'X' THEN 1 ELSE 0 END )       -- Utilizado para determinar si afecta Hedge 1 ó 0
				    )
	END
   
	SET NOCOUNT OFF
	SELECT 0

END

-- SP_AUTORIZA_EJECUTAR 'BACUSER'





GO
