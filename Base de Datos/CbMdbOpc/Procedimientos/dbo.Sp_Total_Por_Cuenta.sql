USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Total_Por_Cuenta]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Sp_Total_Por_Cuenta]( @Fecha datetime , @Usuario Varchar(15) )       

AS BEGIN   

/* Este reporte debe mostrar al usuario el detalle por cuenta de Activo-Pasivo  

   por operacion para poder ver el total de operaciones que esta siendo considerado  

   en los archivos normativos   

   Por hacer:   

   - Indice por fecha del modelo RES  

   - Dependiendo de la fecha de proceso debe leer del modelo RES o del  

     modelo cartera vigente.  

  

Sp_Total_Por_Cuenta_Map '20111012', 'PP'



*/   

  

/*  

   select Reporte       = Convert( Varchar(40), 'Saldos de Cuentas de Balance Al' )  

        , Fecha         = Convert( Datetime, @Fecha )  

        , Usuario       = Convert( Varchar(15), @Usuario )  

        , NumContrato   = Convert( numeric(8), 0 )  

        , NumComponente = Convert( numeric(6), 0 )  

        , MdaCtaCod     = Convert( numeric(5), 0 )  

        , MdaCtaDsc     = Convert( varchar(8), '' ) -- Nemo  

        , CuentaCod     = Convert( varchar(20), '' )  

        , CuentaDsc     = Convert( varchar(80) , 'SIN DATOS' )  

        , MtoDebe       = Convert( numeric(21,4), 0.0 )  

        , MtoHaber      = Convert( numeric(21,4), 0.0 )  

        , Perfil        = Convert( numeric(8), 0 )   

  

*/  

   SET NOCOUNT ON  

   -- POR HACER: Ver como son tratados los montos.  

   --            si pasa lo mimsmo uniformizar multiplicando   

   --            por 10 elevado a la cantidad de decimales  

   --            Revisar registro de Control  

   DECLARE @dFechaProceso    DATETIME  

   DECLARE @dFechaProcAnt    DATETIME  

   DECLARE @dFechaProcesoRes DATETIME  

   DECLARE @dFechaProcAntRes DATETIME  

   DECLARE @dFechaConsulta   DATETIME  

  

   SELECT  @dFechaProceso   = fechaproc   -- Prueba NEOSOFT  

         , @dFechaProcAnt   = fechaant         

   FROM    OpcionesGeneral with (Nolock)  

  

   SELECT  @dFechaProcesoRes  = fechaproc   -- Prueba NEOSOFT  

         , @dFechaProcAntRes  = fechaant         

   FROM    OpcionesResGeneral with (Nolock)  

   WHERE   fechaproc = @Fecha   

  

   SET    @dFechaConsulta =   @dFechaProceso -- @dFechaProcAnt

  

  

   IF  @Fecha < @dFechaProceso   

      SET @dFechaConsulta =  @dFechaProceso --@dFechaProcAntRES

   

   /* select 'debug' = '@dFechaConsulta', @dFechaConsulta */

  

  

   SELECT vmcodigo, vmfecha, vmvalor INTO #VM   

   FROM bacparamsudaValor_moneda with (nolock) WHERE vmfecha = @dFechaConsulta AND vmcodigo not in(999,998) -- select * from bacparamsudaValor_moneda

   INSERT INTO #VM SELECT  999, @dFechaConsulta,  1.0   

   INSERT INTO #VM SELECT  998, @dFechaConsulta, 1.0   

  

   SELECT vmcodigo      = Codigo_Moneda  

   ,      vmfecha       = Fecha  

   ,      vmvalor       = Tipo_Cambio  

   INTO   #VALOR_TC_CONTABLE  

   FROM   bacparamsudaVALOR_MONEDA_CONTABLE with (nolock) -- select * from bacparamsudaVALOR_MONEDA_CONTABLE where fecha = '20111012'

   WHERE  Fecha         = @dFechaConsulta  

   AND    Codigo_Moneda NOT IN(998,999)  

  

   INSERT INTO #VALOR_TC_CONTABLE  

        SELECT 999 , @dFechaConsulta , 1.0  

  

   -- 1.0 Rescate de Conceptos fr los perfiles  

   select   C.Id_Sistema  

         ,  TipPErfil = 'PERFIL'

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

                          ,  303 -- NN Dif. AVR Neg. ML

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

   select C.id_sistema

        , TipPErfil = 'PERFILVARIABLE'

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

                          ,  303 -- NN Dif. AVR Neg. ML

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

  

   -- PROD 13028 Se agregan los perfiles de productos con contabilida Externa al SAO.

   UNION

   select   C.Id_Sistema  

         ,  TipPErfil = 'PERFIL'

         ,  P.Folio_Perfil

         ,  P.correlativo_perfil

         ,  C.Nombre_Campo_tabla 

         ,  C.tipo_operacion 

         ,  C.Codigo_campo

         ,  codigo_campo_variable = 0

         ,  valor_dato_campo = 0

         ,  codigo_cuenta 

         ,  C.tipo_movimiento         

   from   lnkBac.BacParamSuda.dbo.PERFIL_DETALLE_CNT P 

     , lnkBac.BacParamSuda.dbo.PERFIL_CNT E

     , lnkBac.BacParamSuda.dbo.Campo_Cnt  C

   where C.id_sistema = 'BFW'  

   and C.tipo_movimiento in ( 'MOV', 'DEV'  )  

   and C.Codigo_campo in (   300 -- NN Capital Moneda Origen                                    

                          ,  301 -- NN Capital en ML                                            

                          ,  304 -- NN Utilidad Real del FW.                                    

                          ,  305 -- NN Perdida Real del FW.                                                                                              

                    )  

   and C.Codigo_campo = p.Codigo_Campo

   and C.Id_sistema   = E.Id_sistema

   and E.Folio_perfil = P.Folio_Perfil

   and E.tipo_operacion = C.tipo_operacion

   and E.Tipo_movimiento = C.tipo_Movimiento

   and P.Codigo_Cuenta <> ''

   and E.tipo_movimiento = C.tipo_movimiento  

   and substring( P.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo

   and ( E.tipo_operacion like '%15%' or E.tipo_operacion like '%17%' )

   and ( E.tipo_operacion not like 'V15%' and E.tipo_operacion not like 'V17%' )

   UNION

   select C.id_sistema

        , TipPErfil = 'PERFILVARIABLE'

        , P.Folio_Perfil  

        , P.correlativo_perfil

        , C.Nombre_Campo_tabla 

        , C.tipo_operacion

        , C.Codigo_campo

        , P.codigo_campo_variable 

        , V.valor_dato_campo

        , V.codigo_cuenta 

        , C.tipo_movimiento

   from   lnkBac.BacParamSuda.dbo.PERFIL_DETALLE_CNT P 

     , lnkBac.BacParamSuda.dbo.PERFIL_Variable_CNT V 

     , lnkBac.BacParamSuda.dbo.PERFIL_CNT E

     , lnkBac.BacParamSuda.dbo.Campo_Cnt  C

   where C.id_sistema = 'BFW'

   and C.tipo_movimiento in ( 'MOV', 'DEV' )  

   and C.Codigo_campo in (   300 -- NN Capital Moneda Origen                                    

                          ,  301 -- NN Capital en ML                                            

                          ,  304 -- NN Utilidad Real del FW.                                    

                          ,  305 -- NN Perdida Real del FW.                                                                                              

                    )  

   and C.Codigo_campo       = p.Codigo_Campo

   and C.Id_sistema         = E.Id_sistema

   and E.Folio_perfil       = P.Folio_Perfil

   and E.tipo_operacion     = C.tipo_operacion

   and E.Tipo_movimiento    = C.tipo_Movimiento

   and V.Folio_Perfil       = E.Folio_Perfil

   and V.Correlativo_perfil = P.correlativo_perfil 

   and substring( V.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo

   and ( E.tipo_operacion like '%15%' or E.tipo_operacion like '%17%' )

   and ( E.tipo_operacion not like 'V15%' and E.tipo_operacion not like 'V17%' )

   -- PROD 13028



   /*select 'Debug' = '#VALOR_TC_CONTABLE', * from #VALOR_TC_CONTABLE*/

  

   -- 2.0 Cartera y Cartera Clasificacion Contable  

   select  Origen = 'CARTERA_CLASIFCTB'   

      , CodigoCarteraCtble = Clasif.CodigoCartera   

      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )  

      , Tipo_movimiento = 'MOV'

      , tipo_operacion = ltrim( rtrim( D.CaSubyacente ) ) + ltrim( rtrim( D.CaCVOpc ) )  + substring( D.CaCallPut, 1, 1 )   

      , E.CaCarNormativa   

      , E.CaSubCarNormativa  

    , D.CaNumcontrato  

      , D.CaNumEstructura  

      , D.CaSubyacente        

      , D.CaCVOpc  

      , D.CaCallPut  

      , CaVrDetML = 0 --D.CaVrDetML 

      , D.CaCodMon1  

      , D.CaMontoMon1  

      , D.CaMontoMon2  

      , D.CaCodMon2    

   into #Cartera_ClasifCTB  

        from      CaResDetContrato D   

                , CaResEncContrato E  

                , OpcionEstructura Estruc  

                , LnkBac.BacParamSuda.dbo.Cliente C  

                , BacParamSudaTBL_CLASIFICACION_CARTERA Clasif  

   where     D.CaNumContrato = E.CaNumContrato  

       and E.CaRutCliente  = C.ClRut  

       and E.CaCodigo      = C.ClCodigo  

       -- PROD-13028

       and Estruc.OpcEstCod = E.CaCodEstructura

       and Estruc.OpcContabExterna = 'N'

       and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte  

       and CaCarNormativa = Clasif.CarteraNormativa  

       and CaSubCarNormativa = Clasif.SubCarteraNormativa   

       and D.CaDetFechaRespaldo = @dFechaConsulta   

       and D.CaDetFechaRespaldo = E.CaEncFechaRespaldo  

       and CaFechaPagoEjer   > @dFechaConsulta  

       and E.CaEstado <> 'C' 

   UNION

   select  Origen = 'CARTERA_CLASIFCTB' 

      , CodigoCarteraCtble = Clasif.CodigoCartera 

      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )

      , Tipo_movimiento = 'AVR'

      , tipo_operacion = ltrim( rtrim( D.CaSubyacente ) ) + ltrim( rtrim( D.CaCVOpc ) )  + substring( D.CaCallPut, 1, 1 ) 

      , E.CaCarNormativa 

      , E.CaSubCarNormativa

    , D.CaNumcontrato

      , D.CaNumEstructura

      , D.CaSubyacente      

      , D.CaCVOpc

      , D.CaCallPut

      , CaVrDetML  = D.CaVrDetML 

      , D.CaCodMon1

      , CaMontoMon1 = 0 --D.CaMontoMon1

      , CaMontoMon2 = 0 --D.CaMontoMon2

      , D.CaCodMon2     

        from CaResDetContrato D 

                , CaResEncContrato E

                , OpcionEstructura Estruc  -- select * from OpcionEstructura 

                , lnkBac.BacParamSuda.dbo.Cliente C

                , BacParamSudaTBL_CLASIFICACION_CARTERA Clasif -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA

   where     D.CaNumContrato = E.CaNumContrato

       and E.CaRutCliente  = C.ClRut

       and E.CaCodigo      = C.ClCodigo

       -- PROD-13028

       and Estruc.OpcEstCod = E.CaCodEstructura

       and Estruc.OpcContabExterna = 'N'

       and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte

       and E.CaCarNormativa = Clasif.CarteraNormativa

       and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 

       and D.CaDetFechaRespaldo = @dFechaConsulta 

       and D.CaDetFechaRespaldo = E.CaEncFechaRespaldo

       and D.CaFechaPagoEjer   >  @dFechaConsulta

       and E.CaEstado <> 'C'

   UNION   

   select Distinct Origen = 'CARTERA_CLASIFCTB' 

      , CodigoCarteraCtble = Clasif.CodigoCartera 

      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )

      , Tipo_Movimiento = 'MOV'

      , tipo_operacion = ltrim( rtrim( Estruc.OpcContabExternaProd ) ) + ltrim( rtrim( E.CaCVEstructura ) )  + '' --substring( D.CaCallPut, 1, 1 ) 

      , E.CaCarNormativa 

      , E.CaSubCarNormativa

      , D.CaNumcontrato

      , CaNumEstructura = 1

      , D.CaSubyacente      

      , E.CaCVEstructura 

      , CaCallPut = 'NA'

      , CaVrDetML = 0 -- E.CaVr

      , D.CaCodMon1

      , D.CaMontoMon1

      , D.CaMontoMon2

      , D.CaCodMon2  

        from CaResDetContrato D 

                , CaResEncContrato E

                , OpcionEstructura Estruc                -- select * from OpcionEstructura

                , lnkBac.BacParamSuda.dbo.Cliente C       

                , BacParamSudaTBL_CLASIFICACION_CARTERA Clasif -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA

   where     D.CaNumContrato = E.CaNumContrato

       and E.CaRutCliente  = C.ClRut

       and E.CaCodigo      = C.ClCodigo

       -- PROD-13028

       and Estruc.OpcEstCod = E.CaCodEstructura

       and Estruc.OpcContabExterna = 'S'

       and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte

       and E.CaCarNormativa = Clasif.CarteraNormativa

       and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 

       and D.CaDetFechaRespaldo = @dFechaConsulta 

       and D.CaDetFechaRespaldo = E.CaEncFechaRespaldo

       and D.CaFechaPagoEjer   > @dFechaConsulta 

       and E.CaEstado <> 'C'

   UNION

   select Distinct Origen = 'CARTERA_CLASIFCTB' 

      , CodigoCarteraCtble = Clasif.CodigoCartera 

      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )

      , Tipo_Movimiento = 'DEV'

      , tipo_operacion = 'D' + ltrim( rtrim( Estruc.OpcContabExternaProd ) ) + ltrim( rtrim( E.CaCVEstructura ) )  + '' --substring( D.CaCallPut, 1, 1 ) 

      , E.CaCarNormativa 

      , E.CaSubCarNormativa

      , D.CaNumcontrato

      , CaNumEstructura = 1

      , D.CaSubyacente      

      , E.CaCVEstructura 

      , CaCallPut = 'NA'

      , CaVrDetML = E.CaVr

      , D.CaCodMon1

      , CaMontoMon1 = 0

      , CaMontoMon2 = 0

      , D.CaCodMon2  

        from CaResDetContrato D 

                , CaResEncContrato E

                , OpcionEstructura Estruc                -- select * from OpcionEstructura

                , lnkBac.BacParamSuda.dbo.Cliente C       

                , BacParamSudaTBL_CLASIFICACION_CARTERA Clasif -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA

   where     D.CaNumContrato = E.CaNumContrato

       and E.CaRutCliente  = C.ClRut

       and E.CaCodigo      = C.ClCodigo

       -- PROD-13028

       and Estruc.OpcEstCod = E.CaCodEstructura

       and Estruc.OpcContabExterna = 'S'

       and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte

       and E.CaCarNormativa = Clasif.CarteraNormativa

       and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 

       and D.CaDetFechaRespaldo = @dFechaConsulta 

       and D.CaDetFechaRespaldo = E.CaEncFechaRespaldo

       and D.CaFechaPagoEjer   > @dFechaConsulta 

       and E.CaEstado <> 'C'

  

   CREATE TABLE #InformeBalanceOpc  

   (   Documento  NUMERIC(9)
   ,   Producto    VARCHAR(5)  
   ,   Fecha       DATETIME  
   ,   Cuenta      VARCHAR(20)  
   ,   Monto       NUMERIC(21,4)
   ,   Moneda      INTEGER  
   ,   TipCta      integer  
   ,   NumPerfil   integer  
   )  

  

  

  

   CREATE INDEX #_ippo_InformeBalanceOpc ON #InformeBalanceOpc (Documento, Cuenta, Moneda, Fecha)  

  

   --> (1.0) Valorizacion de Cartera  

   INSERT INTO #InformeBalanceOpc  

   SELECT Documento   = rtrim( CarClasificada.CaNumContrato ) +  rtrim( CarClasificada.CaNumEstructura )  

   ,      Producto    = CarClasificada.tipo_operacion  

   ,      Fecha       = @dFechaConsulta   

   ,      Cuenta      = Perfil.Codigo_cuenta  

   ,      Monto       = case when codigo_campo = 300 then CaMontoMon1   

                             when Codigo_Campo = 310 then CaMontoMon2  

                             when Codigo_campo = 305 then case when CarClasificada.CaVrDetML > 0 then CarClasificada.CaVrDetML else 0 end

                             when Codigo_campo = 303 then case when CarClasificada.CaVrDetML < 0 then -CarClasificada.CaVrDetML else 0 end

                             else CarClasificada.CaVrDetML end  

   ,      Moneda      = case when codigo_campo = 300 then CaCodMon1   

                             when codigo_campo = 310 then CaCodMon2   

                             else 999 end  

   ,      TipCta      = case when substring( Perfil.Codigo_cuenta , 1, 1 ) in ( 1,2,3,4)   

                       then substring( Perfil.Codigo_cuenta , 1, 1 )  

                             else substring( Perfil.Codigo_cuenta , 1, 2 ) end  

   ,      NumPerfil   =  Perfil.Folio_Perfil      

  

   FROM   #Cartera_ClasifCTB CarClasificada   

        , #PERFIL_CONCEPTO   Perfil                  

   WHERE     Perfil.tipo_Operacion = CarClasificada.Tipo_Operacion  

         and ( Perfil.Codigo_campo_Variable = 0    

               or     Perfil.Codigo_campo_Variable <> 0   

                  and CarClasificada.CodigoCarteraCtble = Perfil.valor_dato_campo   

              )  

         and  Perfil.Tipo_movimiento = CarClasificada.Tipo_movimiento

         and  Perfil.Id_Sistema = 'OPT'



   ORDER BY CarClasificada.CanumContrato * 100 + CarClasificada.CaNumEstructura , Perfil.Codigo_cuenta  



   INSERT INTO #InformeBalanceOpc

   SELECT Documento   = rtrim( CarClasificada.CaNumContrato ) +  rtrim( CarClasificada.CaNumEstructura )

   ,      Producto    = CarClasificada.tipo_operacion

   ,      Fecha       = @dFechaProceso 

   ,      Cuenta      = Perfil.Codigo_cuenta

   ,      Monto       = case when codigo_campo = 300 then CaMontoMon1 

                             when Codigo_Campo = 301 then CaMontoMon2

                             when Codigo_Campo = 305 then case when CarClasificada.CaVrDetML < 0 then -CarClasificada.CaVrDetML else 0 end

                             when Codigo_Campo = 304 then case when CarClasificada.CaVrDetML > 0 then CarClasificada.CaVrDetML else 0 end 

                             else CaMontoMon1 end

   ,      Moneda      = case when codigo_campo = 300 then CaCodMon1 

                             when codigo_campo = 301 then CaCodMon2                            

                             else 999 end

   ,      TipCta      = case when substring( Perfil.Codigo_cuenta , 1, 1 ) in ( 1,2,3,4) 

                                  then substring( Perfil.Codigo_cuenta , 1, 1 )

                             else substring( Perfil.Codigo_cuenta , 1, 2 ) end

   ,      NumPerfil   =  Perfil.Folio_Perfil  



   FROM   #Cartera_ClasifCTB CarClasificada 

        , #PERFIL_CONCEPTO   Perfil                

   WHERE     Perfil.tipo_Operacion = CarClasificada.Tipo_Operacion

         and ( Perfil.Codigo_campo_Variable = 0  

               or     Perfil.Codigo_campo_Variable <> 0 

                  and CarClasificada.CodigoCarteraCtble = Perfil.valor_dato_campo 

              )

         and  Perfil.Tipo_movimiento = CarClasificada.Tipo_movimiento

         and  Perfil.Id_Sistema = 'BFW'

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

   FROM    #InformeBalanceOpc  


   IF EXISTS (SELECT 1 
				FROM   #InformeBalanceOpc  
				  LEFT JOIN LnkBac.BacParamSuda.dbo.MONEDA with (nolock) ON mncodmon = Moneda  
				  LEFT JOIN #VALOR_TC_CONTABLE                 ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END  
				where Monto <> 0)
   BEGIN
		   SELECT 'Registros'            = @iRegistros  
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
																	   then round( Monto , 2 )   
					   else round( Monto  , 0 ) end  
											  )   
											   )  
		   ,      'S_B_Mda_Local'        = '+'  
		   ,      'B_Mda_Local'          = convert( numeric(18), CASE WHEN Moneda <> 999 THEN round( ABS(Monto) * ISNULL(vmvalor,0.0), 0 ) ELSE round(ABS(Monto), 0) END   
												   )  
		   ,      'S_B_Local_Agregdo'    = '+'  
		   ,      'B_Local_Agregdo'      = 0  
		   ,      'C_Moneda'             = Moneda  --mncodfox  
		   ,      'G_Moneda'             = mnnemo   
		   ,      'N_Perfil'             = NumPerfil  
		   ,      'BannerLargo'			 = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)
		   FROM   #InformeBalanceOpc  
				  LEFT JOIN LnkBac.BacParamSuda.dbo.MONEDA with (nolock) ON mncodmon = Moneda  
				  LEFT JOIN #VALOR_TC_CONTABLE                 ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END  
		  where Monto <> 0
		   ORDER BY Documento , Producto   
      END
   ELSE
   BEGIN  
		SELECT 'Registros'            = @iRegistros
		   ,      'Nro_Operacion'        = 0
		   ,      'Fecha_Contable'       = @Fecha
		   ,      'Cuenta'               = ''
		   ,      'Indicador'            = 'C'
		   ,      'Cod_Evento_Cble'      = 0
		   ,      'S_B_Mda_Origin'       = '+'  
		   ,      'B_Mda_Original'       = 0
		   ,      'S_B_Mda_Local'        = '+'  
		   ,      'B_Mda_Local'          = 0
		   ,      'S_B_Local_Agregdo'    = '+'  
		   ,      'B_Local_Agregdo'      = 0  
		   ,      'C_Moneda'             = ''
		   ,      'G_Moneda'             = ''
		   ,      'N_Perfil'             = 0
		   ,	  'BannerLargo'			 = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)
	END  

   /*SELECT 'Registros'            = @iRegistros  
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
                                                               then round( Monto , 2 )   
               else round( Monto  , 0 ) end  
                                      )   
                                       )  
   ,      'S_B_Mda_Local'        = '+'  
   ,      'B_Mda_Local'          = convert( numeric(18), CASE WHEN Moneda <> 999 THEN round( ABS(Monto) * ISNULL(vmvalor,0.0), 0 ) ELSE round(ABS(Monto), 0) END   
                                           )  
   ,      'S_B_Local_Agregdo'    = '+'  
  ,      'B_Local_Agregdo'      = 0  
   ,      'C_Moneda'             = Moneda  --mncodfox  
   ,      'G_Moneda'             = mnnemo   
   ,      'N_Perfil'             = NumPerfil  

   FROM   #InformeBalanceOpc  
          LEFT JOIN LnkBac.BacParamSuda.dbo.MONEDA with (nolock) ON mncodmon = Moneda  
          LEFT JOIN #VALOR_TC_CONTABLE                 ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END  

  where Monto <> 0

   ORDER BY Documento , Producto   */

  
   DROP TABLE #InformeBalanceOpc  

   DROP TABLE #PERFIL_CONCEPTO  

   DROP TABLE #Cartera_ClasifCTB  

END   

GO
