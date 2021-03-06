USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VENTASFILTROINTRAMESAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VENTASFILTROINTRAMESAS]
(
	@RutCart		NUMERIC(09)	,
	@Cadena_Familias	CHAR(255)= ''	,
	@Cadena_Monedas		CHAR(255)= ''	,
	@Cadena_Series		CHAR(255)= ''	,
	@Id_Cartera_Normativa	CHAR(10) = ''	,
	@Id_Cartera_Financiera	CHAR(10) = ''	,
	@Id_Libro		CHAR(10) = ''	
)
/*
Creado por Jorge Bravo H., 22-10-2009
Para uso con tablas de Intramesas
*/
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @FECHA_PROCESO		DATETIME

	SELECT @FECHA_PROCESO = CONVERT(CHAR(8),acfecproc,112) FROM text_arc_ctl_dri 
	
	SELECT	A.cprutcart			, --1
		A.cpnumdocu			, --2
		A.cprutcli			, --3
		A.cpcodcli			, --4
		A.id_instrum			, --5
		A.cpbasemi			, --6
		A.cptasemi			, --7
		A.cpnominal - A.cpnomi_vta	, --8
		A.cpvalvenc * ISNULL(1 - (cpnomi_vta / cpnominal),1)	, --9
		A.cppvpcomp			, --10
		A.cptircomp			, --11
		A.cpvptirc * ISNULL(1 - (cpnomi_vta / cpnominal),1)	, --12
		A.cpfecpago			, --13
		A.cpfeccomp			, --14
		A.cpvalcomu * ISNULL(1 - (cpnomi_vta / cpnominal),1)	, --15
		A.cpfecemi			, --16
		A.cpfecven			, --17
		A.cprutemi			, --18
		A.cpmonemi			, --19
		A.basilea			, --20
		A.tipo_tasa			, --21
		A.encaje			, --22
		A.codigo_carterasuper		, --23
		A.sucursal			, --24
		' '				, --tipo_riesgo		, --25
		' '				, --grado_riesgo	, --26
		' '				, --codigo_riesgo	, --27
		A.cod_familia			, --28
		A.cpmonpag			, --29
		' ',				-- 30 era un campo que no existe en esta tabla, confirmacion
		A.forma_pago			, --31
		A.cpcodemi			, --32
		A.base_tasa			, --33
		A.cusip				, --34
		B.Nom_Familia  			, --35
			' '				, --36
		c.MNNEMO			, --37
		ISNULL(d.mostatreg,'')		,	  --38
		A.monto_emision		, -- 39 agregado el 27-10-2009, JBH
		A.cpfecneg			,  -- 40  agregado el 27-10-2009, JBH
		A.DurMacaulay			, --- 41  agregado el 27-10-2009, JBH
		A.DurModificada			, --- 42   agregado el 27-10-2009, JBH
		A.Convexidad			  ---  43   agregado el 27-10-2009, JBH
	FROM	CAR_ticketbonext A
	LEFT OUTER JOIN view_moneda c
	ON		A.cpmonemi		= c.MNCODMON  
	RIGHT OUTER JOIN MOV_ticketbonext d
	ON		D.monumoper		= A.cpnumdocu
	AND		D.mocorrelativo	= A.cpcorrelativo
	AND     D.mofecpro      = D.mofecpago
	INNER JOIN text_fml_inm B
	ON     A.Cod_familia	= B.cod_familia
	WHERE	A.cprutcart = @rutcart
	AND     A.cpnominal  > 0  
       	AND     A.cpnomi_vta < A.cpnominal
	AND	A.codigo_carterasuper		= @Id_Cartera_Normativa 

	AND 	A.tipo_cartera_financiera		= @Id_Cartera_Financiera
	AND	A.Id_Libro			= @Id_Libro
	AND	CONVERT(CHAR(8),A.cpfeccomp,112)<= @FECHA_PROCESO

	SET NOCOUNT OFF

END

GO
