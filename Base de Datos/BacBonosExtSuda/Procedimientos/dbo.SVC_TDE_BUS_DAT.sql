USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_TDE_BUS_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_TDE_BUS_DAT] 
(
    @cod_familia          NUMERIC    (5) ,
    @cod_nemo    		CHAR       (20),
    @fecha_vcto		DATETIME       ,	
    @num_cupon   		NUMERIC (03, 0),
    @fecha_vcto_cupon     DATETIME       ,
    @interes     		FLOAT          ,
				  @Amortiza		FLOAT	       ,	
				  @flujo       		FLOAT	       ,
				  @saldo	      	FLOAT	       ,
				  @Factor		FLOAT	       
)		
AS
BEGIN
SET NOCOUNT ON

	IF EXISTS(SELECT * FROM TEXT_dsa WHERE	  cod_nemo = @cod_nemo 		AND
 						  cod_familia = @cod_familia 	AND
					 	  num_cupon = @num_cupon        AND
						  fecha_vcto = @fecha_vcto	)BEGIN

		UPDATE TEXT_dsa 
		SET   	num_cupon	= @num_cupon			,
			fecha_vcto_cupon= @fecha_vcto_cupon	,
			interes		= @interes    			,
			amortizacion	= @amortiza			, 	     	
			flujo		= @flujo              		,
			saldo		= @saldo			,
			Factor		= @Factor  					 	  					 	

		WHERE	cod_nemo	= @cod_nemo	AND 
			cod_familia	= @cod_familia 	AND
			fecha_vcto 	= @fecha_vcto	AND
			num_cupon	= @num_cupon 		
			
        END 

	ELSE BEGIN

		INSERT INTO TEXT_dsa (cod_familia			,
					 cod_nemo			,
					 num_cupon			,
					 fecha_vcto_cupon		,
					 interes   			,
					 amortizacion			, 	     	
					 flujo				,
					 saldo	  		  	,
					 fecha_vcto			,
					 Factor				)

		VALUES   		(@cod_familia			,
					 @cod_nemo			,
					 @num_cupon			,
					 @fecha_vcto_cupon		,
					 @interes   			,
					 @amortiza 	     		,
					 @flujo				,
					 @saldo	  		  	,
					 @fecha_vcto			,
					 @Factor			)


       END
SET NOCOUNT OFF
END		 

GO
