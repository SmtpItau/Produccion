USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_CARTERA_SWAP]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_CARTERA_SWAP]   
(  @FechaParMuerto DATETIME
 , @Rut   Numeric(13) 
 , @Codigo NUmeric(3) 
  
) AS  
BEGIN 
   SET NOCOUNT ON;  
/************* Mantención ********************************
 Procedimiento debe agregar:
	+ Registros de la tabla BacSwapNY.dbo.Cartera_Eval (1)
	+ Registros de la tabla BacSwapSuda.dbo.Cartera_Eval (2)
	+ Registros de la tabla BacSwapNY.dbo.Cartera (3)
Debido a PRDXXXXX
	Proyecto Turing del año 2012 no agregó tabla (2).  
	Banco soportará las lineas de clientes NY por esto se
	agregan tablas (1) y (3).

	SP_RIEFIN_CONSULTA_CARTERA_SWAP '20150623', 200000190 , 1

**********************************************************/
-- Chequeo existencia Base de datos.
   declare @BaseNYActiva varchar(1)
   declare @ComandoRescateCartera Varchar(8000)
   select @BaseNYActiva = 'N'
   if exists( select (1) from master.dbo.sysdatabases where name = 'BacSwapNY' )
   begin
	select @BaseNYActiva = 'S'
   end
   select   numero_operacion  
		,	numero_flujo
		,	tipo_Flujo
		,	tipo_swap
		,	modalidad_pago
		,	compra_codigo_Tasa
		,	venta_codigo_tasa
		,	fecha_inicio_Flujo
		,	fecha_vence_flujo
		,	diasreset
		,	fecha_fijacion_tasa
		,	fechaLiquidacion
		,	compra_valor_tasa
		,	venta_valor_tasa
		,	compra_spread
		,	venta_spread
		,	compra_Saldo
		,	venta_saldo
		,	compra_amortiza
		,	venta_amortiza
		,	intercprinc
		,	Compra_Flujo_Adicional
		,	Venta_flujo_adicional
		,	Activo_FlujoCLP
		,	Pasivo_FlujoCLP
		,	Rut_Cliente
		,	codigo_cliente
		,	Valor_RazonableCLP
		,	compra_moneda
		,	venta_moneda
		,	fecha_termino 
		,   Cartera_inversion
		,   Estado
		,   Compra_Base
		,   Venta_Base
		,   PosibleAplicacionET = 'N' 
		into #Cartera from BacSwapSuda.dbo.cartera where 1 = 2

		
   select @ComandoRescateCartera = ''
   select @ComandoRescateCartera = @ComandoRescateCartera + ' select    numero_operacion,numero_flujo,tipo_Flujo,tipo_swap,modalidad_pago,compra_codigo_Tasa
   ,venta_codigo_tasa,fecha_inicio_Flujo,fecha_vence_flujo,diasreset,fecha_fijacion_tasa,fechaLiquidacion,compra_valor_tasa,venta_valor_tasa,compra_spread
   ,venta_spread,compra_Saldo,venta_saldo,compra_amortiza,venta_amortiza,intercprinc,Compra_Flujo_Adicional,Venta_flujo_adicional,Activo_FlujoCLP,Pasivo_FlujoCLP
   ,Rut_Cliente,codigo_cliente,Valor_RazonableCLP,compra_moneda,venta_moneda,fecha_termino,Cartera_inversion,Estado,Compra_Base,Venta_Base
   , PosibleAplicacionET = case when bEarlyTermination = 1 and Valor_RazonableCLP <= 0 then ''S'' else ''N'' end
    from BacSwapSuda.dbo.Cartera 
	union 
    select      numero_operacion,numero_flujo,tipo_Flujo,tipo_swap,modalidad_pago,compra_codigo_Tasa
   ,venta_codigo_tasa,fecha_inicio_Flujo,fecha_vence_flujo,diasreset,fecha_fijacion_tasa,fechaLiquidacion,compra_valor_tasa,venta_valor_tasa,compra_spread
   ,venta_spread,compra_Saldo,venta_saldo,compra_amortiza,venta_amortiza,intercprinc,Compra_Flujo_Adicional,Venta_flujo_adicional,Activo_FlujoCLP,Pasivo_FlujoCLP
   ,Rut_Cliente,codigo_cliente,Valor_RazonableCLP,compra_moneda,venta_moneda,fecha_termino,Cartera__EVAL_inversion,Estado,Compra_Base,Venta_Base
   , PosibleAplicacionET = case when bEarlyTermination = 1 and Valor_RazonableCLP <= 0 then ''S'' else ''N'' end
	from BacSwapSuda.dbo.Cartera__Eval '
   if @BaseNYActiva = 'S'
		select @ComandoRescateCartera = @ComandoRescateCartera + ' union select    numero_operacion,numero_flujo,tipo_Flujo,tipo_swap,modalidad_pago,compra_codigo_Tasa
        ,venta_codigo_tasa,fecha_inicio_Flujo,fecha_vence_flujo,diasreset,fecha_fijacion_tasa,fechaLiquidacion,compra_valor_tasa,venta_valor_tasa,compra_spread
        ,venta_spread,compra_Saldo,venta_saldo,compra_amortiza,venta_amortiza,intercprinc,Compra_Flujo_Adicional,Venta_flujo_adicional,Activo_FlujoCLP,Pasivo_FlujoCLP
        ,Rut_Cliente,codigo_cliente,Valor_RazonableCLP,compra_moneda,venta_moneda,fecha_termino,Cartera_inversion,Estado,Compra_Base,Venta_Base
		, PosibleAplicacionET = ''N''
		from BacSwapNY.dbo.Cartera 
		union 
		select   numero_operacion,numero_flujo,tipo_Flujo,tipo_swap,modalidad_pago,compra_codigo_Tasa
        ,venta_codigo_tasa,fecha_inicio_Flujo,fecha_vence_flujo,diasreset,fecha_fijacion_tasa,fechaLiquidacion,compra_valor_tasa,venta_valor_tasa,compra_spread
        ,venta_spread,compra_Saldo,venta_saldo,compra_amortiza,venta_amortiza,intercprinc,Compra_Flujo_Adicional,Venta_flujo_adicional,Activo_FlujoCLP,Pasivo_FlujoCLP
        ,Rut_Cliente,codigo_cliente,Valor_RazonableCLP,compra_moneda,venta_moneda,fecha_termino,Cartera__EVAL_inversion,Estado,Compra_Base,Venta_Base
		, PosibleAplicacionET = ''N''
		from BacSwapNY.dbo.Cartera__Eval '
   --select '@ComandoRescateCartera', '*'+@ComandoRescateCartera+'*'
   --return

   -- Crear la tabla y unirla al exec
   insert into #Cartera
   exec (@ComandoRescateCartera)
 
   
   CREATE INDEX #I_Cartera ON #Cartera ( Rut_Cliente, Codigo_Cliente )   
   
   --select 'debug', * from #Cartera
   --return

-- SP_RIEFIN_CONSULTA_CARTERA_SWAP '20140801', 200000190, 1
  
-- select * from BacSwapSuda.dbo.CARTERA where rut_cliente in ( 470300136, 470300828)  
  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
  
-- Status: falta crear los parametrizadores  
-- SP_RIEFIN_CONSULTA_CARTERA_SWAP '20140804' , 97036000, 1   
  
 
  
-- Para Cuadratura 8800
	DECLARE @Fecha DATETIME
	DECLARE @FechaProx DATETIME
	
	-- Importa las fechas relevantes
	SELECT
		@Fecha = acfecproc
	,	@FechaProx = acfecprox 
	FROM
		BacTraderSuda..MdAc   --- select * from BacTraderSuda..MdAc
	-- Importa las fechas relevantes

    DECLARE @FechaMet5y2 DATETIME
    SELECT  @FechaMet5y2 = acfecproc FROM bactradersuda..mdac


    
      
 IF @Rut = 0   
 BEGIN  
  SELECT  
   'Numero Operacion' = CARTERA.numero_operacion  
  , 'Numero Flujo' = CARTERA.numero_flujo  
  , 'Tipo Flujo' = CARTERA.tipo_flujo  
  , 'Tipo Swap' = CARTERA.tipo_swap  
  , 'Modalidad Pago' = CARTERA.modalidad_pago  
  , 'Cartera' = PARAMETRIZA_CARTERA.Codigo  
  , 'Moneda' = PARAMETRIZA_MONEDA.Codigo  
  , 'Codigo Tasa' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_codigo_tasa  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_codigo_tasa  
    END  
  , 'Convencion' = RTRIM(BASE.Dias)  
  , 'Base' = RTRIM(LTRIM(BASE.Base))  
  , 'Plazo Forward' = case when   CASE  
							WHEN CARTERA.tipo_flujo = 1 THEN  
							 CARTERA.compra_codigo_tasa  
							WHEN CARTERA.tipo_flujo = 2 THEN  
							 CARTERA.venta_codigo_tasa  
							END in ( 13, 21 ) then datediff( dd, CARTERA.fecha_inicio_flujo, CARTERA.fecha_vence_flujo )  else 
	                                                                                            PARAMETRIZA_PLAZO_FWD.Plazo_Forward  end
  , 'Dias Reset' = CARTERA.diasreset  
  , 'Fecha Inicio Flujo' = CARTERA.fecha_inicio_flujo  
  , 'Fecha Vencimiento Flujo' = CARTERA.fecha_vence_flujo  
  , 'Fecha Fijacion Tasa' = CARTERA.fecha_fijacion_tasa  
  , 'Fecha Liquidacion' = CARTERA.fechaliquidacion  
  , 'Curva Descuento' = PARAMETRIZA_DESCTO.codigo  
  , 'Curva Forward' = PARAMETRIZA_FORWARD.codigo  
  , 'Tasa' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_valor_tasa / 100  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_valor_tasa / 100  
    END  
  , 'Spread' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_spread / 100  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_spread / 100  
    END  
  , 'Saldo' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_saldo + CARTERA.compra_amortiza  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_saldo + CARTERA.venta_amortiza  
    END  
  , 'Amortizacion' = CASE  
    WHEN CARTERA.intercprinc = 1 THEN  
     CASE  
     WHEN CARTERA.tipo_flujo = 1 THEN  
      CARTERA.compra_amortiza  
     WHEN CARTERA.tipo_flujo = 2 THEN  
      CARTERA.venta_amortiza  
     END  
    ELSE  
     0  
    END  
  , 'Flujo Adicional' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_flujo_adicional  
    WHEN CARTERA.tipo_flujo = 2 THEN  
CARTERA.venta_flujo_adicional  
    END  
  , 'Valor Mercado' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.Activo_FlujoCLP  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     - CARTERA.Pasivo_FlujoCLP  
    END  
  , 'Rut' = CARTERA.RUT_CLIENTE  
  ,   'Codigo' = CARTERA.Codigo_cliente  
        ,   'PosibleAplicacionET' = case when CARTERA.bEarlyTermination = 1 and CARTERA.Valor_RazonableCLP <= 0 then 'S' else 'N' end
        ,   'Moneda_BAC'          = CARTERA.Compra_moneda + CARTERA.Venta_moneda  
        ,   'Plazo'               = datediff( dd, @FechaMet5y2, case when CARTERA.Tipo_Swap <> 2 
                                                               then fecha_termino else FechaLiquidacion end  
                                                )   
        ,   'Duration'            = datediff( dd, @FechaMet5y2, fecha_termino ) / 365.0        
  FROM  
   BacSwapSuda.dbo.CARTERARES CARTERA  
--            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID   
--                      ON MddMod = 'PCS' and MddNumOpe = Cartera.Numero_Operacion  
  , BacSwapSuda.dbo.BASE BASE  
  , ParametrosdboParametrizacion_Swap PARAMETRIZA_SWAP  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_DESCTO -- select * from ParametrosdboParametrizacion_Curvas  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_FORWARD  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA  
  , ParametrosdboParametrizacion_Plazo_Fwd PARAMETRIZA_PLAZO_FWD  
  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  
--  , BacLineas.dbo.linea_general BANCOS                         -- Original Threshold select * from BacLineas.dbo.linea_general  
  
  WHERE  
--   CARTERA.Rut_Cliente = BANCOS.Rut_Cliente  
--  AND CARTERA.Codigo_cliente = BANCOS.Codigo_cliente  
--  AND   
        PARAMETRIZA_DESCTO.producto = 'Swap'
	and PARAMETRIZA_FORWARD.producto = 'Swap'
    and CARTERA.Fecha_Proceso = @Fecha  
  AND CARTERA.fecha_vence_flujo > @Fecha  
  AND PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cartera_inversion  
  AND CARTERA.estado <> 'C'  
  AND PARAMETRIZA_SWAP.Moneda = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_moneda  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_moneda  
    END  
  AND PARAMETRIZA_SWAP.Tasa = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_codigo_tasa  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_codigo_tasa  
    END  
  AND PARAMETRIZA_SWAP.Producto = CARTERA.tipo_swap  
  AND PARAMETRIZA_DESCTO.curva = PARAMETRIZA_SWAP.Curva_descuento  
  AND PARAMETRIZA_FORWARD.curva = PARAMETRIZA_SWAP.Curva_forward  
  AND PARAMETRIZA_MONEDA.Codigo_BAC = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_moneda  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_moneda  
    END  
  AND PARAMETRIZA_PLAZO_FWD.codigo_tasa = PARAMETRIZA_SWAP.tasa  
  AND BASE.Codigo  = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_base  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_base  
    END  
  ORDER BY  
   CARTERA.Numero_Operacion  
  , CARTERA.Tipo_Flujo   
  , CARTERA.Numero_Flujo  
 END -- @Rut = 0  
 ELSE  
 BEGIN  
  -- Para mantener se debe compiar el módulo IF @Rut = 0  
        -- Aplicar los filtros de Rut  
        -- Leer directo de Cartera  
  DECLARE @Existe AS INT  
  SET @Existe = 0  
  
        CREATE TABLE #FAMILIA  
           (  
             Id                 VARCHAR(19) ,  
             ClRut              numeric(13),  
             ClCodigo           numeric(5),  
             Afecta_Lineas_Hijo numeric(1)  
           )  
        CREATE INDEX #I_FAMILIA ON #FAMILIA  ( ClRut, ClCodigo )  
        INSERT INTO #FAMILIA  
            EXECUTE BacLineas..SP_RIEFIN_FAMILIAS @Rut, @Codigo  
        -- and #Familia.Afecta_Lineas_Hijo = 0 -- colocar al cruzar con Cartera  
  
  SELECT @Existe=1  
  FROM    #Familia  WITH(INDEX( #I_FAMILIA)) 
              , #Cartera WITH(INDEX( #I_CARTERA))
  WHERE rut_cliente = Clrut and  
              codigo_Cliente = ClCodigo  
         and #Familia.Afecta_Lineas_Hijo = 0  
    
  IF @Existe =0   
  begin  
   SELECT 'Consulta'= -1,'Rut'= 'Rut no existe en Cartera'  
   Return  
  END  
          
  SELECT  
   'Numero Operacion' = CARTERA.numero_operacion  
  , 'Numero Flujo' = CARTERA.numero_flujo  
  , 'Tipo Flujo' = CARTERA.tipo_flujo  
  , 'Tipo Swap' = CARTERA.tipo_swap  
  , 'Modalidad Pago' = CARTERA.modalidad_pago  
  , 'Cartera' = PARAMETRIZA_CARTERA.Codigo  
  , 'Moneda' = PARAMETRIZA_MONEDA.Codigo  
  , 'Codigo Tasa' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_codigo_tasa  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_codigo_tasa  
    END  
  , 'Convencion' = RTRIM(BASE.Dias)  
  , 'Base' = RTRIM(LTRIM(BASE.Base))  
  , 'Plazo Forward' = case when   CASE  
							WHEN CARTERA.tipo_flujo = 1 THEN  
							 CARTERA.compra_codigo_tasa  
							WHEN CARTERA.tipo_flujo = 2 THEN  
							 CARTERA.venta_codigo_tasa  
							END in ( 13, 21 ) then datediff( dd, CARTERA.fecha_inicio_flujo, CARTERA.fecha_vence_flujo )  else 
	                                                                                            PARAMETRIZA_PLAZO_FWD.Plazo_Forward  end  
  , 'Dias Reset' = CARTERA.diasreset  
  , 'Fecha Inicio Flujo' = CARTERA.fecha_inicio_flujo  
  , 'Fecha Vencimiento Flujo' = CARTERA.fecha_vence_flujo  
  , 'Fecha Fijacion Tasa' = CARTERA.fecha_fijacion_tasa  
  , 'Fecha Liquidacion' = CARTERA.fechaliquidacion  
  , 'Curva Descuento' = PARAMETRIZA_DESCTO.codigo  
  , 'Curva Forward' = PARAMETRIZA_FORWARD.codigo  
  , 'Tasa' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_valor_tasa / 100  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_valor_tasa / 100  
    END  
  , 'Spread' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_spread / 100  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_spread / 100  
    END  
  , 'Saldo' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_saldo + CARTERA.compra_amortiza  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_saldo + CARTERA.venta_amortiza  
    END  
  , 'Amortizacion' = CASE  
    WHEN CARTERA.intercprinc = 1 THEN  
     CASE  
     WHEN CARTERA.tipo_flujo = 1 THEN  
      CARTERA.compra_amortiza  
     WHEN CARTERA.tipo_flujo = 2 THEN  
      CARTERA.venta_amortiza  
     END  
    ELSE  
     0  
    END  
  , 'Flujo Adicional' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_flujo_adicional  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_flujo_adicional  
    END  
  , 'Valor Mercado' = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.Activo_FlujoCLP  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     - CARTERA.Pasivo_FlujoCLP  
    END  
  , 'Rut' = CARTERA.RUT_CLIENTE  
  ,   'Codigo' = CARTERA.Codigo_cliente  
        ,   PosibleAplicacionET 
        ,   'Moneda_BAC'          = CARTERA.Compra_moneda + CARTERA.Venta_moneda  
        ,   'Plazo'               = datediff( dd, @FechaMet5y2, case when CARTERA.Tipo_Swap <> 2 
                                                               then fecha_termino else FechaLiquidacion end  
                                                )   
        ,   'Duration'            = datediff( dd, @FechaMet5y2, fecha_termino ) / 365.0        
  FROM  
   #Cartera CARTERA  WITH(INDEX( #I_CARTERA))
--            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID   
--                      ON MddMod = 'PCS' and MddNumOpe = Cartera.Numero_Operacion  
  , BacSwapSuda.dbo.BASE BASE  
  , ParametrosdboParametrizacion_Swap PARAMETRIZA_SWAP  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_DESCTO -- select * from ParametrosdboParametrizacion_Curvas  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_FORWARD  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA  
  , ParametrosdboParametrizacion_Plazo_Fwd PARAMETRIZA_PLAZO_FWD  
  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  
        ,   #Familia Fam  WITH(INDEX( #I_FAMILIA))
--  , BacLineas.dbo.linea_general BANCOS                         -- Original Threshold select * from BacLineas.dbo.linea_general  
  WHERE  
-- CARTERA.Rut_Cliente = @Rut  
--  AND CARTERA.Codigo_cliente = @Codigo  
--  AND CARTERA.Rut_Cliente = BANCOS.Rut_Cliente  
--  AND CARTERA.Codigo_cliente = BANCOS.Codigo_cliente  
--  AND CARTERA.Fecha_Proceso = @Fecha AND  
--			CARTERA.fecha_vence_flujo > @Fecha
--		AND	
        PARAMETRIZA_DESCTO.producto = 'Swap'
	and PARAMETRIZA_FORWARD.producto = 'Swap'
    and 
            PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cartera_inversion
  AND CARTERA.estado <> 'C'  
  AND PARAMETRIZA_SWAP.Moneda = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_moneda  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_moneda  
    END  
  AND PARAMETRIZA_SWAP.Tasa = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_codigo_tasa  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_codigo_tasa  
    END  
  AND PARAMETRIZA_SWAP.Producto = CARTERA.tipo_swap  
  AND PARAMETRIZA_DESCTO.curva = PARAMETRIZA_SWAP.Curva_descuento  
  AND PARAMETRIZA_FORWARD.curva = PARAMETRIZA_SWAP.Curva_forward  
  AND PARAMETRIZA_MONEDA.Codigo_BAC = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_moneda  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_moneda  
    END  
  AND PARAMETRIZA_PLAZO_FWD.codigo_tasa = PARAMETRIZA_SWAP.tasa  
  AND BASE.Codigo  = CASE  
    WHEN CARTERA.tipo_flujo = 1 THEN  
     CARTERA.compra_base  
    WHEN CARTERA.tipo_flujo = 2 THEN  
     CARTERA.venta_base  
    END  
        AND CARTERA.Rut_cliente = Fam.Clrut   
        AND CARTERA.Codigo_cliente = Fam.ClCodigo   

 	   AND	(
			(
				CARTERA.Modalidad_Pago = 'E' AND CARTERA.fechaliquidacion >= @Fecha
			)
		OR
			(
				CARTERA.Modalidad_Pago = 'C' AND CARTERA.fechaliquidacion >= @FechaProx
			)
		)


  ORDER BY  
   CARTERA.Numero_Operacion  
  , CARTERA.Tipo_Flujo   
  , CARTERA.Numero_Flujo  
 END  
  
  
  
  
SET NOCOUNT OFF  
END  


GO
