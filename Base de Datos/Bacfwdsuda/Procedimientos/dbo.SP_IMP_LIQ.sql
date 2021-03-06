USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMP_LIQ]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMP_LIQ]    
   (   @Contrato       NUMERIC(10)
     , @Fecha_Usuario  DATETIME --character(8)   
   )
AS
BEGIN

	SET NOCOUNT ON
	
	declare @Fecha_proceso datetime
	select  @Fecha_proceso = acfecproc from MFAC

	declare @Fecha_ant_Habil datetime
	if @Fecha_usuario = @Fecha_proceso
		select  @Fecha_ant_Habil = acfecante from MFAC 
	else
		select  @Fecha_ant_Habil = acfecante 
		from MFACH where acfecproc = @Fecha_usuario

	select PrdCod = 10000000000, PrdDsc = replicate( ' ', 25 )
	  into #PRODUCTO from bacparamsuda..producto where 1 = 2 

	insert into #PRODUCTO 
	select PrdCod = convert( numeric(10) , codigo_producto ) , 
	PrdDsc = substring( Descripcion, 1, 25 ) 
	from BacParamSuda..producto
	where   id_sistema = 'BFW'
        
	--
	-- identificacion operaciones relacionadas
	--
	DECLARE @oper1 float
	DECLARE @oper2 float
        if ( select 1 from MFCA where var_moneda2 = @Contrato and canumoper != @Contrato ) = 1
        begin
		select @oper1= var_moneda2, 
		       @oper2= canumoper 
	          from MFCA
	         where var_moneda2 = @Contrato
	           and canumoper != @Contrato
       end
	else
	begin
		if ( select 1 from MFCA where canumoper = @Contrato and var_moneda2 != @Contrato ) = 1
		begin
			select  @oper1=var_moneda2, 
	                        @oper2=canumoper 
	                from MFCA
        	       where canumoper = @Contrato 
	                 and var_moneda2 != @Contrato 
		end 
	End
	set @oper1 = isnull(@oper1, 0)
	set @oper2 = isnull(@oper2, 0)
	--
	-- ANTICIPO DEL DIA DE PROCESO
	Select 	'Contrato' 		= ORIGINAL.CaNumOper
	, 'Anexo_Anticipo' 		= ANTICIPO.Canumoper
	, 'Tipo_Derivado'		= PRODUCTO.PrdDsc				            
	, 'Correlativo'			= ANTICIPO.caAntCorrela
	, 'Tipo_Operacion'		= case when ANTICIPO.CaTipOper = 'C' then 'Compra' else 'Vende' end 
	, 'Fecha_Cierre'		= ANTICIPO.Cafecha
	, 'ClienteRut'			= rtrim( convert( char( 13 ), CLIENTE.ClRut ) ) + '-' + convert( char(1) , ClDv) + ' Codigo=' + convert( char(3), ClCodigo ) 
	, 'ClienteNombre'		= substring(CLIENTE.ClNombre , 1, 40)
	, 'Total_Parcial'  		= case when ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente then 'totalmente' else 'parcialmente' end 
	, 'Nocional_Cont'		= ORIGINAL.CaMtoMon1
	, 'Conversion_Cont'		= ORIGINAL.CaMtoMon2
	, 'Tipo_valor_Cont'		= Case when  ORIGINAL.CaCodPos1 in ( 1, 3 ) then 'Precio Pactado' 
                                               when  ORIGINAL.CaCodPos1 = 2 then 'Paridad Pactada'
					               else  'Tasa Pactada' 
							  End 
	, 'Valor_Pactado_Cont'		= ORIGINAL.CatipCam
	, 'Fecha_Vencimiento_Cont'	= ORIGINAL.CaFecVcto
	, 'Modalidad_Cont'		= ORIGINAL.CaTipModa	 
	, 'Forma_Pago_Mda_Tran_Cont'		= isnull( FORMAPAGM1.glosa , 'N/A' )
 	, 'Forma_Pago_Mda_Cnv_Cont'		= isnull( FORMAPAGM2.glosa , 'N/A' )  

	, 'Nocional_Ant' 		= ANTICIPO.CaMtoMon1 
	, 'Nombre_Cliente' 		= substring( CLIENTE.clnombre , 1, 20 )
	, 'Fecha_Suscripcion_Cont' 	= ORIGINAL.cafecha						    
	, 'Moneda_Trasanda'		= MONEDA1.MnNemo
	, 'Moneda_Conversion'		= MONEDA2.MnNemo
	, 'Modalidad_Ant'		=  ANTICIPO.CaTipModa
	, 'Operador'			= ANTICIPO.caoperador
	, 'Forma_Pago_Mda_Tran_Ant'	= isnull( FORMAPAGANTM1.glosa , 'N/A' )
 	, 'Forma_Pago_Mda_Cnv_Ant'	= isnull( FORMAPAGANTM2.glosa , 'N/A' )  	
	, 'Monto_Mda_Cnv_Ant'		= case when MONEDA1.mnrrda = 'M' then  ANTICIPO.CaAntPreOpEF * ANTICIPO.CaMtoMon1 else ANTICIPO.CaAntPreOpEF *  ANTICIPO.CaMtoMon1 end
	, 'Tipo_Valor_EF_Ant'		= Case when  ANTICIPO.CaCodPos1 in ( 1, 3 ) then 'Precio Ant. E.F.' 
                                               when  ANTICIPO.CaCodPos1 = 2 then 'Paridad Ant. E.F.'
					       else  'Tasa Ant. E.F.' 
                                               end
	, 'Valor_Operacion_EF_Ant'		= ANTICIPO.catipcam -->  ANTICIPO.CaAntPreOpEF
	, 'Mda_Compensacion_Ant'		= MONEDACOMP.MnNemo
	, 'Forma_Pago_Compensacion_Ant'		= isnull( FORMACOMP.Glosa, 'N/A' )
	, 'Monto_en_Mda_Compensacion_Ant'	= ANTICIPO.caAntMtoMdaComp 
	, 'Operaciones MX-CLP'			= CASE WHEN @oper1 = 0 or @oper2 = 0 Then '' ELSE convert(varchar, @oper1) + ' - ' + convert(varchar, @oper2) END
	, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	from  MFCARES As ORIGINAL
	INNER JOIN MFCA ANTICIPO                             On ANTICIPO.NumeroContratoCliente = ORIGINAL.CaNumOper 
	INNER JOIN VIEW_CLIENTE CLIENTE                      On ANTICIPO.CaCodigo   = CLIENTE.ClRut and ANTICIPO.CaCodCli = CLIENTE.ClCodigo
	 LEFT JOIN BacParamSuda..MONEDA MONEDA1              On MONEDA1.MnCodMon    = ANTICIPO.CaCodMon1
	 LEFT JOIN BacParamSuda..MONEDA MONEDA2              On MONEDA2.MnCodMon    = ANTICIPO.CaCodMon2	
	 LEFT JOIN BacParamSuda..MONEDA MONEDACOMP           On MONEDACOMP.MnCodMon = ANTICIPO.Moneda_Compensacion
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGM1    On ORIGINAL.cafpagomn  = FORMAPAGM1.codigo 
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGM2    On ORIGINAL.cafpagomx  = FORMAPAGM2.codigo   
	 LEFT JOIN BacParamSuda..forma_de_pago FORMACOMP     On ANTICIPO.caAntForPagMdaComp = FORMACOMP.codigo 
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGANTM1 On ANTICIPO.cafpagomn = FORMAPAGANTM1.Codigo 
	 LEFT JOIN BacParamSuda..forma_de_pago FORMAPAGANTM2 On ANTICIPO.cafpagomx = FORMAPAGANTM2.Codigo 
         LEFT JOIN #PRODUCTO PRODUCTO                        On PRODUCTO.PrdCod     = ANTICIPO.CaCodpos1
	WHERE 	 ORIGINAL.CaFechaProceso = @Fecha_ant_Habil  	-- Para ver valores de op. "Ayer"
		and  ORIGINAL.CaNumOper = @Contrato
	UNION
	-- Anticipo de días anteriores
	Select 	'Contrato' 		= ORIGINAL.CaNumOper
	, 'Anexo_Anticipo' 		= ANTICIPO.Canumoper
	, 'Tipo_Derivado'		= PRODUCTO.PrdDsc				            
	, 'Correlativo'			= ANTICIPO.caAntCorrela
	, 'Tipo_Operacion'		= case when ANTICIPO.CaTipOper = 'C' then 'Compra' else 'Vende' end 
	, 'Fecha_Cierre'		= ANTICIPO.Cafecha
	, 'ClienteRut'			= rtrim( convert( char( 13 ), CLIENTE.ClRut ) ) + '-' + convert( char(1) , ClDv) + ' Codigo=' + convert( char(3), ClCodigo ) 
	, 'ClienteNombre'		= substring(CLIENTE.ClNombre , 1, 40)
	, 'Total_Parcial'  		= case when ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente then 'Totalmente' else 'Parcialmente' end 
	, 'Nocional_Cont'		= ORIGINAL.CaMtoMon1
	, 'Conversion_Cont'		= ORIGINAL.CaMtoMon2
	, 'Tipo_valor_Cont'		= Case when  ORIGINAL.CaCodPos1 in ( 1, 3 ) then 'Precio Pactado' 
                                               when  ORIGINAL.CaCodPos1 = 2 then 'Paridad Pactada'
					               else  'Tasa Pactada' 
						         End 
	, 'Valor_Pactado_Cont'		= ORIGINAL.CatipCam
	, 'Fecha_Vencimiento_Cont'  	= ORIGINAL.CaFecVcto
	, 'Modalidad_Cont'		= ORIGINAL.CaTipModa
	, 'Forma_Pago_Mda_Tran_Cont'	= isnull( FORMAPAGM1.glosa , 'N/A' ) 
 	, 'Forma_Pago_Mda_Cnv_Cont'	= isnull( FORMAPAGM2.glosa , 'N/A' )  
	, 'Nocional_Ant' 		= ANTICIPO.CaMtoMon1 
	, 'Nombre_Cliente' 		= substring( CLIENTE.clnombre , 1, 20 )
	, 'Fecha_Suscripcion_Cont' 	= ORIGINAL.cafecha						    
	, 'Moneda_Trasanda'		= MONEDA1.MnNemo
	, 'Moneda_Conversion'		= MONEDA2.MnNemo
	, 'Modalidad_Ant'		= ANTICIPO.CaTipModa	
	, 'Operador'			= ANTICIPO.caoperador
	, 'Forma_Pago_Mda_Tran_Ant'	= isnull( FORMAPAGANTM1.glosa , 'N/A' )
 	, 'Forma_Pago_Mda_Cnv_Ant'	= isnull( FORMAPAGANTM2.glosa , 'N/A' )
	, 'Monto_Mda_Cnv_Ant'		= case when MONEDA1.mnrrda = 'M' then  ANTICIPO.CaAntPreOpEF * ANTICIPO.CaMtoMon1  	
								      else ANTICIPO.CaAntPreOpEF *  ANTICIPO.CaMtoMon1 
								 End
	, 'Tipo_Valor_EF_Ant'		= Case when  ANTICIPO.CaCodPos1 in ( 1, 3 ) then 'Precio Ant. E.F.' 
                                               when  ANTICIPO.CaCodPos1 = 2 then 'Paridad Ant. E.F.'
									   else  'Tasa Ant. E.F.' 
								End
	, 'Valor_Operacion_EF_Ant'		= ANTICIPO.CaAntPreOpEF
	, 'Mda_Compensacion_Ant'		= MONEDACOMP.MnNemo
	, 'Forma_Pago_Compensacion_Ant'		= FORMACOMP.Glosa
	, 'Monto_en_Mda_Compensacion_Ant'	= isnull( ANTICIPO.caAntMtoMdaComp , 'N/A' ) 
	, 'Operaciones MX-CLP'	   = CASE WHEN @oper1 = 0 or @oper2 = 0 Then '' ELSE convert(varchar, @oper1) + ' - ' + convert(varchar, @oper2) END
	, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
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
		-- +++ 2018.07.03 cvegasan IN2084105 Impresión y visualizacion de anticipos
		and ANTICIPO.CaFechaProceso >= @Fecha_Usuario  
		and ANTICIPO.CaFechaProceso = ANTICIPO.CaFecVcto
		and ANTICIPO.caantici='A'
		-- --- 2018.07.03 cvegasan IN2084105 Impresión y visualizacion de anticipos
    ORDER BY CORRELATIVO
	
END 
-- +++ 2018.07.03 cvegasan IN2084105 Impresión y visualizacion de anticipos

GO
