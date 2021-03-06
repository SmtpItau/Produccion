USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZCAP9ANEXO3]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZCAP9ANEXO3]
       (
	@mes		FLOAT		,
	@Año		FLOAT		/*,
	@RutApod	FLOAT*/
	)
AS
BEGIN

	SET NOCOUNT ON


-- 3184     8648


/*
DECLARE     @mes		FLOAT		,
			@Año		FLOAT		,
			@RutApod	FLOAT

SELECT 
            @mes	   = 04
		,	@Año	   = 2013
	    ,	@RutApod   = 8346589
*/

-- SP_INTERFAZCAP9ANEXO3 12,2012

	DECLARE @NombreBanco	CHAR	(50)	,
		@Apoderado1	CHAR	(50)	,
		@Apoderado2	CHAR	(50)	,
		@RutBco		NUMERIC	(10)	,
		@DigBco		CHAR	(15)	,
		@Telef1		CHAR	(15)	,
		@Telef2		CHAR	(15)	,
		@Cargo1		CHAR	(30)	,
		@Cargo2		CHAR	(30)	,
		@CodSectorEc	NUMERIC	(20)	,
		@cuenta		NUMERIC	(20)	,
		@Fecha		CHAR	(08)    , --DATEtime    	,
		@FechaANT	CHAR	(08)	,
		@email		CHAR	(50)	,
		@direcc		CHAR	(50)	,
		@espacios	CHAR	(10)    ,
        @nTotEnc    NUMERIC(6,0)    ,
        @nTotDet    NUMERIC(6,0)


	SELECT  
		@NombreBanco	= isnull (RTRIM(m.clnombre), ' ') ,  
       	@RutBco		= s.rut		  			,
		@DigBco	 	= m.Cldv    				,
		@CodSectorEc 	= 81   					,
		@Fecha		= CONVERT(CHAR(08), fechaproc, 112)	, 
		@FechaANT	= CONVERT(CHAR(08), fechaproc, 112)	,
		@direcc			= ISNULL(RTRIM(Cldirecc),'') + ' / SANTIAGO'  
	FROM view_cliente 	m,
		 swapgeneral 	s 
	WHERE m.clcodigo 	= convert(numeric(10) ,s.codigobanco)	AND
		  m.clrut    	= s.rut


	SELECT  @FechaANT	= SUBSTRING(@FechaANT ,1,6) + '01'  

/*
	SELECT 	@Apoderado1	= RTRIM( apnombre ),
		@Telef1		= RTRIM( apfono   ),
		@Cargo1		= RTRIM( apcargo  ),
		@email		= RTRIM( apemail  )
	FROM 	view_cliente_apoderado	,
       		swapgeneral
	WHERE 	aprutcli = rut
		AND apcodcli = codigobanco
		AND aprutapo = @RutApod
	
	SELECT  @Apoderado1 = ISNULL ( @Apoderado1  , ' ') ,  
		@Telef1			= ISNULL ( @Telef1 , ' ') ,  
		@Cargo1			= ISNULL ( @Cargo1 , ' ') ,  
		@email			= ISNULL ( @email , ' ')  
*/



/*

 Bloque siguiente es temporal,  ya que se deben agregar campos Codigo_BCCH, Glosa_BCCH a  
 tabla BacParamSuda.dbo.TASAS_MONEDA  y además  modificar Mantenedor  de Tasas por Moneda, 
 agregando  2 cajas  de texto  para ingresar estos  datos.

*/    


   SELECT  Codigo_Moneda
         , Codigo_Tasa
         , Codigo_BCCH = CONVERT(NUMERIC(5),0) 
         , Glosa_BCCH  = CONVERT(VARCHAR(50),'')            
   INTO  #TASAS_MONEDA
   FROM  BacParamSuda.dbo.TASAS_MONEDA

UPDATE #TASAS_MONEDA  
SET Codigo_BCCH = CASE WHEN Codigo_Moneda = 13 AND Codigo_Tasa = 6   THEN 4520
					   WHEN Codigo_Moneda = 13 AND Codigo_Tasa = 7   THEN 4540	
					   WHEN	Codigo_Moneda = 13 AND Codigo_Tasa = 14  THEN 4550
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 13 THEN 4870
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 8  THEN 4890
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 9  THEN 4890
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 10 THEN 4890
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 15 THEN 4890
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 13 THEN 4860
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 8  THEN 4880
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 9  THEN 4880
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 10 THEN 4880
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 15 THEN 4880
                   ELSE 0 END    
 ,  Glosa_BCCH  = CASE WHEN Codigo_Moneda = 13  AND Codigo_Tasa = 6  THEN 'LIBOR USD 90 DIAS'
					   WHEN Codigo_Moneda = 13  AND Codigo_Tasa = 7  THEN 'LIBOR USD 180 DIAS'
					   WHEN Codigo_Moneda = 13  AND Codigo_Tasa = 14 THEN 'LIBOR USD 12 MESES'
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 13 THEN 'TASA REAL ANUAL'
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 8  THEN 'TAB REAL ANUAL'
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 9  THEN 'TAB REAL ANUAL'
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 10 THEN 'TAB REAL ANUAL'
                       WHEN Codigo_Moneda = 998 AND Codigo_Tasa = 15 THEN 'TAB REAL ANUAL'
                       WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 13 THEN 'TASA NOMINAL ANUAL'
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 8  THEN 'TAB NOMINAL ANUAL'
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 9  THEN 'TAB NOMINAL ANUAL'
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 10 THEN 'TAB NOMINAL ANUAL'
					   WHEN Codigo_Moneda = 999 AND Codigo_Tasa = 15 THEN 'TAB NOMINAL ANUAL'
                   ELSE '' END     


 /*Termino Bloque  temporal */


    SELECT	DISTINCT
            Numero_Operacion 						, 
			Codigo_Cliente							, 							 		
			Tipo_operacion 							, 	
			Fecha_Cierre							,
            Fecha_inicio							,
			Fecha_termino			
    INTO  #MovHist
	FROM MovHistorico 		
	WHERE DATEPART(month ,Fecha_cierre) =  @Mes 	AND
		  DATEPART(year ,Fecha_cierre) 	=  @Año 	AND
          Tipo_Swap     in (1,4)					AND		 		
		  tipo_flujo 					=  2		 AND         
          estado						<> 'C' 
        
		

   -- Registro Encabezado

	SELECT DISTINCT
		'Numero_Operacion' 	= cc.Numero_Operacion 							, 
		'numeroOP'   		= CC.Numero_Operacion							,
		'Codigo_Cliente'	= cc.Codigo_Cliente							, 
		'Nombrecli'	    	= ISNULL(clnombre,'*')							, 
		'codigoPais'		= convert(Numeric(05) , clpais ) 					,
		'nombrepais'		= nombre 								,
		'Tipo_operacion'	= cc.Tipo_operacion 							, 
		'Instrumento'		= (CASE CC.Tipo_Swap WHEN 1  THEN 'IRS'				     
							     ELSE 'SPC' END)				, 
	    'Cod_Tasa_Pag'      = cc.venta_codigo_tasa , 
        'Cod_Tasa_Rec'      = 0 , 
		'TasaPagada' 		= (CASE venta_codigo_tasa WHEN 0 THEN 'F' ELSE 'V' END)	,		
		'TasaRecibimos'		= '' , 
        'Spread_Pag'        = cc.venta_Spread , 
        'Spread_Rec'        = CONVERT(NUMERIC(10,6),0.0)				, 
		'FechaCierre'   	= CONVERT(CHAR(8), cc.Fecha_Cierre,112)		,
		'FechaInicio'		= CONVERT(CHAR(8), cc.Fecha_inicio,112)   	,
		'Fechatermino'   	= CONVERT(CHAR(8), cc.Fecha_termino,112)	,
        'FechaEfectiva'   	= CONVERT(CHAR(8), cc.FechaEfectiva,112)	,
		'MonedaOperacion'	= cc.venta_moneda   							, 
        'NombreMoneda'		=ISNULL((SELECT mnnemo FROM view_moneda WHERE  mncodmon = cc.venta_moneda) , '*'),
        'Periodo'		    = 0 , -- cc.numero_flujo 								,
		'fechainicioflujo'	= CONVERT(CHAR(8), cc.Fecha_inicio_flujo,112)   ,
		'fechavenceflujo'	= CONVERT(CHAR(8), cc.Fecha_vence_flujo,112)   	,
		'dias'			    = Datediff(dd,cc.Fecha_inicio_flujo , cc.Fecha_vence_flujo ) 		,
       	'MontoOperacion' 	= cc.venta_capital  							,		
        'Saldo'             = cc.venta_saldo + cc.venta_Amortiza	,
		'TasaFija'		    = (CASE cc.venta_codigo_tasa WHEN 0 
								  THEN (cc.venta_valor_tasa)  	
								   ELSE 0 					
					   END), 
		'GlosaBaseFija'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN Glosa 				    	
								   ELSE '            ' 			
					   END),         
		'BaseFija'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN Base 				    	
								   ELSE ' '
					   END), 

		'TasaVariable'	= CASE WHEN cc.venta_codigo_tasa <> 0 	THEN  cc.venta_codigo_tasa  ELSE cc.compra_codigo_tasa END,                     
		'GlosaBaseVariable'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN '            '  				
								   ELSE Glosa  				
					  END),		
        'BaseVariable'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN ' '
								   ELSE Base  				
					  END),		
		'FlujoCompra'		= cc.numero_flujo								,						
		'FlujoVenta'		= 0									,
		'SectorEconCli'		= clactivida								,	 
		'rutcli'		= cc.rut_cliente								, 
		'digcli'		= ISNULL(cldv ,'*')							,
		'banco'			= ISNULL(@NombreBanco ,'*') 						,
		'FechaEnvio'	= @Fecha 								,
		'FlagTipoReg'	= 'O'									,
		'FVC'			= cc.Fecha_vence_flujo						,
		'tipoflujo'		= cc.tipo_flujo								,
        'Estado_Flujo'  = cc.estado_flujo							,
        'CodigoBCCH'	= 0											,	
        'Cod_Tasa_Variale' = CASE WHEN cc.venta_codigo_tasa  = 0  THEN cc.compra_codigo_tasa ELSE cc.venta_codigo_tasa END ,
        'Val_Tasa_Fija' =  CASE WHEN cc.venta_codigo_tasa = 0 	THEN   cc.venta_valor_tasa   ELSE cc.compra_valor_tasa END									         
           
	INTO 	#ENC	
	FROM 	CARTERARES CC	    RIGHT JOIN #MovHist AA  ON CC.Fecha_Proceso = AA.Fecha_cierre AND CC.Numero_Operacion = AA.Numero_Operacion 	,
	        view_cliente	    LEFT JOIN view_pais ON clpais = codigo_pais 	,
	      	base
	WHERE (clcodigo 			= cc.codigo_cliente	AND
		 clrut				    = cc.rut_cliente)	AND
         cc.tipo_flujo 		    = 2				    AND
         cc.estado_flujo        = 1                 AND 
   		 Codigo 				= venta_base



  UPDATE 	#ENC 
	SET	TasaRecibimos 	  	= (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) , 	 	
        Cod_Tasa_Rec        =  CC.compra_codigo_tasa , 
        Spread_Rec          = CC.compra_spread , 
		GlosaBaseVariable	= (CASE CC.compra_codigo_tasa WHEN 0 THEN GlosaBaseVariable  			ELSE glosa 				END),		
        BaseVariable	    = (CASE CC.compra_codigo_tasa WHEN 0 THEN BaseVariable ELSE Base END),	
 	 	TasaFija		    = (CASE CC.compra_codigo_tasa WHEN 0 THEN CC.compra_valor_tasa 	ELSE TasaFija   END), 
		GlosaBaseFija		= (CASE CC.compra_codigo_tasa WHEN 0 THEN glosa  ELSE BaseFija	END),		
        BaseFija		    = (CASE CC.compra_codigo_tasa WHEN 0 THEN Base ELSE BaseFija	END),		        
		FlujoVenta		    =  CC.numero_flujo   ,
        CodigoBCCH          = CASE WHEN TasaPagada = 'V' and (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) = 'V' THEN 4900 
                               ELSE ISNULL((	SELECT Codigo_BCCH
								FROM 	#TASAS_MONEDA 
								WHERE 	Codigo_Moneda = MonedaOperacion  AND
									    Codigo_Tasa = TasaVariable),0 ) 
                               END   ,
        Cod_Tasa_Variale  = CASE WHEN (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) = 'V' THEN CC.compra_codigo_tasa  ELSE Cod_Tasa_Variale END ,
		Val_Tasa_Fija     = CASE WHEN (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) = 'F' THEN cc.compra_valor_tasa ELSE Val_Tasa_Fija END 

	FROM  CARTERARES CC ,
          base	    
    WHERE CC.Numero_Operacion = #ENC.Numero_Operacion 
     AND  #ENC.FechaCierre    = CC.Fecha_Proceso
     AND  CC.tipo_flujo 			=  1	
     AND  Codigo 				= compra_base

     UPDATE #ENC 
     SET CodigoBCCH  = CASE WHEN TasaRecibimos = 'V'  AND TasaPagada = 'V' THEN 4900  ELSE Codigo_BCCH END
     FROM #TASAS_MONEDA 
     WHERE 	Codigo_Moneda = MonedaOperacion  AND
		    Codigo_Tasa = Cod_Tasa_Variale

    
     SELECT @nTotEnc = COUNT(*)
     FROM  #ENC   
    
   
	-- Detalle Registros Pagamos
   
	SELECT DISTINCT
		'Numero_Operacion' 	= cc.Numero_Operacion							, 
		'numeroOP'		    = CC.Numero_Operacion							, 
		'Codigo_Cliente'	= cc.Codigo_Cliente							, 
		'Nombrecli'		= ISNULL(clnombre,'*')							, 
		'codigoPais'		= convert(Numeric(05) , clpais ) 					,
		'nombrepais'		= nombre 								,
		'Tipo_operacion'	= cc.Tipo_operacion 							, 
		'Instrumento'		= (CASE CC.Tipo_Swap WHEN 1  THEN 'IRS'				     
							     ELSE 'SPC' END)				,   	 
		'Cod_Tasa_Pag'      = cc.venta_codigo_tasa	,
        'Cod_Tasa_Rec'      =  0  ,  	
		'TasaPagada' 		= (CASE venta_codigo_tasa WHEN 0 THEN 'F' ELSE 'V' END)	,		
		'TasaRecibimos'		= ''  , 
        'Spread_Pag'        = cc.venta_spread							, 
        'Spread_Rec'        = CONVERT(NUMERIC(10,6),0.0)				, 
        'FechaCierre'   	= CONVERT(CHAR(8), cc.Fecha_Cierre,112)		,
		'FechaInicio'		= CONVERT(CHAR(8), cc.Fecha_inicio,112)   	,
		'Fechatermino'   	= CONVERT(CHAR(8), cc.Fecha_termino,112)	,
        'FechaEfectiva'   	= CONVERT(CHAR(8), cc.FechaEfectiva,112)	,
		'MonedaOperacion'	= cc.venta_moneda   							, 
        'NombreMoneda'		=ISNULL((SELECT mnnemo FROM view_moneda WHERE  mncodmon = cc.venta_moneda) , '*'),
        'Periodo'		    = cc.numero_flujo 								,
		'fechainicioflujo'	= CONVERT(CHAR(8), cc.Fecha_inicio_flujo,112)   ,
		'fechavenceflujo'	= CONVERT(CHAR(8), cc.Fecha_vence_flujo,112)   	,
		'dias'			    = Datediff(dd,cc.Fecha_inicio_flujo , cc.Fecha_vence_flujo ) 		,
       	'MontoOperacion' 	= cc.venta_capital  					,	
        'Saldo'             = cc.venta_saldo + cc.venta_Amortiza    ,
		'TasaFija'		    = (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN (cc.venta_valor_tasa)  	
								   ELSE 0 					
					   END), 
		'GlosaBaseFija'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN Glosa 				    	
								   ELSE '            ' 			
					   END), 
		'BaseFija'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN Base 				    	
								   ELSE ' '
					   END), 
        
		'TasaVariable'	= (CASE venta_codigo_tasa WHEN 0 THEN 0 ELSE cc.venta_codigo_tasa END) ,
		'GlosaBaseVariable'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN '            '  				
								   ELSE Glosa  				
					  END),		
        'BaseVariable'		= (CASE cc.venta_codigo_tasa WHEN 0 
								   THEN ' '
								   ELSE Base
					  END),		
		'FlujoCompra'		= cc.numero_flujo								,						
		'FlujoVenta'		= 0									,
		'SectorEconCli'		= clactivida								,	 
		'rutcli'		= cc.rut_cliente								, 
		'digcli'		= ISNULL(cldv ,'*')							,
		'banco'			= ISNULL(@NombreBanco ,'*') 						,
		'FechaEnvio'	= @Fecha 								,
		'FlagTipoReg'	= 'C'									,
		'FVC'			= cc.Fecha_vence_flujo						,
		'tipoflujo'		= cc.tipo_flujo								,
        'Estado_Flujo'  = cc.estado_flujo							,
        'CodigoBCCH'	= 0											,											         
        'Cod_Tasa_Variale' = CASE WHEN cc.venta_codigo_tasa  = 0  THEN cc.compra_codigo_tasa ELSE cc.venta_codigo_tasa END ,
        'Val_Tasa_Fija' =  CASE WHEN cc.venta_codigo_tasa = 0 	THEN   cc.venta_valor_tasa   ELSE cc.compra_valor_tasa END 
    INTO 	#DET	
	FROM 	CARTERARES CC	    RIGHT JOIN #MovHist AA  ON CC.Fecha_Proceso = AA.Fecha_cierre AND CC.Numero_Operacion = AA.Numero_Operacion 	,
	        view_cliente	    LEFT JOIN view_pais ON clpais = codigo_pais 	,
	      	base
	WHERE (clcodigo 			= cc.codigo_cliente	AND
		 clrut				    = cc.rut_cliente)	AND
         cc.tipo_flujo 		    = 2				    AND         
   		 Codigo 				= venta_base		AND 
         cc.Fecha_inicio_flujo  <>  cc.Fecha_vence_flujo


--    select  '#DET_1',*  from  #DET  where Numero_Operacion = 4523 -- 3846  -- OK  -- 5822 OK -- 4712 OK

	UPDATE 	#DET 
	SET	TasaRecibimos 		= (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) ,  	
        Cod_Tasa_Rec    =  CC.compra_codigo_tasa  , 
        Spread_Rec       = CC.compra_spread		 , 
		GlosaBaseVariable	= (CASE CC.compra_codigo_tasa WHEN 0 THEN GlosaBaseVariable ELSE glosa  END),		
        BaseVariable	= (CASE CC.compra_codigo_tasa WHEN 0 THEN BaseVariable ELSE Base END),		
 	 	TasaFija		= (CASE CC.compra_codigo_tasa WHEN 0 THEN CC.compra_valor_tasa ELSE TasaFija   END), 
		GlosaBaseFija	= (CASE CC.compra_codigo_tasa WHEN 0 THEN glosa ELSE GlosaBaseFija	END),		
        BaseFija		= (CASE CC.compra_codigo_tasa WHEN 0 THEN Base ELSE BaseFija	END),		        
		FlujoVenta		=  CC.numero_flujo  ,
        CodigoBCCH     = CASE WHEN TasaPagada = 'V' and (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) = 'V' THEN 4900 
                               ELSE ISNULL((	SELECT 	 Codigo_BCCH
								FROM 	#TASAS_MONEDA 
								WHERE 	Codigo_Moneda = MonedaOperacion  AND
									    Codigo_Tasa = TasaVariable),0 ) 
                          END   ,
        Cod_Tasa_Variale  = CASE WHEN (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) = 'V' THEN CC.compra_codigo_tasa  ELSE Cod_Tasa_Variale END ,
		Val_Tasa_Fija     = CASE WHEN (CASE CC.compra_codigo_tasa WHEN 0 THEN 'F'  ELSE 'V' END) = 'F' THEN cc.compra_valor_tasa ELSE Val_Tasa_Fija END    
  	FROM  CARTERARES CC ,
          base	    
    WHERE CC.Numero_Operacion = #DET.Numero_Operacion 
     AND  #DET.FechaCierre    = CC.Fecha_Proceso
     AND  CC.tipo_flujo 	  =  1	 
     AND  Codigo 				= compra_base


     UPDATE #DET 
     SET CodigoBCCH  = CASE WHEN TasaRecibimos = 'V'  AND TasaPagada = 'V' THEN 4900  ELSE Codigo_BCCH END
     FROM #TASAS_MONEDA 
     WHERE 	Codigo_Moneda = MonedaOperacion  AND
		    Codigo_Tasa = Cod_Tasa_Variale




     SELECT Numero_Operacion, cnt = count(1)  
     INTO  #CANT_COMPENSA
     FROM  #DET  
     WHERE FlagTipoReg = 'C'
     GROUP BY Numero_Operacion  

    
      


---   SELECT '#DET_222',*  FROM  #DET  where Numero_Operacion =  4523 -- 3846  -- OK  -- 5822 OK -- 4712 OK


SELECT 'Tot_Reg_Ope'    = @nTotEnc     
      ,'Tot_Reg_Comp'   = B.cnt  
      ,'Rut_Bco'        = @RutBco
      ,'Dig_Bco'        = @DigBco
      ,'Fecha'          = @Fecha      
      ,'Rut_Cli'        = A.rutcli
      ,'Rut_Dig_Cli'    = A.digcli
      ,'Instrumento'    = 'SWAP' --Instrumento
      ,'Num_Contrato'   = A.Numero_Operacion
      ,'Periodo'		= A.Periodo
      ,'Tasa_Int_Paga'  = A.TasaPagada   
      ,'Tasa_Int_Reci'  = A.TasaRecibimos   
      ,'Fecha_Suscrip'  = A.FechaCierre 
      ,'Fecha_Efect'    = CASE WHEN A.FechaEfectiva < A.FechaCierre THEN A.FechaCierre  ELSE A.FechaEfectiva  END --A.FechaEfectiva
      ,'Fecha_Term'     = A.Fechatermino
      ,'Codigo_Mda_Ope' = A.MonedaOperacion
      ,'Observaciones'  = (SELECT tbglosa FROM BacParamSuda.dbo.Tabla_General_Detalle WHERE A.Cod_Tasa_Variale = tbcodigo1 AND tbcateg = 1042)  
      ,'Fecha_Desde'    = CASE WHEN A.fechainicioflujo < A.FechaCierre THEN A.FechaCierre  ELSE A.fechainicioflujo  END  --A.fechainicioflujo
      ,'Fecha_Hasta'    = A.fechavenceflujo
      ,'MontoSaldo'     = A.Saldo
      ,'TasaFija_1'     = A.TasaFija
      ,'TasaFija_2'     = 0.0
      ,'BaseTasaFija'   = A.BaseFija
      ,'Cod_Tas_Int_Var' = A.CodigoBCCH
      ,'Spread'          = CASE WHEN A.Spread_Pag = 0.0 THEN A.Spread_Rec ELSE A.Spread_Pag END
      ,'BaseTasaVariable' = A.BaseVariable
      ,'Prima'            = 0.0
      ,'Flag'			  = A.FlagTipoReg
INTO  #RESULTADO  
FROM  #DET				A		
     ,#CANT_COMPENSA    B
WHERE A.Numero_Operacion = B.Numero_Operacion
-- AND   A.Numero_Operacion =  4523 -- 3846  -- OK  -- 5822 OK -- 4712 OK




INSERT INTO #RESULTADO  
SELECT 'Tot_Reg_Ope'    = @nTotEnc     
      ,'Tot_Reg_Comp'   = B.cnt    
      ,'Rut_Bco'        = @RutBco
      ,'Dig_Bco'        = @DigBco
      ,'Fecha'          = @Fecha
      ,'Rut_Cli'        = A.rutcli
      ,'Rut_Dig_Cli'    = A.digcli
      ,'Instrumento'    = 'SWAP' --Instrumento
      ,'Num_Contrato'   = A.Numero_Operacion
      ,'Periodo'		= A.Periodo
      ,'Tasa_Int_Paga'  = A.TasaPagada   
      ,'Tasa_Int_Reci'  = A.TasaRecibimos   
      ,'Fecha_Suscrip'  = A.FechaCierre 
      ,'Fecha_Efect'    = CASE WHEN A.FechaEfectiva < A.FechaCierre THEN A.FechaCierre  ELSE A.FechaEfectiva  END -- A.FechaEfectiva
      ,'Fecha_Term'     = A.Fechatermino
      ,'Codigo_Mda_Ope' = A.MonedaOperacion
      ,'Observaciones'  = (SELECT tbglosa FROM BacParamSuda.dbo.Tabla_General_Detalle WHERE A.Cod_Tasa_Variale = tbcodigo1 AND tbcateg = 1042)  
      ,'Fecha_Desde'    = CASE WHEN A.FechaEfectiva < A.FechaCierre THEN A.FechaCierre  ELSE A.fechainicioflujo  END  -- A.fechainicioflujo
      ,'Fecha_Hasta'    = A.fechavenceflujo
      ,'MontoSaldo'     = A.Saldo
      ,'TasaFija_1'     = A.TasaFija
      ,'TasaFija_2'     = 0.0
      ,'BaseTasaFija'   = A.BaseFija
      ,'Cod_Tas_Int_Var' = A.CodigoBCCH
      ,'Spread'          = CASE WHEN A.Spread_Pag = 0.0 THEN A.Spread_Rec ELSE A.Spread_Pag END
      ,'BaseTasaVariable' = A.BaseVariable
      ,'Prima'            = 0.0
      ,'Flag'			  = A.FlagTipoReg
FROM  #ENC				A		
     ,#CANT_COMPENSA    B
WHERE A.Numero_Operacion = B.Numero_Operacion
-- AND   A.Numero_Operacion =  4523 -- 3846  -- OK  -- 5822 OK -- 4712 OK

 select * from #RESULTADO    order by Num_Contrato,Periodo  --- where Numero_Operacion = 5822


/*
DROP TABLE #ENC
DROP TABLE #DET
DROP TABLE #MovHist
DROP TABLE #RESULTADO
DROP TABLE #TASAS_MONEDA
DROP TABLE #CANT_COMPENSA
*/



	SET NOCOUNT OFF
	RETURN 0

END
GO
