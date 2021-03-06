USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_C18]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_C18]
   (   @dFechaInterfaz   DATETIME   )
AS
BEGIN

DECLARE @FechaProceso DATETIME
DECLARE @EsHabil      CHAR(2)


SET @FechaProceso = @dFechaInterfaz   

EXEC BACPARAMSUDA..SP_DETECTA_FECHA_HABIL_INHABIL @dFechaInterfaz, @EsHabil OUTPUT

IF @EsHabil = 'NO'
BEGIN
    EXEC BACPARAMSUDA..SP_FECHA_HABIL_ANTERIOR  @dFechaInterfaz, @FechaProceso   output
END



   SET NOCOUNT ON

CREATE TABLE #INTERFAZ_C18
   (	c18_CAMPO_01	CHAR(02)	--> 01 DIA				( CODIGO DE LA IF )		-- PRIMER REGISTRO
   ,	c18_CAMPO_02	CHAR(14)	--> 02 ACTIVO CIRCULANTE			( IDENTIFICACION DEL ARCHIVO )	-- PRIMER REGISTRO
   ,	c18_CAMPO_03	CHAR(03)	--> 03 CODIGO DEL BANCO ACREEDOR		( PERIODO AAAAMM )		-- PRIMER REGISTRO
   ,	c18_CAMPO_04	CHAR(01)	--> 04 PLAZO RESIDUAL DE VENCIMIENTO	( FILLER)			-- PRIMER REGISTRO
   ,	c18_CAMPO_05	CHAR(14)	--> 05 MONEDA DE PAGO
   ,	c18_CAMPO_06	CHAR(14)	--> 06 CUENTAS CORRIENTES
   ,	c18_CAMPO_07	CHAR(14)	--> 07 OTRAS OBLIGACIONES A LA VISTA
   ,	c18_CAMPO_08	NUMERIC(14,0)	--> 08 OPERACIONES CON LIQUIDACION EN CURSO
   ,	c18_CAMPO_09	CHAR(14)	--> 09 CONTRATOS DE RETROCOMPRA Y PRESTAMOS DE VALORES
   ,	c18_CAMPO_10	CHAR(14)	--> 10 DEPOSITOS Y OTRAS CAPTACIONES A PLAZO
   ,	c18_CAMPO_11	CHAR(14)	--> 11 CONTRATOS DE DERIVADOS FINANCIEROS
   ,	c18_CAMPO_12	CHAR(14)	--> 12 OBLIGACIONES CON BANCOS
   ,	c18_CAMPO_13	CHAR(14)	--> 13 MONTO CUBIERTO CON GARANTIAS VALIDAS PARA LIMITES
   ,	c18_CAMPO_14	CHAR(122)	--> 14 FILLER
   ,	c18_Sistema	CHAR(003)	--> SISTEMA... NO SE RETORNA SOLO DATO DE CONTROL
   )



   INSERT INTO #INTERFAZ_C18
   SELECT 'c18_CAMPO_01' = LTRIM(RTRIM( DATEPART(DAY, @dFechaInterfaz) ))
   ,	  'c18_CAMPO_02' = REPLICATE('0',14)
   ,	  'c18_CAMPO_03' = CONVERT(CHAR(3), REPLICATE('0', 3 - LEN(Cod_Inst)) + RTRIM(LTRIM( Cod_Inst )) )
   ,	  'c18_CAMPO_04' = CASE WHEN DATEDIFF(DAY, fecha, fecha_vencimiento) = 0   THEN '1'
                                WHEN DATEDIFF(DAY, fecha, fecha_vencimiento) > 364 THEN '3'
                                ELSE                                                    '2' --> Entre 2 y 365
                           END
   ,	  'c18_CAMPO_05' = CASE WHEN moneda = 999        THEN 1
                                WHEN moneda IN(998, 994) THEN 2
                                ELSE                          3
                           END 
   ,	  'c18_CAMPO_06' = REPLICATE('0',14)
   ,	  'c18_CAMPO_07' = REPLICATE('0',14)
   ,	  'c18_CAMPO_08' = ABS( monto_operacion )
   ,	  'c18_CAMPO_09' = REPLICATE('0',14)
   ,	  'c18_CAMPO_10' = REPLICATE('0',14)
   ,	  'c18_CAMPO_11' = REPLICATE('0',14)
   ,	  'c18_CAMPO_12' = REPLICATE('0',14)
   ,	  'c18_CAMPO_13' = REPLICATE('0',14)
   ,	  'c18_CAMPO_14' = 0
   ,	  'c18_Sistema'  = LTRIM(RTRIM( sistema ))
   FROM   BacParamSuda..MDLBTR             with (nolock)
          INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente
    WHERE Fecha             = @FechaProceso
     AND  Fecha_Vencimiento > @dFechaInterfaz
     AND  sistema           = 'BTR'
     AND  cltipcli	    = 1 --> Cliente Banco Nacional
     AND  clpais	    = 6 --> Residencia en Chile
     AND (forma_pago        IN(11, 12, 13, 14)                                         --> TELEX
       OR forma_pago        IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 ) --> SPAV
         ) AND  Tipo_Movimiento   = 'C'

   INSERT INTO #INTERFAZ_C18
   SELECT 'c18_CAMPO_01' = LTRIM(RTRIM( DATEPART(DAY, @dFechaInterfaz) ))
   ,	  'c18_CAMPO_02' = REPLICATE('0',14)
   ,	  'c18_CAMPO_03' = CONVERT(CHAR(3), REPLICATE('0', 3 - LEN(Cod_Inst)) + RTRIM(LTRIM( Cod_Inst )) )
   ,	  'c18_CAMPO_04' = CASE WHEN DATEDIFF(DAY, fecha, fecha_vencimiento) = 0   THEN '1'
                                WHEN DATEDIFF(DAY, fecha, fecha_vencimiento) > 364 THEN '3'
                                ELSE                                                    '2' --> Entre 2 y 365
                           END
   ,	  'c18_CAMPO_05' = CASE WHEN moneda = 999        THEN 1
                                ELSE                          3
                           END 
   ,	  'c18_CAMPO_06' = REPLICATE('0',14)
   ,	  'c18_CAMPO_07' = REPLICATE('0',14)
   ,	  'c18_CAMPO_08' = ABS( monto_operacion )
   ,	  'c18_CAMPO_09' = REPLICATE('0',14)
   ,	  'c18_CAMPO_10' = REPLICATE('0',14)
   ,	  'c18_CAMPO_11' = REPLICATE('0',14)
   ,	  'c18_CAMPO_12' = REPLICATE('0',14)
   ,	  'c18_CAMPO_13' = REPLICATE('0',14)
   ,	  'c18_CAMPO_14' = 0
   ,	  'c18_Sistema'  = LTRIM(RTRIM( sistema ))
   FROM   BacParamSuda..MDLBTR             with (nolock)
          INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente
    WHERE Fecha             = @FechaProceso
     AND  Fecha_Vencimiento > @dFechaInterfaz
      AND sistema           = 'BCC'
      AND cltipcli	    = 1 --> Cliente Banco Nacional
      AND clpais	    = 6 --> Residencia en Chile
      AND (forma_pago        IN(11, 12, 13, 14)                                         --> TELEX
       OR  forma_pago        IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 ) --> SPAV
          )
     AND  Tipo_Movimiento   = 'C'

   INSERT INTO #INTERFAZ_C18
   SELECT 'c18_CAMPO_01' = LTRIM(RTRIM( DATEPART(DAY, @dFechaInterfaz) ))
   ,	  'c18_CAMPO_02' = REPLICATE('0',14)
   ,	  'c18_CAMPO_03' = CONVERT(CHAR(3), REPLICATE('0', 3 - LEN(Cod_Inst)) + RTRIM(LTRIM( Cod_Inst )) )
   ,	  'c18_CAMPO_04' = CASE WHEN DATEDIFF(DAY, fecha, fecha_vencimiento) = 0   THEN '1'
                                WHEN DATEDIFF(DAY, fecha, fecha_vencimiento) > 364 THEN '3'
                                ELSE                                                    '2' --> Entre 2 y 365
                           END
   ,	  'c18_CAMPO_05' = CASE WHEN moneda = 999        THEN 1
                                WHEN moneda IN(998, 994) THEN 2
                                ELSE                          3
                           END 
   ,	  'c18_CAMPO_06' = REPLICATE('0',14)
   ,	  'c18_CAMPO_07' = REPLICATE('0',14)
   ,	  'c18_CAMPO_08' = ABS( monto_operacion )
   ,	  'c18_CAMPO_09' = REPLICATE('0',14)
   ,	  'c18_CAMPO_10' = REPLICATE('0',14)
   ,	  'c18_CAMPO_11' = REPLICATE('0',14)
   ,	  'c18_CAMPO_12' = REPLICATE('0',14)
   ,	  'c18_CAMPO_13' = REPLICATE('0',14)
   ,	  'c18_CAMPO_14' = 0
   ,	  'c18_Sistema'  = LTRIM(RTRIM( sistema ))
   FROM   BacParamSuda..MDLBTR             with (nolock)
          INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente
    WHERE Fecha             = @FechaProceso
     AND  Fecha_Vencimiento > @dFechaInterfaz
      AND sistema           IN('PCS','BFW' )
      AND cltipcli	    = 1 --> Cliente Banco Nacional
      AND clpais	    = 6 --> Residencia en Chile
     AND (forma_pago        IN(11, 12, 13, 14)                                         --> TELEX
       OR forma_pago        IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 ) --> SPAV
         )
     AND  Tipo_Movimiento   = 'C'

   -->    Genera Retorno de Registro de Cabecera
   SELECT 'c18_CAMPO_01' = '027'                                                   --> ( CODIGO DE LA IF )
	, 'c18_CAMPO_02' = 'C18'					           --> ( IDENTIFICACION DEL ARCHIVO )	
	, 'c18_CAMPO_03' = SUBSTRING( CONVERT(CHAR(8),@dFechaInterfaz,112) , 1,6 ) --> ( PERIODO AAAAMM )
	, 'c18_CAMPO_04' = SPACE(122)					           --> ( FILLER )
	, 'c18_CAMPO_05' = ''
	, 'c18_CAMPO_06' = ''
	, 'c18_CAMPO_07' = ''
	, 'c18_CAMPO_08' = ''
	, 'c18_CAMPO_09' = ''
	, 'c18_CAMPO_10' = ''
	, 'c18_CAMPO_11' = ''
	, 'c18_CAMPO_12' = ''
	, 'c18_CAMPO_13' = ''
	, 'c18_CAMPO_14' = ''
   INTO #RETORNO
   
   UNION ALL

   -->    Genera Retorno de Registros de Vencimientos
   SELECT 'c18_CAMPO_01' = c18_CAMPO_01
	, 'c18_CAMPO_02' = c18_CAMPO_02
	, 'c18_CAMPO_03' = c18_CAMPO_03
	, 'c18_CAMPO_04' = c18_CAMPO_04
	, 'c18_CAMPO_05' = c18_CAMPO_05
	, 'c18_CAMPO_06' = c18_CAMPO_06
	, 'c18_CAMPO_07' = c18_CAMPO_07
	, 'c18_CAMPO_08' = LTRIM(RTRIM( SUM(c18_CAMPO_08) ))
	, 'c18_CAMPO_09' = c18_CAMPO_09
	, 'c18_CAMPO_10' = c18_CAMPO_10
	, 'c18_CAMPO_11' = c18_CAMPO_11
	, 'c18_CAMPO_12' = c18_CAMPO_12
	, 'c18_CAMPO_13' = c18_CAMPO_13
	, 'c18_CAMPO_14' = c18_CAMPO_14
   FROM	#INTERFAZ_C18
   GROUP BY c18_CAMPO_03
        ,   c18_CAMPO_04
        ,   c18_CAMPO_05
        ,   c18_CAMPO_01
        ,   c18_CAMPO_02
        ,   c18_CAMPO_06
        ,   c18_CAMPO_07
        ,   c18_CAMPO_09
        ,   c18_CAMPO_10
        ,   c18_CAMPO_11
        ,   c18_CAMPO_12
        ,   c18_CAMPO_13
        ,   c18_CAMPO_14

   DECLARE @iRegistros   NUMERIC(9)
       SET @iRegistros   = (SELECT COUNT(1) FROM #RETORNO)

   SELECT 'c18_CAMPO_01' = c18_CAMPO_01
	, 'c18_CAMPO_02' = c18_CAMPO_02
	, 'c18_CAMPO_03' = c18_CAMPO_03
	, 'c18_CAMPO_04' = c18_CAMPO_04
	, 'c18_CAMPO_05' = c18_CAMPO_05
	, 'c18_CAMPO_06' = c18_CAMPO_06
	, 'c18_CAMPO_07' = c18_CAMPO_07
	, 'c18_CAMPO_08' = c18_CAMPO_08
	, 'c18_CAMPO_09' = c18_CAMPO_09
	, 'c18_CAMPO_10' = c18_CAMPO_10
	, 'c18_CAMPO_11' = c18_CAMPO_11
	, 'c18_CAMPO_12' = c18_CAMPO_12
	, 'c18_CAMPO_13' = c18_CAMPO_13
	, 'c18_CAMPO_14' = c18_CAMPO_14
        , 'Registros'    = @iRegistros
    FROM #RETORNO
  
END






GO
