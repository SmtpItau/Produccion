USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENCNTCONTABILIZA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GENCNTCONTABILIZA]

   (   @Fecha_Hoy   DATETIME   )
AS
BEGIN

-- dbo.SP_GenCntContabiliza '20090904'  -- 20091201
-- dbo.SP_GenCntContabiliza '20090908'  -- 20091201  --select * from cntContabiliza where cntcontrato = 986

-- dbo.SP_GenCntContabiliza '20081209'  -- 20091201
-- dbo.SP_GenCntContabiliza '20081211'
-- dbo.SP_GenCntContabiliza '20081216'  -- 20091201
-- dbo.SP_GenCntContabiliza '20081215'
-- dbo.SP_GenCntContabiliza '20081230'  -- 20091201
-- select * from CntContabiliza
-- select CaFechaPagoEjer, * from CaDetContrato order by CaDetContrato.CaFechaPagoEjer
-- MAP 17 de Septiembre liquidacion total y reverso LBTR
-- Codigo_instrumento = 0 debe ser cambado por Codigo_instrumento = ' '
-- Nota: los perfiles habian sido mal migrados.

-- MAP 08 Octubre
-- Conceptos Nocional y Valor Strike no se generaron correctamente.
-- Ajuste de AVR se hace siempre en CLP
-- Join mal manejado al liquidar total estructuras

-- MAP 13, 14 Octubre
-- No debería generarse pago de prima cuando se ANTICIPA
-- Estaba evaluando mal el Monto Subyacente y Valor Strike.

-- MAP 22 Octubre 
-- No debe generar contabilidad de movimientos para
-- inicio de operacion con ANULA

-- MAP 02 Noviembre 2009
-- Problemas con reversos x Valuta 
-- deben leer caja no CadetContrato
-- por efecto de la modificacion.

-- MAP  04 Nov.  2009 Inclusion de No ejercidos para declarar prima

-- MAP 09 Nov. 2009  Corrige Discriminacion de ANULACIONES

-- MAP 13 Nov. Entrega

-- MAP 17 Nov. Corrige REV x Pago Prima y REV x ANTICIPA
-- MAP 17 Nov. descarta formas de pago 2, 3, 5, 6, 7, 8, 15, 16, 123, 140, 141, 142
--             del evento reverso

   SET NOCOUNT ON


   DECLARE @dAcfecproc   DATETIME
       SET @dAcfecproc   = (SELECT fechaproc FROM OpcionesGeneral with (nolock) )

   DECLARE @dAcfecante   DATETIME
       SET @dAcfecante   = (SELECT fechaant FROM OpcionesGeneral with (nolock) )  

   DECLARE @FechaAnt     CHAR(8)
       SET @FechaAnt     = CONVERT(CHAR(8), @dAcfecante ,112)

   DECLARE @Fecha_Ayer   DATETIME
       SET @Fecha_Ayer   = @dAcfecante

   DECLARE @iFound       INTEGER
      SET  @iFound       = -1

   SELECT  @iFound       = 0
   FROM    BacParamSudaVALOR_MONEDA_CONTABLE with (nolock)  
   WHERE   Fecha         = @dAcfecproc
   AND     Tipo_Cambio  <> 0

   IF @iFound = -1
   BEGIN
      -- RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      -- Para retornar el error al procedimiento llamador y así al usuario
      select convert( varchar(290), '¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ' )
      RETURN -1
   END

   -- MAP  04 Nov.  2099 Inclusion de No ejercidos
   select * into #CaCaja from CaCaja
   update #CaCaja
      set CaCajMtoMon1 = 0 , CaCajMtoMon2 = 0
   where CaCajEstado = 'N'


   select * into #Cliente from BacParamSudaCLIENTE where Clrut in (  select moRutCliente from MoEncContrato union select moRutCliente from MoHisEncContrato )


   DECLARE @Control_Error  INTEGER
   DECLARE @diasdevengar   INTEGER
   DECLARE @correla	       NUMERIC(3)

   DECLARE @FechaActual    CHAR(08)
       SET @FechaActual    = CONVERT(CHAR(8),@Fecha_Hoy,112)

   DECLARE @PrimerDiaMes   CHAR(08)
       SET @PrimerDiaMes   = SUBSTRING(@FechaActual,1,6) + '01'

   DECLARE @FechaValorMoneda DATETIME
   DECLARE @FechaValorMonAye DATETIME

   EXECUTE BacParamSudaSP_FECHA_VALOR_MONEDA @Fecha_Hoy, @FechaValorMoneda OUTPUT
   EXECUTE BacParamSudaSP_FECHA_VALOR_MONEDA @FechaAnt,  @FechaValorMonAye OUTPUT

   ----<< Chequea si es el Primer dia del Mes
   IF SUBSTRING(@PrimerDiaMes,5,2) <> SUBSTRING(@FechaAnt,5,2)
   BEGIN
      SET @FechaAnt     = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)
      SET @diasdevengar = DATEDIFF(DAY, @FechaAnt, @PrimerDiaMes)
   END

   --|========================================================================================|
   --| LLENADO DE ARCHIVO DE CONTABILIZACION         |
   --|========================================================================================|
   TRUNCATE TABLE CntContabiliza

   IF @@ERROR <> 0
   BEGIN
      SELECT  convert( varchar(290) , 'ERROR_PROC FALLA BORRANDO Tabla CntContabiliza.' )
      RETURN -1
   END

   -- Lista de Versiones Anteriores de Contratos
   -- Que están actualmente en cartera
   select  MoNumContrato     = Car.CaNumContrato 
         , MoFechaCreacionRegistro    = Max( MovAnt.MoFechaCreacionRegistro )  
         , MoNumFolioAnterior         = max( MovAnt.MoNumFolio )
   into #ContratoOriginal
   from MoHisEncContrato As MovAnt
      , CaEnCContrato    As Car 
   where  MovAnt.MoNumContrato    = Car.CaNumContrato                  
--      And MovAnt.MoNumFolio    <  Car.CaNumFolio
-- El max(moNumFolio) corresponde al ultimo movimiento generado
 group by Car.CaNumContrato


   SELECT vmfecha
        , vmcodigo
        , vmvalor
   INTO   #VALOR_MONEDA
   FROM   BacParamSudaVALOR_MONEDA with (nolock)
   WHERE (   vmfecha   = @dAcfecproc 
          or vmfecha = @dAcfecante 
          or vmfecha in ( select MoFechaCreacionRegistro from #ContratoOriginal ) 
         )
   and    vmcodigo  NOT IN(999,998)
   
   INSERT INTO #VALOR_MONEDA
   SELECT @dAcfecproc
   ,      vmcodigo
   ,      vmvalor
   FROM   BacParamSudaVALOR_MONEDA with (nolock)
  WHERE  (     vmfecha   = @FechaValorMoneda 
           )
   AND    vmcodigo  = 998

   INSERT INTO #VALOR_MONEDA
   SELECT @dAcfecante
   ,      vmcodigo
   ,      vmvalor
   FROM   BacParamSudaVALOR_MONEDA with (nolock)
   WHERE  vmfecha   = @FechaValorMonAye
   AND    vmcodigo  = 998

   INSERT INTO #VALOR_MONEDA
   SELECT vmfecha
        , vmcodigo
        , vmvalor
   FROM   BacParamSudaVALOR_MONEDA with (nolock)
   WHERE      vmfecha in ( select MoFechaCreacionRegistro from #ContratoOriginal ) 
          and vmfecha <> @dAcfecproc and vmfecha <> @dAcfecante 
   and    vmcodigo  IN (998)



   INSERT INTO #VALOR_MONEDA 
   SELECT @dAcfecproc
   ,      999
   ,      1.0
   
   INSERT INTO #VALOR_MONEDA
   SELECT @dAcfecante
   ,      999
   ,      1.0

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmfecha       = Fecha
   ,      vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor       = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSudaVALOR_MONEDA_CONTABLE WITH (NOLOCK)
   WHERE (    Fecha         = @dAcfecproc 
           OR Fecha         = @dAcfecante
           OR fecha in ( select MoFechaCreacionRegistro from #ContratoOriginal ) 
          )
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)

   -- POR HACER: agregar los valores de moneda no reajustables 
   -- de días en que se hayan cursado contratos para evaluar los
   -- reversos de conceptos ML.

   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmfecha
   ,      vmcodigo
   ,      vmvalor
   FROM   #VALOR_MONEDA 
   WHERE  vmcodigo  IN(994,995,997,998,999)

   DECLARE @fValorDo_Hoy   FLOAT
       SET @fValorDo_Hoy   = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 994)

   DECLARE @fValorIvp_Hoy  FLOAT
       SET @fValorIvp_Hoy  = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 997)

   DECLARE @fValorUf_Hoy   FLOAT
       SET @fValorUf_Hoy   = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 998)


-- 16 Septiembre, MAP
-- Pagos al inicio

-- PRIMA
   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
    ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML
     ,CntPagar
     ,CntRecibir
     ,CntCompPagar
     ,CntCompRecibir
     ,CntUtiPrima
     ,CntUtiPrimaML
     ,CntPerPrima
     ,CntPerPrimaML
     ,CntRevRecibirML
     ,CntRevEntregarML
     ,CntRevRecibir
     ,CntRevEntregar
     ,CntBancoNoBanco

   ) 
   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              =  'LTE'               -- Liquidacion total ejercida, para Primas  
   ,CntTipoOperacion               =  'LTE'     -- Esto es por Contrato
   ,CntInstrumento                 = ''    
   ,CntMoneda                      = CaCodMonPagPrima   -- Moneda de apgo de la primea
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = 1                  -- Un solo pago por Contrato, inpendiente de la cantidad de componentes.
   ,CntFolio                       = Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = case when CaPrimaInicialML > 0 then CafPagoPrima else 0 end      -- MAP oct 14 recupera semantica 
   ,CntFormaPagoEntregar           = case when CaPrimaInicialML <= 0 then CafPagoPrima else 0 end
   ,CntValorStrike                 = 0.0
   ,CntValorStrikeML               = 0.0
   ,CntSubyacente                  = 0.0
   ,CntSubyacenteML                = 0.0
   ,CntPagarML                     = case when CaPrimaInicialML < 0 then -CaPrimaInicialML else 0 end 
   ,CntRecibirML                   = case when CaPrimaInicialML >= 0 then CaPrimaInicialML else 0 end 
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0
   ,CntPagar                       = case when CaPrimaInicial < 0 then -CaPrimaInicial else 0 end
   ,CntRecibir                     = case when CaPrimaInicial >= 0 then CaPrimaInicial else 0 end 
   ,CntCompPagar                   = 0
   ,CntCompRecibir                 = 0

   -- MAP 13 Octubre, cambios en administracion de vencimiento
   ,CntUtiPrima                    = 0
   ,CntUtiPrimaML                  = 0                  
   ,CntPerPrima                    = 0
   ,CntPerPrimaML                  = 0
   ,CntRevRecibirML                = 0
   ,CntRevEntregarML               = 0
   ,CntRevRecibir                  = 0
   ,CntRevEntregar                 = 0
   ,CntBancoNoBanco                = case when CltipCli in ( 1, 2 )  then 1 else 2 end -- Banco <-> no Banco 


   FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN BacParamSudaCLiente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                                                   AND Cli.clcodigo = Enc.CaCodigo 
   WHERE  
          (  Enc.CaFechaPagoPrima      = @Fecha_Hoy and CaRelacionaPAE = 0 
		  or CaRelacionaPAE = 1 and Enc.CaFechaContrato = @Fecha_Hoy )
   AND     Enc.CaEstado              = ''


-- PRIMA
   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
 ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML
     ,CntPagar
     ,CntRecibir
     ,CntCompPagar
     ,CntCompRecibir
     -- AMP 14 Octubre
     ,CntUtiPrima
     ,CntUtiPrimaML
     ,CntPerPrima
     ,CntPerPrimaML
     ,CntRevRecibirML
     ,CntRevEntregarML
     ,CntRevRecibir
     ,CntRevEntregar
     ,CntBancoNoBanco
   ) 
   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              = 'REV'               -- Liquidacion total ejercida, para Primas  
   ,CntTipoOperacion               = 'REV'
   ,CntInstrumento                 = ''    
   ,CntMoneda                      = CaCajMdaM1          -- Moneda de apgo de la prima en caja
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = 1                 -- Un solo pago por Contrato, inpendiente de la cantidad de componentes.
   ,CntFolio                       = Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = case when CaCajMtoMon1 > 0 then CaCajFormaPagoMon1 else 0 end    -- MAP 14 Oct. hay semantica --MAP 02 Nov 
   ,CntFormaPagoEntregar           = case when CaCajMtoMon1 < 0 then CaCajFormaPagoMon1 else 0 end    -- hay semantica --MAP 02 Nov 
   ,CntValorStrike                 = 0.0  
   ,CntValorStrikeML               = 0.0
   ,CntSubyacente                  = 0.0
   ,CntSubyacenteML                = 0.0
   ,CntPagarML                     = case when CaPrimaInicialML < 0 then  -CaPrimaInicialML else 0 end    
   ,CntRecibirML                   = case when CaPrimaInicialML >= 0 then +CaPrimaInicialML else 0 end   
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML           = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0
   ,CntPagar                       = case when CaCajMtoMon1 < 0 then  -CaCajMtoMon1 else 0 end     -- MAP 17 Nov. Concepto no negativo.     
   ,CntRecibir                     = case when CaCajMtoMon1 >= 0 then +CaCajMtoMon1 else 0 end       
   ,CntCompPagar                   = 0
   ,CntCompRecibir                 = 0
   -- MAP 13 Octubre, cambios en administracion de vencimiento
   ,CntUtiPrima                    = 0
   ,CntUtiPrimaML                  = 0                  
   ,CntPerPrima                    = 0
   ,CntPerPrimaML                  = 0
   ,CntRevRecibirML                = 0
   ,CntRevEntregarML               = 0
   ,CntRevRecibir                  = 0
   ,CntRevEntregar                 = 0
   ,CntBancoNoBanco                = case when CltipCli in ( 1, 2 )  then 1 else 2 end -- Banco <-> no Banco 
  FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN BacParamSudaCLiente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                                                   AND Cli.clcodigo = Enc.CaCodigo 
          LEFT JOIN CaVenCaja Caj  with (nolock) ON       Caj.CaNumContrato = Enc.CaNumContrato       -- Valuta se maneja de mov. caj. vencidos

         
   WHERE  
           Enc.CaEstado              = ''
   AND     Caj.CaCajFechaPagMon1     = @Fecha_Hoy   -- Vencimiento de Valuta
   AND     Caj.CaCajModalidad        = 'C' 
   AND     Caj.CaCajOrigen           = 'PP'          -- Prima
   AND     Caj.CaCajFormaPagoMon1 not in ( 2, 3, 5, 6, 7, 8, 15, 16, 123, 140, 141, 142 )  -- MAP 17 Nov. 2009

-- 16 Septiembre, MAP

-- MAP 17 de Septiembre Pago Total al vencimiento
-- Pago al Vencimiento, compensacion, EF movera dos perfiles.
-- Cruzar encabezado con CaCaja 'PV' seguna la fecha de pago

   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML
     ,CntPagar
     ,CntRecibir
     ,CntCompPagar
     ,CntCompRecibir
     ,CntUtiPrima
     ,CntUtiPrimaML
     ,CntPerPrima
     ,CntPerPrimaML
     ,CntRevRecibirML
     ,CntRevEntregarML
     ,CntRevRecibir
     ,CntRevEntregar
     ,CntBancoNoBanco
   ) 
   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              = 'LTE'
   ,CntTipoOperacion               = 'LTE'
   ,CntInstrumento                 = ''                                             -- select * from CaCaja
   ,CntMoneda                      = Caj.CaCajMdaM1 
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = 0                                             -- select * from CaEncContrato
   ,CntFolio                       = Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   -- MAP 14 Octubre se retorna con la semantica
   -- MAP 12 Nov. Contabilizacion liquidacion de Anticipo
   ,CntFormaPagoRecibir            = case when Enc.CaTipoTransaccion = 'ANTICIPA' then case when CaUnwind > 0 then CaFormPagoUnwind else 0 end
                                          else 
                                              case when sum( CaCajMtoMon1 ) > 0 then CaCajFormaPagoMon1  else 0 end   
                                          end
   ,CntFormaPagoEntregar           = case when Enc.CaTipoTransaccion = 'ANTICIPA' then case when CaUnwind < 0 then CaFormPagoUnwind else 0 end
                                          else 
                                              case when sum( CaCajMtoMon1 ) <= 0 then CaCajFormaPagoMon1  else 0 end
                                          end
   ,CntValorStrike                 = 0.0
   ,CntValorStrikeML               = 0.0
   ,CntSubyacente                  = 0.0
   ,CntSubyacenteML                = 0.0
   ,CntPagarML                     = 0.0                                           
   ,CntRecibirML                   = 0.0 
   ,CntCompRecibirML               = case when Enc.CaTipoTransaccion = 'ANTICIPA' then case when CaUnwind > 0 then CaUnwindML else 0 end
                                          else 
                                              case when sum( CaCajMtoMon1 ) > 0 then sum( CaCajMtoMon1 ) else 0.0 end 
                                          end
   ,CntCompPagarML                 = case when Enc.CaTipoTransaccion = 'ANTICIPA' then case when CaUnwind < 0 then -CaUnwindML else 0 end
                                          else 
                                              case when sum( CaCajMtoMon1 ) < 0 then -sum( CaCajMtoMon1 ) else 0.0 end 
                                          end
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0

   ,CntPagar                       = 0
   ,CntRecibir                     = 0
   ,CntCompPagar                   = case when Enc.CaTipoTransaccion = 'ANTICIPA' then case when CaUnwind < 0 then -CaUnwind else 0 end
                                          else 
                                              case when sum(  Caj.CaCajMtoMon1 ) <= 0 then  -sum(  Caj.CaCajMtoMon1 ) else 0.0 end -- MAP 14 Octubre Corrige Error
                                          end
   ,CntCompRecibir                 = case when Enc.CaTipoTransaccion = 'ANTICIPA' then case when CaUnwind > 0 then CaUnwind else 0 end
                                          else 
                                              case when sum(  Caj.CaCajMtoMon1 ) > 0 then  +sum(  Caj.CaCajMtoMon1 ) else 0.0 end
                                          end

   -- MAP 13 Octubre, cambios en administracion de vencimiento
   ,CntUtiPrima                    = 0  -- No aplica en LTE
   ,CntUtiPrimaML                  = 0  -- No aplica en LTE               
   ,CntPerPrima                    = 0  -- No aplica en LTE
   ,CntPerPrimaML                  = 0  -- No aplica en LTE
   ,CntRevRecibirML                = 0  -- No aplica en LTE
   ,CntRevEntregarML               = 0  -- No aplica en LTE
   ,CntRevRecibir                  = 0  -- No aplica en LTE
   ,CntRevEntregar                 = 0  -- No aplica en LTE
   ,CntBancoNoBanco                = case when CltipCli in ( 1, 2 )  then 1 else 2 end -- Banco <-> no Banco 

     FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN BacParamSudaCLiente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                                                   AND Cli.clcodigo = Enc.CaCodigo 
        , CaDetContrato As Det with (nolock)  
        , CaCaja        As Caj with (nolock)
   WHERE   Enc.CaNumContrato          = Det.CaNumContrato 
   AND     Enc.CaEstado              = ''  
   AND     Caj.CaCajEstado           in ( 'E', 'N' )           -- Liquidacion Opciones Ejercidas y No Ejercida -- MAP 04 Nov.   
   AND     Caj.CaCajFecPago          = @Fecha_Hoy
   AND     Caj.CaNumContrato         = Det.CaNumContrato
   AND     Caj.CaNumEstructura       = Det.CaNumEstructura     -- MAP 08 Octubre Join mal manejado
   AND     Caj.CaCajModalidad        = 'C'  
   AND     Caj.CaCajOrigen           in ( 'PV'  , 'PA' )
   group by
                Enc.CaSistema
              , Caj.CaCajMdaM1
              , Enc.CaNumContrato
              , Enc.CaNumFolio
              , Enc.CaCarNormativa
              , Enc.CaSubCarNormativa
              , CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END
              , CaCajFormaPagoMon1
              , CaCajModalidad
              , Cli.CltipCli
              , Enc.CaTipoTransaccion
              , Enc.CaUnwind
              , Enc.CaUnwindML
              , Enc.CaFormPagoUnwind


 -- Error de JOin


--   update CntContabiliza
--       set   CntCompRecibirML = CntCompRecibir * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
--                                                                      where vmfecha  = @Fecha_Hoy 
--                                                                     AND vmcodigo = CntMoneda), 1 )
--           , CntCompPagarML   = CntCompPagar   * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
--                                                                      where vmfecha  = @Fecha_Hoy 
--                                                                     AND vmcodigo = CntMoneda), 1 )
--
--           -- MAP 14 Octubre Actualizacion de la forma de pago con la codificacion contable
--           , CntFormaPagoRecibir  = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
--                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
--                                                   and tbtasa = CntFormaPagoRecibir ), 0 )
--           , CntFormaPagoEntregar = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
--                 where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
--                                                  and tbtasa = CntFormaPagoEntregar ), 0 ) 
--     where     CntSisCod                      = 'OPT'
--           and CntTipoMovimiento              = 'LTE'
--           and CntTipoOperacion               = 'LTE'



-- select * from cntcontabiliza

 
-- Reverso Vencimiento 

   INSERT INTO CntContabiliza
   (      
      CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML
     ,CntPagar
     ,CntRecibir
     ,CntCompPagar
     ,CntCompRecibir
    -- MAP 14 OCtubre 
     ,CntUtiPrima
     ,CntUtiPrimaML
     ,CntPerPrima
     ,CntPerPrimaML
     ,CntRevRecibirML
     ,CntRevEntregarML
     ,CntRevRecibir
     ,CntRevEntregar
     ,CntBancoNoBanco
   ) 
   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              = 'REV'
   ,CntTipoOperacion               = 'REV'
   ,CntInstrumento                 = ''                                             -- select * from CaCaja
   ,CntMoneda                      = Caj.CaCajMdaM1 
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = 0                                             -- Pago total es de todo el contrato
   ,CntFolio                       = Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = case when sum( CaCajMtoMon1 ) > 0  then CaCajFormaPagoMon1 else 0 end   -- MAP 14 Octubre existe semantica recibir - entregar 
   ,CntFormaPagoEntregar           = case when sum( CaCajMtoMon1 ) <= 0 then CaCajFormaPagoMon1 else 0 end   -- MAP 14 Octubre existe semantica recibir - entregar
   ,CntValorStrike                 = 0.0
   ,CntValorStrikeML               = 0.0
  ,CntSubyacente                  = 0.0
   ,CntSubyacenteML                = 0.0
   ,CntPagarML                     = 0.0
   ,CntRecibirML                   = 0.0 
   ,CntCompRecibirML               = Case when sum( CaCajMtoMon1 ) > 0 
                                         then
           sum( CaCajMtoMon1 ) * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                         else 0.0 end
   ,CntCompPagarML                 = Case when sum( Caj.CaCajMtoMon1 ) <= 0 
                                         then
                                             abs( sum( Caj.CaCajMtoMon1 ) )  * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                         else 0.0 end
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0

   ,CntPagar                       = 0
   ,CntRecibir                     = 0
   ,CntCompPagar                  = case when sum( Caj.CaCajMtoMon1 ) <= 0 
                                         then
                                             abs( sum( Caj.CaCajMtoMon1) ) 
                                         else 0.0 end
                                     
   ,CntCompRecibir                 = Case when sum( CaCajMtoMon1 ) > 0 
                   then
                                             sum( CaCajMtoMon1 )
                                         else 0.0 end
                                     
   -- MAP 13 Octubre, cambios en administracion de vencimiento
   ,CntUtiPrima                    = 0  -- NO Aplica
   ,CntUtiPrimaML                  = 0  -- NO Aplica                
   ,CntPerPrima                    = 0  -- NO Aplica
   ,CntPerPrimaML                  = 0  -- NO Aplica
   ,CntRevRecibirML                = 0  -- NO Aplica
   ,CntRevEntregarML               = 0  -- NO Aplica
   ,CntRevRecibir                  = 0  -- NO Aplica
   ,CntRevEntregar                 = 0  -- NO Aplica
   ,CntBancoNoBanco                = case when CltipCli in ( 1, 2 )  then 1 else 2 end -- Banco <-> no Banco 

     FROM   CaVenEncContrato As Enc with (nolock)
          LEFT JOIN BacParamSudaCLiente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                                                   AND Cli.clcodigo = Enc.CaCodigo 
        , CaVenDetContrato As Det with (nolock)  
        , CaVenCaja     As Caj with (nolock)
   WHERE   Enc.CaNumContrato          = Det.CaNumContrato 
   AND     Enc.CaEstado              = ''
   AND     Caj.CaCajEstado           = 'E'                     -- Liquidacion Opciones Ejercidas    
   AND     Caj.CaNumContrato         = Det.CaNumContrato
   AND     Caj.CaCajModalidad        = 'C'  
   AND     Caj.CaCajFechaPagMon1     = @Fecha_Hoy              -- Vencimiento de Valuta
   AND     Caj.CaCajModalidad        = 'C' 
   AND     Caj.CaCajOrigen           in ( 'PV', 'PA' )         -- Pago al vencimiento, MAP 17 Nov. 2009 Pago Anticipa
   AND     Caj.CaCajFormaPagoMon1 not in ( 2, 3, 5, 6, 7, 8, 15, 16, 123, 140, 141, 142 )  -- MAP 17 Nov. 2009

   group by
                Enc.CaSistema
              , Caj.CaCajMdaM1
              , Enc.CaNumContrato
              , Enc.CaNumFolio
              , Enc.CaCarNormativa
              , Enc.CaSubCarNormativa
              , CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END
              , CaCajFormaPagoMon1
              , CaCajModalidad
              , Cli.CltipCli

--***************************************************************************************************
-- MAP 17 de Septiembre


   -- MAP 14 Octubre Falta aplicar esto sobre los REV
   update  CntContabiliza
	 set  CntFormaPagoRecibir  = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
                                                   and tbtasa = CntFormaPagoRecibir ), 0 )
            , CntFormaPagoEntregar = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
                                                  and tbtasa = CntFormaPagoEntregar ), 0 ) 
     where     CntSisCod                      = 'OPT'
           and CntTipoMovimiento              = 'REV'
           and CntTipoOperacion               = 'REV'





-- Pagos al inicio

   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
  ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML
     ,CntBancoNoBanco
   ) -- select * from cntContabiliza where CntContrato = 781
  -- Registro de Activo o Pasivo al inicio
   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              =  'LIQ'
   ,CntTipoOperacion               = ltrim( ltrim( Det.CaSubyacente ) ) + rtrim( ltrim( Det.CaCVOpc ) )+ substring( Det.CaCallPut, 1, 1 )
   ,CntInstrumento                 = Det.CaCodMon2
   ,CntMoneda                      = Det.CaCodMon1
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = Det.CaNumEstructura
   ,CntFolio                       = 0 -- PROD 7274 Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = case when CaPrimaInicial > 0 then  CafPagoPrima else 0 end 
   ,CntFormaPagoEntregar           = case when CaPrimaInicial <= 0 then CafPagoPrima else 0 end 
   ,CntValorStrike                 = 0.0
   ,CntValorStrikeML               = 0.0
   ,CntSubyacente                  = 0.0
   ,CntSubyacenteML                = 0.0
   ,CntPagarML                     = case when CaPrimaInicialdetML < 0 then -CaPrimaInicialdetML else 0 end 
   ,CntRecibirML                   = case when CaPrimaInicialDetML >= 0 then CaPrimaInicialDetML else 0 end 
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0
   ,CntBancoNoBanco                = case when CltipCli in ( 1, 2 )  then 1 else 2 end

   FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN BacParamSudaCLiente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                                                   AND Cli.clcodigo = Enc.CaCodigo 
        , CaDetContrato As Det with (nolock)
   WHERE  Enc.CaNumContrato = Det.CaNumContrato 
 --   AND  (  Enc.CaFechaContrato = @Fecha_Hoy  and CaTipoTransaccion = 'CREACION'
 --         or
 --          Enc.CaFechaCreacionRegistro = @Fecha_Hoy  and CaTipoTransaccion = 'MODIFICA'
 --        )
 -- PAE:
 -- Registro de la prima como primer valor del contrato, no se puede usar la CaFechaPagoPrima 
   AND     Enc.CaFechaContrato      = @Fecha_Hoy   -- PROD 7274 -- AND     Enc.CaFechaPagoPrima      = @Fecha_Hoy
   AND     Enc.CaEstado              = ''
   AND     Enc.CaTipoTransaccion     <> 'ANTICIPA'            -- MAP 14 Octubre Este caso no deberia darse, se confirmará por e-mail
-- MAP Julio 24

-- Pagos al final x COmponente
   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML
     -- MAP 14 Octubre 
     ,CntPagar                       
     ,CntRecibir                    
     ,CntCompPagar                   
     ,CntCompRecibir                
     -- MAP 13 Octubre, cambios en administracion de vencimiento
     ,CntUtiPrima                    
     ,CntUtiPrimaML     
     ,CntPerPrima                    
     ,CntPerPrimaML                 
     ,CntRevRecibirML                
     ,CntRevEntregarML               
     ,CntRevRecibir                 
     ,CntRevEntregar   
     , CntEFisRevEntregarML          
     , CntEFisRevRecibirML                        
     ,CntBancoNoBanco                 
   ) 
   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              =  'LIQ'
   ,CntTipoOperacion               = ltrim( ltrim( Det.CaSubyacente ) ) + rtrim( ltrim( Det.CaCVOpc ) )+ substring( Det.CaCallPut, 1, 1 )
   ,CntInstrumento                 = Det.CaCodMon2
   ,CntMoneda                      = Det.CaCodMon1
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                = Det.CaNumEstructura
   ,CntFolio                       = Caj.CaCajFolio      --- PROD 7274 select * from cacaja
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END  
   ,CntFormaPagoRecibir            = 0
   ,CntFormaPagoEntregar           = 0

-- MAP 15 Octubre se corrige evaluacion del concepto strike
   ,CntValorStrike                 = case when CaCajModalidad = 'E' then abs( CaCajMtoMon2 ) else 0.0 end  
   ,CntValorStrikeML               = case when CaCajModalidad = 'E' then abs( CaCajMtoMon2 ) else 0.0 end
   ,CntSubyacente                  = case when CaCajModalidad = 'E' then abs( CaCajMtoMon1 ) else 0.0 end
   ,CntSubyacenteML                = case when CaCajModalidad = 'E' then abs( CaCajMtoMon1 ) * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) else 0.0 end
   ,CntPagarML                     = 0.0
   ,CntRecibirML                   = 0.0 
   ,CntCompRecibirML               = Case when CaCajModalidad = 'C' 
                                     then
                                         case when CaCajMtoMon1 > 0 
                                         then
                                             CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                         else 0.0 end
                                    else
                                        0.0 -- case when CaMTMImplicito > 0 then CaMTMImplicito else 0.0 end -- concepto debe evaluar 0 para EF  -- PRD XXXX
                                     end 
   ,CntCompPagarML                 = Case when Caj.CaCajModalidad = 'C' 
                                     then
                                         case when Caj.CaCajMtoMon1 <= 0 
                                   then
                                             abs( Caj.CaCajMtoMon1 )  * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) -- PRD XXXX
                                         else 0.0 end
                                     else
                                        0.0 -- case when CaMTMImplicito > 0 then CaMTMImplicito else 0.0 end -- concepto debe evaluar 0 para EF
                                     end
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
 ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0
   ,CntPagar                       = 0
   ,CntRecibir                     = 0
   ,CntCompPagar                   = case when Caj.CaCajModalidad = 'C'  then 
                                          case when Caj.CaCajMtoMon1  <= 0 
                              then
                                             abs(  Caj.CaCajMtoMon1 ) 
                                         else 0.0 end
                                      else
                                          0.0
                                      end
                                     
   ,CntCompRecibir                 = case when Caj.CaCajModalidad = 'C' then
                                           Case when  CaCajMtoMon1  > 0 
                                         then
                                              CaCajMtoMon1 
                                         else 0.0 end
                                     else
                                         0.0 
                                     end
   -- MAP 13 Octubre, cambios en administracion de vencimiento
   -- select * from CaCaja
   -- Concpeto en moneda origen no se puede porque hay dos monedas origen: Mda 
   -- compensacion y moneda prima.
   ,CntUtiPrima                    = round( case when Caj.CaCajModalidad = 'C' then                                                   
                                         (     CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                           - - CaPrimaInicialDetML )
                                         
                                       * ( case when CaCVOpc = 'C'                          then 1.0 else 0.0 end )

                                       * ( case when CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                           - - CaPrimaInicialDetML > 0 then 1.0 else 0.0 end )

                                       + ( CaPrimaInicialDetML 
                                           - - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) )

                                       * ( case when CaCVOpc = 'V'                          then 1.0 else 0.0 end )

           * ( case when CaPrimaInicialDetML - - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) > 0 then 1.0 else 0.0 end )
                                     else -- PRD XX 
									      case when Caj.CaMTMImplicito + CaPrimaInicialDetML > 0 then Caj.CaMTMImplicito + CaPrimaInicialDetML else 0 end
								     end , 0 )
   ,CntUtiPrimaML                  = round( case when Caj.CaCajModalidad = 'C' then                                                   
                                         (     CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                           - - CaPrimaInicialDetML )
               
                                       * ( case when CaCVOpc = 'C'                          then 1.0 else 0.0 end )

                                       * ( case when CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
  AND vmcodigo = Caj.CaCajMdaM1), 1 )
                                           - - CaPrimaInicialDetML > 0 then 1.0 else 0.0 end )

                                       + ( CaPrimaInicialDetML 
                                           - - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) )

                                       * ( case when CaCVOpc = 'V'                          then 1.0 else 0.0 end )

                                       * ( case when CaPrimaInicialDetML - - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) > 0 then 1.0 else 0.0 end )
                                     else -- PRD XX 
									      case when Caj.CaMTMImplicito + CaPrimaInicialDetML > 0 then Caj.CaMTMImplicito + CaPrimaInicialDetML else 0 end
                                     end , 0 )                
   ,CntPerPrima                    = round( case when Caj.CaCajModalidad = 'C' then                                                   
                                         (  - CaPrimaInicialDetML - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) )
                                       * ( case when CaCVOpc = 'C'                          then 1.0 else 0.0 end )
                                       * ( case when  - CaPrimaInicialDetML - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) > 0 then 1.0 else 0.0 end )
                                       + ( - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) 
                                           - CaPrimaInicialDetML   )
                                       * ( case when CaCVOpc = 'V'                          then 1.0 else 0.0 end )
                                       * ( case when - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) 
                                           - CaPrimaInicialDetML  > 0 then 1.0 else 0.0 end )
                                     else  -- PRD XXXX
									       case when Caj.CaMTMImplicito + CaPrimaInicialDetML < 0 then abs( Caj.CaMTMImplicito + CaPrimaInicialDetML ) else 0 end
                                         end, 0 )
   ,CntPerPrimaML                  = round( case when Caj.CaCajModalidad = 'C' then                                                   
                                         (  - CaPrimaInicialDetML - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) )
                                       * ( case when CaCVOpc = 'C'                          then 1.0 else 0.0 end )
                                       * ( case when  - CaPrimaInicialDetML - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) > 0 then 1.0 else 0.0 end )
                                       + ( - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) 
                                           - CaPrimaInicialDetML   )
                                   * ( case when CaCVOpc = 'V'                          then 1.0 else 0.0 end )
                                       * ( case when - CaCajMtoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = Caj.CaCajMdaM1), 1 ) 
                                  - CaPrimaInicialDetML  > 0 then 1.0 else 0.0 end )
                                     else  -- PRD XXXX
									     case when Caj.CaMTMImplicito + CaPrimaInicialDetML < 0 then abs( Caj.CaMTMImplicito + CaPrimaInicialDetML ) else 0 end									     
                                     end , 0 )

   -- PRD XXXX Estos conceptos se utilizarán para Entrega Fisica y Compensación
   , CntRevRecibirML                = Round(case when CaPrimaInicialDetML >  0 then CaPrimaInicialDetML else 0.0 end  
                                      --  * ( case when Caj.CaCajModalidad = 'C' then 1.0 else 0.0 end)
									  ,0)
   , CntRevEntregarML               = Round(case when CaPrimaInicialDetML <= 0 then -CaPrimaInicialDetML else 0.0 end 
                                      -- * ( case when Caj.CaCajModalidad = 'C' then 1.0 else 0.0 end)
									  ,0)
   , CntRevRecibir                  = case when CaPrimaInicialDet >  0 then CaPrimaInicialDet else 0.0 end  
                                      --* ( case when Caj.CaCajModalidad = 'C' then 1.0 else 0.0 end)
   , CntRevEntregar                 = case when CaPrimaInicialDet <= 0 then -CaPrimaInicialDet else 0.0 end 
                                      --* ( case when Caj.CaCajModalidad = 'C' then 1.0 else 0.0 end)

   -- Comceptos Reutilizados   
   , CntEFisRevEntregarML           = -- PRD XXXX Compensacion Equivalente para entrega fisica
									       case when Caj.CaMTMImplicito  < 0 then abs(Caj.CaMTMImplicito) else 0 end
                                        * ( case when Caj.CaCajModalidad = 'E' then 1 else 0 end) 
   , CntEFisRevRecibirML          = -- PRD XXXX Compensacion Equivalente para entrega fisica
									     case when Caj.CaMTMImplicito > 0 then Caj.CaMTMImplicito else 0 end 										  
                                      * ( case when Caj.CaCajModalidad = 'E' then 1 else 0 end) 

   , CntBancoNoBanco                = case when CltipCli in ( 1, 2 )  then 1 else 2 end -- Banco <-> no Banco 

   FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN BacParamSudaCLiente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
    AND Cli.clcodigo = Enc.CaCodigo 
        , CaDetContrato As Det with (nolock)  
        , #CaCaja       As Caj with (nolock)
   WHERE   Enc.CaNumContrato          = Det.CaNumContrato 
   AND     Enc.CaEstado              = ''   
   AND     Det.CaFechaPagoEjer       = @Fecha_Hoy
   AND     Caj.CaCajFecPago     = @Fecha_Hoy
   AND     ( Caj.CaCajOrigen         <> 'PP' )  -- PROD 7274 PAE
   AND     Caj.CaNumContrato         = Det.CaNumContrato
   AND     Caj.CaNumEstructura       = Det.CaNumEstructura
   AND    not (  Enc.CaTipoTransaccion = 'ANTICIPA'         
            and Enc.CaFechaContrato = @Fecha_Hoy )   
   -- MAP 14 Octubre Este caso SI deberia darse, pero no resiste que sea en el dia
   -- Se deja inmune a pruebas select * from caDetContrato

-- MAP Julio 24


   --> ***************************************
   --> Contabilidad Movimiento 
   --  Se contabiliza el movimiento y creacion 
   --  como si todo fuera nuevo
   --  más abajo se "descontabiliza" la 
   -- versión anterior del contrato.
   --> ***************************************
   -- select * from cntContabiliza order by CntContrato,   CntComponente
   -- select 'debug', * from #VALOR_TC_CONTABLE order by vmfecha, vmcodigo

   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
   ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML

   ) 

   SELECT 
    CntSisCod                      = Enc.MoSistema
   ,CntTipoMovimiento              =  'MOV'
   ,CntTipoOperacion               = ltrim( ltrim( Det.MoSubyacente ) ) + rtrim( ltrim( Det.MoCVOpc ) )+ substring( Det.MoCallPut, 1, 1 )
   ,CntInstrumento                 = Det.MoCodMon2
   ,CntMoneda                      = Det.MoCodMon1
   ,CntContrato                    = Enc.MoNumContrato
   ,CntComponente           = Det.MoNumEstructura
   ,CntFolio                       = Det.MoNumFolio
   ,CntCarteraNormativa            = Enc.MoCarNormativa
   ,CntSubCarteraNormativa         = Enc.MoSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = Case when Det.MoCVOpc = 'C' then 
                                     Case when Det.MoCallPut = 'Call' then Det.MoFormaPagoMon1 else Det.MoFormaPagoMon2 end
                                  else
                                     Case when Det.MoCallPut = 'Call' then Det.MoFormaPagoMon2 else Det.MoFormaPagoMon1 end
end
   ,CntFormaPagoEntregar           = Case when Det.MoCVOpc = 'C' then 
                                     Case when Det.MoCallPut = 'Call' then Det.MoFormaPagoMon2 else Det.MoFormaPagoMon1 end
                                  else
                                     Case when Det.MoCallPut = 'Call' then Det.MoFormaPagoMon1 else Det.MoFormaPagoMon2 end
                                  end
   ,CntValorStrike                 = Det.MoMontoMon2
   ,CntValorStrikeML               = Det.MoMontoMon2 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha  = @dAcfecproc AND vmcodigo = Mocodmon2), 1 )
   ,CntSubyacente                  = Det.MoMontoMon1
   ,CntSubyacenteML                = Det.MoMontoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha  = @dAcfecproc AND vmcodigo = Mocodmon1), 1 )
   ,CntPagarML  = 0
   ,CntRecibirML                   = 0
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML            = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0



   FROM   MoEncContrato As Enc with (nolock)
          LEFT JOIN #Cliente Cli with (nolock)  ON     Cli.clrut    = Enc.MoRutCliente  
            AND Cli.clcodigo = Enc.MoCodigo 
        , MoDetContrato As Det with (nolock)
   WHERE  Enc.MoNumFolio = Det.MoNumFolio 
   AND  (  Enc.MoFechaContrato = @Fecha_Hoy  and MoTipoTransaccion = 'CREACION'
          or
            convert( varchar(8), Enc.MoFechaCreacionRegistro, 112 ) = @Fecha_Hoy  and MoTipoTransaccion = 'MODIFICA'  -- MAP 13 Nov. 2009
         )
   AND     Enc.MoEstado              = ''
   AND     Enc.MoTipoTransaccion     not in ( 'ANULA', 'ANTICIPA' )  -- MAP 22 Octubre 2009
   AND     Enc.MoNumContrato         not in ( select MoNumContrato from MoEncContrato where MoTipoTransaccion = 'ANULA' ) -- MAP 09 Noviembre 2009


   /*-- 
   select  'debug', mofechaContrato, MoFechaCreacionRegistro, MoTipoTransaccion, count(*) 
   from moEncContrato group by mofechaContrato, MoFechaCreacionRegistro, MoTipoTransaccion,

   */


  /* Reverso de Movimiento */
  /* Contabiliza Revero de Nocionales por 
   -- modificación , anticipo anulacion
   -- Nota: cada vez que se anule se reversarán los nocionales
   --     parándose en el movimiento de anulacion, anticipo , modifica
   --       referenciando el movimiento anterior, mínimo tiene que 
   --       existir el de CREACION.

  */

 
   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML

   )
 
   SELECT distinct
   CntSisCod                      = Enc.MoSistema
   ,CntTipoMovimiento            =  'MOV'
   ,CntTipoOperacion               = ltrim( ltrim( Det.MoSubyacente ) ) + rtrim( ltrim( Det.MoCVOpc ) )+ substring( Det.MoCallPut, 1, 1 )
   ,CntInstrumento                 = Det.MoCodMon2
   ,CntMoneda                      = Det.MoCodMon1
   ,CntContrato                    = Enc.MoNumContrato
   ,CntComponente                  = Det.MoNumEstructura
   ,CntFolio                       = EncAnt.MoNumFolio 
   ,CntCarteraNormativa            = EncAnt.MoCarNormativa 
   ,CntSubCarteraNormativa         = EncAnt.MoSubCarNormativa 
   ,CntExtNacional                 = CASE WHEN cliAnt.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir     = Case when DetAnt.MoCVOpc = 'C' then 
                                               Case when DetAnt.MoCallPut = 'Call' then DetAnt.MoFormaPagoMon1 else DetAnt.MoFormaPagoMon2 end
                                   else
                                               Case when DetAnt.MoCallPut = 'Call' then DetAnt.MoFormaPagoMon2 else DetAnt.MoFormaPagoMon1 end
                                              end 
   ,CntFormaPagoEntregar           = Case when DetAnt.MoCVOpc = 'C' then 
                                              Case when DetAnt.MoCallPut = 'Call' then DetAnt.MoFormaPagoMon2 else DetAnt.MoFormaPagoMon1 end
                                             else
                                              Case when DetAnt.MoCallPut = 'Call' then DetAnt.MoFormaPagoMon1 else DetAnt.MoFormaPagoMon2 end
                                             end 
   ,CntValorStrike                 =  - DetAnt.MoMontoMon2  
   ,CntValorStrikeML               =  - DetAnt.MoMontoMon2 
                                  * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE 
              vmfecha  = EncAnt.MoFechaCreacionRegistro AND vmcodigo = DetAnt.Mocodmon2), 1 )
   ,CntSubyacente                  =  - DetAnt.MoMontoMon1 
  ,CntSubyacenteML                =  - DetAnt.MoMontoMon1 
                                  * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE 
                                             vmfecha  = EncAnt.MoFechaCreacionRegistro AND vmcodigo = DetAnt.Mocodmon1), 1 )
   ,CntPagarML                     = 0
   ,CntRecibirML                   = 0
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0

   FROM   MoEncContrato As Enc with (nolock)
          LEFT JOIN #Cliente Cli with (nolock)  ON     Cli.clrut    = Enc.MoRutCliente  
                                            AND Cli.clcodigo = Enc.MoCodigo
        , MoDetContrato     As Det with (nolock)
          -- Cruce Con version Anterior del Contrato
        , MoHisEncContrato  As EncAnt with (nolock)  
          LEFT JOIN #Cliente CliAnt with (nolock)  ON     CliAnt.clrut = EncAnt.MoRutCliente  
                                                   AND CliAnt.clcodigo = EncAnt.MoCodigo
 
    , MoHisDetContrato  As DetAnt 
        , #ContratoOriginal As IndicaAnt with (nolock)                                                         

         
   WHERE  Enc.MoNumFolio    = Det.MoNumFolio 
   and    EncAnt.MoNumFolio = DetAnt.MoNumFolio
   and    Det.MoNumEstructura  = DetAnt.MoNumEstructura  -- MAP 13 Nov 2009 
   and    Enc.MoNumContrato = IndicaAnt.MoNumContrato
   and    Enc.MoNumContrato = EncAnt.MoNumContrato
   and    IndicaAnt.MoNumContrato = EncAnt.MoNumContrato  
   and    IndicaAnt.MoNumFolioAnterior = EncAnt.MoNumFolio
   AND    Enc.MoEstado              = ''
   and    Enc.MoTipoTransaccion     in ( 'MODIFICA'  )   -- MAP 09 Noviembre 2009 se saca 'ANULA' y 13 Nov. 2009 'ANTICIPA'
   and    convert( varchar(8), Enc.MoFechaCreacionRegistro, 112 ) = @Fecha_Hoy  -- MAP 13 Nov. 2009


   

   --> ***************************************
   --> Contabilidad Ajuste al Valor Razonable 
   --> ***************************************
   select * 
   into #CaResDetContrato
   from CaResDetContrato where CaDetFechaRespaldo = @Fecha_Ayer


   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
   ,CntReversoAVRNegML
     ,CntReversoAVRPosML

   ) 

   SELECT   
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              =  'AVR'
   ,CntTipoOperacion               = ltrim( ltrim( Det.CaSubyacente ) ) + rtrim( ltrim( Det.CaCVOpc ) )+ substring( Det.CaCallPut, 1, 1 )
   ,CntInstrumento                 = Det.CaCodMon2
   ,CntMoneda                      = Det.CaCodMon1
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = Det.CaNumEstructura
   ,CntFolio                       = Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = Case when Det.CaCVOpc = 'C' then 
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon1 else Det.CaFormaPagoMon2 end
                                  else
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon2 else Det.CaFormaPagoMon1 end
                                  end
   ,CntFormaPagoEntregar           = Case when Det.CaCVOpc = 'C' then 
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon2 else Det.CaFormaPagoMon1 end
                                  else
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon1 else Det.CaFormaPagoMon2 end
       end
   ,CntValorStrike                 = 0
   ,CntValorStrikeML               = 0
   ,CntSubyacente                  = 0
   ,CntSubyacenteML                = 0
   ,CntPagarML                     = 0
   ,CntRecibirML                   = 0
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0

   -- MAP 08 Octubre Prima debe manipularse en CLP siempre
   -- MAP 14 Octubre No se contabiliza AVR al dia del vencimiento
   ,CntAVRNegML                    = Case when Det.CaVrDetML - -Det.CaPrimaInicialDetML < 0 then  - ( Det.CaVrDetML - -Det.CaPrimaInicialDetML) else 0 end   
                                     * ( case when Det.CaFechaPagoEjer =  @Fecha_Hoy then 0.0 else 1.0 end )
   ,CntAVRPosML                    = Case when Det.CaVrDetML - -Det.CaPrimaInicialDetML > 0 then    ( Det.CaVrDetML - -Det.CaPrimaInicialDetML) else 0 end 
                                     * ( case when Det.CaFechaPagoEjer =  @Fecha_Hoy then 0.0 else 1.0 end )
   ,CntReversoAVRNegML             = (Case when ResDet.CaVrDetML - -ResDet.CaPrimaInicialDetML < 0 then  - ( ResDet.CaVrDetML - -ResDet.CaPrimaInicialDetML) else 0 end  )
   ,CntReversoAVRPosML             = (Case when ResDet.CaVrDetML - -ResDet.CaPrimaInicialDetML > 0 then    ( ResDet.CaVrDetML - -ResDet.CaPrimaInicialDetML) else 0 end   )




   FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN #Cliente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                         AND Cli.clcodigo = Enc.CaCodigo 
 
        , CaDetContrato As Det with (nolock)
          LEFT JOIN #CaResDetContrato ResDet with (nolock)   
                                                ON     ResDet.CaNumContrato   = Det.CaNumContrato 
                                                   AND ResDet.CaNumEstructura = Det.CaNumEstructura
   WHERE  Enc.CaNumContrato = Det.CaNumContrato 
   AND    Enc.CaEstado              = ''

   -- MAP 17 de Septiembre
   -- Bajada de Nocionales
   INSERT INTO CntContabiliza
   (      
     CntSisCod
     ,CntTipoMovimiento
     ,CntTipoOperacion
     ,CntInstrumento
     ,CntMoneda
     ,CntContrato
     ,CntComponente
     ,CntFolio
     ,CntCarteraNormativa
     ,CntSubCarteraNormativa
     ,CntExtNacional
     ,CntFormaPagoRecibir
     ,CntFormaPagoEntregar
     ,CntValorStrike
     ,CntValorStrikeML
     ,CntSubyacente
     ,CntSubyacenteML
     ,CntPagarML
     ,CntRecibirML
     ,CntCompRecibirML
     ,CntCompPagarML
     ,CntCompPosImpML
     ,CntCompNegImpML
     ,CntAVRNegML
     ,CntAVRPosML
     ,CntReversoAVRNegML
     ,CntReversoAVRPosML

   ) 

   SELECT 
    CntSisCod                      = Enc.CaSistema
   ,CntTipoMovimiento              =  'MOV'
   ,CntTipoOperacion               = ltrim( ltrim( Det.CaSubyacente ) ) + rtrim( ltrim( Det.CaCVOpc ) )+ substring( Det.CaCallPut, 1, 1 )
   ,CntInstrumento                 = Det.CaCodMon2
   ,CntMoneda                      = Det.CaCodMon1
   ,CntContrato                    = Enc.CaNumContrato
   ,CntComponente                  = Det.CaNumEstructura
   ,CntFolio                       = Enc.CaNumFolio
   ,CntCarteraNormativa            = Enc.CaCarNormativa
   ,CntSubCarteraNormativa         = Enc.CaSubCarNormativa
   ,CntExtNacional                 = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END 
   ,CntFormaPagoRecibir            = Case when Det.CaCVOpc = 'C' then 
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon1 else Det.CaFormaPagoMon2 end
                                  else
               Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon2 else Det.CaFormaPagoMon1 end
end
   ,CntFormaPagoEntregar           = Case when Det.CaCVOpc = 'C' then 
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon2 else Det.CaFormaPagoMon1 end
                                  else
                                     Case when Det.CaCallPut = 'Call' then Det.CaFormaPagoMon1 else Det.CaFormaPagoMon2 end
                                  end
   ,CntValorStrike                 = -Det.CaMontoMon2
   ,CntValorStrikeML               = -Det.CaMontoMon2 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha  = @dAcfecproc AND vmcodigo = Cacodmon2), 1 )
   ,CntSubyacente                  = -Det.CaMontoMon1
   ,CntSubyacenteML                = -Det.CaMontoMon1 * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha  = @dAcfecproc AND vmcodigo = Cacodmon1), 1 )
 ,CntPagarML = 0
   ,CntRecibirML                   = 0
   ,CntCompRecibirML               = 0
   ,CntCompPagarML                 = 0
   ,CntCompPosImpML                = 0
   ,CntCompNegImpML                = 0
   ,CntAVRNegML                    = 0
   ,CntAVRPosML                    = 0
   ,CntReversoAVRNegML             = 0
   ,CntReversoAVRPosML             = 0



   FROM   CaEncContrato As Enc with (nolock)
          LEFT JOIN #Cliente Cli with (nolock)  ON     Cli.clrut    = Enc.CaRutCliente  
                                                   AND Cli.clcodigo = Enc.CaCodigo 
        , CaDetContrato As Det with (nolock)
   WHERE  Enc.CaNumContrato = Det.CaNumContrato 
   AND  (  CaFechaPagoEjer = @dAcfecproc
         )
   AND     Enc.CaEstado              = ''



   --> ( *** ) Proceso de Actualización del Codigo de Cartera Para Derivados Forward
   CREATE TABLE #Llena_Codigo_Paso
   (   MiSistema       CHAR(3)    NOT NULL DEFAULT('')
   ,   MiContraparte   INTEGER    NOT NULL DEFAULT(0)
   ,   MiCartera       CHAR(5)    NOT NULL DEFAULT('')
   ,   MiSubCartera    NUMERIC(9) NOT NULL DEFAULT(0)
   ,   MiCodCartera    NUMERIC(9) NOT NULL DEFAULT(0)
       CONSTRAINT [Primary_llenacodigopaso] PRIMARY KEY NONCLUSTERED
       (   [MiSistema], [MiContraparte], [MiCartera], [MiSubCartera], [MiCodCartera]   )
   )

   INSERT INTO #Llena_Codigo_Paso
   SELECT CntSisCod                as MiSistema
   ,      CntExtNacional           as MiContraparte
   ,      CntCarteraNormativa     as MiCartera
   ,      CntSubCarteraNormativa   as MiSubCartera
   ,      0                        as MiCodCartera
   FROM   CntContabiliza with (nolock)
   GROUP BY CntSisCod 
 ,        CntExtNacional 
   ,        CntCarteraNormativa 
   ,        CntSubCarteraNormativa



   UPDATE #Llena_Codigo_Paso
   SET    MiCodCartera        = CodigoCartera 
   FROM   BacParamSudaTBL_CLASIFICACION_CARTERA   -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA
   WHERE  id_Sistema          = MiSistema
   AND    Contraparte         = MiContraparte
   AND    CarteraNormativa    = MiCartera
   AND    SubcarteraNormativa = MiSubCartera


   UPDATE CntContabiliza
   SET    CntCmpContraparteCartera = MiCodCartera
   FROM   #Llena_Codigo_Paso
   WHERE  CntSisCod              = MiSistema
   AND    CntExtNacional         = MiContraparte
   AND    CntCarteraNormativa    = MiCartera
   AND    CntSubCarteraNormativa = MiSubCartera



   -- PROD 7274 PAE
   -- Ordenar para que no cueste evalaur la variable
   update CntContabiliza
       set   CntCompRecibirML = CntCompRecibir * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = CntMoneda), 1 )
           , CntCompPagarML   = CntCompPagar   * isnull( (SELECT vmvalor FROM #VALOR_TC_CONTABLE  
                                                                      where vmfecha  = @Fecha_Hoy 
                                                                     AND vmcodigo = CntMoneda), 1 )

           -- MAP 14 Octubre Actualizacion de la forma de pago con la codificacion contable
           , CntFormaPagoRecibir  = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
                                                   and tbtasa = CntFormaPagoRecibir ), 0 )
           , CntFormaPagoEntregar = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
                                                  and tbtasa = CntFormaPagoEntregar ), 0 ) 
     where     CntSisCod                      = 'OPT'
           and CntTipoMovimiento      = 'LTE'
           and CntTipoOperacion               = 'LTE'



   -- PROD 7274 PAE
   update CntContabiliza
       set 
             CntFormaPagoRecibir  = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
                                                   and tbtasa = CntFormaPagoRecibir ), 0 )
           , CntFormaPagoEntregar = isnull( (select tbcodigo1 from lnkbac.bacparamsuda.dbo.tabla_general_detalle 
                                                  where tbcateg = 2552 and tbvalor = CntBancoNoBanco 
                                                  and tbtasa = CntFormaPagoEntregar ), 0 ) 
     where     CntSisCod                      = 'OPT'
           and CntTipoMovimiento              = 'LIQ'
           and CntTipoOperacion               = 'FXCC'





   DROP TABLE #Llena_Codigo_Paso
   --> ( *** ) Proceso de Actualización del Codigo de Cartera Para Derivados Opciones

   -- select 'Debug', 'Pendiente traducir los codigos de forma de Pago'


   -- select 'debug', * from CntContabiliza where cntcontrato = 2366

  -- Falta el Control de errores está chacreado para variar
   
   RETURN 0

END
GO
