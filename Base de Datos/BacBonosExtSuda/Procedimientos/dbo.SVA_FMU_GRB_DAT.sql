USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_FMU_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_FMU_GRB_DAT] 
( 
                                   @cod_familia	NUMERIC		(4) ,
				   @Cod_nemo		CHAR		(20)  ,
				   @fecha_vcto	DATETIME	     ,	
				   @Tipo_cal		NUMERIC 	(1)  ,
				   @Num_linea		NUMERIC         (2)  ,		
				   @variable		CHAR		(50) ,
				   @formula		CHAR		(100),
				   @Tipo_formula	CHAR		(1)  ,	
				   @Param1		CHAR		(15) ,
				   @Param2		CHAR		(15) ,
				   @Param3		CHAR		(15) ,
				   @Param4		CHAR		(15) 
)

AS
BEGIN
SET NOCOUNT ON
/*	DELETE FROM invex_formulas where 	cod_familia = @cod_familia 	AND
						cod_nemo    = @cod_nemo	   	AND
						fecha_vcto  = @fecha_vcto  	
--						Tipo_cal    = @tipo_cal	   	AND
--						num_linea   = @num_linea	


	IF EXISTS (SELECT * FROM invex_formulas WHERE cod_familia = @cod_familia and cod_nemo=@cod_nemo and  tipo_cal = @tipo_cal and num_linea = @num_linea and fecha_vcto = @fecha_vcto)BEGIN
		UPDATE invex_formulas 
		SET variable = @variable ,
		     formula = @formula
		WHERE cod_nemo  = @cod_nemo 
		and cod_familia = @cod_familia
		and tipo_cal    = @tipo_cal 
		and num_linea   = @num_linea 
		and fecha_vcto  = @fecha_vcto
	END
	ELSE BEGIN
*/		
INSERT INTO text_frm (	     cod_familia,	
		                                     Cod_nemo,
						     fecha_vcto,			
						     Tipo_cal,
						     Num_linea,
			     			     variable,
		              		             formula,
						     Tipo_formula,
					     	     Parametro1,
					     	     Parametro2,
					     	     Parametro3,
					     	     Parametro4
                     )

		VALUES	(    @cod_familia,
 			     @Cod_nemo,	
			     @fecha_vcto,	
			     @Tipo_cal,
			     @Num_linea,
            		     @variable,
			     @formula,
			     @Tipo_formula,
			     @Param1,
			     @Param2,
			     @Param3,
			     @Param4
                )



            
SET NOCOUNT OFF
END
--src_invex_graba_formulas 2000, 'BRASIL', '20010317', 2, '1', 'SA', '1+1','' 
--src_invex_graba_formulas 2000, 'BRASIL', '20010317', '1', '1', 'VP', '@V005 /  @V008', ''
--src_invex_graba_formulas 2000, 'BRASIL', '20010317', '1', '1', 'VP', '@V005 /  @V008', ''


GO
