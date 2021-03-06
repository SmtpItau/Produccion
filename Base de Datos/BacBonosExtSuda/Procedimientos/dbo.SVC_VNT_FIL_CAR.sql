USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_VNT_FIL_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_VNT_FIL_CAR]
( 
    @nCodFam NUMERIC(04,00),
    @unidad	 char(4)	
)
AS
BEGIN

	SET NOCOUNT ON
	if exists(
	SELECT	id_instrum		,	--1
		cpfecven		,	--2
		cpnominal - cpnomi_vta	,	--3
		cptircomp		,	--4
		cppvpcomp		,	--5
		(case WHEN cpnominal > 0 then cpvptirc - ( cpvptirc * ( cpnomi_vta / cpnominal ) )END)	,	--6
		cprutcart		,	--7
		cpnumdocu    			--8
	FROM 	TEXT_CTR_INV	,
		text_arc_ctl_dri
	WHERE	cod_familia=@nCodFam
	AND	cpfecpago <= acfecproc
	AND	cpnominal > 0
	and	sucursal = @unidad) begin

		SELECT	id_instrum		,	--1
			cpfecven		,	--2
			cpnominal - cpnomi_vta	,	--3
			cptircomp		,	--4
			cppvpcomp		,	--5
			'nominal'=(case  WHEN cpnominal > 0 then cpvptirc - ( cpvptirc * ( cpnomi_vta / cpnominal ) )END)	,	--6
			cprutcart		,	--7
			cpnumdocu    			--8
		FROM 	TEXT_CTR_INV	,
			text_arc_ctl_dri
		WHERE	cod_familia=@nCodFam
		AND	cpfecpago <= acfecproc
		AND	cpnominal > 0
		and	sucursal = @unidad
	end
	else begin
		select 0, 'No se encontraron datos en cartera'
	end
	

	SET NOCOUNT OFF
END

-- Sp_invex_ventas_FiltrarCartera 2000
GO
