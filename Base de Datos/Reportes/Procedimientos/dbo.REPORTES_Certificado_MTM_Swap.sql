USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[REPORTES_Certificado_MTM_Swap]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--REPORTES_Certificado_MTM_Swap 5458230, 1, '20130830', 'PMOYA'



--SELECT * FROM CARTERA WHERE numero_operacion = 5113

CREATE PROCEDURE [dbo].[REPORTES_Certificado_MTM_Swap]
(
		@nRut AS NUMERIC(11)
	,	@nCod AS INT
	,	@dFecha varchar(10)
	,	@Usuario VARCHAR(40)

	)
AS  BEGIN

SET NOCOUNT ON




--		declare @dFecha		datetime
--			set @dFecha		= '20131230'
----			set @dFecha		= '20140409'

--		declare @nContrato	numeric(9)
--			--set @nContrato	= 5113

--		declare @nRut		numeric(11)
--			--set	@nRut		= 3468996 --> 5458230 --> 2506803
--			set	@nRut		= 5458230 --> 2506803

--		declare @nCod		int
--			set @nCod		= 1

--	select rut_cliente, numero_operacion from BacSwapSuda.dbo.Cartera group by rut_cliente, numero_operacion order by rut_cliente, numero_operacion 
     
	 
	    DECLARE @dia			VARCHAR(02)   
		DECLARE @mes			VARCHAR(20)
        DECLARE @año			VARCHAR(04)
        DECLARE @fecha_Consulta VARCHAR(20)

				DECLARE @Conta NUMERIC(10)
		SET @Conta = (SELECT charindex('-', (SELECT nombre FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)))

		 /*Format fecha*************************************************************/
   SELECT @dia  = SUBSTRING(@dFecha,7,2)
   select @mes  = SUBSTRING(@dFecha,5,2)
   SELECT @año	= SUBSTRING(@dFecha,1,4) 

   SELECT @fecha_Consulta = @dia + '-' + @mes + '-' + @año 
	                            
	select	'N° Contrato'       = act.numero_operacion
             ,  'Fecha Inicio'      = convert(char(10), act.Fecha_inicio, 103)
             ,  'Tipo Contrato'     = case when act.tipo_swap = 1 then 'Swap de Tasas'
                                           when act.tipo_swap = 2 then 'Swap de Monedas'
                                           when act.tipo_swap = 4 then 'Swap Promedio Camara'
										end
             ,  'Modalidad'         = case when act.modalidad_pago = 'C' then 'Compensado' else 'Fisico' end
             ,  'Monedas'           = ltrim(rtrim( mac.mnnemo )) + '-' + ltrim(rtrim( mps.mnnemo ))
             ,  'Tasas'             = ltrim(rtrim( Tac.tbglosa )) + '-' + ltrim(rtrim( Tps.tbglosa ))
             ,  'Monto Nocional'    = act.compra_capital 
             ,  'Fecha Vcto'        = convert(char(10), act.fecha_termino, 103)
             ,  'Valor MTM Activo'  = act.compra_mercado_clp --> compra_valor_presente --> Activo_FlujoClp
             ,  'Valor MTM Pasivo'  = pas.venta_mercado_clp	-->	venta_valor_presente	--> Activo_FlujoClp
             ,  'Valor MTM Neto'    = act.Valor_RazonableCLP
             ,  'Observacion'       = case when act.Valor_RazonableCLP >= 0 then 'A Favor Corpbanca' else 'A Favor Cliente' end
			  , 'Cliente'			= (select Clnombre from BacParamSuda..cliente where clrut = @nRut and clcodigo = @nCod)	
			 , 'Fecha_Consulta'		= @fecha_Consulta
			  , 'FirmaBanco'		= (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario) 

			, 'Usuario_Banco'		= 
										CASE WHEN @Conta = 0 THEN
										( SELECT substring(nombre, 1, 80) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario) 
											
										ELSE
												( SELECT substring(nombre, 1, charindex('-', nombre)-1) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario) 
												--(select substring(@Usuario, 1, 80))
										END



       from	(	select	numero_operacion,numero_flujo,compra_moneda, compra_codigo_tasa, tipo_flujo, Valor_RazonableCLP
					,	Fecha_inicio, fecha_termino, tipo_swap, modalidad_pago, compra_capital, compra_mercado_clp
				from	BacSwapSuda.dbo.CarteraRes with(nolock)
				where	Fecha_Proceso		= @dFecha
				and	(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
			--	and		numero_operacion	= @nContrato
					union
				select	numero_operacion,numero_flujo,compra_moneda, compra_codigo_tasa, tipo_flujo, Valor_RazonableCLP
					,	Fecha_inicio, fecha_termino, tipo_swap, modalidad_pago, compra_capital, compra_mercado_clp
				from	BacSwapSuda.dbo.Cartera with(nolock)
				where(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
			--			numero_operacion	= @nContrato
				and		@dFecha				= (select fechaproc from bacSwapSuda.dbo.SwapGeneral)
			)	act 
                inner join (	select	Contrato			= numero_operacion
									,   Tipo				= tipo_flujo
                                    ,   Flujo				= min(numero_flujo)
                                from	BacSwapSuda.dbo.CarteraRes with(nolock)
                                where	Fecha_Proceso		= @dFecha
                                and (	rut_cliente	= @nRut and codigo_cliente = @nCod	)
							--	and		numero_operacion	= @nContrato
                                group 
                                by		numero_operacion, tipo_flujo
									union
								select	Contrato			= numero_operacion
									,   Tipo				= tipo_flujo
                                    ,   Flujo				= min(numero_flujo)
                                from	BacSwapSuda.dbo.Cartera with(nolock)
                                where(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
                             -- and		numero_operacion	= @nContrato
                                and		@dFecha				= (select fechaproc from bacSwapSuda.dbo.SwapGeneral)
                                group 
                                by		numero_operacion, tipo_flujo
                                
                          )		Grp		On  Grp.Contrato	= act.numero_operacion
										and	Grp.Flujo		= act.numero_flujo
                                        and Grp.Tipo		= 1 --> act.tipo_flujo
                                        
                left Join (		select	numero_operacion,		numero_flujo,	tipo_flujo
                                ,		venta_moneda,			compra_codigo_tasa
                                ,		venta_codigo_tasa,		Activo_FlujoClp
                                ,		venta_valor_presente,	venta_mercado_clp
                                from	BacSwapSuda.dbo.CarteraRes with(nolock)
                                where	Fecha_Proceso		= @dFecha
								and (	rut_cliente	= @nRut and codigo_cliente = @nCod	)
                            --  and		numero_operacion	= @nContrato
									union
								select	numero_operacion,		numero_flujo,	tipo_flujo
                                ,		venta_moneda,			compra_codigo_tasa
                                ,		venta_codigo_tasa,		Activo_FlujoClp
                                ,		venta_valor_presente,	venta_mercado_clp
                                from	BacSwapSuda.dbo.Cartera with(nolock)
                                where(	rut_cliente	= @nRut and codigo_cliente = @nCod	)
                             -- and		numero_operacion	= @nContrato
								and		@dFecha				= (select fechaproc from bacSwapSuda.dbo.SwapGeneral)
                          )		Pas		On  Pas.numero_operacion = Grp.Contrato
                                        and Pas.numero_flujo     = Grp.Flujo
                                        and Pas.tipo_flujo       = 2 -- Grp.Tipo

				left join BacparamSuda.dbo.Moneda mac On mac.mncodmon = act.compra_moneda
				left join BacparamSuda.dbo.Moneda mps On mps.mncodmon = pas.venta_moneda
                    
				left join (		select	tbcodigo1, tbglosa
                                from	BacParamSuda.dbo.Tabla_General_Detalle
                                where	tbcateg = 1042
                          )     Tac		On Tac.tbcodigo1 = act.compra_codigo_tasa
                    
                left join (     select	tbcodigo1, tbglosa
                                from	BacParamSuda.dbo.Tabla_General_Detalle
                                where	tbcateg = 1042
                          )     Tps		On Tps.tbcodigo1 = pas.venta_codigo_tasa

	where	act.tipo_flujo          = 1
END


GO
