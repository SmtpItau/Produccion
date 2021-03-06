USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_THRESHOLD_INICIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--BACPARAMSUDA.dbo.SP_GENERA_THRESHOLD_INICIO 'PCS', 8822


CREATE PROCEDURE [dbo].[SP_GENERA_THRESHOLD_INICIO]
   (   @Modulo           CHAR(3)
   ,   @NumeroContrato   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @xMensaje        VARCHAR(250)
   DECLARE @RutCliente      NUMERIC(10)
   DECLARE @CodCliente      INTEGER
   DECLARE @nProducto       INTEGER
   DECLARE @iSegmento       INTEGER
   DECLARE @FirmoNuevasCCG  CHAR(1)
   DECLARE @nNocional       NUMERIC(21,4)
   DECLARE @nMoneda         INTEGER
   DECLARE @nMnrrda         CHAR(1)
   DECLARE @nPlazo          NUMERIC(9)
   DECLARE @nValorMoneda    NUMERIC(21,4)
   DECLARE @nMontoPesos     NUMERIC(21,0)
   DECLARE @Bullet          CHAR(1)
   DECLARE @ClasRiesgo      VARCHAR(6)

   DECLARE @iFound          INTEGER
       SET @iFound          = -1

   DECLARE @nContMensaje    INTEGER
       SET @nContMensaje    = 0

   -->     1.0   Valor para determinar fecha de los valores de Monedas
   DECLARE @dFechaValMoneda DATETIME
       SET @dFechaValMoneda = CASE WHEN @Modulo = 'BFW' THEN (SELECT acfecante  FROM BacFwdSuda.dbo.MFAC         with(nolock) )
                                   WHEN @Modulo = 'PCS' THEN (SELECT fechaant   FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )
                                   ELSE                      (SELECT acfecante  FROM BacTraderSuda.dbo.MDAC      with(nolock) )
                              END

   -->     2.0   Valor para determinar fecha de los valores del Do y Uf
   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = CASE WHEN @Modulo = 'BFW' THEN (SELECT acfecproc  FROM BacFwdSuda.dbo.MFAC         with(nolock) )
                                   WHEN @Modulo = 'PCS' THEN (SELECT fechaproc  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )
                                   ELSE                      (SELECT acfecproc  FROM BacTraderSuda.dbo.MDAC      with(nolock) )
                              END 


   -->     3.0   Valor para la Unidad de Fomento
   DECLARE @nValUf          NUMERIC(21,4)
       SET @nValUf          = (SELECT vmvalor FROM BacparamSuda.dbo.VALOR_MONEDA with(nolock)
                                             WHERE vmfecha = @dFechaProceso and vmcodigo = 998)
   -->     4.0   Valor para el valor del Dolar Contable
   DECLARE @nValDo          NUMERIC(21,4)
       SET @nValDo          = (SELECT tipo_cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
                                                 WHERE Fecha = @dFechaValMoneda AND Codigo_Moneda = 994)

   -->     4.1   Inicializa variable con para el Valor del Threshold
   DECLARE @Threshold     FLOAT --> NUMERIC(14,4)
       SET @Threshold     = 0

	--> Para determinar si la operación fue generada en Chile o en NY --
	DECLARE @EsOperacionNY as varchar(2)
	set @EsOperacionNY = 'No'
	IF exists (select 1 from BacSwapNY..cartera where numero_operacion = @NumeroContrato)
				set @EsOperacionNY = 'Si'

	IF exists (select 1 from BacFWDNY..cartera where canumoper = @NumeroContrato)
				set @EsOperacionNY = 'Si'


	IF @EsOperacionNY = 'No'
		begin		
			   -->    5.0    Lee los Valores requeridos para ejecutar validaciones
			   IF @Modulo = 'BFW'
			   BEGIN
				  -->     5.1    Lee los Valores requeridos para ejecutar validaciones de Forward
				  SELECT  @RutCliente      = cacodigo
					 ,    @CodCliente      = cacodcli
					 ,    @nProducto       = cacodpos1
					 ,    @iSegmento       = isnull(CASE WHEN seg_comercial = '' THEN -1 ELSE seg_comercial END, -1)
					 ,    @FirmoNuevasCCG  = CASE WHEN nuevo_ccg_firmado = 'S' THEN 'S' ELSE 'N' END
					 ,    @nNocional       = camtomon1
					 ,    @nMoneda         = cacodmon1
					 ,    @nMnrrda         = mnrrda
					 ,    @nValorMoneda    = CASE WHEN cacodmon1 = 999 THEN 1.0 
												  WHEN cacodmon1 = 998 THEN @nValUf
												  ELSE                      ISNULL(Tipo_Cambio, 0)
											 END
					 ,    @nPlazo          = DATEDIFF( DAY, cafecha, cafecvcto)
					 ,    @nMontoPesos     = CASE WHEN cacodmon1 = 999 THEN camtomon1
												  WHEN cacodmon1 = 998 THEN ROUND(camtomon1 * @nValUf, 0)
												  ELSE                      ROUND(camtomon1 * ISNULL(Tipo_Cambio, 0.0), 0)
											 END
			 ,    @Bullet          = '-'
					 ,    @ClasRiesgo      = CASE WHEN clclsbif = '' or clclsbif = 'NA' or clclsbif = 'SC' THEN 'SC' 
												  ELSE                                                          clclsbif
											 END
				  FROM    BacFwdSuda.dbo.MFCA                               with(nolock)
						  INNER JOIN BacParamSuda.dbo.CLIENTE               with(nolock) ON clrut    = cacodigo and clcodigo = cacodcli
						  INNER JOIN BacParamSuda.dbo.MONEDA                with(nolock) ON mncodmon = cacodmon1 
						  LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) ON Fecha    = @dFechaValMoneda AND codigo_moneda = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
				  WHERE   canumoper        = @NumeroContrato

			   END ELSE
			   BEGIN
				  -->     5.2    Lee los Valores requeridos para ejecutar validaciones de Swap
				  SELECT  @RutCliente      = rut_cliente
					 ,    @CodCliente      = codigo_cliente
					 ,    @nProducto       = tipo_swap
					 ,    @iSegmento       = isnull(CASE WHEN seg_comercial = '' THEN -1 ELSE seg_comercial END, -1)
					 ,    @FirmoNuevasCCG  = CASE WHEN nuevo_ccg_firmado = 'S' THEN 'S' ELSE 'N' END
					 ,    @nNocional       = compra_capital
					 ,    @nMoneda         = compra_moneda
					 ,    @nMnrrda         = mnrrda
					 ,    @nValorMoneda    = CASE WHEN compra_moneda = 999 THEN 1.0 
												  WHEN compra_moneda = 998 THEN @nValUf
												  ELSE                          ISNULL(Tipo_Cambio, 0)
											 END
					 ,    @nPlazo          = DATEDIFF( DAY, fecha_inicio, fecha_termino)
					 ,    @nMontoPesos     = CASE WHEN compra_moneda = 999 THEN compra_capital
												  WHEN compra_moneda = 998 THEN ROUND(compra_capital * @nValUf, 0)
												  ELSE                          ROUND(compra_capital * ISNULL(Tipo_Cambio, 0.0), 0)
											 END
					 ,    @Bullet          = CASE WHEN compra_codamo_capital = 6 THEN 'S' ELSE 'N' END
					 ,    @ClasRiesgo      = CASE WHEN clclsbif = '' or clclsbif = 'NA' or clclsbif = 'SC' THEN 'SC' 
												  ELSE                                                          clclsbif
											 END
				  FROM    BacSwapSuda.dbo.CARTERA                           with(nolock)
						  INNER JOIN BacParamSuda.dbo.CLIENTE               with(nolock) ON clrut   = rut_cliente and clcodigo = codigo_cliente
						  INNER JOIN BacParamSuda.dbo.MONEDA                with(nolock) ON mncodmon= compra_moneda 
						  LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) ON Fecha   = @dFechaValMoneda AND codigo_moneda = case when compra_moneda = 13 then 994 else compra_moneda END
				  WHERE   numero_operacion = @NumeroContrato
				  AND     tipo_flujo       = 1
				  AND     numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock)
											   WHERE numero_operacion = @NumeroContrato
												 AND tipo_flujo       = 1)
			   END
	END

	IF @EsOperacionNY = 'Si'
		begin		
			   -->    5.0    Lee los Valores requeridos para ejecutar validaciones
			   IF @Modulo = 'BFW'
			   BEGIN
				  -->     5.1    Lee los Valores requeridos para ejecutar validaciones de Forward
				  SELECT  @RutCliente      = cacodigo
					 ,    @CodCliente      = cacodcli
					 ,    @nProducto       = cacodpos1
					 ,    @iSegmento       = isnull(CASE WHEN seg_comercial = '' THEN -1 ELSE seg_comercial END, -1)
					 ,    @FirmoNuevasCCG  = CASE WHEN nuevo_ccg_firmado = 'S' THEN 'S' ELSE 'N' END
					 ,    @nNocional       = camtomon1
					 ,    @nMoneda         = cacodmon1
					 ,    @nMnrrda         = mnrrda
					 ,    @nValorMoneda    = CASE WHEN cacodmon1 = 999 THEN 1.0 
												  WHEN cacodmon1 = 998 THEN @nValUf
												  ELSE                      ISNULL(Tipo_Cambio, 0)
											 END
					 ,    @nPlazo          = DATEDIFF( DAY, cafecha, cafecvcto)
					 ,    @nMontoPesos     = CASE WHEN cacodmon1 = 999 THEN camtomon1
												  WHEN cacodmon1 = 998 THEN ROUND(camtomon1 * @nValUf, 0)
												  ELSE                      ROUND(camtomon1 * ISNULL(Tipo_Cambio, 0.0), 0)
											 END
			 ,    @Bullet          = '-'
					 ,    @ClasRiesgo      = CASE WHEN clclsbif = '' or clclsbif = 'NA' or clclsbif = 'SC' THEN 'SC' 
												  ELSE                                                          clclsbif
											 END
				  FROM    BacFWDNY.dbo.MFCA                               with(nolock)
						  INNER JOIN BacParamSuda.dbo.CLIENTE               with(nolock) ON clrut    = cacodigo and clcodigo = cacodcli
						  INNER JOIN BacParamSuda.dbo.MONEDA                with(nolock) ON mncodmon = cacodmon1 
						  LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) ON Fecha    = @dFechaValMoneda AND codigo_moneda = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
				  WHERE   canumoper        = @NumeroContrato

			   END ELSE
			   BEGIN
				  -->     5.2    Lee los Valores requeridos para ejecutar validaciones de Swap
				  SELECT  @RutCliente      = rut_cliente
					 ,    @CodCliente      = codigo_cliente
					 ,    @nProducto       = tipo_swap
					 ,    @iSegmento       = isnull(CASE WHEN seg_comercial = '' THEN -1 ELSE seg_comercial END, -1)
					 ,    @FirmoNuevasCCG  = CASE WHEN nuevo_ccg_firmado = 'S' THEN 'S' ELSE 'N' END
					 ,    @nNocional       = compra_capital
					 ,    @nMoneda         = compra_moneda
					 ,    @nMnrrda         = mnrrda
					 ,    @nValorMoneda    = CASE WHEN compra_moneda = 999 THEN 1.0 
												  WHEN compra_moneda = 998 THEN @nValUf
												  ELSE                          ISNULL(Tipo_Cambio, 0)
											 END
					 ,    @nPlazo          = DATEDIFF( DAY, fecha_inicio, fecha_termino)
					 ,    @nMontoPesos     = CASE WHEN compra_moneda = 999 THEN compra_capital
												  WHEN compra_moneda = 998 THEN ROUND(compra_capital * @nValUf, 0)
												  ELSE                          ROUND(compra_capital * ISNULL(Tipo_Cambio, 0.0), 0)
											 END
					 ,    @Bullet          = CASE WHEN compra_codamo_capital = 6 THEN 'S' ELSE 'N' END
					 ,    @ClasRiesgo      = CASE WHEN clclsbif = '' or clclsbif = 'NA' or clclsbif = 'SC' THEN 'SC' 
												  ELSE                                                          clclsbif
											 END
				  FROM    BacSwapNY.dbo.CARTERA                           with(nolock)
						  INNER JOIN BacParamSuda.dbo.CLIENTE               with(nolock) ON clrut   = rut_cliente and clcodigo = codigo_cliente
						  INNER JOIN BacParamSuda.dbo.MONEDA                with(nolock) ON mncodmon= compra_moneda 
						  LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) ON Fecha   = @dFechaValMoneda AND codigo_moneda = case when compra_moneda = 13 then 994 else compra_moneda END
				  WHERE   numero_operacion = @NumeroContrato
				  AND     tipo_flujo       = 1
				  AND     numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapNY.dbo.CARTERA with(nolock)
											   WHERE numero_operacion = @NumeroContrato
												 AND tipo_flujo       = 1)
			   END
	END


   IF @nMontoPesos IS NULL
      SET @nMontoPesos = 0.0

   --> () Si existen mensaje para esta operacion se eliminan   
   DELETE FROM dbo.TBL_MENSAJES_OPERACION_THRESHOLD
         WHERE Id_Sistema   = @Modulo
           AND Num_Contrato = @NumeroContrato

   -->     6.0    Determina el Nocional en Dolares
   DECLARE @nMontoDolares   FLOAT
       SET @nMontoDolares   = (@nMontoPesos / @nValDo)

   IF @nMontoDolares IS NULL
      SET @nMontoDolares = 0.0

   -->     7.0    Determina el valor de REC calculado para la operación
   DECLARE @MontoMatriz     FLOAT
       SET @MontoMatriz     = isnull((SELECT TOP 1 isnull(montooriginal, 0.0)
      FROM BacLineas.dbo.LINEA_TRANSACCION
     WHERE Id_Sistema      = @Modulo
       AND NumeroOperacion = @NumeroContrato), 0.0)

   IF @MontoMatriz = 0.0
   BEGIN
      SET @xMensaje     = 'EL REC de la Operación es Cero.'
      SET @nContMensaje = @nContMensaje + 1

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @xMensaje, @dFechaProceso, 'N'
   END


   DECLARE @LinRutCliente   NUMERIC(10)
       SET @LinRutCliente   = @RutCliente
   DECLARE @LinCodCliente   INTEGER
       SET @LinCodCliente   = @CodCliente

   IF EXISTS( SELECT 1 FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @LinRutCliente)
   BEGIN
      SET @LinRutCliente = (SELECT TOP 1 clrut_padre    FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @LinRutCliente)
      SET @LinCodCliente = (SELECT TOP 1 clcodigo_padre FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @LinRutCliente)
   END

   -->     8.0    Lee el valor asignado como Linea de Credito para el Threshold
   DECLARE @LineaCredito    NUMERIC(19,4)
       SET @LineaCredito    = isnull((SELECT isnull(Monto_Linea_Threshold, 0)
                                        FROM BacLineas.dbo.LINEA_GENERAL with(nolock)
                                       WHERE Rut_Cliente    = @LinRutCliente
                                         AND Codigo_Cliente = @LinCodCliente), 0)

   -->     9.1    Determina el porcentaje de Linea de Credito que aplicara para evaluar
   DECLARE @PorcCredito     NUMERIC(21,4)
       SET @PorcCredito     = CASE WHEN @iSegmento = 1 THEN (@LineaCredito * 0.1)   --> BANCA PRIVADA
                                   WHEN @iSegmento = 2 THEN (@LineaCredito * 0.1)   --> EMPRESAS E INMOBILIARIAS
                                   WHEN @iSegmento = 3 THEN (@LineaCredito * 0.1)   --> EMPRESAS CORPORATIVAS
                                   WHEN @iSegmento = 4 THEN (@LineaCredito * 0.1)   --> INSTITUCIONALES
                                   WHEN @iSegmento = 5 THEN (@LineaCredito * 0.1)   --> BANCOS
                                   ELSE                      @LineaCredito
                              END

   DECLARE @iPlazoFRAPolitica  NUMERIC(9)
       SET @iPlazoFRAPolitica  = -1
       SET @iPlazoFRAPolitica  = ISNULL((SELECT ISNULL(Plazo, 0)
                                               FROM BacParamSuda.dbo.TBL_CONTROL_THRESHOLD with(nolock)
                                              WHERE Segmento = @iSegmento
                                                AND Modulo   = @Modulo
                                                AND Producto = @nProducto
                                                AND Riesgo   = CASE WHEN @iSegmento = 3 AND @ClasRiesgo  = 'SC' THEN 'N'
                                                                    WHEN @iSegmento = 3 AND @ClasRiesgo <> 'SC' THEN 'S'
                                                                    ELSE Riesgo
                                                               END), 0)
      SET @iPlazoFRAPolitica  = (@iPlazoFRAPolitica / 365)


   -->     9.0    Determina si por politica requiere la aplicacion del Threshold
   DECLARE @oThreshold      CHAR(1)
       SET @oThreshold      = (SELECT Threshold FROM BacParamSuda.dbo.TBL_CONTROL_THRESHOLD with(nolock)
                                       WHERE Segmento = @iSegmento
                                         AND Modulo   = @Modulo
                                         AND Producto = @nProducto
                                         AND Riesgo   = CASE WHEN @iSegmento = 3 AND @ClasRiesgo  = 'SC' THEN 'N'
                                                             WHEN @iSegmento = 3 AND @ClasRiesgo <> 'SC' THEN 'S'
                                                             ELSE Riesgo
                                                        END
                                         AND @nPlazo <= CASE WHEN @Modulo = 'PCS' AND @nProducto = 2 AND @iSegmento = 2 AND @Bullet = 'S' THEN (365*3)
                                                             WHEN @Modulo = 'PCS' AND @nProducto = 2 AND @iSegmento = 3 AND @Bullet = 'S' THEN (365*3)
                                                             WHEN @Modulo = 'PCS' AND @nProducto = 2 AND @iSegmento = 4 AND @Bullet = 'S' THEN (365*3)
                                                             WHEN @Modulo = 'PCS' AND @nProducto = 2 AND @iSegmento = 5 AND @Bullet = 'S' THEN (365*3)
                                                             ELSE Plazo
                                                        END)

   IF @FirmoNuevasCCG = 'N' OR @FirmoNuevasCCG = ''
   BEGIN
      SET @oThreshold = 'S'
   END

   IF @oThreshold = 'N'
   BEGIN
      SET @xMensaje     = 'Por politica de derivados, operación no requiere threshold.'
      SET @nContMensaje = @nContMensaje + 1

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @xMensaje, @dFechaProceso, 'N'

      DELETE FROM dbo.TBL_THRESHOLD_OPERACION 
            WHERE Sistema = @Modulo and Numero_Operacion = @NumeroContrato

      INSERT INTO dbo.TBL_THRESHOLD_OPERACION
      SELECT @Modulo 
         ,   @nProducto
         ,   @RutCliente
         ,   @CodCliente
         ,   @NumeroContrato
         ,   @Threshold
         ,   @Threshold
         ,   @MontoMatriz

      SELECT 'ThresholdPropuesto' = @Threshold
      ,      'Threshold'          = @Threshold
      ,      'Mensaje'            = @xMensaje
      ,      'Threshold'          = 'N' --> @oThreshold
      ,      'Rec'                = @MontoMatriz

      RETURN
   END

   -->    9.1 Si no puede determinar si aplicara Politica de Derivados
   IF @oThreshold IS NULL 
   BEGIN
      SET @xMensaje     = 'Operación se encuentra fuera de la politica de derivados. Plazo exede : ' 
                        + ltrim(rtrim( @iPlazoFRAPolitica )) + ' años.'
      SET @nContMensaje = @nContMensaje + 1

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD   
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @xMensaje, @dFechaProceso, 'N'
      
      SET @oThreshold   = 'S'
      -->   SET @Threshold  = @MontoMatriz --> Aplica REC Como Threshold
      -->   SET @oThreshold = 'N'
   END

   DECLARE @iRequiereThreshold   CHAR(1)
       SET @iRequiereThreshold   = 'N'

   IF @FirmoNuevasCCG = 'N' OR @FirmoNuevasCCG = ''
   BEGIN
      SET @xMensaje     = 'Cliente cumple con normativa antigua del threshold. Aplicara 20%.'
      SET @nContMensaje = @nContMensaje + 1

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD   
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @xMensaje, @dFechaProceso, 'N'

      --> Se aplica la Politica Antigua 20% del nocional
      SET @Threshold = 0
      SET @Threshold = ISNULL(ROUND(@nMontoPesos * 0.2, 0), 0.0)
   END

   DECLARE @MSGAfirmativo   VARCHAR(150)
       SET @MSGAfirmativo   = 'Por politica de derivados, operación se encuentra exenta de threshold.'


   IF @FirmoNuevasCCG = 'S' OR @FirmoNuevasCCG = '' OR @FirmoNuevasCCG = 'N'
   BEGIN
      --> Control por Segmento del Cliente

      --> BANCA PRIVADA <--
      IF @iSegmento = 1
      BEGIN
         IF (@MontoMatriz > @PorcCredito) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S' --> Si REC > 10% Linea Credito
            SET @MSGAfirmativo      = 'cumple con condición : REC es mayor al 10% de la línea de crédito.'
         END
         IF (@nMontoDolares > 5000000) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S' --> Monto en Dolares es mayor a 5. Millones
            SET @MSGAfirmativo      = 'cumple con condición : Monto mayor a US$ 5.000.000.'
         END
         IF (@Modulo = 'PCS' AND @nProducto = 2 AND @nPlazo > 365) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S'
            SET @MSGAfirmativo      = 'cumple con condición : CCS mayor a 1 año.'
         END

         --> Si la Operacion Requiere Threshold, sera aqui donde define el Monto del Threshold para este segmento
         IF @iRequiereThreshold = 'S'
         BEGIN
            SET @Threshold  = @MontoMatriz

            --> Si es superior al 20% del Nominal, sera el 20% del Nominal
            IF @Threshold > ROUND(@nMontoPesos * 0.2, 0)
            BEGIN
               SET @Threshold = ROUND(@nMontoPesos * 0.2, 0)
               SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold mayor al 20% Nominal. (Aplica 20%)'
            END ELSE
            BEGIN
               SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold menor al 20% Nominal. (Aplica REC)'
            END

            IF @Threshold = 0 OR @Threshold IS NULL
               SET @Threshold = @MontoMatriz
         END
      END
      --> BANCA PRIVADA <--


      --> EMPRESAS E INMOBILIARIAS <--
      IF @iSegmento = 2
      BEGIN
         --> SE SOLICITO SEPARAR ESTA CONDICION EL DIA 21-04-2010 (Certificación)

         --> Si REC > 10% Linea Credito; O Plazo para CCS mayores a 2 Años
         --> IF (@MontoMatriz > @PorcCredito) OR (@Modulo = 'PCS' AND @nProducto = 2 AND @nPlazo > (365*2))
         -->    SET @iRequiereThreshold = 'S'

         IF (@MontoMatriz > @PorcCredito) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S'   --> Si REC > 10% Linea Credito
            SET @MSGAfirmativo      = 'cumple con condición : REC es mayor al 10% de la línea de crédito.'
         END
         IF (@Modulo = 'PCS' AND @nProducto = 2 AND @nPlazo > (365*2)) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S'   --> Plazo para CCS mayores a 2 Años
            SET @MSGAfirmativo      = 'cumple con condición : CCS mayor a 2 años.'
         END
         IF (@nMontoDolares > 15000000) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S'   --> Monto en Dolares es mayor a 15 Millones
            SET @MSGAfirmativo      = 'cumple con condición : Monto mayor a US$ 15.000.000.'
         END

         --> Si la Operacion Requiere Threshold, sera aqui donde define el Monto del Threshold para este segmento
         IF @iRequiereThreshold = 'S'
         BEGIN
            SET @Threshold  = @MontoMatriz

            --> Si es superior al 20% del Nominal, sera el 20% del Nominal
            IF @Threshold > ROUND(@nMontoPesos * 0.2, 0)
            BEGIN
               SET @Threshold     = ROUND(@nMontoPesos * 0.2, 0)
               SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold mayor al 20% Nominal. (Aplica 20%)'
            END ELSE
            BEGIN
               SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold menor al 20% Nominal. (Aplica REC)'
            END

            IF @Threshold = 0 OR @Threshold IS NULL
               SET @Threshold = @MontoMatriz
         END
      END
      --> EMPRESAS E INMOBILIARIAS <--


      --> EMPRESAS CORPORATIVAS <--
      IF @iSegmento = 3
      BEGIN

         --> Empresas SIN Claisificacion de Riesgo
         IF @ClasRiesgo = 'SC'
         BEGIN

            IF (@MontoMatriz > @PorcCredito) and (@iRequiereThreshold = 'N')
            BEGIN
               SET @iRequiereThreshold = 'S'  --> Si REC > 10% Linea Credito
               SET @MSGAfirmativo      = 'cumple con condición : REC es mayor al 10% de la línea de crédito.'
            END
            IF (@nPlazo > (365*5)) and (@iRequiereThreshold = 'N')
            BEGIN
               SET @iRequiereThreshold = 'S'  --> Si el Plazo de la Operacion es superior a 5 Años
               SET @MSGAfirmativo      = 'cumple con condición : Plazo es mayor a 5 años.'
            END
            IF (@nMontoDolares > 15000000) and (@iRequiereThreshold = 'N')
            BEGIN
               SET @iRequiereThreshold = 'S'   --> Monto en Dolares es mayor a 15 Millones
               SET @MSGAfirmativo      = 'cumple con condición : Monto mayor a US$ 15.000.000.'
            END

            IF @iRequiereThreshold = 'S'
            BEGIN
               SET @Threshold     = @MontoMatriz
               SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold será el REC.'
            END

            IF @Threshold = 0 OR @Threshold IS NULL
               SET @Threshold = @MontoMatriz

         END ELSE
         BEGIN
            
            IF (@MontoMatriz > @PorcCredito) and (@iRequiereThreshold = 'N')
            BEGIN
               SET @iRequiereThreshold = 'S' --> Si REC > 10% Linea Credito
               SET @MSGAfirmativo      = 'cumple con condición : REC es mayor al 10% de la línea de crédito.'
            END
            IF (@nPlazo > (365*5)) and (@iRequiereThreshold = 'N')
            BEGIN
               SET @iRequiereThreshold = 'S'  --> Si el Plazo de la Operacion es superior a 5 Años
               SET @MSGAfirmativo      = 'cumple con condición : Plazo es mayor a 5 años.'
            END
            IF (@nMontoDolares > 15000000) and (@iRequiereThreshold = 'N')
            BEGIN
               SET @iRequiereThreshold = 'S'  --> Monto en Dolares es mayor a 15 Millones
               SET @MSGAfirmativo      = 'cumple con condición : Monto mayor a US$ 15.000.000.'
            END

            IF @iRequiereThreshold = 'S'
            BEGIN
               SET @Threshold     = @MontoMatriz
               SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold será el REC.'
            END
            IF @Threshold = 0 OR @Threshold IS NULL
               SET @Threshold = @MontoMatriz
         END
      END
      --> EMPRESAS CORPORATIVAS    <--

      --> INSTITUCIONALES y BANCOS <--
      IF @iSegmento = 4 OR @iSegmento = 5
      BEGIN

         IF (@MontoMatriz > @PorcCredito) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S' --> Si REC > 10% Linea Credito
            SET @MSGAfirmativo      = 'cumple con condición : REC es mayor al 10% de la línea de crédito.'
         END


         IF (@nMontoDolares > 30000000) and (@iRequiereThreshold = 'N')
         BEGIN
            SET @iRequiereThreshold = 'S' --> Monto en Dolares es mayor a 15 Millones
            SET @MSGAfirmativo      = 'cumple con condición : Monto mayor a US$ 30.000.000.'
         END

         IF @iRequiereThreshold = 'S'
         BEGIN
            SET @Threshold     = @MontoMatriz
            SET @MSGAfirmativo = @MSGAfirmativo + ' Monto threshold será el REC.'
         END
         IF @Threshold = 0 OR @Threshold IS NULL
            SET @Threshold = @MontoMatriz
      END
      --> INSTITUCIONALES       <--

   END
   --> Creacion de tabla de Reduccion de Threshold   TBL_REDUCCION_THRESHOLD

   IF @FirmoNuevasCCG = 'N' OR @FirmoNuevasCCG = ''
   BEGIN
      SET @Threshold = ISNULL(ROUND(isnull(@nMontoPesos, 0) * 0.2, 0), 0.0)
   END

   IF @iRequiereThreshold = 'N'
   BEGIN
      SET @xMensaje      = 'Operación se encuentra exenta de Threshold por Politica de Derivados.'
      SET @nContMensaje  = @nContMensaje + 1
      IF @FirmoNuevasCCG = 'N' OR @FirmoNuevasCCG = ''
      BEGIN
         SET @xMensaje   = 'Cliente cumple con normativa antigua del threshold. (Se encuentra Exenta de Threshold)'
      END

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD   
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @xMensaje, @dFechaProceso, 'N'
   END ELSE
   BEGIN
      SET @nContMensaje = @nContMensaje + 1

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD   
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @MSGAfirmativo, @dFechaProceso, 'N'

      SET @xMensaje     = 'Operación evalua Threshold, valor propuesto es de : ' + LTRIM(RTRIM( CONVERT(NUMERIC(21,0), @Threshold) )) -->   LTRIM(RTRIM( @Threshold ))
      SET @nContMensaje = @nContMensaje + 1

      IF @FirmoNuevasCCG = 'N' OR @FirmoNuevasCCG = ''
      BEGIN
         SET @xMensaje   = 'Cliente cumple con normativa antigua del threshold. Aplica 20% Nocional : ' + LTRIM(RTRIM( CONVERT(NUMERIC(21,0), @Threshold )))
      END

      INSERT INTO dbo.TBL_MENSAJES_OPERACION_THRESHOLD   
      SELECT @Modulo, @nProducto, @NumeroContrato, @nContMensaje, @xMensaje, @dFechaProceso, 'N'
   END

   --> Creacion de tabla de Threshold Operación
   DELETE FROM dbo.TBL_THRESHOLD_OPERACION 
         WHERE Sistema = @Modulo and Numero_Operacion = @NumeroContrato

   INSERT INTO dbo.TBL_THRESHOLD_OPERACION
   SELECT @Modulo 
      ,   @nProducto
      ,   @RutCliente
      ,   @CodCliente
      ,   @NumeroContrato
      ,   @Threshold
      ,   @Threshold
      ,   @MontoMatriz

   IF @FirmoNuevasCCG = 'N' OR @FirmoNuevasCCG = ''
   BEGIN
      EXECUTE dbo.SP_CREACION_TABLA_REDUCCION @Modulo
                                            , @nProducto
                                            , @NumeroContrato
                                            , @iSegmento
                                            , @MontoMatriz
                                            , @ClasRiesgo
   END

   IF @FirmoNuevasCCG  = 'N' OR @FirmoNuevasCCG = ''
      SET @MontoMatriz = @Threshold

   SELECT 'ThresholdPropuesto' = @Threshold
   ,      'Threshold'          = @Threshold
   ,      'Mensaje'            = @xMensaje --> 'Se ha definido Threshold'
   ,      'Threshold'          = @iRequiereThreshold
   ,      'Rec'                = @MontoMatriz

END

GO
