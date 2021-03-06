USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_STOCK_BFW]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REPORTES_STOCK_BFW]
	(	@Fecha			DATETIME = NULL
	)
AS
DECLARE @FechaDesde	    DATETIME	     
DECLARE @FechaHasta	    DATETIME	 
DECLARE @tipo_reporte   CHAR(3) = 'BFW'
  
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
	   ,[Forward rate] varchar(250)
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
	)

		  -->	   Forward
		  ---------------------------------------  
		  INSERT INTO #RESULTADOS_BFW
		  SELECT dbo.Fx_Convalida_Tipos(7,1,1,CASE WHEN MODIF.canumoper IS NULL THEN 'VIGENTE'
				WHEN MODIF.Estado <> 'A' AND Forward.cafecvcto = @Fecha THEN 'A VENCER'	 
			    ELSE CASE WHEN MODIF.Estado = 'M' THEN 'MODIFICADA'
				WHEN MODIF.Estado = 'A' THEN 'ANTICIPADA' END 
			    END,0) AS [Type]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(7,1,1,CASE WHEN MODIF.canumoper IS NULL THEN 'VIGENTE' 
				WHEN MODIF.Estado <> 'A' AND Forward.cafecvcto = @Fecha THEN 'A VENCER'	 
			    ELSE CASE WHEN MODIF.Estado = 'M' THEN 'MODIFICADA'
				WHEN MODIF.Estado = 'A' THEN 'ANTICIPADA' END 
			    END,0) = 'U' THEN 'Unwind' ELSE '' END AS [Contract Update Reason]
			 ,'N/A' AS [Part Account]
			 ,dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Forward.catipoper),1) AS [Part Position]
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
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(3,1,1,UPPER(Forward.catipoper),1) = 'SELLER' THEN 'BUYER' ELSE 'SELLER' END AS [Counterpart Position]
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
			 ,'TR-' + convert(varchar(50),Forward.canumoper) AS [Contract Number]			 
			 ,CASE WHEN forward.Relacion <> 0 THEN CONVERT(NUMERIC(36,2),ROUND((CASE WHEN Rmon2.mnnemo = 'CLP'  THEN segcam.nocional_rel
												 WHEN Rmon2.mnnemo = 'UF'   THEN segcam.nocional_rel   
												 WHEN Rmon2.mnnemo = 'USD'  THEN segcam.nocional_rel
											ELSE 0 END),2))     
										ELSE CONVERT(NUMERIC(36,2),ROUND((CASE WHEN Forward.cacodpos1 = 14 THEN Forward.noci0  
												 WHEN mon2.mnnemo = 'CLP'  THEN Forward.nocional
												 WHEN mon2.mnnemo = 'UF'   THEN Forward.nocional   
												 WHEN mon2.mnnemo = 'USD'  THEN Forward.nocional
											ELSE 0 END),2)) END AS [Notional Amount (Part position)]				
			 ,case when forward.Relacion <> 0 THEN Rmon2.mnnemo ELSE mon2.mnnemo END AS [Reference Currency]
			 ,dbo.Fx_Convalida_Tipos(33,1,1,Forward.forma_pago,0) AS [Settlement Reference Currency]
			 ,'N/A' AS [Underlying asset]
			 ,CONVERT(varchar,Forward.cafecha,3) AS [Trade Date]
			 ,CONVERT(varchar,Forward.cafecha,3) AS [Effective Date]
			 ,CONVERT(varchar,ISNULL(MODIF.cafecvcto,Forward.cafecvcto),3) AS [Settlement Date]
			 --,case when Forward.motipoper = 'C' then mon1.mnnemo ELSE mon2.mnnemo end AS [Buyer Currency]
			 ,case when forward.Relacion <> 0 THEN (case when Forward.catipoper = 'C' then mon1.mnnemo ELSE Rmon2.mnnemo END)
			 ELSE (case when Forward.catipoper = 'C' then mon1.mnnemo ELSE mon2.mnnemo end) END AS [Buyer Currency]
			 --,case when Forward.motipoper = 'V' then mon1.mnnemo ELSE mon2.mnnemo END AS [Seller Currency]
			 ,case when forward.Relacion <> 0 THEN (case when Forward.catipoper = 'V' then mon1.mnnemo ELSE Rmon2.mnnemo END)
			 ELSE (case when Forward.catipoper = 'V' then mon1.mnnemo ELSE mon2.mnnemo END) END AS [Seller Currency]
			 ,case when Forward.Relacion <> 0 THEN Forward.precierre  
			  ELSE   ISNULL(CASE WHEN Forward.cacodpos1 = 1  THEN Forward.catipcam
				    WHEN Forward.cacodpos1 = 2  THEN Forward.capremon1
				    WHEN Forward.cacodpos1 = 3  THEN Forward.catipcam
				    WHEN Forward.cacodpos1 = 13 THEN Forward.catipcam
				    WHEN Forward.cacodpos1 = 14 THEN Forward.capremon1
				    WHEN Forward.cacodpos1 = 16 THEN Forward.capremon1 				
				    END,0) 
			   END AS [Forward rate]
			 ,'N.A.' AS [Barrier]
			 ,'D-1' AS [Fixing Date]
                ,'Final' AS [Settlement Rate Type]
			 ,dbo.Fx_Rate_Source(Forward.canumoper) AS [Rate Source]
			 ,'CHILE' AS [Country Origin]
			 ,'' AS [Registration]
			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]
			 ,'' AS [Addicional information]			 
			 ,ISNULL(dbo.Fx_DCE_contract('TR-' + convert(varchar(50),Forward.canumoper),'BFW'),'') AS [DCE Contract]
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
			  then 'No' else 'Yes' end AS [US Person]
			 ,'Yes' AS [OTC]
			 ,'No' AS [Dealing Activity]
			 ,'No' AS [IntraGroup]
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(7,1,1,CASE WHEN MODIF.canumoper IS NULL THEN 'VIGENTE' 
				WHEN MODIF.Estado <> 'A' AND Forward.cafecvcto = @Fecha THEN 'A VENCER'	 
			    ELSE CASE WHEN MODIF.Estado = 'M' THEN 'MODIFICADA'
				WHEN MODIF.Estado = 'A' THEN 'ANTICIPADA' END 
			    END,0) = 'U' THEN 'Yes' ELSE 'No' END AS [Unwind]
			 ,'No' AS [Trade Done In Brazil]
			 --,CONVERT(NUMERIC(36,2),ROUND(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,mon1.mncodmon,Forward.momtomon1,13),2)) AS [USD Notional]
			 ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN mon1.mnnemo = 'USD' THEN Forward.camtomon1
									   WHEN mon2.mnnemo = 'USD' THEN Forward.nocional
			 ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,mon1.mncodmon,Forward.camtomon1,13) END,2)) AS [USD Notional]
			 FROM	(select cafecha, cacodpos1, canumoper, catipoper, caoperador, camtomon1, nocional = camtomon2, caequusd1, noci0 = caequmon1, catipcamSpot
								, catipcam, capremon1, capremon2,caparmon1, caparmon2, capreciopunta, cacodmon1, cacodmon2
								, cacodigo, cacodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, cafecvcto, catipmoda
								, Relacion     = var_moneda2, precierre = caprecal,forma_pago = cafpagomn
						  from BacFwdSuda.dbo.mfca WITH(NOLOCK)
									   left  join 
									   (      select fecha, codigo_moneda, tipo_cambio
										  from   BacParamSuda.dbo.valor_moneda_contable with(nolock) 
										  where  codigo_moneda              = 994
									   )      vcont  On     vcont.fecha = cafecha --> ctro.acfecante
														  and vcont.codigo_moneda = 994													   
						  where	 caestado	   <> 'A'
						  and	 cafecvcto    > @Fecha
						  and     not		   (var_moneda2 <> 0 and cacodpos1 = 1)				   
					   )	Forward

					   left join
					   (select cafecha,  cacodpos1, canumoper, catipoper, caoperador, camtomon1, nocional_rel = camtomon2, caequusd1, caequmon1, catipcamSpot
							 , catipcam, capremon1, capremon2, caparmon1, caparmon2, capreciopunta, monedaSC1 =  cacodmon1, monedaSC2 = cacodmon2
							 , cacodigo, cacodcli, Resultado_Mesa, cafecvcto, catipmoda, Relacion = var_moneda2
					   from   BacFwdSuda.dbo.Mfca with(nolock)             
					   where  cafecvcto      > @Fecha
					   and caestado        NOT IN ('A')
					   and var_moneda2   <> 0
					   and cacodpos1       =  1
					   ) segcam On segcam.Relacion  = Forward.Relacion

					   inner join 
					   (	select	clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						  from	BacParamSuda.dbo.cliente with(nolock)
					   )	Clie	On	Clie.clrut		= Forward.cacodigo
								    and Clie.clcodigo	= Forward.cacodcli

					   inner join	
					   (	select	codigo_producto, descripcion 
						  from	BacParamSuda.dbo.Producto with(nolock)
						  where	Id_Sistema = 'BFW'
					   )	Prod	On Prod.codigo_producto = Forward.cacodpos1

					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	mon1	on mon1.mncodmon = Forward.cacodmon1        
					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	mon2	on mon2.mncodmon = Forward.cacodmon2

					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	Rmon1	on Rmon1.mncodmon = segcam.monedaSC1        
					   left  join 
					   (	select	mncodmon, mnnemo 
						  from	BacParamSuda.dbo.Moneda with(nolock)
					   )	Rmon2	on Rmon2.mncodmon = segcam.monedaSC2
					   
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
					   ) MODIF ON MODIF.canumoper = Forward.canumoper

			 WHERE Forward.catipmoda = 'C'

		  -->	Anticipos y Operaciones Forward Americano
		   ------------------------------------------------------
            INSERT INTO #RESULTADOS_BFW
		SELECT 'I' AS [Type]
		  --dbo.Fx_Convalida_Tipos(2,1,1,Opciones.MoTipoTransaccion,0) AS [Type]
		  ,CASE WHEN Reportes.dbo.Fx_Convalida_Tipos(2,1,1,Opciones.MoTipoTransaccion,0) = 'U' THEN 'Unwind' ELSE '' END    AS [Contract Update Reason]
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
		  ,CONVERT(numeric(36,2),ROUND(Opciones.momontomon2,2)) AS [Notional Amount (Part position)] -->DEFINIR configuración regional                                                                               
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
		  ,ISNULL(dbo.Fx_DCE_contract('TR-' + CONVERT(varchar(50),Opciones.MoNumContrato),'BFW'),'') AS [DCE Contract]
		  ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
		  then 'No' else 'Yes' end AS [US Person] 
		  ,'Yes' AS [OTC]     -->VALIDAR
		  ,'No' AS [Dealing Activity]       -->VALIDAR y DEFINIR
		  ,'No' AS [IntraGroup]      --VALIDAR y DEFINIR
		  ,CASE WHEN dbo.Fx_Convalida_Tipos(2,1,1,Opciones.MoTipoTransaccion,0) = 'U' THEN 'Yes' ELSE 'No' END  AS [Unwind]     
		  ,'No' AS [Trade Done In Brazil]   --Dice "Do not fill in (Default Filling - No)"
		  --,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,13,Opciones.MoMontoMon1,13),2)) AS [USD Notional]      
		  ,CONVERT(NUMERIC(36,2),ROUND(CASE WHEN (CASE WHEN Opciones.MoCVOpc = 'C' THEN 'USD' ELSE 'CLP' END) = 'USD' THEN Opciones.MoMontoMon1
		  WHEN (CASE WHEN Opciones.MoCVOpc = 'V' THEN 'USD' ELSE 'CLP' END)  = 'USD' THEN Opciones.momontomon2
		  ELSE BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,13,Opciones.MoMontoMon1,13) END,2)) AS [USD Notional]
		  from     (      select monumcontrato       = mvto.canumcontrato
					   ,  monumfolio          = mvto.canumfolio
					   ,  mooperador          = mvto.caoperador
					   ,  moresultadoventasml = mvto.caresultadoventasml
					   ,  mofechacontrato     = mvto.cafechacontrato
					   ,  morutcliente        = mvto.carutcliente
					   ,  mocodigo                   = mvto.cacodigo
					   ,  morelacionapae             = mvto.carelacionapae
					   ,  mocodestructura     = mvto.cacodestructura
					   ,  motipotransaccion   = mvto.catipotransaccion
					   ,  monumestructura     = Deta.canumestructura
					   ,  mocallput                  = Deta.cacallput
					   ,  mostrike                   = Deta.castrike
					   ,  movinculacion       = Deta.cavinculacion
					   ,  mocvopc                    = Deta.cacvopc
					   ,  momontomon1         = Deta.camontomon1
					   ,  momontomon2         = Deta.camontomon2
					   ,  MonTransada         = Mon1.mnnemo
					   ,  MonConversion       = Mon2.mnnemo
					   ,  MoFechaUnwind       = mvto.CaFechaUnwind
					   ,  formapago                = mvto.CafPagoPrima
					   , MoMdaCompensacion   = Deta.caMdaCompensacion    
					   , MoFechaInicioOpc     = Deta.caFechaInicioOpc
					   , MoFechaVcto          = Deta.caFechaVcto
					   , MoPrimaInicialML     = mvto.CaPrimaInicialML
					   , MoTipoEjercicio      = Deta.caTipoEjercicio
					   , PayOffTipDsc         = POT.PayOffTipDsc  
				from  CbMdbOpc.dbo. CaEncContrato mvto   with(nolock)
				inner join (      select CaNumContrato
								,    canumestructura
								,    cacallput
								,    castrike
								,    cavinculacion
								,    cacvopc
								,    camontomon1
								,    camontomon2
								,    cacodmon1
								,    cacodmon2
								, caMdaCompensacion
								, caFechaInicioOpc
								, caFechaVcto
								, caPrimaInicialDet
								, caTipoEjercicio
								, caTipoPayOff
								from      CbMdbOpc.dbo.CaDetContrato det with(nolock)
								WHERE det.caModalidad <> 'E'
								AND det.CaFechaVcto > @Fecha                                                                        
								)  Deta   On     Deta.CaNumContrato     =       mvto.CaNumContrato
                                                  
				INNER JOIN ( SELECT canumcontrato,caNumEstructura 
							 FROM CbMdbOpc.dbo.CaFixing with(nolock) 
							 )fix ON Deta.canumcontrato    = fix.canumcontrato AND Deta.canumestructura = fix.caNumEstructura

				INNER JOIN (SELECT PayOffTipCod, PayOffTipDsc
							 FROM CbMdbOpc.dbo.PayOffTipo with(nolock)
							 )POT ON Deta.caTipoPayOff = POT.PayOffTipCod 

				inner join (     select mncodmon, mnnemo 
								    from      BacParamSuda.dbo.Moneda with(nolock) 
								)  Mon1   On     Mon1.mncodmon =       Deta.cacodmon1

				inner join (     select mncodmon, mnnemo 
								    from      BacParamSuda.dbo.Moneda with(nolock) 
								)  Mon2   On     Mon2.mncodmon =       Deta.cacodmon2
			 )    Opciones

			 inner join (    SELECT  CaNumContrato	= Grp.CaNumContrato
							    ,CaNumFolio	= max(Grp.CaNumFolio) 
						  FROM CbMdbOpc.dbo.CaEncContrato Grp WITH(NOLOCK)
						  WHERE Grp.CaEstado NOT IN ('C','P')
						  GROUP BY Grp.CaNumContrato
								)   Grp On  Grp.canumcontrato	  = Opciones.monumcontrato
								    and	  Grp.canumfolio	  = Opciones.monumfolio

			 left  join (      select OpcEstCod,   OpcEstDsc
								    from CbMdbOpc.dbo.OpcionEstructura     with(nolock)
								)   Estr   ON Estr.OpcEstCod          =      Opciones.mocodestructura

			 inner join (      select clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), Clpais 
								    from BacParamSuda.dbo.cliente   with(nolock)
								)   Clie   On     Clie.clrut                 =       Opciones.MoRutCliente
												and Clie.clcodigo             =       Opciones.MoCodigo

			 WHERE Opciones.motipotransaccion NOT IN('ANULA','ANTICIPA')
			 AND Opciones.mocodestructura IN (8,13)

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
               
            UPDATE #RESULTADOS_BFW
            SET [Buyer Currency] = 'CLF'
            WHERE [Buyer Currency] = 'UF'
            
            UPDATE #RESULTADOS_BFW
            SET [Seller Currency] = 'CLF'
            WHERE [Seller Currency] = 'UF'
            
            UPDATE #RESULTADOS_BFW
            SET [Reference Currency] = 'CLF'
            WHERE [Reference Currency] = 'UF'
            
		  -- SELECT DISTINCT RB.Type, RB.[Contract Update Reason], RB.[Part Account], RB.[Part Position], RB.[Part Code], RB.[Part CPF/CNPJ], RB.Part, RB.[Counterpart Indentified], RB.[Counterpart Position], RB.[Counterpart Code], RB.[Counterpart CPF/CNPJ], RB.Counterpart, RB.[Derivative Type], RB.[Trading Place], RB.[Contract Number], RB.[Notional Amount (Part position)], RB.[Reference Currency], RB.[Settlement Reference Currency], RB.[Underlying asset], RB.[Trade Date], RB.[Effective Date], RB.[Settlement Date], RB.[Buyer Currency], RB.[Seller Currency], RB.[Forward rate], RB.Barrier, RB.[Fixing Date], RB.[Settlement Rate Type], RB.[Rate Source], RB.[Country Origin], RB.Registration, RB.[Derivative Master Agreement], RB.[Addicional information], RB.[DCE Contract], RB.[US Person], RB.OTC, RB.[Dealing Activity], RB.IntraGroup, RB.Unwind, RB.[Trade Done In Brazil], RB.[USD Notional] FROM #RESULTADOS_BFW RB ORDER BY RB.[Contract Number] DESC		  
		  
	      SELECT DISTINCT *
		  FROM #RESULTADOS_BFW RB
		  WHERE convert(datetime,RB.[Trade Date],3) <= '20160331'
		  --WHERE convert(datetime,RB.[Trade Date],3) > '20160331'
		  ORDER BY RB.[Contract Number] DESC	
		  
END

GO
