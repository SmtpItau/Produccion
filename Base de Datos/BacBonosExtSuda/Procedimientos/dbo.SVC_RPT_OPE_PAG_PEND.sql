USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_OPE_PAG_PEND]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SVC_RPT_OPE_PAG_PEND] 
(
     @FEC1 	   CHAR(8)	,
     @Cartera_INV    INTEGER		
)
AS
BEGIN

Declare @Glosa_Cartera   Char   (20)

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BEX'
     And  rcrut     = @Cartera_INV
 --  ORDER BY rcrut

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'

	SELECT  dri.monumoper,
	dri.motipoper,
	dri.monumdocu,
	isnull(dri.corr_cli_nombre,'Sin Contraparte') as Contraparte,
	dri.mofecneg,
	dri.mofecpago,
	dri.cod_nemo,
	dri.monominal,
	dri. motir,
	dri.moint_compra as Int_corrido,
	dri.mopvp as precio,
	dri.moprincipal,
	--valornegociacion
	formapago =(select Glosa from view_forma_de_pago where Codigo=dri.forma_pago),
	cor.nombre as Corresponsal,
	dri.operador_Banco,
	'Pendientes' as Operaciones,
	SUBSTRING(@FEC1, 7, 2) + '/' + SUBSTRING(@FEC1, 5, 2) + '/' + SUBSTRING(@FEC1, 1, 4) as Fecha,
	dri.movalven,
	dri.movalcomp,
	isnull(dri.mousuario,'Sin Operador') as Operador,
	'Tipo_Inv'   = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_inversion),		
	'Glosa_Cart' = @Glosa_Cartera
		
	FROM text_mvt_dri dri,
	           view_corresponsal cor

	WHERE mofecpago >= @FEC1
	AND dri.mofecpro < dri.mofecpago	--pendiente
	AND cor.rut_cliente = dri.morutcli	
	AND (tipo_inversion =  @Cartera_INV or @Cartera_INV = 0)
	AND MOSTATREG <> 'A' 

	UNION
		SELECT dri.monumoper,
		dri.motipoper,
		dri.monumdocu,
		isnull(dri.corr_cli_nombre,'Sin Contraparte') as Contraparte,
		dri.mofecneg,
		dri.mofecpago,
		dri.cod_nemo,
		dri.monominal,
		dri. motir,
		dri.moint_compra as Int_corrido,
		dri.mopvp as precio,
		dri.moprincipal,
		--valornegociacion
		formapago =(select Glosa from view_forma_de_pago where Codigo=dri.forma_pago),
		cor.nombre as Corresponsal,
		dri.operador_Banco,
		'Canceladas' as Operaciones,
		SUBSTRING(@FEC1, 7, 2) + '/' + SUBSTRING(@FEC1, 5, 2) + '/' + SUBSTRING(@FEC1, 1, 4) as Fecha,
		dri.movalven,
		dri.movalcomp,
		isnull(dri.operador_contraparte,'Sin Operador') as Operador,
		'Tipo_Inv'   = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_inversion),		
		'Glosa_Cart' = @Glosa_Cartera						

--	select *
		FROM text_mvt_dri dri,
		           view_corresponsal cor

		WHERE mofecpago >= @FEC1
		AND dri.mofecpro > dri.mofecpago	--Canceladas
		AND cor.rut_cliente = dri.morutcli	
		and (tipo_inversion =  @Cartera_INV or @Cartera_INV = 0)
		AND MOSTATREG <> 'A' 
		order by dri.motipoper, dri.monumoper,dri.mofecpago

END

GO
