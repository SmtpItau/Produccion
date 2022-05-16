USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_FMU_VAL]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RPT_FMU_VAL] 
(	
        @Cod_Familia	FLOAT		, 
	@Cod_nemo	CHAR(20)  	,
	@fecha_vcto	CHAR(08)	
)
AS
BEGIN
	DECLARE @fechav	DATETIME

	SELECT @fechav = @fecha_vcto

		SELECT	*
		FROM	text_frm
		WHERE	cod_familia = @Cod_familia
		AND	cod_nemo = @Cod_nemo	
		AND 	fecha_vcto = @fechav
		order by tipo_Cal,Num_linea

		
END

GO
