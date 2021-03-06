USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_TDE_LEE_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_TDE_LEE_DAT] 
(
	@cod_familia		NUMERIC 	 (5),
	@cod_nemo		CHAR		(20),
	@num_cupon		NUMERIC	       (3,0),
	@fecha_vcto		DATETIME	    
)
AS
BEGIN
		SELECT 	Cod_familia 	,
			cod_nemo        ,     
			num_cupon	, 
			fecha_vcto      ,            
			fecha_vcto_cupon,            
			interes         ,                                      
			amortizacion    ,                                      
			flujo           ,                                      
			saldo           ,                                      
			Factor                                                
		FROM 	TEXT_DSA	 
		WHERE 	cod_familia = @cod_familia 
		AND	Cod_nemo    = @cod_nemo    AND
			num_cupon    = @num_cupon  AND
			fecha_vcto = @fecha_vcto
END

GO
