USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_VERIFICA_PARAMETROS_VAR]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_VERIFICA_PARAMETROS_VAR] 
   (
       @Objetivo_A_Verificar VarChar(30)
    )
AS
BEGIN

-- VERIFICA CURVAS ok.
-- SMILE ok.
-- VALOR MONEDA ok
-- VALOR MONEDA CONTABLE ok
-- ICP ok
-- UF ok

-- SP_RIEFIN_VERIFICA_PARAMETROS_VAR 'XXX'

		-- Se asume que se ejecutará después de abrir el dia
		declare @Fecha        datetime
		declare @FechaInicial datetime
		declare @NroSim       int

		Set Nocount On


  	    select  @Fecha = acfecante 
			 ,  @NroSim = NumeroSimulaciones 
		from bacTraderSuda.dbo.MdAc


        exec SP_RIEFIN_ParametrosLCR 'SI' 
        if @@error <> 0  begin
            select  'Fecha'             = @Fecha
                 , 'TipoParametro'     = 'FALLO SP_RIEFIN_ParametrosLCR '
				 , 'Parametro'         = 'FALLO SP_RIEFIN_ParametrosLCR ' -- select * from BacParamsuda..moneda
				 , 'VerificaParametro' = 'FALTA'


       end




		SELECT TOP (@NroSim)
				@FechaInicial = acfecproc
			from
				BactraderSuda.dbo.fechas_proceso   --- select * from BactraderSuda.dbo.fechas_proceso order by acfecproc desc
			where
			   ( @Objetivo_A_Verificar <> 'PAR_DIA' and fecha <= @Fecha )
            or ( @Objetivo_A_Verificar = 'PAR_DIA' and fecha = @Fecha ) 
            order by acfecproc desc


        select * into  #BactraderSudaDboFechas_proceso
        from  BactraderSuda.dbo.fechas_proceso  where acfecproc >= @FechaInicial and acfecproc <= @Fecha

        --select 'debug', * from #BactraderSudaDboFechas_proceso



		select 
				   'Fecha'             = FechasDeCierres.acfecproc
                 , 'TipoParametro'     = 'Curva                '
				 , 'Parametro'         = ParCurRie.Curva
				 , 'VerificaParametro' = case when not exists( select 1 from BacParamSuda.dbo.Curvas CurBac 
														  where CurBac.FechaGeneracion = FechasDeCierres.acfecproc 
															and CurBac.CodigoCurva     = ParCurRie.Curva )
										 then 'FALTA' else 'NO FALTA' end
     into #VerificaParametros
		From 
			#BactraderSudaDboFechas_proceso FechasDeCierres              
		 ,  BacLineas.dbo.ParametrosDboParametrizacion_Curvas ParCurRie
		where ( FechasDeCierres.acfecproc >= @FechaInicial )
		  and ParCurRie.Curva <> 'No Aplica'
		--and ParCurRie.Curva = 'CurvaFwGBP' -- Prueba



     Insert into #VerificaParametros
		select 
				   'Fecha'             = FechasDeCierres.acfecproc
                 , 'TipoParametro'     = 'Valor Moneda Contable'
				 , 'Parametro'         = ParMndRie.Nemo -- select * from moneda
				 , 'VerificaParametro' = case when not exists( select 1 from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE VMCBac 
														  where VMCBac.Fecha = FechasDeCierres.acfecproc 
															and ( case when VMCBac.Codigo_Moneda = 994 then 13 else VMCBac.Codigo_Moneda end ) = ParMndRie.Codigo_BAC )
										 then 'FALTA' else 'NO FALTA' end

		From 
			#BactraderSudaDboFechas_proceso FechasDeCierres              
		 ,  BacLineas.dbo.ParametrosDboParametrizacion_Monedas ParMndRie  -- 
		where FechasDeCierres.acfecproc >= @FechaInicial 
         and  ParMndRie.Codigo_BAC not in ( 999, 998 ) 		
		--and ParMndRie.Codigo_BAC = 102  -- Prueba


     Insert into #VerificaParametros
		select 
				   'Fecha'             = FechasDeCierres.acfecproc
                 , 'TipoParametro'     = 'Valor Moneda'
				 , 'Parametro'         = MndBac.mnnemo -- select * from BacParamsuda..moneda
				 , 'VerificaParametro' = case when not exists( select 1 from BacParamSuda.dbo.VALOR_MONEDA VMBac 
														  where VMBac.VmFecha = FechasDeCierres.acfecproc 
															and VMBac.VmCodigo  = MndBac.MnCodMon )
										 then 'FALTA' else 'NO FALTA' end

		From 
			#BactraderSudaDboFechas_proceso FechasDeCierres              
		 ,  BacParamsuda..moneda MndBac
		where FechasDeCierres.acfecproc >= @FechaInicial 
         and  MndBac.MnCodMon in ( 998, 800  ) 	 	
		--and ParMndRie.Codigo_BAC = 102  -- Prueba


     Insert into #VerificaParametros
		select 
				   'Fecha'             = FechasDeCierres.acfecproc
                 , 'TipoParametro'     = 'Smile'
				 , 'Parametro'         = 'Smile' -- select * from BacParamsuda..moneda
				 , 'VerificaParametro' = case when not exists( select 1 from lnkOpc.CbMdbOpc.dbo.SMILE Smile 
														  where Smile.SmlFecha = FechasDeCierres.acfecproc 
															  )
										 then 'FALTA' else 'NO FALTA' end

		From 
			#BactraderSudaDboFechas_proceso FechasDeCierres              
		where FechasDeCierres.acfecproc >= @FechaInicial 

 
    select Fecha, TipoParametro, Parametro from #VerificaParametros where VerificaParametro = 'FALTA'

    exec SP_RIEFIN_ParametrosLCR 'NO'  -- Para que cargue el modelo solo con 
                                       -- parámetros para los cuales hay datos
END
-- use baclineas
-- select * from ParametrosDboParametrizacion_Monedas
-- select * from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE
-- select * from bacTraderSuda.dbo.MdAc
-- select * from BacParamSuda.dbo.VALOR_MONEDA
-- select * from lnkOpc.CbMdbOpc.dbo.SMILE  SmlFecha
--  SP_RIEFIN_VERIFICA_PARAMETROS_VAR 'PAR_DIA'
--  SP_RIEFIN_VERIFICA_PARAMETROS_VAR 'PAR_SIMULACIONES'

GO
