USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_OPCIONES_REPROCESO]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_OPCIONES_REPROCESO]
AS
BEGIN

   SET NOCOUNT ON
   -- POR HACER: Ver como son tratados los montos.
   --            si pasa lo mimsmo uniformizar multiplicando 
   --            por 10 elevado a la cantidad de decimales
   --            Revisar registro de Control
   DECLARE @dFechaProceso   DATETIME
   SELECT  @dFechaProceso   = '20101006' -- Reproceso -- fechaproc   -- Prueba NEOSOFT
   FROM    OpcionesGeneral with (Nolock)


   SELECT vmcodigo, vmfecha, vmvalor INTO #VM 
   FROM bacparamsudaValor_moneda with (nolock) WHERE vmfecha = @dFechaProceso AND vmcodigo not in(999,998)
   INSERT INTO #VM SELECT  999, @dFechaProceso,  1.0 
   INSERT INTO #VM SELECT  998, @dFechaProceso, 1.0 

   SELECT vmcodigo      = Codigo_Moneda
   ,      vmfecha       = Fecha
   ,      vmvalor       = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   bacparamsudaVALOR_MONEDA_CONTABLE with (nolock)
   WHERE  Fecha         = @dFechaProceso
   AND    Codigo_Moneda NOT IN(998,999)

   INSERT INTO #VALOR_TC_CONTABLE
        SELECT 999 , @dFechaProceso , 1.0

   -- 1.0 Rescate de Conceptos fr los perfiles
   select   TipPErfil = 'PERFIL'
         ,  P.Folio_Perfil
         ,  P.correlativo_perfil
         ,  C.Nombre_Campo_tabla 
         ,  C.tipo_operacion 
         ,  C.Codigo_campo
         ,  codigo_campo_variable = 0
         ,  valor_dato_campo = 0
         ,  codigo_cuenta 
         ,  C.tipo_movimiento
   INTO #PERFIL_CONCEPTO
   from   BacParamSudaPERFIL_DETALLE_CNT P 
     , BacParamSudaPERFIL_CNT E
     , bacparamSudaCampo_Cnt  C
   where C.id_sistema = 'OPT'
   and C.tipo_movimiento in ( 'MOV', 'AVR'  )  -- LIQ se toma para tener un ejemplo variable
   and C.Codigo_campo in (   305 -- NN Dif. AVR Pos. ML 
                          ,  300 -- NN Valor Strike
                          ,  310 -- NN Valor Subyacente                                                         
                    )  
   and C.Codigo_campo = p.Codigo_Campo
   and C.Id_sistema   = E.Id_sistema
   and E.Folio_perfil = P.Folio_Perfil
   and E.tipo_operacion = C.tipo_operacion
   and E.Tipo_movimiento = C.tipo_Movimiento
   and P.Codigo_Cuenta <> ''
   and E.tipo_movimiento = C.tipo_movimiento  
   and substring( P.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo
   UNION
   select TipPErfil = 'PERFILVARIABLE'
        , P.Folio_Perfil  
        , P.correlativo_perfil
        , C.Nombre_Campo_tabla 
        , C.tipo_operacion
        , C.Codigo_campo
        , P.codigo_campo_variable 
        , V.valor_dato_campo
        , V.codigo_cuenta 
        , C.tipo_movimiento
   from   BacParamSudaPERFIL_DETALLE_CNT P 
     , BacParamSudaPERFIL_Variable_CNT V 
     , BacParamSudaPERFIL_CNT E
     , bacparamSudaCampo_Cnt  C
   where C.id_sistema = 'OPT'
   and C.tipo_movimiento in ( 'MOV', 'AVR' )  -- LIQ se toma para tener un ejemplo variable
   and C.Codigo_campo in ( 305 -- NN Dif. AVR Pos. ML   
                          ,  300 -- NN Valor Strike
                          ,  310 -- NN Valor Subyacente   
                    )  
   and C.Codigo_campo       = p.Codigo_Campo
   and C.Id_sistema         = E.Id_sistema
   and E.Folio_perfil       = P.Folio_Perfil
   and E.tipo_operacion     = C.tipo_operacion
   and E.Tipo_movimiento    = C.tipo_Movimiento
   and V.Folio_Perfil       = E.Folio_Perfil
   and V.Correlativo_perfil = P.correlativo_perfil 
   and substring( V.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo


   -- 2.0 Cartera y Cartera Clasificacion Contable
   select  Origen = 'CARTERA_CLASIFCTB' 
      , CodigoCarteraCtble = Clasif.CodigoCartera 
      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )
      , tipo_operacion = ltrim( rtrim( D.CaSubyacente ) ) + ltrim( rtrim( D.CaCVOpc ) )  + substring( D.CaCallPut, 1, 1 ) 
      , E.CaCarNormativa 
      , E.CaSubCarNormativa
    , D.CaNumcontrato
      , D.CaNumEstructura
      , D.CaSubyacente      
      , D.CaCVOpc
      , D.CaCallPut
      , D.CaVrDetML
      , D.CaCodMon1
      , D.CaMontoMon1
      , D.CaMontoMon2
      , D.CaCodMon2  
   into #Cartera_ClasifCTB
        from CaResDetContrato D  -- select * from caresdetcontrato
                , CaResEncContrato E  -- select * from CaResEncContrato
                , lnkBac.BacParamSuda.dbo.Cliente C
                , BacParamSudaTBL_CLASIFICACION_CARTERA Clasif
   where     D.CaNumContrato = E.CaNumContrato
       and E.CaRutCliente  = C.ClRut
       and E.CaCodigo      = C.ClCodigo
       and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte
       and CaCarNormativa = Clasif.CarteraNormativa
       and CaSubCarNormativa = Clasif.SubCarteraNormativa 
       and CaFechaPagoEjer   > @dFechaProceso
       and CaEstado <> 'C'
       -- Reproceso
       and CaDetFechaRespaldo = @dFechaProceso
       and CaEncFechaRespaldo = @dFechaProceso



--   select 'debug', * from #PERFIL_CONCEPTO 
--   select 'debug', * from #Cartera_ClasifCTB


   CREATE TABLE #InterfazBalanceOpc
   (   Documento   NUMERIC(9)
   ,   Producto    VARCHAR(5)
   ,   Fecha       DATETIME
   ,   Cuenta      VARCHAR(20)
   ,   Monto       NUMERIC(21,4)
   ,   Moneda      INTEGER
   ,   TipCta      integer
   )



   CREATE INDEX #_ippo_InterfazBalanceOpc ON #InterfazBalanceOpc (Documento, Cuenta, Moneda, Fecha)

   --> (1.0) Valorizacion de Cartera
   INSERT INTO #InterfazBalanceOpc
   SELECT Documento   = rtrim( CarClasificada.CaNumContrato ) +  rtrim( CarClasificada.CaNumEstructura )
   ,      Producto    = CarClasificada.tipo_operacion
   ,      Fecha       = @dFechaProceso 
   ,      Cuenta      = Perfil.Codigo_cuenta
   ,      Monto       = case when codigo_campo = 300 then CaMontoMon1 
                             when Codigo_Campo = 310 then CaMontoMon2
                             else CarClasificada.CaVrDetML end
   ,      Moneda      = case when codigo_campo = 300 then CaCodMon1 
                             when codigo_campo = 310 then CaCodMon2 
                             else 999 end
   ,      TipCta      = case when substring( Perfil.Codigo_cuenta , 1, 1 ) in ( 1,2,3,4) 
                                  then substring( Perfil.Codigo_cuenta , 1, 1 )
                             else substring( Perfil.Codigo_cuenta , 1, 2 ) end

   FROM   #Cartera_ClasifCTB CarClasificada 
        , #PERFIL_CONCEPTO   Perfil                
   WHERE     Perfil.tipo_Operacion = CarClasificada.Tipo_Operacion
         and ( Perfil.Codigo_campo_Variable = 0  
               or     Perfil.Codigo_campo_Variable <> 0 
                  and CarClasificada.CodigoCarteraCtble = Perfil.valor_dato_campo 
              )
   ORDER BY CarClasificada.CanumContrato * 100 + CarClasificada.CaNumEstructura , Perfil.Codigo_cuenta
/* POS HACER: nocionales */
/* Sacar
   DELETE  I
   FROM    #InterfazBalanceFwd I
           INNER JOIN #InterfazBalanceFwd P ON P.Documento = I.Documento AND P.Cuenta = I.Cuenta AND P.Moneda = I.Moneda AND P.Validacion <> I.Validacion
   WHERE  (I.Fecha > I.FechaInicio AND I.Validacion = 0)
*/
   DECLARE @iRegistros  NUMERIC(9)
   SELECT  @iRegistros  = COUNT(1)
   FROM    #InterfazBalanceOpc

   SELECT 'Registros'            = @iRegistros
   ,      'T_Producto'           = 'MD49'
   ,      'Producto'             = 'MDIR'
   ,      'Nro_Operacion'        = Documento
   ,      'Fecha_Contable'       = Fecha
   ,      'Cuenta'               = LTRIM(RTRIM(Cuenta)) + '0000000'
   ,      'Indicador'            = CASE WHEN TipCta in ( 1,2 ) THEN 'D' 
                                        WHEN TipCta in ( 3,4 ) THEN 'C'
                                        WHEN TipCta in ( 98 ) THEN 'D'
                                        ELSE 'C' END
   ,      'Cod_Evento_Cble'      = '0'
   ,      'S_B_Mda_Origin'       = '+'
   ,      'B_Mda_Original'       = ABS( convert( numeric(18) , case when Moneda <> 999 
                                                               then round( Monto * 100 , 2 ) 
               else round( Monto  , 0 ) * 100 end
                                          ) 
                                       )
   ,      'S_B_Mda_Local'        = '+'
   ,      'B_Mda_Local'          = convert( numeric(18),  100.0 * CASE WHEN Moneda <> 999 THEN round( ABS(Monto) * ISNULL(vmvalor,0.0), 0 ) ELSE round(ABS(Monto), 0) END 
                                           )
   ,      'S_B_Local_Agregdo'    = '+'
   ,      'B_Local_Agregdo'      = 0
   ,      'C_Moneda'             = mncodfox
   FROM   #InterfazBalanceOpc
          LEFT JOIN LnkBac.BacParamSuda.dbo.MONEDA with (nolock) ON mncodmon = Moneda
          LEFT JOIN #VALOR_TC_CONTABLE                 ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END
   ORDER BY Documento , Producto 


   DROP TABLE #InterfazBalanceOpc
   DROP TABLE #PERFIL_CONCEPTO
   DROP TABLE #Cartera_ClasifCTB
END




GO
