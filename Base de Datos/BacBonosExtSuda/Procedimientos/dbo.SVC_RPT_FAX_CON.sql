USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_FAX_CON]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RPT_FAX_CON]
			(	@tipoper 	CHAR(3)	,
				@monumoper	FLOAT,
				@telefono_bech	char(60),
				@fax_bech	char(60),
				@telefono_cli	char(60),
				@fax_cli	char(60))
as
begin

	set nocount on

	create table #fax
		(	Instrumento	char(20)	not null default ' '	,
			Movimiento	char(3)		not null default ' '	,
			Moneda		char(3)		not null default ' '	,
			Cod_Moneda	numeric(3)	not null default 0	,
			Nominal		numeric(19,4)	not null default 0	,
			Precio		numeric(19,7)	not null default 0	,
			Tasa_Emision	numeric(9,4)	not null default 0	,
			tir		numeric(19,7)	not null default 0	,
			Contraparte	char(60)	not null default ' '	,
			Referencia	char(60)	not null default ' '	,
			Principal	numeric(19,4)	not null default 0	,
			Interes		numeric(19,4)	not null default 0	,
			monto		numeric(19,4)	not null default 0	,
			Fecha_valuta	datetime	not null default ' '	,
			operador_bech	char(50)	not null default ' '	,
			operador_contra char(50)	not null default ' '	,
			Fec_neg		datetime	not null default ' '	,
			Dias		numeric(10)	not null default ' '	)

	insert into #fax

		select	id_instrum		,
			motipoper		,
			(select mnnemo from VIEW_moneda where mncodmon = momonemi )	,
			momonemi		,
			monominal		,
			mopvp			,
			motasemi		,
			motir			,
			( Select clnombre from VIEW_CLIENTE where clrut = morutcli and clcodigo = mocodcli )	,
			corr_bco_ref		,
			moprincipal		,
			moint_compra		,
			movalcomu		,
			mofecpago		,
			operador_Banco		,
			operador_contraparte	,
			mofecneg		,
			(case when cod_familia = 2000 then (select datediff(day,mofecemi,mofecpcup) 
							    from text_mvt_dri 
							    where monumoper = @monumoper and @tipoper = motipoper) 
							    else ( select datediff(day,mofecemi,mofecven)
								   from text_mvt_dri 
								   where monumoper = @monumoper and @tipoper = motipoper) end )
			from 	text_mvt_dri
			WHERE 	monumoper = @monumoper
			and 	@tipoper = motipoper

		select 	*		,
			'telefono_bech' = @telefono_bech	,
			'fax_bech' = @fax_bech			,
			'telefono_cli' = @telefono_cli		,
			'fax_cli' = @fax_cli			

		from	#fax
			
end				

GO
