USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENCABEZADO_MTM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SP_ENCABEZADO_MTM '15-01-2013', 773
--SP_ENCABEZADO_MTM '11-11-2013', 773



CREATE PROCEDURE [dbo].[SP_ENCABEZADO_MTM]
(
		@dFecha		varchar(10) --DATETIME
	,	@NumOper	INT
)
AS
BEGIN

SET NOCOUNT ON
			
						
			--declare @dFecha	Datetime
			--	set @dFecha	= '20110328'

			  --Variables formato fecha		  	    	    
	    DECLARE @dia			VARCHAR(02)   
		DECLARE @mes			VARCHAR(02)
        DECLARE @año			VARCHAR(04)
		DECLARE @fecha_Contrato VARCHAR(10)

		 /*Format fecha contrato*************************************************************/

--declare @dFecha as varchar(10)
--set @dFecha = '17-09-2013'

   SELECT @dia  = SUBSTRING(@dFecha,1,2)
   select @mes  = SUBSTRING(@dFecha,4,2)
   SELECT @año	= SUBSTRING(@dFecha,7,4) 

    SELECT @fecha_Contrato = @año + @mes + @dia
	--print @dia
	--print @mes
	--print @año
	--print @fecha_Contrato

	set @dFecha = @fecha_Contrato
	--print @dFecha
				
		select  TOP 1
				Operacion					= Activo.numero_operacion
			,	FechaProceso				= convert(char(10),Activo.fecha_proceso,23)
			,	SaldoActivo					= Activo.compra_saldo
			,	SaldoPasivo					= Pasivo.Saldo
			,	'TasaActivo'				= Activo.Tasa_Compra_Curva
      		,	'TasaPasivo'				= Pasivo.Tasa_venta_Curva
      		,	'Tipo_Cambio'				=	(select Tipo_Cambio from BACPARAMSUDA..valor_moneda_contable where fecha = @fecha_Contrato and codigo_moneda = 994)
			,	'Tipo_Tasa_Activo'			=	(select tbglosa from bacparamsuda..tabla_general_detalle where tbcodigo1 = compra_codigo_tasa and tbcateg = 1042)
			,	'Tipo_Tasa_Pasivo'			=	Pasivo.Tipo_Tasa_Pasivo
			,	'Tipo_Nocional_Activo'		=	(select mnnemo from bacparamsuda..moneda where mncodmon = compra_moneda) 
			,	Tipo_Nocional_Pasivo
			,	'Cliente'					=  nombre_cliente
			,	'Rut_Cliente'				=  ltrim(rtrim(convert(char(10),cliente.rut_cliente))) + '-' + cliente.Cldv 
		from	BacSwapSuda.dbo.CarteraRes Activo
				inner join (	select  contrato				= numero_operacion
									,	Saldo					= venta_saldo
									,	Tasa_venta_Curva
									,	Tipo_Tasa_Pasivo		= (select tbglosa from bacparamsuda..tabla_general_detalle where tbcodigo1 = venta_codigo_tasa and tbcateg = 1042)
									,	Tipo_Nocional_Pasivo	= (select mnnemo from bacparamsuda..moneda where mncodmon = venta_moneda) 
								from	BacSwapSuda.dbo.CarteraRes 
								where	fecha_proceso	= @fecha_Contrato
								and		tipo_flujo		= 2 --> Pasivo
								and		@fecha_Contrato			between fecha_inicio_flujo and fecha_vence_flujo 
							)	Pasivo	On Pasivo.contrato	= Activo.numero_operacion
			
								left join ( select nombre_cliente = clnombre
											,   contrato1				= numero_operacion
											, rut_cliente
											, Cldv
											, Clcodigo
									from BacSwapSuda.dbo.CarteraRes cr
										,			bacparamsuda..cliente cl
									where cr.rut_cliente = cl.Clrut
									and		@fecha_Contrato			between fecha_inicio_flujo and fecha_vence_flujo 
								) cliente on cliente.contrato1 = Activo.numero_operacion


		where	Activo.fecha_proceso	= @fecha_Contrato
		and		Activo.tipo_flujo		= 1 --> Activo
		and		Activo.numero_operacion = @NumOper --> 773
		and		@fecha_Contrato					between Activo.fecha_inicio_flujo and Activo.fecha_vence_flujo

END


--select distinct(Clnombre) from CarteraRes 
--,	bacparamsuda..cliente cl
--where cr.numero_operacion = 773
--and cr.rut_cliente = cl.Clrut

--select Clnombre, Clrut, cldv, Clcodigo,* from BacParamSuda..cliente where Clrut = 96908970




--select compra_codigo_tasa, compra_moneda, venta_codigo_tasa, venta_moneda,* 
--from carterares where fecha_proceso = '20110328' and numero_operacion = 773
--order by tipo_flujo

--select * from bacparamsuda..tabla_general_detalle where tbcodigo1 = '7' and tbcateg = 1042
--select * from bacparamsuda..tabla_general_detalle where tbcodigo1 = '0' and tbcateg = 1042


--select tg.tbglosa,* from bacparamsuda..tabla_general_detalle tg
--,	carterares cr
--where tg.tbcodigo1 = cr.compra_codigo_tasa and tg.tbcateg = 1042
--and cr.numero_operacion = 773
--and cr.fecha_proceso = '20110328'


--select * from bacparamsuda..tasa

--select * from bacparamsuda..PRODUCTO_MONEDA


--select * from bacparamsuda..tabla_general_detalle where tbglosa like '%Libor%'
--select * from bacparamsuda..tabla_general_detalle where tbglosa like '%USD%'
--tbcateg tbcodigo1 tbtasa
--1042	7     	2	2001-01-01 00:00:00.000	0.000000	LIBOR 180                       

--select mnnemo,* from bacparamsuda..moneda where mncodmon = 13 


GO
