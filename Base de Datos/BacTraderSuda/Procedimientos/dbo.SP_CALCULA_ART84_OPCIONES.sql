USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_ART84_OPCIONES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CALCULA_ART84_OPCIONES]
   (   @Fecha       DATETIME   
   ) 
-- Sp_Calcula_Art84_Opciones '20091228'
AS  
BEGIN
     
        -- JPF 20100108 Inicio especificacion
     	SET NOCOUNT ON

	-- Declara v	ariables
	DECLARE
    		@fecproOPT	DATETIME       
	-- Declara variables

	-- Define fecha de proceso
	SELECT @fecproOPT = fechaproc 
    	FROM LnkOpc.CbMdbOpc.dbo.OpcionesGeneral
	-- Define fecha de proceso

-->	Crea tabla con los valores de moneda para el día   
	CREATE TABLE #VALOR_TC_CONTABLE
	(		
		vmcodigo INTEGER NOT NULL DEFAULT(0), 
		vmvalor  FLOAT NOT NULL DEFAULT(0.0)
	)
	CREATE INDEX #ixt_VALOR_TC_CONTABLE ON #VALOR_TC_CONTABLE (vmcodigo)
-->	Crea tabla con los valores de moneda para el día   

-->	Inserta datos a la tabla de valores de moneda
-->	Inserta valor para el Peso
   	INSERT INTO #VALOR_TC_CONTABLE
	SELECT
		999
	,	1
-->	Inserta valor para el Peso

-->	Inserta valor para monedas Mx
	INSERT INTO #VALOR_TC_CONTABLE
	SELECT
		CASE
		WHEN codigo_moneda = 994 THEN
			13 
		ELSE 
			codigo_moneda 
		END
	,	tipo_cambio
   	FROM
		BacParamSuda.dbo.VALOR_MONEDA_CONTABLE
   	WHERE
		Fecha = @fecproOPT
	AND	Codigo_Moneda NOT IN(13,995,997,998,999)
	AND	Tipo_Cambio   <> 0.0

	-->	Control de error de que no esté cargada la tabla de paridades
	IF @@ROWCOUNT = 0 BEGIN
		RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
		SELECT '(RETURN -1)'
	END
	-->	Control de error de que no esté cargada la tabla de paridades
-->	Inserta valor para monedas Mx

-->	Inserta valor para UF
	INSERT INTO #VALOR_TC_CONTABLE
	SELECT
		vmcodigo
	,	vmvalor
	FROM	
		BacParamSuda.dbo.VALOR_MONEDA
	WHERE	
		vmfecha = @fecproOPT
	AND	vmcodigo IN(995,997,998,999)

	-->	Control de error de que no esté cargada la tabla de paridades
	IF @@ROWCOUNT = 0 BEGIN
		RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
		SELECT 'RETURN -1'
	END
	-->	Control de error de que no esté cargada la tabla de paridades
-->	Inserta valor para UF
-->	Inserta datos a la tabla de valores de moneda


    	-- Borra la tabla si es que existieron calculos anteriores
	IF EXISTS(SELECT 1 FROM ART84_DERIVADOS_OPCIONES WHERE Fecha_Proc = @Fecha OR (@fecproOPT = @Fecha AND Modulo ='OPT')) 
	BEGIN 
        	DELETE
			ART84_DERIVADOS_OPCIONES
		WHERE
			Fecha_Proc = @Fecha
    	END
    	-- Borra la tabla si es que existieron calculos anteriores

	-- Arma tabla con cartera de operaciones
   	SELECT  'Fec_Proc'              = @Fecha
     	,	'Numero_operacion' 	= A.CaNumContrato
        ,	'rut_cliente'      	= A.CaRutCliente
        , 	'codigo_cliente'   	= A.CaCodigo 
        , 	'Nocional'         	= MAX(B.CaMontoMon1)
	,	'Moneda_Nocional'	= B.CaCodMon1
        , 	'fecha_cierre'     	= A.CaFechaContrato
        , 	'Tir' 			= CONVERT(FLOAT,0.0)
        , 	'Producto' 	        = CONVERT(CHAR(05),B.CaSubyacente)
        , 	'Valor_Razonable'     	= ISNULL(CONVERT(FLOAT,A.CaVr),0.0)
        , 	'Moneda_Valor_Raz'    	= A.CaMon_vr
        , 	'fecha_termino'       	= B.CaFechaVcto
	,	'plazo'			= DATEDIFF(dd,@fecproOPT,B.CaFechaVcto)
	, 	'Fecha'               	= @fecproOPT
        , 	'Subyacente'          	= B.CaSubyacente
        , 	'Vinculacion'         	= B.CaVinculacion
        , 	'TipoPayOff'          	= B.CaTipoPayOff
        , 	'CodEstructura'       	= A.CaCodEstructura 
    , 	'SistemaAsociado'     	= B.CaIteAsoSis
        , 	'ContratoAsociado'    	= B.CaIteAsoCon
	,	'Factor_Art84'		= CONVERT(FLOAT,0.0)
	,	'Addon_Art84'		= CONVERT(FLOAT,0.0)
        ,       'Valor_moneda'          = COnvert(FLOAT,0.0)   -- 2010 MAP para seguimientos futuros
        ,       'Valor_Moneda_VR'       = Convert(FLOAT,0.0)   -- 2010 MAP para futuros seguimientos
        ,       'Nocional_CLP'          = convert(FLOAT,0.0)   -- 2010 MAP 
     	INTO #CARTERAOPCIONES
     	FROM
		LnkOpc.CbMdbOpc.dbo.CaEncContrato  A
        ,	LnkOpc.CbMdbOpc.dbo.CaDetContrato  B
   	WHERE	
				A.CaNumContrato = B.CaNumContrato 
	AND	A.CaEstado <> 'C' -- Descarte Cotizaciones
	AND	B.CaFechaVcto > @fecproOPT
	AND	(
			A.CaCodEstructura = 2 	-- Collar
		OR
			A.CaCodEstructura = 4	-- Forward utilidad acotada
		OR
			A.CaCodEstructura = 5 	-- Forward perdida acotada
		OR	
			A.CaCodEstructura = 6 	-- Forward sintético
		OR	
			A.CaCodEstructura = 8 	-- Forward Americano
		OR
			A.CaCodEstructura = 13	-- Forward Asiático Entrada Salida
		OR
			(
				A.CaCVEstructura = 'C'	-- Opciones que tienen REC solo si estan compradas
			AND	(
					A.CaCodEstructura = 0	-- Vanillas
				OR
					A.CaCodEstructura = 1	-- Straddle
				OR
					A.CaCodEstructura = 7	-- Strangle
				)
			)
		OR	
			(
				A.CaCVEstructura = 'V'	-- Butterfly vendida tiene REC
			AND	A.CaCodEstructura = 3
			)
		)
	GROUP BY
		A.CaNumContrato
	,	A.CaRutCliente
	,	A.CaCodigo 
	,	B.CaCodMon1
	,	A.CaFechaContrato
	,	B.CaSubyacente
	,	A.CaVr
	,	A.CaMon_vr
	,	B.CaFechaVcto   
	,	B.CaSubyacente
        ,	B.CaVinculacion
        ,	B.CaTipoPayOff
        ,	A.CaCodEstructura 
        ,	B.CaIteAsoSis
        ,	B.CaIteAsoCon
	-- Arma tabla con cartera de operaciones

        if @fecha < @fecproOPT  -- Fecha anterior a la fecha de proceso de Opciones
        begin
            truncate table #CARTERAOPCIONES
            insert into #CARTERAOPCIONES
        	SELECT
				'Fec_Proc'       	= @Fecha
     	     ,	'Numero_operacion' 	= A.CaNumContrato
             ,	'rut_cliente'      	= A.CaRutCliente
             , 	'codigo_cliente'   	= A.CaCodigo 
             , 	'Nocional'         	= MAX(B.CaMontoMon1)
             ,	'Moneda_Nocional'	= B.CaCodMon1
             , 	'fecha_cierre'     	= A.CaFechaContrato
             , 	'Tir' 			= CONVERT(FLOAT,0.0)
             , 	'Producto' 	        = CONVERT(CHAR(05),B.CaSubyacente)
             , 	'Valor_Razonable'     	= ISNULL(CONVERT(FLOAT,A.CaVr),0.0)
             , 	'Moneda_Valor_Raz'    	= A.CaMon_vr
             , 	'fecha_termino'       	= B.CaFechaVcto
     	     ,	'plazo'			= DATEDIFF(dd,@fecha,B.CaFechaVcto)
             , 	'Fecha'               	= @fecproOPT
             , 	'Subyacente'          	= B.CaSubyacente
             , 	'Vinculacion'         	= B.CaVinculacion
             , 	'TipoPayOff'          	= B.CaTipoPayOff
             , 	'CodEstructura'       	= A.CaCodEstructura 
             , 	'SistemaAsociado'     	= B.CaIteAsoSis
             , 	'ContratoAsociado'    	= B.CaIteAsoCon
             ,	'Factor_Art84'		= CONVERT(FLOAT,0.0)
          	,	'Addon_Art84'		= CONVERT(FLOAT,0.0)
             ,       'Valor_moneda'          = COnvert(FLOAT,0.0)   -- 2010 MAP para seguimientos futuros
             ,       'Valor_Moneda_VR'       = Convert(FLOAT,0.0)   -- 2010 MAP para futuros seguimientos
             ,       'Nocional_CLP'          = convert(FLOAT,0.0)   -- 2010 MAP 
          	FROM
	          	LnkOpc.CbMdbOpc.dbo.CaResEncContrato  A
                  ,	LnkOpc.CbMdbOpc.dbo.CaResDetContrato  B
   	          WHERE	
		A.CaNumContrato = B.CaNumContrato 
	AND	A.CaEstado <> 'C' -- Descarte Cotizaciones
	AND	B.CaFechaVcto > @fecproOPT
	AND	(
			A.CaCodEstructura = 2 	-- Collar
		OR
			A.CaCodEstructura = 4	-- Forward utilidad acotada
		OR
			A.CaCodEstructura = 5 	-- Forward perdida acotada
		OR	
			A.CaCodEstructura = 6 	-- Forward sintético
                OR	
			A.CaCodEstructura = 8 	-- Forward Americano
				OR
					A.CaCodEstructura = 13	-- Forward Asiático Entrada Salida
				OR
					(
				A.CaCVEstructura = 'C'	-- Opciones que tienen REC solo si estan compradas
			AND	(
					A.CaCodEstructura = 0	-- Vanillas
				OR
					A.CaCodEstructura = 1	-- Straddle
				OR
					A.CaCodEstructura = 7	-- Strangle
				)
			)
		OR	
			(
				A.CaCVEstructura = 'V'	-- Butterfly vendida tiene REC
			AND	A.CaCodEstructura = 3
			)
		)                
                and CaEncFechaRespaldo = @fecha
                and CaDetFechaRespaldo = @fecha
          	GROUP BY
          		A.CaNumContrato
          	,	A.CaRutCliente
          	,	A.CaCodigo 
          	,	B.CaCodMon1
          	,	A.CaFechaContrato
 	,	B.CaSubyacente
          	,	A.CaVr
          	,	A.CaMon_vr
          	,	B.CaFechaVcto   
          	,	B.CaSubyacente
                  ,	B.CaVinculacion
                  ,	B.CaTipoPayOff
                  ,	A.CaCodEstructura 
                  ,	B.CaIteAsoSis
                  ,	B.CaIteAsoCon
	-- Arma tabla con cartera de operaciones pero desde un dia cerrado, por si generan interfaz al otro dia
        end

	-- Calcula los factores según tabla Articulo 84
	-- Primero las opciones no asiaticas
	UPDATE #CARTERAOPCIONES
	SET
		Factor_Art84 = CASE
			WHEN Plazo <= 365 THEN
				0.015
			WHEN Plazo <= 1825 THEN
				0.07
			ELSE
				0.13
			END
	WHERE
		TipoPayOff = '01'
	-- Primero las opciones no asiaticas
	
	-- Ahora las opciones asiaticas
	-- Rescata las fijaciones de las opciones asiaticas
	SELECT
		A.CaNumContrato
	,	C.CaFixFecha
	,	Plazo = DATEDIFF(dd,@fecproOPT,C.CaFixFecha)
	,	C.CaPesoFij
	,	Factor_Pond = CONVERT(FLOAT,0.0)
	INTO #FIJACIONES
     	FROM
		LnkOpc.CbMdbOpc.dbo.CaEncContrato  A
        ,	LnkOpc.CbMdbOpc.dbo.CaDetContrato  B
	,	LnkOpc.CbMdbOpc.dbo.CaFixing       C
   	WHERE	
		A.CaNumContrato = B.CaNumContrato
	AND	B.CaNumContrato = C.CaNumContrato
	AND	B.CaNumEstructura = C.CaNumEstructura
	AND	A.CaEstado <> 'C' -- Descarte Cotizaciones
	AND	C.CaFixFecha > @fecproOPT
	AND	B.CaCVOpc = 'C'
	-- Rescata las fijaciones de las opciones asiaticas

	-- Calcula el ponderador de articulo 84 para cada fijacion
	UPDATE #FIJACIONES
	SET
		Factor_Pond = CaPesoFij /100 * CASE
			WHEN Plazo <= 365 THEN
				0.015
			WHEN Plazo <= 1825 THEN
				0.07
			ELSE
				0.13
			END
	-- Calcula el ponderador de articulo 84 para cada fijacion

	-- Obtiene el factor por opcion asiatica
	SELECT
		CaNumContrato
	,	Factor_Pond = SUM(Factor_Pond)
	INTO #VECTOR_POND_ASIAN
	FROM
		#FIJACIONES
	GROUP BY
		CaNumContrato
	-- Obtiene el factor por opcion asiatica
	
	-- Asigna el factor obtenido para cada opcion
	UPDATE #CARTERAOPCIONES
	SET
		Factor_Art84 = Factor_pond
	FROM
		#VECTOR_POND_ASIAN
	WHERE
		TipoPayOff = '02'
	AND	Numero_operacion = CaNumContrato
		
	-- Asigna el factor obtenido para cada opcion
	-- Ahora las opciones asiaticas
	
	-- Calcula los factores según tabla Articulo 84
	
	-- Calcula el addon del Articulo 84
	UPDATE #CARTERAOPCIONES
	SET
		Addon_Art84 = round(Factor_Art84 * Nocional * vmvalor,0)
              , Valor_moneda = vmvalor   -- MAP 2010 Para segurimientos futuros
              , Nocional_CLP = round(Nocional * vmvalor,0)
	FROM
		#VALOR_TC_CONTABLE
	WHERE
		vmcodigo = Moneda_Nocional
	-- Calcula el addon del Articulo 84

        -- Traduce valor razoanlbe a CLP y registra el valor de la moneda
	UPDATE #CARTERAOPCIONES
	SET
		Valor_Razonable = round( Valor_Razonable * vmvalor,0)
              , Valor_moneda_VR = vmvalor   -- MAP 2010 Para segurimientos futuros
	FROM
		#VALOR_TC_CONTABLE
	WHERE
		vmcodigo = 999

	
        -- MAP 20100108 Insercion en Art 84 requiere eliminar esto y aplica Insert 
/*
	SELECT
		*
	FROM
		#CARTERAOPCIONES
*/   

        -- JPF 20100108 Fin de especificaion

  

     IF NOT EXISTS(SELECT 1 FROM ART84_DERIVADOS_OPCIONES WHERE Fecha_Proc = @Fecha and Modulo = 'OPT')
     BEGIN
       INSERT INTO ART84_DERIVADOS_OPCIONES   -- select  * from ART84_DERIVADOS_OPCIONES
        SELECT  distinct
		 Fec_Proc                    
                ,NumOpe  = Numero_operacion  
		,Correla = 0    
		,Modulo  = 'OPT'		
                ,Fecha_Fixing = Fecha
		,rut_cliente  = rut_cliente
                ,codigo_cliente = codigo_cliente
		,Instrumento = '' 
		,Mascara     = ''
		,Nocional    = Nocional  
		,fecha_Cierre  = fecha_cierre              
		,fecha_inicio  = fecha_cierre               
		,Seriado       = ''
		,Codigo        = 0
		,Tir           = 0         
		,Moneda        = Moneda_Nocional
		,producto      = Producto
		,Descripcion   = Producto
		,Valor_Razonable_CLP     = case when Valor_Razonable > 0 then Valor_Razonable else Valor_Razonable end -- Para anular el efecto comp bilateral 
                ,Valor_Razonable_CLP_Det = 0
		,Vigencia_Dias = plazo
                ,Valor_Moneda  = Valor_moneda
                ,Moneda_Valor_Raz = Moneda_Valor_Raz
                ,Valor_Moneda_Val_Raz = Valor_Moneda_VR
                ,Nocional_CLP     = Nocional_CLP  
                ,Factor           = Factor_Art84 * 100.0 -- MAP 2010 Para presentacion como porcentaje
                ,REC   		  = 0		-- IndicadorRec MAP 2010 Ya no se utiliza
                ,Vinculacion      = Vinculacion
                ,TipoPayOff       = TipoPayOff
                ,Moneda_Delta     = 0
                ,DeltaFwd         = 0
                ,DeltaFwd_CLP     = 0
                ,Ponderador       = 0
                ,Sum_AVR_Positivo = case when Valor_Razonable > 0 then Valor_Razonable else 0 end
                ,Max_Sum_AVR_Cero = case when Valor_Razonable > 0 then Valor_Razonable else 0 end
                ,CompraoVenta     = ''
                ,Equiv_Credito    = Addon_Art84 + case when Valor_Razonable > 0 then Valor_Razonable else 0 end                          
                ,Monto_Matriz     = Addon_Art84
                ,ClCompBilateral                -- Acu_Comp_Bilateral
-- Debug, sacar !!!' 
/*
                , Addon_Art84
                , case when Valor_Razonable > 0 then Valor_Razonable else 0 end  
*/
         FROM #CARTERAOPCIONES
            , BACPARAMSUDA..Cliente 
         WHERE rut_cliente = Clrut
          and  codigo_cliente = ClCodigo
     END

     SET NOCOUNT OFF
END

-- select * from ART84_DERIVADOS where NumOpe = 7
GO
