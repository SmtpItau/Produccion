USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_INTERFAZ_ART84_NEW]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_FUSION_INTERFAZ_ART84_NEW '20191115','1115','S'
CREATE PROCEDURE [dbo].[SP_FUSION_INTERFAZ_ART84_NEW]
	(	@fecCont		DATETIME
	,	@MesDia			varchar(4)
	,	@Formateada		VARCHAR(1) = 'S'
)
AS
BEGIN	

 	SET NOCOUNT ON

    CREATE TABLE #INT_SALIDA 
	(
          LINEA        CHAR(200)  -- El largo definitivo y el formato será manejado por el SP
   ,      CANTIDAD     Numeric(10)
   ,      Moneda       Numeric(5)
   ,      Rut_Cliente  Numeric(13)
   ,      Codigo_Cliente Numeric(5)
   ,      ORDEN        int IDENTITY(1,1)
    )

DECLARE @fecha_sal    DATETIME 
	,	@DolarObsFMes NUMERIC(19,4)
	,	@PrimerDiaMes DATETIME
	,	@fecproc      DATETIME    
	,	@OtraMonMes   NUMERIC(19,4)  
	,	@UFFMes       NUMERIC(19,4) 
	,	@Fec_Proc     DATETIME 
	,	@Moneda       NUMERIC (05)     
    ,	@Monto        NUMERIC (19,4) 
    ,	@Modulo       CHAR(03) 
    ,	@Rut_Cliente  CHAR(10)
    ,   @Numoper	  NUMERIC(10,0)
 
	SELECT @fecproc = acfecproc  
          FROM   MDAC  


	 CREATE  TABLE #CodigoAS400Mda ( MdaBAC Varchar(3), MdaNemo Varchar(3) /* Findur*/ ,  MdaAS Varchar(4) /*AS400*/ ) 

	 Insert into #CodigoAS400Mda
	 select MdaBac  = rtrim(mnnemo)
	      , MdaNemo = rtrim(mnnemo)
		  , MdaAS   = rtrim(mncodbkb)
	   from bacparamsuda.dbo.moneda Mda   -- select * from bacparamsuda.dbo.moneda Mda
	   where Mda.mnmx = 'C' or mncodmon in ( 999, 998 )

		 -- según la fecha
		 declare @QueryMargen_articulo varchar(100)
		 declare @tabla                varchar(21)


         select * into #margen_articulo84 from margen_articulo84 where 1 = 2
         select * into #MDCP from MDCP where 1 = 2
         select * into #MDVI from MDVI where 1 = 2
         select * into #MDCI from MDCI where 1 = 2

		 select @Tabla = 'margen_articulo84'	+ @MesDia 

		 select @QueryMargen_articulo = 'insert  #margen_articulo84 select * from  ' + @Tabla

		 exec( @QueryMargen_articulo )
         if @@error <> 0 
		 begin
			select LINEA = convert( CHAR(75) , 'NO HAY TABLA ddmm PARA INTERFAZ RF!!!!' )
           , Orden = 0  
		   goto FIN 
		 end
	
---MDCP
		 select @Tabla = 'MDCP'	+ @MesDia 

		 select @QueryMargen_articulo = 'insert  #MDCP select * from ' + @Tabla

		 exec( @QueryMargen_articulo )
         if @@error <> 0 
		 begin
			select LINEA = convert( CHAR(75) , 'NO HAY TABLA ddmm PARA INTERFAZ RF!!!!' )
           , Orden = 0  
		   goto FIN 
		 end
		
		 SELECT c.*
		 ,CASE WHEN cpseriado='N' THEN isnull((SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0) ELSE isnull((SELECT top 1 semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0) END  as moneda
		 ,CASE WHEN cpseriado='N' THEN isnull((SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0) ELSE (SELECT top 1 serutemi FROM VIEW_SERIE   WHERE semascara=cpmascara) END as rut_deudor
		 into #MDCP1 
		 FROM #MDCP c

---MDVI
		 select @Tabla = 'MDVI'	+ @MesDia 

		 select @QueryMargen_articulo = 'insert  #MDVI select * from  ' + @Tabla

		 exec( @QueryMargen_articulo )
         if @@error <> 0 
		 begin
			select LINEA = convert( CHAR(75) , 'NO HAY TABLA ddmm PARA INTERFAZ RF!!!!' )
           , Orden = 0  
		   goto FIN 
		 end

		 SELECT c.*
		 ,999  as moneda
		 ,CASE WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela) ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara) END AS rut_deudor
		 into #MDVI1 
		 FROM #MDVI c

---MDCI
		 select @Tabla = 'MDCI'	+ @MesDia 

		 select @QueryMargen_articulo = 'insert  #MDCI select * from  ' + @Tabla

		 exec( @QueryMargen_articulo )
         if @@error <> 0 
		 begin
			select LINEA = convert( CHAR(75) , 'NO HAY TABLA ddmm PARA INTERFAZ RF!!!!' )
           , Orden = 0  
		   goto FIN 
		 end

		 SELECT c.*
		 ,CASE WHEN ciinstser = 'ICOL' THEN cimonpact ELSE 999 END as moneda
		 ,cirutcli AS rut_deudor
		 into #MDCI1 
		 FROM #MDCI c


		CREATE TABLE #CLI_ITAU ( Rut_Cliente numeric(13), Codigo_Corp numeric(5), Codigo_AS400 Numeric(10) )	 		
			
		insert into #CLI_ITAU
		SELECT	Clrut
			,	Clcodigo
			,	Codigo_AS400 
		FROM	bacparamsuda.dbo.CLIENTE	
	
		-- Letras Hipotecarias Coprbanca
		DELETE FROM #margen_articulo84 WHERE Codigo = 20 AND RutDeudor = 97023000
	
		 -- Renta Fija MDCP
		 select convert(numeric(10),101 )	as [Numero_Cliente]
		 ,		isnull( MdaOri.MnNemo, 'ERR' ) as [Moneda_Origen]
		 ,		isnull( Prd.Codigo_Facility, 'ERR' ) as [Tipo_Facility]
		 ,		'CLP' as [Moneda_pesos]
		 ,		cpnominal as [Monto_Operacion_Moneda_Origen]
		 ,		cpvptirc as [Monto_Imputa_Art84]
		 ,		cpvptirc as [Monto_Imputacion_Interna]
		 ,		1 as [Numero_Secuencia]
		 ,		'BTR' as modulo           
		 ,		'CP   ' as Producto
		 ,		rut_deudor as rut_Cliente
		 ,      Moneda as moneda
		 ,		cpfecven as Fecha_Vencimiento
		 ,		CASE WHEN DATEDIFF (day,@fecCont,cpfecven) < 0 THEN 0 ELSE DATEDIFF (day,@fecCont,cpfecven) END  as Plazo_Residual
		 ,		@fecCont as Fec_proceso
		 ,		cpfeccomp as Fec_Inicio
		 ,		cpfecven as FechaVcto
		 ,		isnull(nNumeroIdd,0) as NumeroIdd
		 ,		cpcapitalc 		as capital
		 ,		cpinteresc		as interes
		 ,		cpreajustc		as reajuste
		 ,		ABS((cpcapitalc + cpinteresc + cpreajustc)- (cpvptirc)) AS DIFERENCIA
		 ,		(cpcapitalc + cpinteresc + cpreajustc) AS TOT
		 ,		cpnumdocu as nro_operacion
		 ,		cpnumdocu as nro_docu
		 ,		cpcorrela as Correlativo
		 ,		cprutcli  as rut_cliente1
		 ,		cpcodcli  as cod_cliente1
		  into #TMP001
	      from #MDCP1      
		  left join  BacParamSuda.dbo.moneda					mdaOri ON MdaOri.MncodMon			= moneda
		  left join  BacParamSuda.dbo.moneda					mdaLiq ON MdaLiq.MncodMon			= moneda
		  LEFT JOIN  BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY	Prd	   ON Prd.Id_sistema			= 'BTR'
																	  AND Prd.Codigo_Producto		= 'CP'
																	  AND Prd.Codigo_instrumento	= cpcodigo
		  left join baclineas.dbo.transacciones_idd	lin on cModulo='BTR' and nOperacion=cpnumdocu and nDocumento=cpnumdocuo and iCorrelativo=cpcorrela
		 where cpnominal   > 0 AND cprutcart > 0 


		 -- Renta Fija MDVI
		 insert into #TMP001
		 select convert(numeric(10),101 )	as [Numero_Cliente]
		 ,		isnull( MdaOri.MnNemo, 'ERR' ) as [Moneda_Origen]
		 ,		isnull( Prd.Codigo_Facility, 'ERR' ) as [Tipo_Facility]
		 ,		'CLP' as [Moneda_pesos]
		 ,		vinominal as [Monto_Operacion_Moneda_Origen]
		 ,		vivptirc as [Monto_Imputa_Art84]
		 ,		vivptirc as [Monto_Imputacion_Interna]
		 ,		1 as [Numero_Secuencia]
		 ,		'BTR' as modulo          
		 ,		'VI   ' as Producto
		 ,		rut_deudor as rut_Cliente
		 ,      Moneda as moneda
		 ,		vifecvenp as Fecha_Vencimiento
		 ,		CASE WHEN DATEDIFF (day,@fecCont,vifecvenp)< 0 THEN 0 ELSE DATEDIFF (day,@fecCont,vifecvenp) END  as Plazo_Residual
		 ,		@fecCont as Fec_proceso
		 ,		vifecinip as Fec_Inicio
		 ,		vifecvenp as FechaVcto
		 ,		isnull(nNumeroIdd,0) as NumeroIdd
		 ,		vicapitalv 		as capital
		 ,		viinteresv		as interes
		 ,		vireajustv		as reajuste
		 ,		ABS((vicapitalv + viinteresv + vireajustv)- (vivptirc)) AS DIFERENCIA
		 ,		(vicapitalv + viinteresv + vireajustv) AS TOT
		 ,		vinumoper as nro_operacion
		 ,		vinumdocu as nro_docu
		 ,		vicorrela as Correlativo
		 ,		virutcli  as rut_cliente1
		 ,		vicodcli  as cod_cliente1
	      from #MDVI1      
		  left join  BacParamSuda.dbo.moneda					mdaOri ON MdaOri.MncodMon			= moneda
		  left join  BacParamSuda.dbo.moneda					mdaLiq ON MdaLiq.MncodMon			= moneda
		  LEFT JOIN  BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY	Prd	   ON Prd.Id_sistema			= 'BTR'
																	  AND Prd.Codigo_Producto		= 'CP'
																	  AND Prd.Codigo_instrumento	= vicodigo
		  left join baclineas.dbo.transacciones_idd	lin on cModulo='BTR' and nOperacion=vinumoper and nDocumento=vinumdocu and iCorrelativo=vicorrela

		 -- Renta Fija MDCI
		 insert into #TMP001
		 select convert(numeric(10),101 )	as [Numero_Cliente]
		 ,		isnull( MdaOri.MnNemo, 'ERR' ) as [Moneda_Origen]
		 ,		isnull( Prd.Codigo_Facility, 'ERR' ) as [Tipo_Facility]
		 ,		'CLP' as [Moneda_pesos]
		 ,		cinominal as [Monto_Operacion_Moneda_Origen]
		 ,		civptirc as [Monto_Imputa_Art84]
		 ,		civptirc as [Monto_Imputacion_Interna]
		 ,		1 as [Numero_Secuencia]
		 ,		'BTR' as modulo          
		 ,		'CI   ' as Producto
		 ,		rut_deudor as rut_Cliente
		 ,      Moneda as moneda
		 ,		cifecvenp as Fecha_Vencimiento
		 ,		CASE WHEN DATEDIFF (day,@fecCont,cifecvenp)< 0 THEN 0 ELSE DATEDIFF (day,@fecCont,cifecvenp) END  as Plazo_Residual
		 ,		@fecCont as Fec_proceso
		 ,		cifecinip as Fec_Inicio
		 ,		cifecvenp as FechaVcto
		 ,		isnull(nNumeroIdd,0) as NumeroIdd
		 ,		cicapitalci 	as capital
		 ,		ciinteresci		as interes
		 ,		cireajustci		as reajuste
		 ,		ABS((cicapitalci + ciinteresci + cireajustci)- (civptirc)) AS DIFERENCIA
		 ,		(cicapitalci + ciinteresci + cireajustci) AS TOT
		 ,		cinumdocu as nro_operacion
		 ,		cinumdocu as nro_docu
		 ,		cicorrela as Correlativo
		 ,		cirutcli  as rut_cliente1
		 ,		cicodcli  as cod_cliente1
	      from #MDCI1      
		  left join  BacParamSuda.dbo.moneda					mdaOri ON MdaOri.MncodMon			= moneda
		  left join  BacParamSuda.dbo.moneda					mdaLiq ON MdaLiq.MncodMon			= moneda
		  LEFT JOIN  BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY	Prd	   ON Prd.Id_sistema			= 'BTR'
																	  AND Prd.Codigo_Producto		= 'CI'
																	  AND Prd.Codigo_instrumento	= 0
		  left join baclineas.dbo.transacciones_idd	lin on cModulo='BTR' and nOperacion=cinumdocu and nDocumento=cinumdocu and iCorrelativo=cicorrela
		  WHERE ciinstser <> 'ICAP'


		UPDATE #TMP001
		SET Numero_Cliente = cli.codigo_as400
		,	Numero_Secuencia= cli.Secuencia
		FROM  #TMP001 t		
		INNER JOIN  BacParamSuda..cliente cli ON  cli.Clrut = t.rut_Cliente


	    -- 690   se informa monto normativo 100% y corporativo 15% si son papeles centrales y 100% otros,  Monto Corporativo:
		-- Rut Banco Central
        DECLARE @rutBancoCentral AS NUMERIC(10,0)
		SET @rutBancoCentral = 97029000
		
		--> WHEN Tipo_Facility = 690 AND Rut_Cliente = @rutBancoCentral AND
		UPDATE #TMP001
			SET Monto_Imputacion_Interna=	CASE WHEN Producto = 'CI' THEN BacLineas.dbo.fxlineas_calcula_mitigacion( nro_operacion , Correlativo )
												 ELSE [Monto_Imputacion_Interna] END

		--Operaciones DE INVERSION FACILITY (670) EL VALOR ART 84 Y EL CORPORATIVO DEBE SER IGUAL  Y EN ALGUNOS CASOS NO SUCEDE ESTO ADJUNTO UNA  MUESTRA 
		UPDATE #TMP001
			SET Monto_Imputacion_Interna= CASE WHEN tipo_facility= 670 OR tipo_facility= 631 THEN Monto_Imputa_Art84 
										ELSE Monto_Imputacion_Interna END
										
		  update #TMP001
		      set [Monto_imputa_Art84]  = 0 
			,		capital				= 0
			,		interes				= 0
			,		reajuste			= 0
		  where rut_Cliente = 76317889 -- Comder no consume artículo 84.
		
          update #TMP001 
		        set [Numero_Cliente] = Cli.Codigo_AS400
		  from #Cli_ITAU Cli where #TMP001.Rut_Cliente = Cli.Rut_Cliente and [Numero_Secuencia] = Cli.Codigo_Corp

		   -- 630   solo informar monto corporativo, normativo en cero
		  UPDATE #TMP001
		  SET		Monto_Imputa_Art84	= 0
			,		capital				= 0
			,		interes				= 0
			,		reajuste			= 0
		  WHERE  Tipo_Facility		= 630


		insert into #INT_SALIDA
		select 
			right(replicate('0',07)+ convert(varchar(7),Numero_Cliente),7)
		+	convert(varchar(4),isnull(MdaOri.mncodbkb,'ERR'))
		+   right(replicate('0',03)+ convert(varchar(3),Tipo_Facility),3)
		+	convert(varchar(4),isnull(MdaLiq.mncodbkb,'ERR'))
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(Monto_Operacion_Moneda_Origen*100))),15)
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(Monto_Imputa_Art84*100))),15)
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(Monto_Imputacion_Interna*100))),15)
		+   right(replicate('0',07)+ convert(varchar(7),convert(numeric(7),(Numero_Secuencia))),7)
		+   right(replicate('0',05)+ convert(varchar(5),convert(numeric(5),(Plazo_Residual))),5)
--		+   right(replicate('0',10)+ convert(varchar(10),convert(numeric(10),(nro_operacion))),10)--FMO 20191217 se concate nro_ope + nro_docu + correlativo
		+   right(replicate('0',10)+convert(varchar(10),nro_operacion),10)+right(replicate('0',08)+convert(varchar(08),nro_docu),8)+right(replicate('0',02)+convert(varchar(02),Correlativo),2)
--		+   right(replicate('0',10)+ convert(varchar(10),convert(numeric(10),(NumeroIdd))),10) --FMO 20191217 se saca nro IDD
		+   right(replicate('0',08)+CONVERT(varchar(08),ISNULL(Fec_Inicio,Fec_proceso),112),08)
		+   right(replicate('0',08)+CONVERT(varchar(08),FechaVcto,112),08)
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(capital*100))),15)
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(TOT*100))),15)
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(interes*100))),15)
		+   right(replicate('0',15)+ convert(varchar(15),convert(numeric(15),(reajuste*100))),15)
		,0
		, moneda
		, rut_Cliente1
		, cod_cliente1
		from #TMP001
			left join BacParamSuda.dbo.moneda	MdaOri  ON MdaOri.mnnemo = Moneda_Origen
			left join BacParamSuda.dbo.moneda	MdaLiq  ON MdaLiq.mnnemo = Moneda_Pesos



	if exists( select (1) from #INT_SALIDA )
	   BEGIN
	       if @Formateada = 'S'
		   begin
              declare @Cnt_Registros numeric(10)
	          select  @Cnt_Registros = count(1) from #INT_SALIDA
	          update #INT_SALIDA set cantidad = @Cnt_Registros

	          if exists( select (1) from #INT_SALIDA where #INT_SALIDA.LINEA like '%ERR%' )
				  select Linea	
					  ,  Cnt	= @Cnt_Registros
					  ,  orden
					  ,  rut_Cliente
                  from #INT_SALIDA  
				  order by  ORDEN
		      else
		      begin
				 SELECT rtrim(LINEA)
		         FROM #INT_SALIDA   order by  #INT_SALIDA.ORDEN
              end     
           end
		   else
		     select * from #TMP001
		       
       END


	else

	 select  Linea = convert( CHAR(75) , 'NO HAY INFORMACION PARA INTERFAZ!!!!' )
           , cantidad = 0  , orden = 0

		
		 drop table #TMP001
		 drop table #Int_salida
		 drop table #CodigoAS400Mda
		 drop table #margen_articulo84
		 drop table #MDCP
		 drop table #MDCI
		 drop table #MDVI
		 drop table #CLI_ITAU
		 FIN:
END
GO
