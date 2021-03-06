USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_OPERACIONES_OPCIONES_REPROCESO]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_OPERACIONES_OPCIONES_REPROCESO]
 --  (   @fechafinmeshabil   CHAR(8)
 --  ,   @fechafinmes        CHAR(8)
 --  )
AS 
BEGIN

   SET NOCOUNT ON
-- Documentacion: todos los Montos 18,2 deben ser multiplicados por 100 y redondeados en cero decimales
--                todos los Montos m,n deben ser multiplicados por power(10, n) y redondeados en cero decimales
-- Por Hacer:     aplicar los valores verdaderos de griegas, yo no he podido hacer valorizar en este PC.
   DECLARE @FECHA 	      DATETIME
       SET @FECHA             = '20210208' --(SELECT fechaproc FROM OpcionesGeneral with (nolock) ) -- Prueba NEOSOFT

   DECLARE @vDolar_obsFinMes  FLOAT
   DECLARE @vUF_FinMes        FLOAT

   DECLARE @max               INTEGER
       SET @max               = (SELECT COUNT(1) FROM CaResEncContrato with (nolock)   -- select * from CaResEncContrato
                                  WHERE   cafechaContrato = @FECHA and CaEstado <> 'C' 
                                      and CaEncFechaRespaldo = @FECHA )
              

      SET @vDolar_obsFinMes   = 0.0
   SELECT @vDolar_obsFinMes   = ISNULL(vmvalor,0.0)     FROM BacParamSudaVALOR_MONEDA          with (nolock) WHERE vmcodigo      = 994 AND vmfecha = @FECHA

      SET @vDolar_obsFinMes   = 0.0
   SELECT @vDolar_obsFinMes   = ISNULL(Tipo_Cambio,0.0) FROM BacParamSudaVALOR_MONEDA_CONTABLE with (nolock) WHERE Codigo_Moneda = 994 AND Fecha   = @FECHA

--      SET @vUF_FinMes         = 0.0
--   SELECT @vUF_FinMes         = ISNULL(vmvalor,0.0)     FROM BacParamSudaVALOR_MONEDA          with (nolock) WHERE vmcodigo      = 998 AND vmfecha = @FECHAFINMES

   SELECT vmptacmp , mnrefusd , mncodmon , vmvalor
   INTO   #tipocambio 
   FROM   BacParamSudaVALOR_MONEDA      with (nolock)
          INNER JOIN lnkbac.BacParamSuda.dbo.MONEDA with (nolock) ON vmcodigo = mncodmon 
   WHERE  vmfecha     = @FECHA
   AND    vmcodigo    NOT IN(998,997)



   SELECT vmptacmp , mnrefusd , mncodmon , vmvalor = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSudaVALOR_MONEDA_CONTABLE   with (nolock)
          INNER JOIN lnkbac.BacParamSuda.dbo.MONEDA       with (nolock) ON Codigo_Moneda = mncodmon 
          INNER JOIN BacParamSudaVALOR_MONEDA with (nolock) ON Codigo_Moneda = vmcodigo and Fecha = vmfecha
   WHERE  Fecha         = @FECHA  
   AND    Codigo_Moneda NOT IN(998,997) 

   INSERT INTO #VALOR_TC_CONTABLE select vmptacmp , mnrefusd , 13 , vmvalor from #VALOR_TC_CONTABLE where mnCodMon = 994
   INSERT INTO #VALOR_TC_CONTABLE select vmptacmp = 1 , mnrefusd = 0 , 999 , 1 --from #VALOR_TC_CONTABLE

   --select 'debug', * from #VALOR_TC_CONTABLE

   CREATE TABLE #TEMPORAL
   (   fecha_contable    DATETIME
   ,   status            CHAR(1)
   ,   cod_producto      CHAR(4)
   ,   T_producto        CHAR(4)
   ,   rut               CHAR(9)
   ,   dig               CHAR(1)
   ,   costo             NUMERIC(1)
   ,   n_operacion       CHAR(10) -- CHAR(5)
   ,   fecha_inic        CHAR(8)
   ,   fecha_vcto        DATETIME
   ,   cod_inter_mda     NUMERIC(3)
   ,   s_mto_cap_ori     CHAR(1)
   ,   mto_cap_origen    FLOAT
   ,   s_mto_cap_loc     CHAR(1)
   ,   mto_cap_local     FLOAT
   ,   s_reaj_mda_loc    CHAR(1)
   ,   mto_reaj_loc      FLOAT
   ,   s_int_mda_loc     CHAR(1)
   ,   mto_int_mda_loc   FLOAT
   ,   tasa_f_v          CHAR(1)
   ,   spread            FLOAT
   ,   valor_en_pesos    FLOAT
   ,   nomin_en_pesos    FLOAT
   ,   t_cartera         CHAR(10)
   ,   mto_op_compra     FLOAT
   ,   registros         NUMERIC(5)
   ,   indicador         CHAR(1)
   ,   colocacion        FLOAT
   ,   destino           NUMERIC(5)
   ,   TasaInteres       FLOAT
   ,   MontoIniBFT       FLOAT
   ,   n_Tipo_Contrato      VARCHAR(1)
   ,   n_Tipo_Operacion     VARCHAR(1)
   ,   n_Operacion_Original VARCHAR(10)
   ,   Monto_Mora_4      varchar(18)            -- En Opciones se utilizaran para guardar las griegas
   ,   Monto_Mora_5      varchar(18)
   ,   Monto_Mora_6      varchar(18)
   )
/* Sacar
   select 'Debug' , 
            CaNumContrato
          , CaNumEstructura
, CaDelta_spot
      , CaGamma_spot
          , CaVega
          , CaVol
          , CaPosDeltaSpot = round( CaDelta_spot *  ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = CaCodMon1 ) 
                                    , 2 )
          , CaRieGammaSpot = Round( power( ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = CaCodMon1 ) 
                                            * 8.0 , 2.0 ) 
                                    * CaGamma_spot / 200000.0 
                                    , 2 ) 
          , CaRieVega      = Round( 0.25 * CaVega * CaVol / 100.00 , 2.0 )  
          , Sxy = ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = CaCodMon1 )
   from CaDetContrato
        where CaFechaPagoEjer > @FECHA   
*/
   -- PENDIENTE: Crear campos físicos para registrar Posición Delta, Riesgo Gamma y 
   -- riesgo Vega por Operación.
   -- Esto debería ser un proceso ya que las monedas en un contrato podríasn ser muchas.
   -- Adicionalmente hay que usar el detalle para descartar operaciones, hay que contemplar
   -- esto en este proceso.
   select *     
          , CaPosDeltaSpot = convert( numeric(18),  round( case when CaDelta_spot = 0 
                                                                   then CaDelta_spot_Num 
                                                                else CaDelta_spot end
                                                            * 1.0 * ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = case when CaCodMon1 = 13 then 994 else CaCodMon1 end )  
                                       , 0 ) )
          , CaRieGammaSpot = convert( numeric(18), Round( power( 1.0 * ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = case when CaCodMon1 = 13 then 994 else CaCodMon1 end ) 
                                            * 8.0 / 100.0 , 2.0 ) 
                                        *  case when CaGamma_spot = 0 
                                                                   then CaGamma_spot_Num 
                                                                else CaGamma_spot end / 2.0 
                                        , 0 ) )
          , CaRieVega      = convert( numeric(18), Round( 100.0 * 0.25 * Case when CaVega = 0.0 
                                                                              then CaVega_num
                                                                              else CaVega end * CaVol , 0 ) )  
          , CaFechaVctoAux = CaFechaPagoEjer
   into #CaDetContrato        
   from CaResDetContrato  -- select * from CaResDetContrato
        where CaFechaPagoEjer > @FECHA  and CaDetFechaRespaldo = @FECHA 

--select 'debug', canumcontrato, canumestructura,  CaRieVega from #CaDetContrato

   Select *
           into #CaEncContrato 
   from CaResEncContrato Enc  -- select * from CaResEncContrato
   where Enc.CanumContrato in ( select canumContrato from #CaDetContrato ) 
     and Enc.CaEstado <> 'C'
     and CaEncFechaRespaldo = @Fecha

                         

   INSERT INTO #TEMPORAL
   SELECT 'fecha_contable'   = @fecha
   ,      'status'           = 'A'
   ,      'cod_producto'     = 'MD49'
   ,      'T_producto'       = 'MDIR'
   ,      'rut'              = CONVERT( CHAR(9), Enc.CaRutCliente )
   ,      'dig'              = ISNULL( Cli.ClDv , '0' )
   ,      'costo'            = 0           -- Antes era 5 !!!
   ,      'n_operacion'      = CONVERT( VARCHAR(20), rtrim( convert( varchar(20), Enc.CaNumContrato ) )  
                                                   + rtrim( CONVERT( varchar(20), Det.CaNumEstructura  ) ) )
   ,      'fecha_inic'       = CONVERT(CHAR(8), Enc.caFechaContrato ,112)
   ,      'fecha_vcto'       = CONVERT(Char(8), Det.CaFechaVctoAux, 112)
   ,      'cod_inter_mda'    = Det.CaCodMon1 
   ,      's_mto_cap_ori'    = '+' 
   ,      'mto_cap_origen'   = round( Det.CaMontoMon1 * 100.0 , 0 ) 
   ,      's_mto_cap_loc'    = '+' 
   ,      'mto_cap_local'    = round( Det.CaMontoMon2 * 100.0 , 0 ) 
   ,      's_reaj_mda_loc'   = '+' 
   ,      'mto_reaj_loc'     = 0               
   ,      's_int_mda_loc'    = SPACE(1)
   ,      'mto_int_mda_loc'  = 0 
   ,      'tasa_f_v'         = 'F'
   ,      'spread'           = 0
   ,      'valor_en_pesos'   = 0              
   ,      'nomin_en_pesos'   = 0               
   ,      't_cartera'        = rtrim( ISNULL((SELECT rtrim( ltrim( ccn_codigo_nuevo ) ) FROM lnkbac.BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA with (nolock) WHERE ccn_codigo_cartera = Enc.caCarNormativa),4) )
   ,      'mto_op_compra'    = 0 -- CASE WHEN cadiferen > 0 THEN cadiferen ELSE 0 END OJO se podría usar !!! Por hacer:  Poner Art 84 !!!
   ,      'registros' 	     = @max
   ,      'indicador'        = CASE WHEN Det.camodalidad = 'C'      THEN 'A'       ELSE 'P' END
   ,      'colocacion'       = 0 
   ,      'destino'        = CASE WHEN Enc.caRutCliente  = 97029000 THEN 211
                                    WHEN Enc.caRutCliente  = 97030000 THEN 212
                                    ELSE                           221
                               END
   ,      'TasaInteres'      = 0.0
   ,      'MontoIniBFT'      = 0.0
   ,      'n_Tipo_Contrato'  = '3'                                               -- Asignado por NEOSOFT para SIGIR
   ,      'n_Tipo_Operacion' = case when CaCVOpc = 'C' and CaCallPut = 'Call' then '1' 
                                    when CaCVOpc = 'C' and CaCallPut = 'Put'  then '2'
                                    when CaCVOpc = 'V' and CaCallPut = 'Call' then '3'
                                    when CaCVOpc = 'V' and CaCallPut = 'Put'  then '4' end
   ,      'n_Operacion_Original' = convert( varchar(20), Enc.CaNumContrato )
   ,      'Monto_Mora_4'         = case when CaPosDeltaSpot < 0 then '-' else '0' end 
                                 + replicate( '0', 17 - len ( convert( varchar(17), round( abs(CaPosDeltaSpot) * 100 , 0 ) ) )  ) 
                                 + rtrim( convert( varchar(17), abs( CaPosDeltaSpot * 100 ) ) ) -- SP_INTERFAZ_OPERACIONES_OPCIONES
   ,      'Monto_Mora_5'         = case when CaRieVega < 0 then '-' else '0' end 
                                 + replicate( '0', 17 - len ( convert( varchar(17), round( abs( CaRieVega ) * 100 , 0 ) ) )  ) 
                                 + rtrim( convert( varchar(17), abs( CaRieVega * 100 ) ) )  -- CaRieVega
   ,      'Monto_Mora_6'         = case when CaRieGammaSpot < 0 then '-' else '0' end 
                                 + replicate( '0', 17 - len ( convert( varchar(17), round( abs( CaRieGammaSpot ) * 100 , 0 ) ) )  ) 
                                 + rtrim( convert( varchar(17), abs( CaRieGammaSpot * 100 ) ) )  

   FROM   #CaDetContrato Det,
          #CaEncContrato Enc                           with (nolock)          
          LEFT JOIN lnkbac.BacParamSuda.dbo.CLIENTE Cli with (nolock) ON clrut = caRutCliente AND clcodigo = cacodigo
    where Det.CaNumContrato = Enc.CaNumContrato 
       and Enc.CaEstado <> 'C'

   ORDER BY Det.CaNumContrato , Det.CaNumEstructura

                     
   SELECT * FROM #TEMPORAL

END

--select * from CaDetContrato



GO
