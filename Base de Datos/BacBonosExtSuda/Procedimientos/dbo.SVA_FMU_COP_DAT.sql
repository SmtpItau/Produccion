USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_FMU_COP_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_FMU_COP_DAT] 
 (
                                  @nemo_ant	CHAR	(20)	,
				  @vcto_ant	DATETIME	,
				  @nemo_nue	CHAR	(20)	,
				  @vcto_nue	DATETIME	
)
AS
BEGIN

	SET NOCOUNT ON

	DELETE text_frm
	WHERE	Cod_nemo	= @nemo_nue
	AND	fecha_vcto	= @vcto_nue


	SELECT Cod_familia	,
	       Cod_nemo    	,
	       Fecha_vcto  	,
	       Tipo_cal    	,
	       Num_linea   	,
	       variable    	,
	       formula     	,
	       Tipo_formula	, 
	       Parametro1  	,
	       Parametro2  	,
	       Parametro3  	,
	       Parametro4      

	INTO #tmp1
	FROM	text_frm
	WHERE	@nemo_ant = cod_nemo
	AND	@vcto_ant = fecha_vcto


	UPDATE	#tmp1
	SET	Cod_nemo	= @nemo_nue	,
		fecha_vcto	= @vcto_nue
 
	INSERT INTO text_frm	(
		Cod_familia	,
		Cod_nemo      ,
	     	Fecha_vcto    ,
		Tipo_cal 	,
		Num_linea 	,
		variable      ,
		formula       ,
		Tipo_formula	,
		Parametro1    ,
		Parametro2    ,
		Parametro3    ,
		Parametro4    )  

	SELECT	Cod_familia	,
	       	Cod_nemo	,
	       	Fecha_vcto    ,
	       	Tipo_cal 	,
	       	Num_linea 	,
	       	variable	,
	       	formula	,
		Tipo_formula	,
		Parametro1 	,
		Parametro2	,
		Parametro3	,
		Parametro4      

	FROM #tmp1



	SET NOCOUNT OFF
END	

GO
