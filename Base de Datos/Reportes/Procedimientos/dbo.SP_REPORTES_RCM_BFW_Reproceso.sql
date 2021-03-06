USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_RCM_BFW_Reproceso]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REPORTES_RCM_BFW_Reproceso]
	(	@Fecha			DATETIME = NULL
	)
AS
DECLARE @FechaDesde	    DATETIME	     
DECLARE @FechaHasta	    DATETIME	 
DECLARE @tipo_reporte   CHAR(3) = 'BFW'
DECLARE @Ayer           DATETIME -- MAP 20170425 

-- SP_REPORTES_RCM_BFW '20160428'
-- select * from cbmdbopc.dbo.OpcionesGeneral
-- select * from bacfwdsuda.dbo.mfac
-- SP_REPORTES_RCM_BFW_Reproceso '20190725' 
-- select moestado, moNroOpeMxClp, * from bacfwdsuda.dbo.mfmoh where mofecha = '20190725'
-- select caestado, * from bacfwdsuda.dbo.mfcaREs where cafechaProceso = '20190725' and cafecha = '20190725'
BEGIN   

	SET NOCOUNT ON	

	IF(@Fecha IS NULL OR @Fecha = '')
	   BEGIN
		  EXEC SP_FECHAPROC_RCM @tipo_reporte,NULL,@Fecha OUTPUT		  
		  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha		  
	   END
	ELSE 
	   BEGIN
	   	  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha
	   END
   
    -- MAP 20190726 Cartera Vigente
    select * into #BacFwdSudadbomfca from BacFwdsuda.dbo.MFCARES where 1 = 2
	insert into #BacFwdSudadbomfca 
	select * from BacFwdSuda.dbo.mfcaRES where cafechaproceso = @Fecha
	 
	   
	-- Calculo fecha @ayer
	Set @Ayer = null
--	Set @Ayer =  ( select fechaant from CBMdbOpc.dbo.OpcionesGeneral  where fechaproc = @Fecha ) -- MAP 20190726
	Set @Ayer = isnull( @Ayer, (select fechaant from CBMdbOpc.dbo.OpcionesResGeneral  where fechaproc = @Fecha ) )

	CREATE TABLE #RESULTADOS_BFW
	(  [Type] varchar(250)
	   ,[Contract Update Reason] varchar(250)
	   ,[Part Account] varchar(250)
	   ,[Part Position] varchar(250)
	   ,[Part Code] varchar(250)
	   ,[Part CPF/CNPJ] varchar(250)
	   ,[Part] varchar(250)
	   ,[Counterpart Indentified] varchar(250)
	   ,[Counterpart Position] varchar(250)
	   ,[Counterpart Code] varchar(250)
	   ,[Counterpart CPF/CNPJ] varchar(250)
	   ,[Counterpart] varchar(250)
	   ,[Derivative Type] varchar(250)
	   ,[Trading Place] varchar(250)
	   ,[Contract Number] varchar(250)
	   ,[Notional Amount (Part position)] varchar(250)
	   ,[Reference Currency] varchar(3)
	   ,[Settlement Reference Currency] varchar(3)
	   ,[Underlying asset] varchar(250)
	   ,[Trade Date] varchar(250)
	   ,[Effective Date] varchar(250)
	   ,[Settlement Date] varchar(250)
	   ,[Buyer Currency] varchar(3)
	   ,[Seller Currency] varchar(3)
	---   ,[Forward rate] varchar(250)  --  MAP 20170417
	   ,[Forward rate] numeric(20,8)    --  MAP 20170417
	   ,[Barrier] varchar(250)
	   ,[Fixing Date] varchar(250)
	   ,[Settlement Rate Type] varchar(250)
	   ,[Rate Source] varchar(250)
	   ,[Country Origin] varchar(250)
	   ,[Registration] varchar(250)
	   ,[Derivative Master Agreement] varchar(250)
	   ,[Addicional information] varchar(250)
	   ,[DCE Contract] varchar(250)
	   ,[US Person] varchar(250)
	   ,[OTC] varchar(250)
	   ,[Dealing Activity] varchar(250)
	   ,[IntraGroup] varchar(250)
	   ,[Unwind] varchar(250)
	   ,[Trade Done In Brazil] varchar(250)
	   ,[USD Notional] varchar(250)
	   ,[QueryOrigen] varchar(250)
	   ,[Effective Date Como Fecha] datetime
	   ,[Contrato] numeric(10)
	   ,[Orden]    numeric(5)
	)

	    select monumcontrato = convert( numeric(12) , MonumContrato )
		     into #Nulas 
		  from 
			    CbMdbOpc.dbo.moHisEncContrato 
				where motipotransaccion = 'ANULA' 
				union
				select monumcontrato from 
			    CbMdbOpc.dbo.moEncContrato 
				where motipotransaccion = 'ANULA' 
                
		if ( 1 = 1 )
		Begin

		  -->	   Forward
		  ---------------------------------------  
		  -- MAP 20171117
		  INSERT INTO #RESULTADOS_BFW
		  SELECT Case when Forward.Evento = 'INSERTAR' Then 'I'
		              when Forward.Evento = 'MODIFICA' Then 'A'
		              when Forward.Evento in ( 'ANT TOTAL', 'TERMINAR' ) Then 'E'
					  when Forward.Evento = 'ANT PARCIAL' Then 'U'
		              else 'I' end
		          AS [Type]
			 , 	 Case 
					  when Forward.Evento = 'ANT PARCIAL' Then 'Amortization'
		              else '' end
		          AS [Contract Update Reason]
			 ,'N/A' AS [Part Account]
			 ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Forward.motipoper),1) AS [Part Position]
			 ,dbo.Fx_Convalida_Tipos(35,1,1,'',1) AS [Part Code] 
			 ,'N/A' AS [Part CPF/CNPJ]
			 ,dbo.Fx_Convalida_Tipos(34,1,1,'',1) AS [Part] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
					   FROM TBL_CONTRATOUSD_PASO cp 
					   WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
					   AND cp.id = (SELECT max(cp2.id) 
								 FROM TBL_CONTRATOUSD_PASO cp2 
								 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 'Yes'
			  ELSE 'No' END AS [Counterpart Indentified]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Forward.motipoper),1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END AS [Counterpart Position]
			 ,'' AS [Counterpart Code]
			 ,'N/A' AS [Counterpart CPF/CNPJ]
			 , CASE WHEN (SELECT top 1 cp.cliente_relacionado 
						 FROM TBL_CONTRATOUSD_PASO cp 
						 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
						 AND cp.id = (SELECT max(cp2.id) 
									  FROM TBL_CONTRATOUSD_PASO cp2 
									  WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 
								(SELECT cp.nombre_cliente FROM TBL_CONTRATOUSD_PASO cp 
								 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
								 AND cp.id = (SELECT max(cp2.id) 
											 FROM TBL_CONTRATOUSD_PASO cp2 
											 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')))
			  ELSE '' END AS [Counterpart] 
			 ,'NDF' AS [Derivative Type]
			 ,'OTC' AS [Trading Place]
			 ,'TR-' + convert(varchar(50),Forward.monumoper) AS [Contract Number]			 
			 --,dbo.Fx_Notional_Amount(@Fecha
				--				,case when Forward.motipoper = 'C' then mon1.mnnemo ELSE mon2.mnnemo END
				--				,ROUND(Forward.momtomon1,2)  
				--				,case when Forward.motipoper = 'V' then mon1.mnnemo ELSE mon2.mnnemo END
				--				,(case when Forward.Relacion <> 0 THEN Forward.precierre  
				--				 ELSE   ISNULL(CASE WHEN Forward.mocodpos1 = 1  THEN Forward.motipcam
				--					   WHEN Forward.mocodpos1 = 2  THEN Forward.mopremon1
				--					   WHEN Forward.mocodpos1 = 3  THEN Forward.motipcam
				--					   WHEN Forward.mocodpos1 = 13 THEN Forward.motipcam
				--					   WHEN Forward.mocodpos1 = 14 THEN Forward.mopremon1
				--					   WHEN Forward.mocodpos1 = 16 THEN Forward.mopremon1 				
				--					   END,0) 
				--				  END)
				--				,Forward.motipoper) AS [Notional Amount (Part position)]
			 ,CASE WHEN forward.Relacion <> 0 THEN CONVERT(NUMERIC(36,2),ROUND((CASE WHEN Rmon2.mnnemo = 'CLP'  THEN segcam.nocional_rel
												 WHEN Rmon2.mnnemo = 'UF'   THEN segcam.nocional_rel   
												 WHEN ltrim(rtrim(Rmon2.mnnemo)) = 'USD'  THEN segcam.nocional_rel 
											ELSE 0 END),2))     
										ELSE CONVERT(NUMERIC(36,2),ROUND((CASE WHEN Forward.mocodpos1 = 14 THEN Forward.noci0  
												 WHEN mon2.mnnemo = 'CLP'  THEN Forward.nocional
												 WHEN mon2.mnnemo = 'UF'   THEN Forward.nocional   
												 WHEN mon2.mnnemo = 'USD'  THEN Forward.nocional
											ELSE 0 END),2)) END AS [Notional Amount (Part position)]				
			 ,case when forward.Relacion <> 0 THEN Rmon2.mnnemo ELSE mon2.mnnemo END AS [Reference Currency]
			 ,dbo.Fx_Convalida_Tipos(33,1,1,Forward.forma_pago,0) AS [Settlement Reference Currency]
			 ,'N/A' AS [Underlying asset]
			 ,CONVERT(varchar,Forward.mofecha,3) AS [Trade Date]
			 ,CONVERT(varchar,Forward.mofecha,3) AS [Effective Date]
			 ,CONVERT(varchar,Forward.mofecvcto,3) AS [Settlement Date]
			 --,case when Forward.motipoper = 'C' then mon1.mnnemo ELSE mon2.mnnemo end AS [Buyer Currency]
			 ,case when forward.Relacion <> 0 THEN (case when Forward.motipoper = 'C' then mon1.mnnemo ELSE Rmon2.mnnemo END)
			 ELSE (case when Forward.motipoper = 'C' then mon1.mnnemo ELSE mon2.mnnemo end) END AS [Buyer Currency]
			 --,case when Forward.motipoper = 'V' then mon1.mnnemo ELSE mon2.mnnemo END AS [Seller Currency]
			 ,case when forward.Relacion <> 0 THEN (case when Forward.motipoper = 'V' then mon1.mnnemo ELSE Rmon2.mnnemo END)
			 ELSE (case when Forward.motipoper = 'V' then mon1.mnnemo ELSE mon2.mnnemo END) END AS [Seller Currency]
			 ,case when Forward.Relacion <> 0 THEN Forward.precierre  
			  ELSE   ISNULL(CASE WHEN Forward.mocodpos1 = 1  THEN Forward.motipcam
				    WHEN Forward.mocodpos1 = 2 THEN Forward.motipcam --  Forward.mopremon1 -- MAP 20170417
				    WHEN Forward.mocodpos1 = 3  THEN Forward.motipcam
				    WHEN Forward.mocodpos1 = 13 THEN Forward.motipcam
				    WHEN Forward.mocodpos1 = 14 THEN Forward.mopremon1
				    WHEN Forward.mocodpos1 = 16 THEN Forward.mopremon1 				
				    END,0) 
			   END AS [Forward rate]
			 ,'N.A.' AS [Barrier]
			 ,'D-1' AS [Fixing Date]
                ,'Final' AS [Settlement Rate Type]
			 , dbo.Fx_Rate_Source(Forward.monumoper) AS [Rate Source]
			 ,'CHILE' AS [Country Origin]
			 ,'' AS [Registration]
			 			 							

			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]
			 ,'' AS [Addicional information]
			 
			 ,ISNULL(dbo.Fx_DCE_contract('TR-' + convert(varchar(50),Forward.monumoper),'BFW'),'') AS [DCE Contract]
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
			  then 'No' else 'Yes' end AS [US Person]
			 ,'Yes' AS [OTC]
			 ,'No' AS [Dealing Activity]
			 ,'No' AS [IntraGroup]
			 , Case when Forward.evento in ( 'ANT TOTAL' ) then 'Yes' Else 'No' End  AS [Unwind]
			 ,'No' AS [Trade Done In Brazil]
			 --,CONVERT(NUMERIC(36,2),ROUND(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,mon1.mncodmon,Forward.momtomon1,13),2)) AS [USD Notional]
			 ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN mon1.mnnemo = 'USD' THEN Forward.momtomon1
									   WHEN mon2.mnnemo = 'USD' THEN Forward.nocional
			 ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,mon1.mncodmon,Forward.momtomon1,13) END,2)) AS [USD Notional]
			 , [QueryOrigen] = 'SECION 01'
			 , [Effective Date Como Fecha] = Forward.mofecha
			 , [Contrato] = Forward.monumoper
			 , [Orden]    = 0
			 
			 FROM	(	select	mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, nocional = momtomon2, moequusd1, noci0 = moequmon1, motipcamSpot
								,	motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, mocodmon1, mocodmon2
								,	mocodigo, mocodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, mofecvcto, motipmoda
								, Relacion = moNroOpeMxClp, precierre = moprecal,forma_pago = mofpagomn , Evento = 'INSERTAR'
							 from	BacFwdSuda.dbo.Mfmo		with(nolock)
								    left  join 
								    (	select	fecha, codigo_moneda, tipo_cambio
									   from	BacParamSuda.dbo.valor_moneda_contable with(nolock)
									   where	fecha	= (select acfecante from BacFwdSuda.dbo.Mfac with(nolock) )
								    )	vcont	On	vcont.codigo_moneda = 994

        	 				  where    moestado		 	NOT IN ('A' /*,'P' No deberia haber pendientes */ )
						  and	    not			(moNroOpeMxClp <> 0 and mocodpos1 = 1)
						  and 1 = 2 -- MAP 20190726 Descartar la fecha que indica mi PC
						  union
						  select	mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, nocional = momtomon2, moequusd1, noci0 = moequmon1, motipcamSpot
								,	motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, mocodmon1, mocodmon2
								,	mocodigo, mocodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, mofecvcto, motipmoda
								, Relacion = moNroOpeMxClp, precierre = moprecal,forma_pago = mofpagomn,  Evento = 'INSERTAR'
							 from	BacFwdSuda.dbo.mfmoh with(nolock)
								    left  join 
								    (	select	fecha, codigo_moneda, tipo_cambio
									   from	BacParamSuda.dbo.valor_moneda_contable with(nolock) 
									   where	codigo_moneda			= 994
								    )	vcont	On	vcont.fecha			= mofecha --> ctro.acfecante
												and vcont.codigo_moneda = 994

						  where   mofecha		between @FechaDesde and @Fechahasta
						  and	    moestado		NOT IN ('A' /*,'P' no debe haber pendientes */)
						  and	    not			(moNroOpeMxClp <> 0 and mocodpos1 = 1)
						  union  
						  select cafecha, cacodpos1, canumoper, catipoper, caoperador, camtomon1, nocional = camtomon2, caequusd1, noci0 = caequmon1, catipcamSpot
								, catipcam, capremon1, capremon2,caparmon1, caparmon2, capreciopunta, cacodmon1, cacodmon2
								, cacodigo, cacodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, cafecvcto, catipmoda
								, Relacion     = var_moneda2, precierre = caprecal,forma_pago = cafpagomn
								, Evento = case when CatipModaOrig = 'E' and catipmoda = 'C' then  'INSERTAR'
								                when CaTipModaOrig = 'C' and catipmoda = 'E' then 'TERMINAR'
										   else 'MODIFICA' end 
						  from #BacFwdSudadbomfca WITH(NOLOCK)  -- MAP 20190726
									   inner join
										  (      select folio = canumoper
										              , CatipModaOrig = catipmoda
												from   bacfwdsuda.dbo.mfca_log
												where  cafecmod     = @Fecha
												    and caestado = 'M'  -- MAP 20170418
										  )      mod On mod.folio    = canumoper
									   left  join 
									   (      select fecha, codigo_moneda, tipo_cambio
										  from   BacParamSuda.dbo.valor_moneda_contable with(nolock) 
										  where  codigo_moneda              = 994
									   )      vcont  On     vcont.fecha = cafecha --> ctro.acfecante
														  and vcont.codigo_moneda = 994
													   
						  where	 caestado	   <> 'A'
						  -- and	 cafecmod    between @FechaDesde and @Fechahasta  -- cafecMod tiene valor 1900-01-01 en MfCa
						  and     not		   (var_moneda2 <> 0 and cacodpos1 = 1)				   
						  and    isnull( [mod].folio , 0 ) <> 0  -- Hubo modificacion en @fecha -- MAP 20170418	
						  and    CaAntici = '' 	
						  and  not  exists ( select (1) from #BacFwdSudadbomfca Car       -- Descarta que modificación sea anticipo
						                     where car.numerocontratocliente = #BacFwdSudadbomfca.canumoper  -- MAP 20190727 
											       and car.caAntici = 'A' )	
												   
						  Union	
						  -- Anticipos Totales 
						  -- Colocar el saldo original de la
						  -- Operacion
						  select Mod.cafecha, cacodpos1, canumoper, catipoper, caoperador, Mod.camtomon1, nocional = Mod.camtomon2, Mod.caequusd1, noci0 = Mod.caequmon1, catipcamSpot
								, Mod.catipcam, Mod.capremon1, Mod.capremon2, Mod.caparmon1, Mod.caparmon2, Mod.capreciopunta, cacodmon1, cacodmon2
								, cacodigo, cacodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, Mod.cafecvcto, catipmoda
								, Relacion     = var_moneda2, precierre = Mod.caprecal,forma_pago = Mod.cafpagomn, Evento = 'ANT TOTAL'
						  from #BacFwdSudadbomfca WITH(NOLOCK)
									   inner join
										  (      select folio = canumoper  -- select 465508600.00 / 931.01720000
										             , Cafecha
													 , cafecvcto
													 , cafpagomn
													 , camtomon1
													 , camtomon2
													 , caequusd1
													 , caequmon1
													 , catipcam
													 , capremon1
													 , capremon2
													 , caparmon1
													 , caparmon2
													 , capreciopunta
													 , caprecal
												from   bacfwdsuda.dbo.mfca_log
												where  cafecmod     = @Fecha 
												    and caestado = 'M'  -- MAP 20170418
										  )      mod On mod.folio    = canumoper
									   left  join 
									   (      select fecha, codigo_moneda, tipo_cambio
										  from   BacParamSuda.dbo.valor_moneda_contable with(nolock) 
										  where  codigo_moneda              = 994
									   )      vcont  On     vcont.fecha = Mod.cafecha --> ctro.acfecante
														  and vcont.codigo_moneda = 994
													   
						  where	 caestado	   <> 'A'
						  and     not (var_moneda2 <> 0 and cacodpos1 = 1)	
						  and    isnull( [mod].folio , 0 ) <> 0  -- Hubo modificacion en @fecha -- MAP 20170418	
						  and    CaAntici = 'A'                        -- Anticipo Total
						  And    numerocontratocliente = canumoper     -- Anticipo Total		
						  union
						  -- Anticipos Parciales 
						  -- Colocar el saldo remanente de la
						  -- Operacion
						  select cafecha, cacodpos1, canumoper, catipoper, caoperador, camtomon1, nocional = camtomon2, caequusd1, noci0 = caequmon1, catipcamSpot
								, catipcam, capremon1, capremon2,caparmon1, caparmon2, capreciopunta, cacodmon1, cacodmon2
								, cacodigo, cacodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, cafecvcto, catipmoda
								, Relacion     = var_moneda2, precierre = caprecal,forma_pago = Mod.cafpagomn, Evento = 'ANT PARCIAL'
						  from #BacFwdSudadbomfca WITH(NOLOCK)  -- MAP 20190726
									   inner join
										  (      select folio = canumoper
										              , cafpagomn
												from   bacfwdsuda.dbo.mfca_log
												where  cafecmod     = @Fecha 
												    and caestado = 'M'  -- MAP 20170418
										  )      mod On mod.folio    = canumoper
									   left  join 
									   (      select fecha, codigo_moneda, tipo_cambio
										  from   BacParamSuda.dbo.valor_moneda_contable with(nolock) 
										  where  codigo_moneda              = 994
									   )      vcont  On     vcont.fecha = cafecha --> ctro.acfecante
														  and vcont.codigo_moneda = 994
													   
						  where	 caestado	   <> 'A'
						  and     not (var_moneda2 <> 0 and cacodpos1 = 1)	
						  and    isnull( [mod].folio , 0 ) <> 0  -- Hubo modificacion en @fecha -- MAP 20170418	
                          and    CaAntici = ''			
						  and    exists ( select (1) from #BacFwdSudadbomfca Car       -- Descarta que modificación sea anticipo
						                     where car.numerocontratocliente = #BacFwdSudadbomfca.canumoper )								  						  			  		   
					   )	Forward

					   left join
					   (select mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, nocional_rel = momtomon2, moequusd1, moequmon1, motipcamSpot
							 , motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, monedaSC1 =  mocodmon1, monedaSC2 = mocodmon2
							 , mocodigo, mocodcli, Resultado_Mesa, mofecvcto, motipmoda, Relacion = moNroOpeMxClp
					   from   BacFwdSuda.dbo.Mfmo with(nolock)             
					   where  mofecha      between @FechaDesde and @Fechahasta
					   and moestado        NOT IN ('A' /*,'P'No debe haber pendientes */ )
					   and moNroOpeMxClp   <> 0
					   and mocodpos1       =  1
					   and 1 = 2 -- MAP 20190726
					   UNION
					   select mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, nocional_rel = momtomon2, moequusd1, moequmon1, motipcamSpot
							 , motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, monedaSC1 =  mocodmon1, monedaSC2 = mocodmon2
							 , mocodigo, mocodcli, Resultado_Mesa, mofecvcto, motipmoda, Relacion = moNroOpeMxClp
					   from   BacFwdSuda.dbo.Mfmoh with(nolock)             
					   where  mofecha      between @FechaDesde and @Fechahasta
					   and moestado        NOT IN ('A' /*,'P' No debe haber operaciones pendientes */)
					   and moNroOpeMxClp   <> 0
					   and mocodpos1       =  1
					   UNION
					   select cafecha,  cacodpos1, canumoper, catipoper, caoperador, camtomon1, nocional_rel = camtomon2, caequusd1, caequmon1, catipcamSpot
							 , catipcam, capremon1, capremon2, caparmon1, caparmon2, capreciopunta, monedaSC1 =  cacodmon1, monedaSC2 = cacodmon2
							 , cacodigo, cacodcli, Resultado_Mesa, cafecvcto, catipmoda, Relacion = var_moneda2
					   from   #BacFwdSudadbomfca with(nolock)             
					   where  cafecha      between @FechaDesde and @Fechahasta
					   and caestado        NOT IN ('A','P')
					   and var_moneda2   <> 0
					   and cacodpos1       =  1
					   ) segcam On segcam.Relacion  = Forward.Relacion

					   left  join
					   (	select	canumoper, var_moneda2
						  from	#BacFwdSudadbomfca	with(nolock)
					   )	Cartera On	Cartera.canumoper  = Forward.monumoper      

					   inner join 
					   (	select	clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						  from	BacParamSuda.dbo.cliente with(nolock)
					   )	Clie	On	Clie.clrut		= Forward.mocodigo
								 and Clie.clcodigo	= Forward.mocodcli

					   inner join	
					   (	select	codigo_producto, descripcion 
						  from	BacParamSuda.dbo.Producto with(nolock)
						  where	Id_Sistema = 'BFW'
					   )	Prod	On Prod.codigo_producto = Forward.mocodpos1

					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	mon1	on mon1.mncodmon = Forward.mocodmon1        
					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	mon2	on mon2.mncodmon = Forward.mocodmon2

					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	Rmon1	on Rmon1.mncodmon = segcam.monedaSC1        
					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	Rmon2	on Rmon2.mncodmon = segcam.monedaSC2
				    /********************************************************	   
				    LEFT JOIN 
				    (   SELECT DISTINCT canumoper, Estado = 'M', cafecvcto
					   FROM	bacfwdsuda.dbo.mfca_LOG WITH(NOLOCK)
					   WHERE	caestado = 'M'
					   AND cafecvcto   BETWEEN @Fecha and @Fecha
					   and catipmoda = 'C'	 
						  UNION
					   SELECT DISTINCT canumoper, Estado = 'A', cafecvcto
					   FROM	BacFwdSuda.dbo.Mfcah WITH(NOLOCK)
					   WHERE	caantici    = 'A'
					   AND cafecvcto   BETWEEN @Fecha and @Fecha
					   and catipmoda = 'C'
				    ) MODIF ON MODIF.canumoper = Forward.monumoper
                                      ********************************************************/
			WHERE 		  (     Forward.motipmoda = 'C'  
			       or  Forward.Evento = 'TERMINAR'  -- Aparecerán los contratos Entrega Fisica que antes
				                                    -- eran compensados
			      )

			
        End
                  /************************************************************
		   -->	   Anticipos Forward 
		   ---------------------------------------
		  INSERT INTO #RESULTADOS_BFW
		  SELECT CASE WHEN unwind.canumoper = unwind.NumeroContratoCliente THEN 'U' ELSE 'U' END AS [Type]
			 ,'Unwind' AS [Contract Update Reason]
			 ,'N/A' AS [Part Account]
			 ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(unwind.catipoper),1) AS [Part Position]
			 ,dbo.Fx_Convalida_Tipos(35,1,1,'',1) AS [Part Code] 
			 ,'N/A' AS [Part CPF/CNPJ]
			 ,dbo.Fx_Convalida_Tipos(34,1,1,'',1) AS [Part] 
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
					   FROM TBL_CONTRATOUSD_PASO cp 
					   WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
					   AND cp.id = (SELECT max(cp2.id) 
								 FROM TBL_CONTRATOUSD_PASO cp2 
								 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 'Yes'
			  ELSE 'No' END AS [Counterpart Indentified]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,UPPER(unwind.catipoper),1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END AS [Counterpart Position]
			 ,'' AS [Counterpart Code]
			 ,'N/A' AS [Counterpart CPF/CNPJ]
			 ,CASE WHEN (SELECT cp.cliente_relacionado 
						 FROM TBL_CONTRATOUSD_PASO cp 
						 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
						 AND cp.id = (SELECT max(cp2.id) 
									  FROM TBL_CONTRATOUSD_PASO cp2 
									  WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 
								(SELECT cp.nombre_cliente FROM TBL_CONTRATOUSD_PASO cp 
								 WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
								 AND cp.id = (SELECT max(cp2.id) 
											 FROM TBL_CONTRATOUSD_PASO cp2 
											 WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')))
			  ELSE '' END AS [Counterpart]
			 ,'NDF' AS [Derivative Type]
			 ,'OTC' AS [Trading Place]
			 ,'TR-' + convert(VARCHAR(50),unwind.canumoper) AS [Contract Number]
			 --,dbo.Fx_Notional_Amount(@Fecha
				--    ,case when unwind.catipoper = 'C' then mon1.mnnemo ELSE mon2.mnnemo END
				--    ,ROUND(unwind.camtomon1,2)  
				--    ,case when unwind.catipoper = 'V' then mon1.mnnemo ELSE mon2.mnnemo END
				--    ,(ISNULL(CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capremon1   
				--	  ELSE unwind.precio_spot  + unwind.caantptosfwd END,0))
				--    ,unwind.catipoper) AS [Notional Amount (Part position)]
			 ,CONVERT(NUMERIC(36,2),ROUND((CASE WHEN mon2.mnnemo = 'CLP'  THEN (camtomon1 * (ISNULL(CASE WHEN cacodpos1 = 2  THEN capremon1  ELSE precio_spot  + caantptosfwd END,0)))--(unwind.nocional)
				  WHEN mon2.mnnemo = 'UF'   THEN unwind.nocional   
				  WHEN mon2.mnnemo = 'USD'  THEN (camtomon1 * (ISNULL(CASE WHEN cacodpos1 = 2  THEN capremon1  ELSE precio_spot  + caantptosfwd END,0)))
			  ELSE 0 END),2)) AS [Notional Amount (Part position)]	
			  --,(camtomon1 * (ISNULL(CASE WHEN cacodpos1 = 2  THEN capremon1  ELSE precio_spot  + caantptosfwd END,0)))				
			 ,mon2.mnnemo AS [Reference Currency]
			 ,dbo.Fx_Convalida_Tipos(33,1,1,unwind.forma_pagou,0) AS [Settlement Reference Currency]
			 ,'N/A' AS [Underlying asset]
			 ,CONVERT(varchar,unwind.cafecha,3) AS [Trade Date] 
			 ,CONVERT(varchar,unwind.cafecha,3) AS [Effective Date]
			 ,CONVERT(varchar,ISNULL(MODIF.cafecvcto,unwind.cafecvcto),3) AS [Settlement Date]
			 ,case when unwind.catipoper = 'C' then Mon1.mnnemo ELSE Mon2.mnnemo end AS [Buyer Currency]
			 ,case when unwind.catipoper = 'V' then Mon1.mnnemo ELSE Mon2.mnnemo end AS [Seller Currency]
			 ,ISNULL(CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capremon1   					  
			 ELSE unwind.precio_spot  + unwind.caantptosfwd END,0) AS [Forward rate]					  
			 --,case when Forward.Relacion <> 0 THEN Forward.precierre  
			 -- ELSE   ISNULL(CASE WHEN Forward.mocodpos1 = 1  THEN Forward.motipcam
				--    WHEN Forward.mocodpos1 = 2  THEN Forward.mopremon1
				--    WHEN Forward.mocodpos1 = 3  THEN Forward.motipcam
				--    WHEN Forward.mocodpos1 = 13 THEN Forward.motipcam
				--    WHEN Forward.mocodpos1 = 14 THEN Forward.mopremon1
				--    WHEN Forward.mocodpos1 = 16 THEN Forward.mopremon1 				
				--    END,0) 
			 --  END AS [Forward rate]					  					  
			 ,'N.A.' AS [Barrier]
			 ,'D-1' AS [Fixing Date]
			 ,'Final' AS [Settlement Rate Type]
			 ,dbo.Fx_Rate_Source(unwind.canumoper) AS [Rate Source]
			 ,'CHILE' AS [Country Origin]
			 ,'' AS [Registration]
			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]
			 ,'' AS [Addicional information]			 			  
			 ,ISNULL(dbo.Fx_DCE_contract('TR-' + convert(VARCHAR(50),unwind.canumoper),'BFW'),'') AS [DCE Contract]
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
			  then 'No' else 'Yes' end AS [US Person]
			 ,'Yes' AS [OTC]
			 ,'No' AS [Dealing Activity]
			 ,'No' AS [IntraGroup]
			 ,'Yes' AS [Unwind]
			 ,'No' AS [Trade Done In Brazil]
			 --,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,mon1.mncodmon,unwind.camtomon1,13),2)) AS [USD Notional]
			 ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN (case when unwind.catipoper = 'C' then Mon1.mnnemo ELSE Mon2.mnnemo END) = 'USD' THEN unwind.camtomon1
			 WHEN (case when unwind.catipoper = 'V' then Mon1.mnnemo ELSE Mon2.mnnemo end)  = 'USD' THEN unwind.nocional
			 ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,mon1.mncodmon,unwind.camtomon1,13) END,2)) AS [USD Notional]
		  FROM	(	select	canumoper,	 cacodpos1,	catipoper, camtomon1,nocional = camtomon2, caequusd1, caequmon1, capremon1, capremon2, capreant
	                    ,		precio_spot,	 caantptosfwd,	caantptoscos ,	caspread, cafecvcto, caoperador, cacodigo, cacodcli, cacodmon1, cacodmon2, catipmoda
	                    ,	 forma_pago = cafpagomn, forma_pagou = caAntForPagMdaComp, NumeroContratoCliente, cafecha
	                    from	BacFwdsuda.dbo.MFCA with(nolock)
	                    where	cafecvcto BETWEEN @FechaDesde and @Fechahasta
	                    and		caantici   = 'A'
	                    and		caestado  <> 'A'
		               UNION 
		               select	canumoper,	 cacodpos1,		catipoper, camtomon1,nocional = camtomon2, caequusd1, caequmon1, capremon1, capremon2, capreant
		               ,		precio_spot, caantptosfwd = 0.0, caantptoscos = 0.0, caspread, cafecvcto, caoperador, cacodigo, cacodcli, cacodmon1, cacodmon2, catipmoda
		               ,	 forma_pago = cafpagomn, forma_pagou = 0, NumeroContratoCliente, cafecha
		               from	BacFwdsuda.dbo.MFCAH  with(nolock) -->Esta tabla tiene las operaciones vencidas
		               where	cafecvcto BETWEEN @FechaDesde and @Fechahasta
		               and		caantici   = 'A'
		               and		caestado  <> 'A'					   
		               )	unwind

				   inner join ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
							    from	BacParamSuda.dbo.cliente with(nolock)
							   ) Clie	On	Clie.clrut		= unwind.cacodigo
									   and Clie.clcodigo	= unwind.cacodcli

				   left  join	( select codigo_producto, descripcion from BacParamSuda.dbo.Producto with(nolock)
								 where Id_Sistema = 'BFW'
							   ) Prod On Prod.codigo_producto = unwind.cacodpos1

				   Left  Join	(	select mncodmon, mnnemo, mnfactor from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = unwind.cacodmon1
				   Left  Join	(	select mncodmon, mnnemo, mnfactor from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = unwind.cacodmon2

				    LEFT JOIN 
				    (   SELECT DISTINCT canumoper, Estado = 'M', cafecvcto
					   FROM	bacfwdsuda.dbo.mfca_LOG WITH(NOLOCK)
					   WHERE	caestado = 'M'
					   AND cafecvcto   BETWEEN @Fecha and @Fecha	
					   and catipmoda = 'C' 
						  UNION
					   SELECT DISTINCT canumoper, Estado = 'A', cafecvcto
					   FROM	BacFwdSuda.dbo.Mfcah WITH(NOLOCK)
					   WHERE	caantici    = 'A'
					   AND cafecvcto   BETWEEN @Fecha and @Fecha
					   and catipmoda = 'C'
				    ) MODIF ON MODIF.canumoper = unwind.canumoper
		  WHERE unwind.catipmoda = 'C'
                  **********************************************************/
		  if ( 1 = 1 )
		  Begin		  
		  -->	Anticipos y Operaciones Forward Americano
		   ------------------------------------------------------
			   
            INSERT INTO #RESULTADOS_BFW
            SELECT 
			Case when Opciones.MoTipoTransaccion = 'CREACION' then 'I'
			     when Opciones.MoTipoTransaccion = 'ANTICIPA' then 'E'
					 when Opciones.MoTipoTransaccion = 'EJERCE'  and Ori.CaMontoMon1Original = Opciones.momontomon1  then 'E'
				 when Opciones.MoTipoTransaccion = 'EJERCE'   then 'U'
				 when Opciones.MoTipoTransaccion = 'MODIFICA' and Ori.CaModalidadOriginal = 'E' then 'I'
				 when Opciones.MoTipoTransaccion = 'MODIFICA' and Ori.CaModalidadOriginal = 'C' and Opciones.Modalidad = 'E' then 'E'
					 when Opciones.MoTipoTransaccion = 'MODIFICA' then 'A'
				 else 'A' end as [Type]
			  , case when Opciones.MoTipoTransaccion = 'EJERCE' and Ori.CaMontoMon1Original > Opciones.momontomon1			  
			          THEN 'Amortization' ELSE '' END    AS [Contract Update Reason]
		  ,'N/A' AS [Part Account] --Naranjo
		  ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Opciones.MoCVOpc),1) AS [Part Position] --e.MoCVEstructura
		  ,dbo.Fx_Convalida_Tipos(35,1,1,'',1) AS [Part Code] 
		  ,'N/A' AS [Part CPF/CNPJ] --Naranjo
		  ,dbo.Fx_Convalida_Tipos(34,1,1,'',1) AS [Part] 
		  ,CASE WHEN (SELECT cp.cliente_relacionado 
		              FROM TBL_CONTRATOUSD_PASO cp 
		              WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
		              AND cp.id = (SELECT max(cp2.id) 
		                           FROM TBL_CONTRATOUSD_PASO cp2 
		                           WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 'Yes'
		   ELSE 'No' END AS [Counterpart Indentified] --Naranjo
		  ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,Opciones.MoCVOpc,1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END  AS [Counterpart Position] --Narajno ¿no cambia? Porqué está Naranjo??
		  ,'' AS [Counterpart Code] -- Naranjo
		  ,'N/A' AS [Counterpart CPF/CNPJ] --Naranjo
		  ,CASE WHEN (SELECT cp.cliente_relacionado 
					  FROM TBL_CONTRATOUSD_PASO cp 
					  WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
					  AND cp.id = (SELECT max(cp2.id) 
								   FROM TBL_CONTRATOUSD_PASO cp2 
								   WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%'))) = 1 THEN 
							 (SELECT cp.nombre_cliente FROM TBL_CONTRATOUSD_PASO cp 
							  WHERE cp.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')
							  AND cp.id = (SELECT max(cp2.id) 
									       FROM TBL_CONTRATOUSD_PASO cp2 
									       WHERE cp2.rut_cliente LIKE concat(convert(varchar(20),clie.clrut),'%')))
		   ELSE '' END AS [Counterpart] --Dependo de la carga de clientes LD1-COR-001
		  ,'NDF' AS [Derivative Type] --Naranjo
		  ,'OTC' AS [Trading Place] --Naranjo
		  ,'TR-' + CONVERT(varchar(50),Opciones.MoNumContrato) + '-' + CONVERT(char(2),Opciones.monumestructura) AS [Contract Number] --> Se realizará re-numeración??                 
			  ,CONVERT(numeric(36,2),ROUND( case when Opciones.MoTipoTransaccion = 'EJERCE' 
			                                      and Ori.CaMontoMon1Original > Opciones.momontomon1 
												  then Ori.CaMontoMon2Original - Opciones.momontomon2  -- Saldo
			                                else Opciones.momontomon2 end
			                                 ,2)) AS [Notional Amount (Part position)] -->DEFINIR configuración regional                                                                               
		  ,'CLP' AS [Reference Currency]
		  ,dbo.Fx_Convalida_Tipos(33,1,1,Opciones.formapago,0) AS [Settlement Reference Currency]
		  ,'N/A' AS [Underlying asset]      -->VALIDAR
		  ,CONVERT(varchar,Opciones.MoFechaContrato,3) AS [Trade Date]     -->DEFINIR configuración regional
		  ,CONVERT(varchar,Opciones.MoFechaInicioOpc,3) AS [Effective Date]       
		  ,CONVERT(varchar,Opciones.MoFechaVcto,3) AS [Settlement Date]    -->VALIDAR podría ser vencimiento o pago 
		  ,CASE WHEN Opciones.MoCVOpc = 'C' THEN 'USD' ELSE 'CLP' END  AS [Buyer Currency]
		  ,CASE WHEN Opciones.MoCVOpc = 'V' THEN 'USD' ELSE 'CLP' END  AS [Seller Currency]
		  ,Opciones.MoStrike AS [Forward rate]
		  ,'N.A.' AS [Barrier]
		  ,'D-1' AS [Fixing Date]    --Fixing de? Caso asiáticas
		  ,dbo.Fx_Convalida_Tipos(5,1,1,Opciones.PayOffTipDsc,1) AS [Settlement Rate Type] -->VALIDAR
		  ,'BCCH' AS [Rate Source] 
		  ,'CHILE' AS [Country Origin]      -->VALIDAR CHILE??
		  ,'' AS [Registration]      --Dice "For  OTC Trade, keep this field in blank."
		  ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
		  then 'ISDA' else 'CGD' end AS [Derivative Master Agreement] 
		  ,'' AS [Addicional information]		  		   
	          ,ISNULL(dbo.Fx_DCE_contract('TR-' + CONVERT(varchar(50),Opciones.MoNumContrato)+'-1','BFW'),'') AS [DCE Contract]
		  ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
		  then 'No' else 'Yes' end AS [US Person] 
		  ,'Yes' AS [OTC]     -->VALIDAR
		  ,'No' AS [Dealing Activity]       -->VALIDAR y DEFINIR
		  ,'No' AS [IntraGroup]      --VALIDAR y DEFINIR
			  ,CASE WHEN Opciones.MoTipoTransaccion = 'ANTICIPA' 
					 or  Opciones.MoTipoTransaccion = 'EJERCE'  and Ori.CaMontoMon1Original = Opciones.momontomon1  
                    THEN 'Yes' ELSE 'No' END  AS [Unwind]     
		  ,'No' AS [Trade Done In Brazil]   --Dice "Do not fill in (Default Filling - No)"
		  --,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,13,Opciones.MoMontoMon1,13),2)) AS [USD Notional]      
--		  ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN (CASE WHEN Opciones.MoCVOpc = 'C' THEN 'USD' ELSE 'CLP' END) = 'USD' THEN Opciones.MoMontoMon1  -- MAP 20170424
--		  WHEN (CASE WHEN Opciones.MoCVOpc = 'V' THEN 'USD' ELSE 'CLP' END)  = 'USD' THEN Opciones.momontomon2                                   -- MAP 20170424
--		  ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,13,Opciones.MoMontoMon1,13) END,2)) AS [USD Notional]                               -- MAP 20170424
	          ,  case when Opciones.MoTipoTransaccion = 'EJERCE' 
			                                      and Ori.CaMontoMon1Original > Opciones.momontomon1 
												  then Ori.CaMontoMon1Original - Opciones.momontomon1  -- Saldo
			                                else Opciones.momontomon1 end AS [USD Notional]
		  , [QueryOrigen] = 'SECION 03'     
		  , [Effective Date Como Fecha] = Opciones.MoFechaContrato
		  , [Contrato] = Opciones.monumcontrato
		  , [Orden]    = 0
		  from     (      select monumcontrato       = mvto.monumcontrato
					   ,  monumfolio          = mvto.monumfolio
					   ,  mooperador          = mvto.mooperador
					   ,  moresultadoventasml = mvto.moresultadoventasml
					   ,  mofechacontrato     = mvto.mofechacontrato
					   ,  morutcliente        = mvto.morutcliente
					   ,  mocodigo                   = mvto.mocodigo
					   ,  morelacionapae             = mvto.morelacionapae
					   ,  mocodestructura     = mvto.mocodestructura
					   ,  motipotransaccion   = mvto.motipotransaccion
					   ,  monumestructura     = Deta.monumestructura
					   ,  mocallput                  = Deta.mocallput
					   ,  mostrike                   = Deta.mostrike
					   ,  movinculacion       = Deta.movinculacion
					   ,  mocvopc                    = Deta.mocvopc
					   ,  momontomon1         = Deta.momontomon1
					   ,  momontomon2         = Deta.momontomon2
					   ,  MonTransada         = Mon1.mnnemo
					   ,  MonConversion       = Mon2.mnnemo
					   ,  MoFechaUnwind       = mvto.mofechaunwind
					   ,  formapago           = case when Deta.MoModalidad = 'C' then deta.MoFormaPagoComp else deta.MoFormaPagoMon2 end
					   , MoMdaCompensacion   = Deta.MoMdaCompensacion    
					   , MoFechaInicioOpc     = Deta.MoFechaInicioOpc
					   , MoFechaVcto          = Deta.MoFechaVcto
					   , MoPrimaInicialML     = mvto.MoPrimaInicialML
					   , MoTipoEjercicio      = Deta.MoTipoEjercicio
					   , PayOffTipDsc         = POT.PayOffTipDsc  
					   , Modalidad            = Deta.MoModalidad
				from  CbMdbOpc.dbo.MoEncContrato mvto   with(nolock)
				inner join (      select monumfolio
								,    monumestructura
								,    mocallput
								,    mostrike
								,    movinculacion
								,    mocvopc
								,    momontomon1
								,    momontomon2
								,    mocodmon1
								,    mocodmon2
								, MoMdaCompensacion
								, MoFechaInicioOpc
								, MoFechaVcto
								, MoPrimaInicialDet
								, MoTipoEjercicio
								, MoTipoPayOff
								, MoModalidad
									, MoFormaPagoComp
									, MoFormaPagoMon2
								from      CbMdbOpc.dbo.MoDetContrato det with(nolock)
								-- WHERE det.MoModalidad <> 'E'                                                                       
								)  Deta   On     Deta.monumfolio     =       mvto.monumfolio
                                                  
				INNER JOIN ( SELECT MoNumFolio,MoNumEstructura 
							 FROM CbMdbOpc.dbo.MoFixing with(nolock) 
							 )fix ON Deta.monumfolio    = fix.MoNumFolio AND Deta.monumestructura = fix.MoNumEstructura

				INNER JOIN (SELECT PayOffTipCod, PayOffTipDsc
							 FROM CbMdbOpc.dbo.PayOffTipo with(nolock)
							 )POT ON Deta.MoTipoPayOff = POT.PayOffTipCod 

				inner join (     select mncodmon, mnnemo 
								    from      BacParamSuda.dbo.Moneda with(nolock) 
								)  Mon1   On     Mon1.mncodmon =       Deta.mocodmon1

				inner join (     select mncodmon, mnnemo 
								    from      BacParamSuda.dbo.Moneda with(nolock) 
								)  Mon2   On     Mon2.mncodmon =       Deta.mocodmon2
                where MoFechaCreacionRegistro >=  @Fecha 
				  and MoFechaCreacionRegistro < dateadd( dd, 1, @Fecha  )
				  and MoEstado <> 'C'
				  and 1 = 2 -- MAP 20190726
			 union 

			 select      monumcontrato       = mvto.monumcontrato
					   ,  monumfolio          = mvto.monumfolio
					   ,  mooperador          = mvto.mooperador
					   ,  moresultadoventasml = mvto.moresultadoventasml
					   ,  mofechacontrato     = mvto.mofechacontrato
					   ,  morutcliente        = mvto.morutcliente
					   ,  mocodigo                   = mvto.mocodigo
					   ,  morelacionapae             = mvto.morelacionapae
					   ,  mocodestructura     = mvto.mocodestructura
					   ,  motipotransaccion   = mvto.motipotransaccion
					   ,  monumestructura     = Deta.monumestructura
					   ,  mocallput                  = Deta.mocallput
					   ,  mostrike                   = Deta.mostrike
					   ,  movinculacion       = Deta.movinculacion
					   ,  mocvopc                    = Deta.mocvopc
					   ,  momontomon1         = Deta.momontomon1
					   ,  momontomon2         = Deta.momontomon2
					   ,  MonTransada         = Mon1.mnnemo
					   ,  MonConversion       = Mon2.mnnemo
					   ,  MoFechaUnwind       = mvto.mofechaunwind
					   ,  formapago           = case when Deta.MoModalidad = 'C' then deta.MoFormaPagoComp else deta.MoFormaPagoMon2 end -- mvto.MofPagoPrima
					   , MoMdaCompensacion   = Deta.MoMdaCompensacion
					   , MoFechaInicioOpc     = Deta.MoFechaInicioOpc
					   , MoFechaVcto          = Deta.MoFechaVcto
					   , MoPrimaInicialML     = mvto.MoPrimaInicialML    
					   , MoTipoEjercicio      = Deta.MoTipoEjercicio
					   , PayOffTipDsc         = POT.PayOffTipDsc
					   ,  Modalidad            = Deta.MoModalidad          
						      
			 from  CbMdbOpc.dbo.MoHisEncContrato mvto      with(nolock)
			 inner join (      select monumfolio
							,    monumestructura
							,    mocallput
							,    mostrike
							,    movinculacion
							,    mocvopc
							,    momontomon1
							,    momontomon2
							,    mocodmon1
							,    mocodmon2
							, MoMdaCompensacion
							, MoFechaInicioOpc
							, MoFechaVcto
							, MoPrimaInicialDet
							, MoTipoEjercicio
							, MoTipoPayOff
							, MoModalidad
								, MoFormaPagoComp
								, MoFormaPagoMon2
							 from      CbMdbOpc.dbo.MoHisDetContrato det       with(nolock)
							 -- WHERE det.MoModalidad <> 'E'
							 )  Deta   On     Deta.monumfolio     =       mvto.monumfolio

			 INNER JOIN ( SELECT MoNumFolio,MoNumEstructura
						  FROM CbMdbOpc.dbo.MoHisFixing      
						  )fix ON Deta.monumfolio    = fix.MoNumFolio AND Deta.monumestructura = fix.MoNumEstructura

			 INNER JOIN (SELECT PayOffTipCod, PayOffTipDsc
						  FROM CbMdbOpc.dbo.PayOffTipo with(nolock)
						  )POT ON Deta.MoTipoPayOff = POT.PayOffTipCod 

			 inner join (     select mncodmon, mnnemo 
								from      BacParamSuda.dbo.Moneda with(nolock) 
							 )  Mon1   On     Mon1.mncodmon =       Deta.mocodmon1

			 inner join (     select mncodmon, mnnemo 
								from      BacParamSuda.dbo.Moneda with(nolock) 
							 )  Mon2   On     Mon2.mncodmon =       Deta.mocodmon2
			  where  MoFechaCreacionRegistro >=  @Fecha 
				  and MoFechaCreacionRegistro < dateadd( dd, 1, @Fecha  )
			     and MoEstado <> 'C'
			 )    Opciones
			 /*********************************************************   Sacar 
			 inner join (      select monumcontrato              = Grp.monumcontrato
								    ,          monumfolio                        = MAX( Grp.MoNumFolio )
								    from CbMdbOpc.dbo.MoEncContrato Grp    with(nolock)
								    where      Grp.moestado NOT IN ('C','P')
								    group 
								 by         Grp.monumcontrato

												UNION 
								    select     monumcontrato              = Grp.monumcontrato
								    ,          monumfolio                        = MAX( Grp.MoNumFolio )
								    from CbMdbOpc.dbo.MoEncContrato Grp    with(nolock)
								    where      Grp.moestado NOT IN ('C','P')
								    group 
								    by         Grp.monumcontrato

												UNION
								    select     monumcontrato              = Grp.monumcontrato
								    ,          monumfolio                        = MAX( Grp.MoNumFolio )
								    from CbMdbOpc.dbo.MoHisEncContrato     Grp    with(nolock)
								    where      Grp.mofechacontrato        BETWEEN @FechaDesde and @FechaHasta
								    and        Grp.moestado               NOT IN ('C','P')
								    group 
								    by         Grp.monumcontrato

												UNION
								    select     monumcontrato              = Grp.monumcontrato
								    ,          monumfolio                        = MAX( Grp.MoNumFolio )
								    from CbMdbOpc.dbo.MoHisEncContrato     Grp    with(nolock)
								    where      Grp.MoFechaUnwind          BETWEEN @FechaDesde and @FechaHasta
								    and        Grp.moestado               NOT IN ('C','P')
								    group 
								    by         Grp.monumcontrato
								)   Grp          On     Grp.monumcontrato   =       Opciones.monumcontrato
												and      Grp.monumfolio             =       Opciones.monumfolio
              *************************************************************************/
			 left  join (      select OpcEstCod,   OpcEstDsc
								    from CbMdbOpc.dbo.OpcionEstructura     with(nolock)
								)   Estr   ON Estr.OpcEstCod          =      Opciones.mocodestructura

			 inner join (      select clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), Clpais 
								    from BacParamSuda.dbo.cliente   with(nolock)
								)   Clie   On     Clie.clrut                 =       Opciones.MoRutCliente
												and Clie.clcodigo             =       Opciones.MoCodigo
			 left join (  -- Datos Operacion Original
			              -- Se usa Left Join porque
						  -- podría no existir
			               select CaNumContrato, CaModalidadOriginal = CaModalidad 	 
							       	, CaMontoMon1Original = CaMontoMon1 
									, CaMontoMon2Original = CaMontoMon2 
									, CaFechaVctoOriginal = CaFechaVcto
						         from      CbMdbOpc.dbo.CaResDetContrato det       with(nolock)
							 WHERE CaDetFechaRespaldo = @Ayer
							 )  Ori   On     Ori.CaNumContrato     =       Opciones.monumcontrato

			 WHERE -- Opciones.motipotransaccion NOT IN('ANULA' , 'EJERCE')
			 -- AND 
			     Opciones.mocodestructura IN (8,13)   
			 AND Opciones.MoNumContrato not in ( select monumcontrato from #Nulas )
			 AND (     Opciones.Modalidad = 'C'  
			       or  Opciones.Modalidad = 'E'  and Ori.CaModalidadOriginal = 'C'  -- Terminar  
			      )

               --update   #RESULTADOS_BFW
               --set      [Notional Amount (Part position)] = convert(numeric(32,2),[Notional Amount (Part position)]) - Anticipo.nMonto
               --,        [USD Notional] = convert(numeric(32,5),[USD Notional]) - Anticipo.nDolares
               --from     ( select     Contrato     = [Contract Number]
                           --             ,    nMonto = convert(numeric(32,2),[Notional Amount (Part position)])
                           --             ,    nDolares     = convert(numeric(32,5),[USD Notional])
                           --    from   #RESULTADOS_BFW 
                           --    where  [Type] = 'U'
                           --) Anticipo
               --where    [Type] = 'U'
               --and      [Contract Number] = Anticipo.Contrato
               

			update #RESULTADOS_BFW
			   Set
			   [Trade Date]      = CONVERT(varchar,Opciones.MoFechaContrato,3) 
		  ,    [Effective Date]  = CONVERT(varchar,Opciones.MoFechaContrato,3)
		  ,    [Effective Date Como Fecha] = Opciones.MoFechaContrato
			  ,    [Settlement Date]  = CONVERT(varchar, Opciones.MoFechaVcto, 3 ) 
			   from ( Select MonumContrato, MoFechaContrato, D.MoFechaVcto 
			             from CbMdbOpc.dbo.MoEncContrato E 
						    left join CbMdbOpc.dbo.MoDetContrato D on D.MoNumFolio = E.MoNumFolio and D.MoNUmEstructura = 1
						 where MoTipoTransaccion = 'CREACION' 
		           union 
					  Select MonumContrato, MoFechaContrato, D.MoFechaVcto 
					     from CbMdbOpc.dbo.MoHisEncContrato E
						left join CbMdbOpc.dbo.MoHisDetContrato D on D.MoNumFolio = E.MoNumFolio and D.MoNUmEstructura = 1
						 where MoTipoTransaccion = 'CREACION' 
				 ) Opciones
			where [QueryOrigen] = 'SECION 03'
			     and [Contrato] = MoNUmContrato

	End -- Para activar /desactiva SAO 
		-- ambiente desarrollo

            UPDATE #RESULTADOS_BFW
			   set [orden] = case when type = 'I' then 0 
			                      when type = 'A' then 1
								  when type = 'E' then 2
								  else 3 end

               
            UPDATE #RESULTADOS_BFW
            SET [Buyer Currency] = 'CLF'
            WHERE [Buyer Currency] = 'UF'
            
            UPDATE #RESULTADOS_BFW
            SET [Seller Currency] = 'CLF'
            WHERE [Seller Currency] = 'UF'
            
            UPDATE #RESULTADOS_BFW
            SET [Reference Currency] = 'CLF'
            WHERE [Reference Currency] = 'UF'

			-- MAP 20170412
			-- Anticipos Parciales de Operaciones con fecha efectiva anterior 
			-- al 17 de Marzo 2014 deben ser informadas como 'A' (correcciones)
			Update #RESULTADOS_BFW
				Set [Type] = 'A' , [Contract Update Reason] = ''
			where #RESULTADOS_BFW.Type = 'U'
				and  #RESULTADOS_BFW.[Contract Update Reason] = 'Amortization'
				and #RESULTADOS_BFW.[Effective Date Como Fecha] < '20140317'

            
	    SELECT DISTINCT RB.Type, RB.[Contract Update Reason], RB.[Part Account], RB.[Part Position], RB.[Part Code], RB.[Part CPF/CNPJ], RB.Part, RB.[Counterpart Indentified], RB.[Counterpart Position]
		              , RB.[Counterpart Code], RB.[Counterpart CPF/CNPJ]
					  , RB.Counterpart, RB.[Derivative Type], RB.[Trading Place]
					  , RB.[Contract Number], RB.[Notional Amount (Part position)]
					  , RB.[Reference Currency], RB.[Settlement Reference Currency]
					  , RB.[Underlying asset], RB.[Trade Date], RB.[Effective Date]
					  , RB.[Settlement Date], RB.[Buyer Currency], RB.[Seller Currency]
					  , RB.[Forward rate], RB.Barrier, RB.[Fixing Date]
					  , RB.[Settlement Rate Type], RB.[Rate Source]
					  , RB.[Country Origin], RB.Registration, RB.[Derivative Master Agreement]
					  , RB.[Addicional information]
					  , RB.[DCE Contract], RB.[US Person]
					  , RB.OTC, RB.[Dealing Activity], RB.IntraGroup, RB.Unwind, RB.[Trade Done In Brazil], RB.[USD Notional] 
					  FROM #RESULTADOS_BFW RB ORDER BY RB.[Contract Number] DESC	   
	     
END
GO
