USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Sinacofi_Graba]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Sinacofi_Graba]
            (	@clrut         NUMERIC(10) ,
		@clcodigo      NUMERIC(10) ,
		@clnumsinacofi CHAR(4)     ,
		@clnomsinacofi CHAR(4)     ,
		@datatec       CHAR(30)    ,
		@bolsa         CHAR(10)    
            )
AS 
BEGIN

	SET NOCOUNT ON
   
	IF NOT EXISTS(	SELECT 	1 
			FROM 	SINACOFI 
			WHERE 	clrut    = @clrut	AND
				clcodigo = @clcodigo
		     )
		BEGIN 
			INSERT INTO SINACOFI( 	clrut
                        			,clcodigo
						,clnumsinacofi
						,clnomsinacofi
						,datatec
						,bolsa
					)
			VALUES(	@clrut
				,@clcodigo
				,@clnumsinacofi
				,@clnomsinacofi
				,@datatec
				,@bolsa
				)
		END
	ELSE
		BEGIN
			UPDATE 	SINACOFI 
			SET 	clrut         = @clrut
				,clcodigo      = @clcodigo
				,clnumsinacofi = @clnumsinacofi
				,clnomsinacofi = @clnomsinacofi
				,datatec       = @datatec
				,bolsa         = @bolsa
			WHERE 	clrut = @clrut 		AND
				clcodigo = @clcodigo
		END

	SET NOCOUNT OFF

END


-- sp_autoriza_ejecutar 'bacuser'





GO
