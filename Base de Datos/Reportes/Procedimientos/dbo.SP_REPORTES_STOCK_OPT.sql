USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_STOCK_OPT]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REPORTES_STOCK_OPT]
	(	@Fecha			DATETIME = NULL
	)
AS
DECLARE @FechaDesde	    DATETIME	     
DECLARE @FechaHasta	    DATETIME	 
DECLARE @OPC            CHAR(3)
  
BEGIN   

	SET NOCOUNT ON	

	IF(@Fecha IS NULL OR @Fecha = '')
	   BEGIN
		  
		  SET @OPC = 'OPC'
				
		  EXEC SP_FECHAPROC_RCM @OPC,NULL,@Fecha OUTPUT	

		  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha		  
	   END
	ELSE 
	   BEGIN
	   	  SET @FechaDesde = @Fecha	  
		  SET @FechaHasta = @Fecha
	   END
	   
	CREATE TABLE #RESULTADOS_OPT
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
	   ,[Currency Option Type] varchar(250)
	   ,[Option] varchar(250)
	   ,[Asset Option] varchar(250)
	   ,[Notional Amount Reference Currency] varchar(3)
	   ,[Notional Amount (Part position)] varchar(250)
	   ,[Settlement Reference Currency] varchar(3)
	   ,[Underlying asset] varchar(3)
	   ,[Trade Date] varchar(250)
	   ,[Effective Date] varchar(250)
	   ,[Settlement Date] varchar(250)
	   ,[Quantity of contracts] varchar(250)
	   ,[Strike Price] varchar(250)
	   ,[Contract reference Month] varchar(250)
	   ,[Contract reference Year] varchar(250)
	   ,[Barrier] varchar(250)
	   ,[Premium Payment Rate] varchar(250)
	   ,[Premium Amount] varchar(250)
	   ,[Currency Option Style] varchar(250)
	   ,[Rate Source] varchar(250)
	   ,[Fixing Date] varchar(250)
	   ,[Settlement Rate Type] varchar(250)
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

    -->  Opciones y Anticipos de Opciones 
    ---------------------------------------
    --IF(@tipo_reporte = 'OPT')
	   --BEGIN
		  
		  INSERT INTO #RESULTADOS_OPT
		  SELECT --dbo.Fx_Convalida_Tipos(2,1,1,Opciones.MoTipoTransaccion,0) AS [Type]
			 'I' AS [Type]  
			 --,CASE WHEN Reportes.dbo.Fx_Convalida_Tipos(2,1,1,Opciones.MoTipoTransaccion,0) = 'U' THEN 'Unwind' ELSE '' END	AS [Contract Update Reason]
			 ,''	AS [Contract Update Reason]	
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
			 ,'OPTIONS' AS [Derivative Type] --Naranjo
			 ,'OTC'	AS [Trading Place] --Naranjo
			 ,'TR-' + CONVERT(varchar(50),Opciones.MoNumContrato) + '-' + CONVERT(char(2),Opciones.monumestructura) AS [Contract Number] --> Se realizará re-numeración??
			 ,UPPER(Opciones.mocallput) AS [Currency Option Type]	-->DEFINIR dónde hacemos la manipulación
			 ,'CURRENCY OPTIONS' AS [Option] 
			 ,'Currency - USD' AS [Asset Option] 			 
			 ,'CLP' AS [Notional Amount Reference Currency]
			 ,CONVERT(NUMERIC(36,2),ROUND(Opciones.momontomon2,0)) AS [Notional Amount (Part position)]
			 ,(SELECT TOP 1 m.mnnemo FROM BacParamSuda.dbo.MONEDA m WHERE m.mncodmon = Opciones.MoMdaCompensacion) AS [Settlement Reference Currency]	-->VALIDAR
			 ,'USD' AS [Underlying asset]	-->VALIDAR
			 ,CONVERT(varchar,Opciones.MoFechaContrato,3) AS [Trade Date]	-->DEFINIR configuración regional
			 ,CONVERT(varchar,Opciones.MoFechaInicioOpc,3) AS [Effective Date]	
			 ,CONVERT(varchar,Opciones.MoFechaVcto,3) AS [Settlement Date]	-->VALIDAR podría ser vencimiento o pago 
			 ,'' AS [Quantity of contracts] -->VALIDAR --Revisar caso de estructuras.
			 ,Opciones.MoStrike AS [Strike Price]	
			 ,'' AS [Contract reference Month] -->VALIDAR Es sobre el Trade Date o sobre el Effective Date?
			 ,'' AS [Contract reference Year]	
			 ,'N.A.' AS [Barrier]
			 ,CONCAT(CONVERT(varchar,ROUND(CONVERT(numeric(36,2),Opciones.MoPrimaInicialML)/CONVERT(numeric(36,2),Opciones.MoMontoMon1),2)),'%') AS [Premium Payment Rate]	-->VALIDAR es un string o %? --Jacques: Quociente del Nocional/Prima. No me cuadra. OJO división por 0.
			 ,ROUND(CONVERT(numeric(36,2),Opciones.MoPrimaInicialML),2) AS [Premium Amount]	-->VALIDAR Es la Prima? En qué moneda?
			 ,dbo.Fx_Convalida_Tipos(4,1,1,UPPER(Opciones.MoTipoEjercicio),1) AS [Currency Option Style]	
			 ,'BCCH' AS [Rate Source]	
			 ,ISNULL(CASE WHEN Opciones.PayOffTipDsc = 'Asiaticas' THEN 'Asian' ELSE 'D-1' END,'D-1') AS [Fixing Date]	--Fixing de? Caso asiáticas
			 ,Reportes.dbo.Fx_Convalida_Tipos(5,1,1,Opciones.PayOffTipDsc,1) AS [Settlement Rate Type]	-->VALIDAR
			 ,'CHILE' AS [Country Origin]	-->VALIDAR CHILE??
			 ,'' AS [Registration]	--Dice "For  OTC Trade, keep this field in blank."
			 ,case when (select top 1 tipo_contrato from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')) = 'ISDA'
			 then 'ISDA' else 'CGD' end AS [Derivative Master Agreement]	
			 ,'' AS [Addicional information]			 
			 ,ISNULL(dbo.Fx_DCE_contract('TR-' + CONVERT(varchar(50),Opciones.MoNumContrato),'OPT'),'') AS [DCE Contract]	
			 ,case when isnull((select top 1 cliente_usa from dbo.TBL_CONTRATOUSD_PASO where rut_cliente like concat(convert(varchar(20),clie.clrut),'%')),0) = 0 
			  then 'No' else 'Yes' end AS [US Person]	
			 ,'Yes' AS [OTC]	-->VALIDAR
			 ,'No' AS [Dealing Activity]	-->VALIDAR y DEFINIR
			 ,'No' AS [IntraGroup]	--VALIDAR y DEFINIR
			 ,CASE WHEN dbo.Fx_Convalida_Tipos(2,1,1,Opciones.MoTipoTransaccion,0) = 'E' THEN 'Yes' ELSE 'No' END  AS [Unwind]	
			 ,'No' AS [Trade Done In Brazil]	--Dice "Do not fill in (Default Filling - No)"
			 --,CONVERT(numeric(36,2),ROUND(Opciones.MoMontoMon1,2)) AS [USD Notional] 
			 ,convert(numeric(36,2),round(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha,13,Opciones.MoMontoMon1,13),2)) AS [USD Notional]
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

			 inner join (SELECT  CaNumContrato = Grp.CaNumContrato
							 ,CaNumFolio	  = max(Grp.CaNumFolio) 
					   FROM CbMdbOpc.dbo.CaEncContrato Grp WITH(NOLOCK)
					   WHERE Grp.CaEstado NOT IN ('C','P')
					   GROUP BY Grp.CaNumContrato
								)   Grp          On     Grp.CaNumContrato   =       Opciones.monumcontrato
												and      Grp.CaNumFolio             =       Opciones.monumfolio

			 left  join (      select OpcEstCod,   OpcEstDsc
								    from CbMdbOpc.dbo.OpcionEstructura     with(nolock)
								)   Estr   ON Estr.OpcEstCod          =      Opciones.mocodestructura

			 inner join (      select clrut = clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), Clpais 
								    from BacParamSuda.dbo.cliente   with(nolock)
								)   Clie   On     Clie.clrut                 =       Opciones.MoRutCliente
												and Clie.clcodigo             =       Opciones.MoCodigo

			 WHERE Opciones.motipotransaccion NOT IN ('ANULA','ANTICIPA')
			 AND Opciones.mocodestructura	    NOT IN (8,13)

               -- SELECT distinct OPT.Type, OPT.[Contract Update Reason], OPT.[Part Account], OPT.[Part Position], OPT.[Part Code], OPT.[Part CPF/CNPJ], OPT.Part, OPT.[Counterpart Indentified], OPT.[Counterpart Position]
			   -- , OPT.[Counterpart Code], OPT.[Counterpart CPF/CNPJ], OPT.Counterpart, OPT.[Derivative Type], OPT.[Trading Place], OPT.[Contract Number], OPT.[Currency Option Type], OPT.[Option], OPT.[Asset Option]
			   -- , OPT.[Notional Amount Reference Currency], OPT.[Notional Amount (Part position)], OPT.[Settlement Reference Currency], OPT.[Underlying asset], OPT.[Trade Date], OPT.[Effective Date], OPT.[Settlement Date]
			   -- , OPT.[Quantity of contracts], OPT.[Strike Price], OPT.[Contract reference Month], OPT.[Contract reference Year], OPT.Barrier, OPT.[Premium Payment Rate], OPT.[Premium Amount], OPT.[Currency Option Style]
			   -- , OPT.[Rate Source], OPT.[Fixing Date], OPT.[Settlement Rate Type], OPT.[Country Origin], OPT.Registration, OPT.[Derivative Master Agreement], OPT.[Addicional information], OPT.[DCE Contract], OPT.[US Person]
			   -- , OPT.OTC, OPT.[Dealing Activity], OPT.IntraGroup, OPT.Unwind, OPT.[Trade Done In Brazil], OPT.[USD Notional] FROM #RESULTADOS_OPT OPT ORDER BY OPT.[Contract Number] DESC  
			 
			SELECT DISTINCT *
			FROM #RESULTADOS_OPT OPT
            WHERE convert(datetime,OPT.[Trade Date],3) <= '20160331'
			--WHERE convert(datetime,OPT.[Trade Date],3) > '20160331' 
            ORDER BY OPT.[Contract Number] DESC

	   --END
    
END


GO
