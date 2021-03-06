USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMP_LIQ_pruebas]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_IMP_LIQ_pruebas]
	(	@Contrato		NUMERIC(10)
	,	@Fecha_Usuario	DATETIME
	)
AS
BEGIN

	SET NOCOUNT ON

	declare @Fecha_proceso		datetime
		set	@Fecha_proceso		= (select acfecproc from BacFwdSuda.dbo.MFAC with(nolock) )

	declare @Fecha_ant_Habil	datetime

	if @Fecha_usuario = @Fecha_proceso
		set @Fecha_ant_Habil	= (	select acfecante from BacFwdSuda.dbo.MFAC with(nolock) )
	else
		set	@Fecha_ant_Habil	= (	select acfecante from BacFwdSuda.dbo.MFACH with(nolock) where acfecproc = @Fecha_usuario	)


	select	PrdCod = 10000000000
		,	PrdDsc = replicate( ' ', 25 )
	  into	#PRODUCTO 
	 from	bacparamsuda.dbo.producto 
	where	1 = 2 

	insert	into #PRODUCTO 
	select	PrdCod = convert( numeric(10) , codigo_producto ) 
		,	PrdDsc = substring( Descripcion, 1, 25 ) 
	from	BacParamSuda.dbo.producto
	where   id_sistema = 'BFW'

	--
	-- identificacion operaciones relacionadas
	--
	DECLARE @oper1 float
	DECLARE @oper2 float
    
	if (	select 1 from BacFwdSuda.dbo.MFCA where var_moneda2 = @Contrato and canumoper != @Contrato ) = 1
    begin
		select	@oper1		 = var_moneda2
			,	@oper2		 = canumoper
		from	BacFwdSuda.dbo.MFCA with(nolock)
	    where	var_moneda2	 = @Contrato
		and		canumoper	!= @Contrato
    end else
	begin
		if ( select 1 from BacFwdSuda.dbo.MFCA where canumoper = @Contrato and var_moneda2 != @Contrato ) = 1
		begin
			select	@oper1		 = var_moneda2
				,	@oper2		 = canumoper 
			from	BacFwdSuda.dbo.MFCA
        	where	canumoper	 = @Contrato 
	        and		var_moneda2 != @Contrato 
		end 
	End

	set @oper1 = isnull(@oper1, 0)
	set @oper2 = isnull(@oper2, 0)
	--
	--		ANTICIPO DEL DIA DE PROCESO
	SELECT	'Contrato' 						= original.canumoper
		,	'Anexo_Anticipo' 				= anticipo.canumoper
		,	'Tipo_Derivado'					= producto.prddsc
		,	'Correlativo'					= anticipo.caantcorrela
		,	'Tipo_Operacion'				= case when anticipo.catipoper = 'C' then 'Compra' else 'Vende' end 
		,	'Fecha_Cierre'					= anticipo.cafecha
		,	'ClienteRut'					= rtrim( convert( char( 13 ), cliente.clrut ) ) 
											+ '-'			+ convert( char(1) , cldv) 
											+ ' codigo='	+ convert( char(3), clcodigo ) 
		,	'ClienteNombre'					= substring(cliente.clnombre , 1, 40)
		,	'Total_Parcial'  				= case when anticipo.canumoper = anticipo.numerocontratocliente then 'Totalmente' else 'Parcialmente' end 
		,	'Nocional_Cont'					= original.camtomon1
		,	'Conversion_Cont'				= original.camtomon2
		,	'Tipo_valor_Cont'				= case	when	original.cacodpos1 = 1	then	'Precio Pactado' 
													when	original.cacodpos1 = 3	then	'Precio Pactado' 
													when	original.cacodpos1 = 2	then	'Paridad Pactada'
													else									'Tasa Pactada' 
												End
		,	'Valor_Pactado_Cont'			= original.catipcam
		,	'Fecha_Vencimiento_Cont'		= original.cafecvcto
		,	'Modalidad_Cont'				= original.catipmoda	
		,	'Forma_Pago_Mda_Tran_Cont'		= isnull( original.formapagm1, 'N/A' )
		,	'Forma_Pago_Mda_Cnv_Cont'		= isnull( original.formapagm2, 'N/A' )
		,	'Nocional_Ant' 					= anticipo.camtomon1 
		,	'Nombre_Cliente' 				= substring( cliente.clnombre, 1, 20)
		,	'Fecha_Suscripcion_Cont' 		= original.cafecha
		,	'Moneda_Trasanda'				= anticipo.moneda1
		,	'Moneda_Conversion'				= anticipo.moneda2
		,	'Modalidad_Ant'					= anticipo.catipmoda
		,	'Operador'						= anticipo.caoperador

		,	'Forma_Pago_Mda_Tran_Ant'		= isnull( anticipo.formapagantm1, 'N/A' )
 		,	'Forma_Pago_Mda_Cnv_Ant'		= isnull( anticipo.formapagantm2, 'N/A' )  
		,	'Monto_Mda_Cnv_Ant'				= case	when	anticipo.mnrrda1  = 'M' then	anticipo.caantpreopef * anticipo.camtomon1
													else									anticipo.caantpreopef * anticipo.camtomon1 
												end
		,	'Tipo_Valor_EF_Ant'				= Case	when	anticipo.cacodpos1 = 1	then	'Precio Ant. E.F.' 
													when	anticipo.cacodpos1 = 3	then	'Precio Ant. E.F.' 
													when	anticipo.cacodpos1 = 2	then	'Paridad Ant. E.F.'
													else									'Tasa Ant. E.F.' 
												end
		,	'Valor_Operacion_EF_Ant'		= anticipo.catipcam
		,	'Mda_Compensacion_Ant'			= anticipo.monedacomp
		,	'Forma_Pago_Compensacion_Ant'	= isnull( anticipo.formacomp, 'N/A' )				
		,	'Monto_en_Mda_Compensacion_Ant'	= anticipo.caantmtomdacomp 
		,	'Operaciones MX-CLP'			= case	when @oper1 = 0 or @oper2 = 0 then	'' 
													else								convert(varchar, @oper1) + ' - ' + convert(varchar, @oper2) 
												end
		,	anticipo.numerocontratocliente
	from	
			(	select	canumoper, camtomon1, camtomon2, cacodpos1, catipcam, cafecvcto, catipmoda, cafecha, cafpagomn, cafpagomx
					,	formapagm1 = mn.glosa
					,	formapagm2 = mx.glosa
				from	BacFwdSuda.dbo.MFCARES with(nolock)
						left join	(	select codigo, glosa from BacParamSuda.dbo.forma_de_pago with(nolock)	)	mn	On mn.codigo = cafpagomn
						left join	(	select codigo, glosa from BacParamSuda.dbo.forma_de_pago with(nolock)	)	mx	On mx.codigo = cafpagomx
				where	cafechaproceso	= @Fecha_ant_Habil
				and		canumoper		= @Contrato
			)	original
			inner join	(	select	canumoper, numerocontratocliente, caantcorrela, catipoper
								,	cafecha, catipmoda, caoperador, caantpreopef, camtomon1, cacodpos1, catipcam, caantmtomdacomp
								,	cacodigo, cacodcli, cacodmon1, cacodmon2, moneda_compensacion, caantforpagmdacomp, cafpagomn, cafpagomx
								,	moneda1			= m1.mnnemo
								,	moneda2			= m2.mnnemo
								,	formapagantm1	= mn.glosa
								,	formapagantm2	= mx.glosa
								,	mnrrda1			= m1.mnrrda
								,	mnrrda2			= m2.mnrrda
								,	monedacomp		= mc.mnnemo
								,	formacomp		= fc.glosa
							from	BacFwdSuda.dbo.MFCA with(nolock)
									left join ( select mncodmon, mnnemo, mnrrda from BacParamSuda.dbo.Moneda with(nolock) )	m1 On m1.mncodmon	= cacodmon1
									left join ( select mncodmon, mnnemo, mnrrda from BacParamSuda.dbo.Moneda with(nolock) )	m2 On m2.mncodmon	= cacodmon2

									left join ( select mncodmon, mnnemo, mnrrda from BacParamSuda.dbo.Moneda with(nolock) )	mc On mc.mncodmon	= moneda_compensacion
									
									left join (	select codigo, glosa from BacParamSuda.dbo.forma_de_pago with(nolock)	)	mn On mn.codigo		= cafpagomn
									left join (	select codigo, glosa from BacParamSuda.dbo.forma_de_pago with(nolock)	)	mx On mx.codigo		= cafpagomx
									left join (	select codigo, glosa from BacParamSuda.dbo.forma_de_pago with(nolock)	)	fc On fc.codigo		= caantforpagmdacomp

							where	NumeroContratoCliente = @Contrato
						)	anticipo		On Anticipo.numerocontratocliente = Original.canumoper

			inner join	(	select	clrut, clcodigo, cldv, clnombre
							from	BacParamSuda.dbo.Cliente with(nolock)
						)	cliente			On cliente.clrut	= anticipo.cacodigo and cliente.clcodigo = anticipo.cacodcli
			left join #PRODUCTO producto	On producto.PrdCod = anticipo.cacodpos1

	/*
	UNION


	-- Anticipo de días anteriores
	Select 	'Contrato' 		= ORIGINAL.CaNumOper
		,	'Anexo_Anticipo' 		= ANTICIPO.Canumoper
		,	'Tipo_Derivado'		= PRODUCTO.PrdDsc				            
		,	'Correlativo'			= ANTICIPO.caAntCorrela
		,	'Tipo_Operacion'		= case when ANTICIPO.CaTipOper = 'C' then 'Compra' else 'Vende' end 
		,	'Fecha_Cierre'		= ANTICIPO.Cafecha
		,	'ClienteRut'			= rtrim( convert( char( 13 ), CLIENTE.ClRut ) ) + '-' + convert( char(1) , ClDv) + ' Codigo=' + convert( char(3), ClCodigo ) 
		,	'ClienteNombre'		= substring(CLIENTE.ClNombre , 1, 40)
		,	'Total_Parcial'  		= case when ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente then 'Totalmente' else 'Parcialmente' end 
		,	'Nocional_Cont'		= ORIGINAL.CaMtoMon1
		,	'Conversion_Cont'		= ORIGINAL.CaMtoMon2
		,	'Tipo_valor_Cont'		= Case when  ORIGINAL.CaCodPos1 in ( 1, 3 ) then 'Precio Pactado' 
                                               when  ORIGINAL.CaCodPos1 = 2 then 'Paridad Pactada'
					               else  'Tasa Pactada' 
						         End 
		,	'Valor_Pactado_Cont'		= ORIGINAL.CatipCam
		,	'Fecha_Vencimiento_Cont'  	= ORIGINAL.CaFecVcto
		,	'Modalidad_Cont'		= ORIGINAL.CaTipModa
		,	'Forma_Pago_Mda_Tran_Cont'	= isnull( FORMAPAGM1.glosa , 'N/A' ) 
 		,	'Forma_Pago_Mda_Cnv_Cont'	= isnull( FORMAPAGM2.glosa , 'N/A' )  
		,	'Nocional_Ant' 		= ANTICIPO.CaMtoMon1 
		,	'Nombre_Cliente' 		= substring( CLIENTE.clnombre , 1, 20 )
		,	'Fecha_Suscripcion_Cont' 	= ORIGINAL.cafecha						    
		,	'Moneda_Trasanda'		= MONEDA1.MnNemo
		,	'Moneda_Conversion'		= MONEDA2.MnNemo
		,	'Modalidad_Ant'		= ANTICIPO.CaTipModa	
		,	'Operador'			= ANTICIPO.caoperador
		,	'Forma_Pago_Mda_Tran_Ant'	= isnull( FORMAPAGANTM1.glosa , 'N/A' )
 		,	'Forma_Pago_Mda_Cnv_Ant'	= isnull( FORMAPAGANTM2.glosa , 'N/A' )
		,	'Monto_Mda_Cnv_Ant'		= case when MONEDA1.mnrrda = 'M' then  ANTICIPO.CaAntPreOpEF * ANTICIPO.CaMtoMon1  	
								      else ANTICIPO.CaAntPreOpEF *  ANTICIPO.CaMtoMon1 
								 End
		,	'Tipo_Valor_EF_Ant'		= Case when  ANTICIPO.CaCodPos1 in ( 1, 3 ) then 'Precio Ant. E.F.' 
                                               when  ANTICIPO.CaCodPos1 = 2 then 'Paridad Ant. E.F.'
									   else  'Tasa Ant. E.F.' 
								End
		,	'Valor_Operacion_EF_Ant'		= ANTICIPO.CaAntPreOpEF
		,	'Mda_Compensacion_Ant'		= MONEDACOMP.MnNemo
		,	'Forma_Pago_Compensacion_Ant'		= FORMACOMP.Glosa
		,	'Monto_en_Mda_Compensacion_Ant'	= isnull( ANTICIPO.caAntMtoMdaComp , 'N/A' ) 
		,	'Operaciones MX-CLP'	   = CASE WHEN @oper1 = 0 or @oper2 = 0 Then '' ELSE convert(varchar, @oper1) + ' - ' + convert(varchar, @oper2) END
	from  MFCARES AS ORIGINAL

	INNER JOIN MFCARES ANTICIPO                          On ANTICIPO.NumeroContratoCliente = ORIGINAL.CaNumOper 
	
	INNER JOIN VIEW_CLIENTE CLIENTE                      On ANTICIPO.CaCodigo   = CLIENTE.ClRut and ANTICIPO.CaCodCli = CLIENTE.ClCodigo
	INNER JOIN #PRODUCTO PRODUCTO                        On PRODUCTO.PrdCod     = ANTICIPO.CaCodpos1
	 LEFT JOIN BacParamSuda..MONEDA MONEDA1              On MONEDA1.MnCodMon    = ANTICIPO.CaCodMon1
	 LEFT JOIN BacParamSuda..MONEDA MONEDA2              On MONEDA2.MnCodMon    = ANTICIPO.CaCodMon2	
	 LEFT JOIN BacParamSuda..MONEDA MONEDACOMP           On MONEDACOMP.MnCodMon = ANTICIPO.Moneda_Compensacion
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGM1    On ORIGINAL.cafpagomn  = FORMAPAGM1.codigo 
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGM2    On ORIGINAL.cafpagomx  = FORMAPAGM2.codigo   
	 LEFT JOIN BacParamSuda..forma_de_pago FORMACOMP     On ANTICIPO.caAntForPagMdaComp = FORMACOMP.codigo 
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGANTM1 On ANTICIPO.cafpagomn = FORMAPAGANTM1.Codigo 
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGANTM2 On ANTICIPO.cafpagomx = FORMAPAGANTM2.Codigo 
	WHERE ORIGINAL.CaFechaProceso = @Fecha_ant_Habil  	-- Para ver valores de op. "Ayer"
		and   ORIGINAL.CaNumOper = @Contrato
    ORDER BY CORRELATIVO
	*/
	
	/*
	select	NumeroContratoCliente, canumoper
	from	BacFwdSuda.dbo.mfcares with(nolock)
	where	cafechaproceso			= 
	and		numerocontratocliente
	*/
	
END 
GO
