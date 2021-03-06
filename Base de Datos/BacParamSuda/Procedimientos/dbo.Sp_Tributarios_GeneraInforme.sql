USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_GeneraInforme]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Tributarios_GeneraInforme]
	(	@dFecha		DATETIME	)
AS
BEGIN
-- Sp_Tributarios_GeneraInforme '20140930' -- 
	SET NOCOUNT ON

	Select	Fecha_Auxiliar			= convert(char(10), Trib.FechaAnalisis, 103)
		,	Fecha_Suscripcion		= convert(char(10), Trib.FechaSuscripcion, 103)
		,	Fecha_Liquidacion		= convert(char(10), Trib.FechaLiquidacion, 103)
		,	Numero_Operacion		= Trib.FolioContrato
		,	Producto				= Case  When Trib.Origen = 'BFW' Then 'Forward'
											When Trib.Origen = 'PCS' Then 'Swap'
											When Trib.Origen = 'OPT' Then 'Opciones' End
		,	SubProducto				= Producto.Descripcion
		,	RutCliente				= --Trib.RutCliente
									  convert(char(14), Replicate(' ', 12 - len(ltrim(rtrim( Trib.RutCliente)) )) 
									+ ltrim(rtrim(Trib.RutCliente)) + '-' + cli.cldv )
									
		,	Cliente					= cli.clnombre
		,	NombreCuentaBalance		=  case when  rtrim(Trib.CtaPatrimonio) = '' and rtrim(Trib.CtaAVR) = ''  then rtrim(CtaRes.descripcion)  
		                               else
									     case when  rtrim(Trib.CtaPatrimonio) = '' then isnull(  rtrim( CtaAVR.descripcion ) , '' )  + isnull( '/'+ CtaRes.descripcion , '' ) 
										 else
		                                      isnull( rtrim(CtaPat.descripcion) , '' )  + isnull( '/**'+ CtaRes.descripcion , '' )                      
                                         end
                                       end  
		,	Codigo_Avr				= Trib.CtaAVR -- case when Trib.CtaAVR = '' then Trib.CtaCaja else Trib.CtaAVR end
		,	CuentaPatrimonio		= Trib.CtaPatrimonio
		,	CuentaResultado			= Trib.CtaResultado

		,	AVR_Neto				= Trib.nMontoAVRNeto
		,	FlujoCaja				= trib.FluCajPer -- 0.0 -- Trib.nMontoCaja

		,	AVR_Proceso				= Trib.nMontoAVRProceso

		,	AVR_Patrimonio			= Trib.nMontoPatrimonio
		,	RESULTADO_AVR			= Trib.nMontoResultado
		,	RESULTADO_LIQUIDACION	= Trib.nMontoLiquidacion
		,	OTROS_RESUULTADOS		= Trib.nMontoCaja
		,	TRASPASO				= 'N/A'
		,	SALDO_AVR_TERMINO		= Trib.nMontoSaldoAvrTermino 
		,   FlujoCajaAnt			= trib.FluCajPerAnt -- 0.0 -- Trib.nMontoCaja 
		
	from	dbo.TBL_TRIBUTARIOS	Trib	with(nolock)
	
			left join ( Select  clnombre, cldv, clrut, clcodigo 
						   from BacParamSuda.dbo.Cliente with(nolock) 
						) cli on cli.clrut = Trib.RutCliente and cli.clcodigo = Trib.CodCliente

			left join ( select cuenta, descripcion 
						  from BacParamSuda.dbo.Plan_de_Cuenta 
					   ) CtaPat On CtaPat.Cuenta = rtrim( ltrim( Trib.CtaPatrimonio ) ) 
			left join ( select cuenta, descripcion 
						  from BacParamSuda.dbo.Plan_de_Cuenta 
					   ) CtaAvr On CtaAvr.Cuenta = rtrim( ltrim( Trib.CtaAVR ) ) 
			left join ( select cuenta, descripcion 
						  from BacParamSuda.dbo.Plan_de_Cuenta 
					   ) CtaRes On CtaRes.Cuenta = rtrim( ltrim( Trib.CtaResultado ) ) 					                        
										   
					     /* case when Trib.CtaAVR = '' then Trib.CtaCaja else Trib.CtaAVR end */

			left join ( select  Id_Sistema, codigo_producto = case		when codigo_producto = 'ST' then 1
																		when codigo_producto = 'SM' then 2
																		when codigo_producto = 'FR' then 3
																		when codigo_producto = 'SP' then 4 end ,	descripcion
						   from  BacParamSuda.dbo.Producto with(nolock)
						  where  Id_Sistema = 'pcs'
								 union
						 select  Id_Sistema, codigo_producto, descripcion
						   from  BacParamSuda.dbo.Producto with(nolock)
						  where  Id_Sistema = 'bfw'
								 union
						 select  'BFW', 15, 'FORWARD ASIATICO' union
						 select	 Id_Sistema, codigo_producto = case	when codigo_producto = 'ST' then 1
																	when codigo_producto = 'SM' then 2
																	when codigo_producto = 'FR' then 3
																	when codigo_producto = 'SP' then 4 end,	descripcion
						   from	 BacParamSuda.dbo.Producto with(nolock)
						  where	 Id_Sistema = 'pcs'
								 union
						  select  'OPT' ,	1 ,	'COMPRA CALL' union 
						  select  'OPT' ,	2 ,	'VENTA  CALL' union 
						  select  'OPT' ,	3 ,	'COMPRA PUT'  union 
						  select  'OPT' ,	4 ,	'VENTA  PUT'  union
						  select  'OPT' ,	15,	'FORWARD AMERICANO' union
						  select  'OPT' ,	17,	'FORWARD ASIATICOS' union
						  select  'OPT' ,	13,	'FORWARD ASIATICOS E/S'
						  ) Producto ON Producto.Id_Sistema		 = Trib.Origen
									and Producto.codigo_producto = Trib.Producto
									  
	where	Trib.FechaAnalisis		= @dFecha  
	--and foliocontrato in ( 580575, 580576 ) -- Por mientras !!
	ORDER BY Trib.Origen, Trib.FolioContrato, Trib.NewRegistro

END

GO
