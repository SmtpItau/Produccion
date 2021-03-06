USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_ParametrosLCR]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_ParametrosLCR]   
(
   @ParaValidar character(2) = 'NO'
) 
AS  
BEGIN  
    

     /**********************************************  
     SP_RIEFIN_ParametrosLCR  
     Migracion de Curvas utilizadas en BAC  
  
     ***********************************************/  
  Set nocount On  
  
     /***********************************************  
     carga de baclineas..ParametrosDboParametrizacion_Curvas    -- select * from ParametrosDboParametrizacion_Curvas where curva like '%Swap%'
     Solo se cargaran las curvas para las cuales  
     hay datos históricos para todas las fechas  
     a simular. La fecha siempre será la fecha  
     anterior a la de proceso  
     ************************************************/  
     declare @Fecha datetime  
     select @fecha = acfecante from BacTraderSuda..Mdac  
  
     declare @NroSim int  
     select @NroSim = 0  
     Select @NroSim = NumeroSimulaciones + 1  
            from bactradersuda..mdac  
      
     SELECT TOP (@NroSim)  
  acfecproc  
      into #fechas  
     from  
         BactraderSuda.dbo.fechas_proceso  
     where  
  fecha <= @Fecha  
     ORDER BY  
  acfecproc  
     DESC  
  
     declare @fechaMin datetime  
           , @fechaMax datetime  
     select  @fechaMin = min( acfecproc )  
           , @fechaMax = max( acfecproc )  
      from #Fechas  
  
     -- Curvas y fechas para las cual   
     -- fue ingresada.  
     select distinct CodigoCurva, fechaGeneracion   
       into #FechaCurva  
            from BacParamSuda..Curvas   
            where fechaGeneracion >= @fechaMin  
            and   fechaGeneracion <= @fechaMax  
        
     select CodigoCurva, Simulaciones = count(1)  
     into #CurvaValida  
        from #FechaCurva  
     group by CodigoCurva  

     IF @ParaValidar = 'NO' 
     delete  #CurvaValida where  Simulaciones < @NroSim --or codigocurva in ( 'CurvaSwapJPY' )      


     -- Eliminar las curvas que no esten asociadas a cartera Vigente
     IF @ParaValidar = 'NO' 
     begin
			 /**********************************************  
		  
			 Producto 'Forward'  
			 ParametrosDboParametrizacion_Curvas  
			 ***********************************************/  
		  select Moneda = Mda.mnnemo  
			   , Producto = ( case when CurPro.Modulo = 'PCS' then 'Swap'   
				  when CurPro.Modulo = 'BFW' then 'Forward'  
					   else 'Opciones' end )       
			   , Curva = CurPro.CodigoCurva  			   
		  into #CurvasSinCartera  
		  from BacParamSuda..CURVAS_PRODUCTO CurPro  				
		  left join BacParamSuda..MONEDA Mda ON CurPro.Moneda = Mda.mncodmon   
		  where modulo in ( 'BFW' )     
			 and CurPro.Producto not in (10,11)  
			 and tipoTasa = 'N'  
             and CurPro.Moneda not in ( select distinct CaCodmon1 from BacFwdSuda..mfca  )
             and CurPro.Moneda not in ( 998, 999 )

           --select 'debug', 'Curvas sin Cartera'
           --select 'debug', * from #CurvasSinCartera

           -- Solo certificacion
		   -- delete #CurvaValida where CodigoCurva in ( Select Curva from #CurvasSinCartera )     
     end
     /**************************************************  
  
     Valor moneda y Valor Moneda Contable válidos  
  
     **************************************************/  
     select distinct Codigo_BAC = vmCodigo, fechaGeneracion = VmFecha  -- select * from bacParamSuda..Valor_Moneda_Contable  
                                                                       -- select * from bacParamSuda..Valor_moneda  
     into #FechaValorMoneda  
            from BacParamSuda..Valor_moneda   
            where vmFecha >= @fechaMin  
            and   vmFecha <= @fechaMax  
            and   vmValor <> 0  
  
  
     select Codigo_BAC, Simulaciones = count(1)  
     into #ValorMonedaValida  
        from #FechaValorMoneda  
     group by Codigo_BAC  
  
     IF @ParaValidar = 'NO'  
    delete #ValorMonedaValida where Simulaciones < @NroSim        
  
  
     select distinct Codigo_BAC = case when Codigo_Moneda = 994 then 13 else Codigo_Moneda end  
                   , fechaGeneracion = Fecha  -- select * from bacParamSuda..Valor_Moneda_Contable  
                                              -- select * from bacParamSuda..Valor_moneda  
     into #FechaValorMonedaContable  
            from BacParamSuda..Valor_moneda_Contable   
            where Fecha >= @fechaMin  
            and   Fecha <= @fechaMax  
            and   Tipo_Cambio <> 0  
  
     select Codigo_BAC, Simulaciones = count(1)  
     into #ValorMonedaContableValida  
        from #FechaValorMonedaContable  
     group by Codigo_BAC  
  
     IF @ParaValidar = 'NO' 
     delete #ValorMonedaContableValida where Simulaciones < @NroSim        
      
   
     /**********************************************  
  
     Producto 'RF' (Forward Bond Trade y los T-LOCK  
     ParametrosDboParametrizacion_Curvas  
  
     ***********************************************/  
  
  
     delete ParametrosDboParametrizacion_Curvas where Producto = 'RF'  
        
     select distinct  Codigo = identity(Int, 0,1)  
                       , Moneda = Mda.MnNemo  -- select * from BacParamSuda..MONEDA  
                       , Producto = 'RF'  
                       , Curva = CurPro.CodigoCurva  
                       , Local = DefCur.CurvaLocal  
     into #ForwardRF    --- drop table #ForwardRF  
     from BacParamSuda..CURVAS_PRODUCTO CurPro  
           left join BacParamSUda..DEFINICION_CURVAS DefCur On     DefCur.CodigoCurva = CurPro.CodigoCurva  
       left join BacParamSuda..MONEDA Mda ON CurPro.Moneda = Mda.mncodmon   
     where modulo in ( 'BFW' )     
     and CurPro.Producto  in (10,11)       
           and CurPro.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
  
     insert into ParametrosDboParametrizacion_Curvas     
     select Curva, Codigo, Producto, Moneda, Local from #ForwardRF  
  
     /**********************************************  
  
     Producto 'Forward'  
     ParametrosDboParametrizacion_Curvas  
     ***********************************************/  
  select distinct  Codigo = identity(INT,0,1)  
       , Moneda = Mda.mnnemo  
       , Producto = ( case when CurPro.Modulo = 'PCS' then 'Swap'   
          when CurPro.Modulo = 'BFW' then 'Forward'  
               else 'Opciones' end )       
        , Curva = CurPro.CodigoCurva  
                , Local = DefCur.CurvaLocal -- Ojo No existe el concepto en Forward    
  into #Prueba  
  from BacParamSuda..CURVAS_PRODUCTO CurPro  
        left join BacParamSUda..DEFINICION_CURVAS DefCur On     DefCur.CodigoCurva = CurPro.CodigoCurva  
  left join BacParamSuda..MONEDA Mda ON CurPro.Moneda = Mda.mncodmon   
  where modulo in ( 'BFW' )     
     and CurPro.Producto not in (10,11)  
     and tipoTasa = 'N'  
           and CurPro.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
  
     -- select * from baclineas..ParametrosDboParametrizacion_Curvas where producto = 'Forward'  
    delete baclineas..ParametrosDboParametrizacion_Curvas where producto = 'Forward'  
  insert into baclineas..ParametrosDboParametrizacion_Curvas   
  select Curva, Codigo, producto, Moneda, Local  from #Prueba  
  
   
     /**********************************************  
  
     Producto 'Swap' (Swap y Opciones)  
     ParametrosDboParametrizacion_Curvas  
  
     ***********************************************/  
  
  select distinct  Codigo = 0 -- identity(INT,0,1)  
       , Moneda = Mda.mnnemo  
       , Producto = 'Swap'       
  --              , Producto_BAC = CurPro.Producto                 
       , Curva = CurPro.CodigoCurva  
                , Local = DefCur.CurvaLocal  , Mda_BAC = CurPro.Moneda
  into #Lista  
  from BacParamSuda..CURVAS_PRODUCTO CurPro  
        left join BacParamSUda..DEFINICION_CURVAS DefCur On     DefCur.CodigoCurva = CurPro.CodigoCurva  
  left join BacParamSuda..MONEDA Mda ON CurPro.Moneda = Mda.mncodmon   
  where modulo in ( 'PCS' )  
           and CurPro.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
     --and CurPro.Producto not in (10,11)  
     --and tipoTasa = 'N'  
     UNION   
  select distinct Codigo = 0  
                   , Moneda = Mda.mnNemo  
                   , Producto = 'Swap'  
                   , Curva    = CurPro.CurAlter            
                   , Local    = DefCur.CurvaLocal   , Mda_BAC = CurPro.Moneda
             from BacParamSuda..CURVAS_PRODUCTO CurPro  
             left join BacParamSUda..DEFINICION_CURVAS DefCur On     DefCur.CodigoCurva = CurPro.CurAlter  -- Error: CurPro.CodigoCurva  
       left join BacParamSuda..MONEDA Mda ON CurPro.Moneda = Mda.mncodmon   
        where modulo in ( 'PCS' )  and CurAlter <> ''  
              and CurPro.CurAlter  /* Correccion */  in ( select CodigoCurva from #CurvaValida  )  
  
      select            Codigo = identity(INT,0,1)  
                     , Moneda = T.Moneda  
                     , Producto = T.Producto  
                     , Curva    = T.Curva  
                     , Local    = T.Local  
      into #Lista2  
      from #Lista T  
      -- IMPORTENTE: Solo cargara curvas que tengan cartera asociada
      -- se consideran las cotizaciones como señal de la Mesa de dinero
      -- para indicar que utilizar{a las curvas).
      -- Solo certificacion
      --where Mda_Bac in ( select compra_moneda + venta_moneda from BacSwapSuda..Cartera /*where estado <> 'C'*/ ) or @ParaValidar = 'SI' 
      
  

      --select 'debug', 'Lista2', * from #Lista2
  
      delete baclineas..ParametrosDboParametrizacion_Curvas where producto = 'Swap'  

   insert into baclineas..ParametrosDboParametrizacion_Curvas   
   select Curva, Codigo, producto, Moneda, Local  from #Lista2  

      Insert into baclineas..ParametrosDboParametrizacion_Curvas select 'No Aplica ' , -1, 'Swap' , '' , ''   

	  ----/* Opciones debe ser temporal */
	  ----declare @MaxCodigo numeric(10)
	  ----select @MaxCodigo = max( Codigo ) from baclineas..ParametrosDboParametrizacion_Curvas  where Producto = 'Swap'	  

	  ----insert into baclineas..ParametrosDboParametrizacion_Curvas 
	  ----select Curva = CodigoCurva, Codigo = @MaxCodigo , Producto = 'Swap', Moneda = Mda.mnnemo , Local = 'N' 
	  ----   from BacParamSuda.dbo.Curvas_producto CurPro
		 ---- ,   BacParamSuda.dbo.Moneda Mda
	  ----   where Modulo = 'OPT' and CurPro.Moneda = Mda.MnCodMon and Mda.mnnemo = 'CLP'


   ----   insert into baclineas..ParametrosDboParametrizacion_Curvas 
   ----   select Curva = CodigoCurva, Codigo = @MaxCodigo + 1 , Producto = 'Swap', Moneda = Mda.mnnemo , Local = 'N' 
	  ----   from BacParamSuda.dbo.Curvas_producto CurPro
		 ---- ,   BacParamSuda.dbo.Moneda Mda
	  ----   where Modulo = 'OPT' and CurPro.Moneda = Mda.MnCodMon and Mda.mnnemo = 'USD'


  
      -- select * from baclineas..ParametrosDboParametrizacion_Curvas  
  
    /************************************************  
  
     Producto 'Swap'   
     ParametrosDBOParametrizacion_Swap  
  
     ************************************************/  
  
     select distinct  
             Tasa     = CurPro1.Indicador  
           , Moneda   = CurPro1.Moneda  
           , Producto = Case when CurPro1.Producto = 'SM' then 2  
                             when CurPro1.Producto = 'ST' then 1  
                             when CurPro1.Producto = 'SP' then 4  
                             when CurPro1.Producto = 'FR' then 3 end  
           , Curva_Descuento  = CurPro1.CodigoCurva  
           , Curva_Forward    = case when Indicador = 0 then 'No Aplica'   
                                     when CurPro1.CurAlter <> '' then CurPro1.CurAlter   
                                     else CurPro1.CodigoCurva end  
 , CurvaLocal       = DefCur.CurvaLocal  
           , SCodigoProducto  = CurPro1.Producto  
     into #CurvasSwap  
     from          bacparamsuda..CURVAS_PRODUCTO CurPro1  
         left join BacParamSuda..MONEDA Mda ON CurPro1.Moneda = Mda.mncodmon   
         left join BacParamSUda..DEFINICION_CURVAS DefCur On     DefCur.CodigoCurva = CurPro1.CodigoCurva  
         where     CurPro1.modulo = 'PCS' -- and CurPro1.Producto not in ( 10, 11)   
               and (      CurPro1.Producto = 'SM' and DefCur.CurvaLocal = 'S' and Mda.mnmx = 'C'  -- Curvas Lcoales para los CCS MX-ML o MX-MX  
                       or CurPro1.Producto = 'SM' and Mda.mnmx <> 'C'      
                       or CurPro1.Producto <> 'SM'    
                   )  
     order by CurPro1.Indicador, CurPro1.Moneda  
  
     update #CurvasSwap  
        set #CurvasSwap.Curva_Forward = isnull( (select max( Prd.CodigoCurva ) from bacparamsuda..CURVAS_PRODUCTO Prd   
                                                       left join BacParamSUda..DEFINICION_CURVAS DefCur On  DefCur.CodigoCurva = Prd.CodigoCurva  
                                        where     #CurvasSwap.SCodigoProducto = Prd.Producto   
                                                        and #CurvasSwap.Moneda          = Prd.Moneda   
                                                        and DefCur.CurvaLocal = 'N' )  
                                     , Curva_Forward )   
     where #CurvasSwap.Producto = 2 and #CurvasSwap.CurvaLocal = 'S' and #CurvasSwap.Tasa <> 0  
  
     if not exists( select 1 from #CurvasSwap where Producto = 3 )  
        insert into #CurvasSwap  
          select  Tasa = Tasa  
                , Moneda = Moneda  
                , Producto = 3  
                , Curva_Descuento = Curva_Descuento        
                , Curva_Forward   = Curva_Forward  
                , CurvaLocal   
                , SCodigoProducto  
        from #CurvasSwap where Producto = 1  
  
     delete ParametrosDBOParametrizacion_swap  -- select * from baclineas..ParametrosDBOParametrizacion_swap  
     insert into ParametrosDBOParametrizacion_swap  
     select Tasa, Moneda, Producto, Curva_Descuento, Curva_Forward  
     from   #CurvasSwap   
           where Curva_Descuento in ( select CodigoCurva from #CurvaValida  )  
                and ( Curva_Forward in ( select CodigoCurva from #CurvaValida  ) or Curva_Forward = 'No Aplica' )  
     /**********************************************  
  
     Producto 'RF' (Forward Bond Trade y los T-LOCK  
     ParametrosDboParametrizacion_Fwd_RF_FMto  
  
     **********************************************/  
  
     delete ParametrosDboParametrizacion_Fwd_RF_FMto  -- select * from ParametrosDboParametrizacion_Fwd_RF_FMto  
     insert into ParametrosDboParametrizacion_Fwd_RF_FMto  
     select distinct Codigo_Moneda_Bac = Moneda , Curva = CodigoCurva   
     from BacParamSuda..Curvas_Producto CurPro  
     where  CurPro.Modulo = 'BFW'   
        and CurPro.Producto in ( 10, 11 )  
        and CurPro.Spread = 'S'  -- Selecciona curva de financiamiento
        and CurPro.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
  
  
    /************************************************  
  
     Producto 'RF'   
     ParametrosDBOParametrizacion_RF  
  
     ************************************************/  
     delete ParametrosDBOParametrizacion_RF      -- select * from ParametrosDBOParametrizacion_RF  
     insert into ParametrosDBOParametrizacion_RF  
     select Serie = Instrumento  
         , Curva = CodigoCurva  
         , Emisor = null   
     from bacparamsuda..CURVAS_PRODUCTO CurPro  
         where   modulo = 'BFW' and Producto in ( 10, 11)   
              and (    instrumento <> '*' and Producto = 10   
                    or Producto = 11 )   
             and CurPro.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
and CurPro.Spread <> 'S' -- Descarta curva de financiamiento
  
  
    /************************************************  
  
     Producto 'Forward'   
     ParametrosDBOParametrizacion_Fwd  
  
     ************************************************/  
     delete ParametrosDBOParametrizacion_fwd  
     insert into ParametrosDBOParametrizacion_fwd  
     select distinct  
             Moneda_1 = CurPro1.Moneda  
           , Moneda_2 = CurPro2.Moneda  
           , Curva_1  = CurPro1.CodigoCurva  
           , Curva_2  = CurPro2.CodigoCurva  
           --           , Producto1 = CurPro1.Producto  
           --           , Producto2 = CurPro2.Producto  
     from    bacparamsuda..CURVAS_PRODUCTO CurPro1  
           left join bacparamsuda..MONEDA Mda1 on Mda1.mncodmon = CurPro1.Moneda  
           , bacparamsuda..CURVAS_PRODUCTO CurPro2  
           left join bacparamsuda..MONEDA Mda2 on Mda2.mncodmon = CurPro2.Moneda  
         where     CurPro1.modulo = 'BFW' and CurPro1.Producto not in ( 10, 11)   
               and ( CurPro1.TipoTasa = 'N' or CurPro1.Producto  in ( 12)    )   -- PROD XXXXX Definicion Extraña para curvas MX/CLP
               and CurPro2.modulo = 'BFW' and CurPro2.Producto not in ( 10, 11)   
               and ( CurPro2.TipoTasa = 'N'   )
               and CurPro1.Producto = CurPro2.Producto  
   --            and CurPro1.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
   --            and CurPro2.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
             and Mda1.mnmx = 'C'                                             -- Monedas Extranjeras o Currency               
             and Mda2.mncodmon in ( 13, 998, 999 )                           -- USD, UF y CLP  
             and (  Mda1.mncodmon <> 13 and Mda2.mncodmon not in ( 998 /*, 999*/ ) -- No va la combinacion MX-ML  -- -- PROD XXXXX Ahora si los CLP
                    or  
                    Mda1.mncodmon = 13 and Mda2.mncodmon  in ( 998 , 999 )    -- No va la combinacion MX-ML  
                 )  

     UNION  
     select distinct  
             Moneda_1 = CurPro1.Moneda  
           , Moneda_2 = CurPro2.Moneda  
           , Curva_1  = CurPro1.CodigoCurva  
           , Curva_2  = CurPro2.CodigoCurva  
           --          , Producto1 = CurPro1.Producto  
           --          , Producto2 = CurPro2.Producto  
     from    bacparamsuda..CURVAS_PRODUCTO CurPro1  
           left join bacparamsuda..MONEDA Mda1 on Mda1.mncodmon = CurPro1.Moneda  
           , bacparamsuda..CURVAS_PRODUCTO CurPro2  
           left join bacparamsuda..MONEDA Mda2 on Mda2.mncodmon = CurPro2.Moneda  
         where     CurPro1.modulo = 'BFW' and CurPro1.Producto  in ( 3)   
               and CurPro1.TipoTasa = 'N'   
               and CurPro2.modulo = 'BFW' and CurPro2.Producto  in ( 3)   
               and CurPro2.TipoTasa = 'N'  
               and CurPro1.Producto = CurPro2.Producto  
               and CurPro1.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
               and CurPro2.CodigoCurva in ( select CodigoCurva from #CurvaValida  )  
               and Mda1.mncodmon = 998                                               -- UF  
               and Mda2.mncodmon = 999                                               -- CLP    
   
  
   /************************************************  
  
     ParametrosDboParametrizacion_Monedas  
  
     ************************************************/  
  
  
     delete ParametrosDboParametrizacion_Monedas   
     select * , Convencion = 0  
      into #MonedasRiesgo1  
     from ParametrosDboParametrizacion_Monedas   
    
  
     insert into #MonedasRiesgo1  select 999, 0 , 'CLP', 1  
     insert into #MonedasRiesgo1  select 998, 1 , 'UF' , 1  
     insert into #MonedasRiesgo1  select  13, 2 , 'USD', 0  
  
     select     Codigo_BAC = mncodmon  
         , Codigo     = identity(Int, 3,1)   
         , Nemo       = mnnemo  
         , Convencion = case when mnrrda = 'D' then 0 else 1 end   
     into  #MonedasRiesgo2  
      from BacParamSuda..moneda where mnmx = 'C'   
       and MnCodMon <> 13  
       and (     MnCodMon in ( select Codigo_BAC from #ValorMonedaValida )  
              or MnCodMon in ( select Codigo_BAC from #ValorMonedaContableValida )  
           )  
  
     insert into ParametrosDboParametrizacion_Monedas select Codigo_BAC, Codigo, Nemo from #MonedasRiesgo1  -- select * from ParametrosDboParametrizacion_Monedas  
     insert into ParametrosDboParametrizacion_Monedas select Codigo_BAC, Codigo, Nemo from #MonedasRiesgo2   
       
     delete VALORIZACIONDboParam_Curva_fwd  
     insert into VALORIZACIONDboParam_Curva_fwd select Codigo_BAC, Codigo, Convencion, Nemo from #MonedasRiesgo1   
     insert into VALORIZACIONDboParam_Curva_fwd select Codigo_BAC, Codigo, Convencion, Nemo from #MonedasRiesgo2       
  
  
     /***********************************************  
  
       ParametrosDboParametrizacion_Plazo_Fwd  
  
     ************************************************/  
  
     delete ParametrosDboParametrizacion_Plazo_Fwd  
     insert into ParametrosDboParametrizacion_Plazo_Fwd  
    Select Codigo_tasa   = tbcodigo1  
          , Plazo_Forward = isnull( dias, 0 )    
     from bacParamSuda..tabla_general_detalle TG  
     left join BacParamSuda..PERIODO_AMORTIZACION Periodo  On Periodo.Sistema = 'PCS'   
                                                         and Periodo.Tabla = 1044   
                                                         and Periodo.Codigo = TG.tbtasa  
     where tbcateg = 1042  
   
  
  
    /************************************************  
  
     Producto 'Opciones'   
     ParametrosDBOParametrizacion_Opciones_FX  
  
     ************************************************/  
  
     


     delete ParametrosDboParametrizacion_Opciones_FX  
     insert into ParametrosDboParametrizacion_Opciones_FX select  'CLP/USD', 13,  'Curva_CLP_CL',  'Curva_USD_CL', 999, 0  

	 -- Por si cambiara la curva asiganda a SAO
	 update ParametrosDboParametrizacion_Opciones_FX
	    set Curva_1 = codigoCurva from BacParamSuda.dbo.Curvas_Producto where modulo = 'OPT' and moneda = 999

	 update ParametrosDboParametrizacion_Opciones_FX
	    set Curva_2 = codigoCurva from BacParamSuda.dbo.Curvas_Producto where modulo = 'OPT' and moneda = 13 
  
     delete ParametrosdboParametrizacion_Carteras
     insert into ParametrosdboParametrizacion_Carteras 
     select Cartera = substring( TbGlosa, 1, 50 ),  Codigo_Cartera_Fina = TbCodigo1, Codigo = 0 from BacParamSuda..tabla_general_detalle where tbcateg = 204
  
      -- select * from baclineas..ParametrosDboParametrizacion_Curvas where Producto = 'Opciones'
      -- Insert into baclineas..ParametrosDboParametrizacion_Curvas select 'No Aplica ' , -1, 'Swap' , '' , ''  

      delete ParametrosdboParametrizacion_Curvas where Producto = 'Opciones'
	  insert into ParametrosdboParametrizacion_Curvas
	  select Curva_1, 1, 'Opciones', 'CLP' , 'N'  from BacLineas.dbo.ParametrosDboParametrizacion_Opciones_FX
	  insert into ParametrosdboParametrizacion_Curvas
	  select Curva_2, 2, 'Opciones', 'USD' , 'N'  from BacLineas.dbo.ParametrosDboParametrizacion_Opciones_FX

	  -- eliminar este código cuando SAO tenga
	  -- sus propias curvas
	  update ParametrosdboParametrizacion_Curvas -- select * from ParametrosdboParametrizacion_Curvas
	      set Codigo = ( select codigo from ParametrosdboParametrizacion_Curvas where producto = 'Swap' and Curva = 'Curva_CLP_CL' )
		  where curva = 'Curva_CLP_CL' and producto = 'Opciones'

	  update ParametrosdboParametrizacion_Curvas -- select * from ParametrosdboParametrizacion_Curvas
	      set Codigo = ( select codigo from ParametrosdboParametrizacion_Curvas where producto = 'Swap' and Curva = 'Curva_USD_CL' )
		  where curva = 'Curva_USD_CL' and producto = 'Opciones'



END  


GO
