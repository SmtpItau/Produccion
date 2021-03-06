USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_BUS_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_FMU_BUS_DAT] 
(
     @Cod_Familia	FLOAT		, 
     @Cod_nemo	CHAR(20)  	,
     @fecha_vcto	CHAR(08)	
)
AS
BEGIN
	DECLARE @fechav	DATETIME

	SELECT @fechav = @fecha_vcto

		SELECT	cod_familia,
			cod_nemo,
			fecha_vcto,
			tipo_cal,
			num_linea,
			variable,
			formula,
			tipo_formula,
			parametro1,
			parametro2,
			parametro3,
			'parametro4' = ISNULL(parametro4,'')
		FROM	text_frm
		WHERE	cod_familia = @Cod_familia
		AND	cod_nemo = @Cod_nemo	
		AND 	fecha_vcto = @fechav
		order by tipo_Cal,Num_linea

		
END

GO
