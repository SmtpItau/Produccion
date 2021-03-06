USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_act_riesgo]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_act_riesgo]
	(	@Numero_operacion	NUMERIC(9)	,
                @producto		CHAR(5)		,
                @rut			NUMERIC(9)	,
                @codigo_cliente		NUMERIC(9)	,
                @fecha_inicio		CHAR(10)	,
                @fecha_vencimiento	CHAR(10)	,
                @monto			NUMERIC(21,4)	,
                @moneda_primaria	NUMERIC(3)	,
                @Moneda_secundaria	NUMERIC(3)	,
                @Modalidad		CHAR(1)		,
                @fecha_proceso		CHAR(10)
	)
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


	INSERT INTO CARTERA_MANUAL
	SELECT	@Numero_operacion	,
                @producto		,
                @rut			,
                @codigo_cliente		,
                @fecha_inicio		,
                @fecha_vencimiento	,
                @monto			,
                @moneda_primaria	,
                @Moneda_secundaria	,
                @Modalidad		,
                @fecha_proceso	

	SET NOCOUNT OFF

END



GO
