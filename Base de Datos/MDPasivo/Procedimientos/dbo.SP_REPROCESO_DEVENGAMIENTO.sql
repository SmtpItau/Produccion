USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPROCESO_DEVENGAMIENTO]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_REPROCESO_DEVENGAMIENTO](@iSistema       CHAR(3),
                                           @iFecha_fin_Mes CHAR(10))
AS
BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON



 IF @iSistema =  'BTR' BEGIN
   
  IF EXISTS(SELECT  1 FROM CARTERA_HISTORICA_TRADER WHERE FECHA_PROCESO = @iFecha_fin_Mes) BEGIN             
       /*==================================================================================*/
       /* Limpieza de la cartera                                                           */
       /*==================================================================================*/
       DELETE FROM CORTE_VENDIDO

       SELECT * 
       INTO #BLOQUEADO 
       FROM DOCUMENTO_BLOQUEADO 

       DELETE DOCUMENTO_BLOQUEADO 

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar los Cortes Vendidos.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Limpieza de la CORTE                                                             */
       /*==================================================================================*/
       DELETE FROM CORTE

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar los Cortes.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Limpieza de la cartera                                                           */
       /*==================================================================================*/
       SELECT * INTO #PASONOSERIE FROM NOSERIE

       DELETE NOSERIE

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar los Cortes Vendidos.'
          SET NOCOUNT OFF
          RETURN
       END

       /*==================================================================================*/
       /* Limpieza de la CARTERA_PROPIA                                                    */
       /*==================================================================================*/
       DELETE FROM CARTERA_PROPIA

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar la Cartera Propia.'
          SET NOCOUNT OFF
          RETURN
       END

       /*==================================================================================*/
       /* Limpieza de la CARTERA_COMPRA_PACTO                                              */
       /*==================================================================================*/
       DELETE FROM CARTERA_COMPRA_PACTO

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar la Cartera Compra con Pacto.'
          SET NOCOUNT OFF
          RETURN
       END

       /*==================================================================================*/
       /* Limpieza de la CARTERA_INTERBANCARIA                                             */
       /*==================================================================================*/
       DELETE FROM CARTERA_INTERBANCARIA

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar la Cartera Interbancaria.'
          SET NOCOUNT OFF
          RETURN
       END

       /*==================================================================================*/
       /* Limpieza de la CARTERA_VENTA_PACTO                                               */
       /*==================================================================================*/
       DELETE FROM CARTERA_VENTA_PACTO

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar la Cartera Venta con Pacto.'
          SET NOCOUNT OFF
          RETURN
       END

       /*==================================================================================*/
       /* Limpieza de la CARTERA_DISPONIBLE                             */
       /*==================================================================================*/

       DELETE FROM CARTERA_DISPONIBLE

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo Limpiar la Cartera Disponible.'
          SET NOCOUNT OFF
          RETURN  
       END

       /*==================================================================================*/
       /* Cartera Disponible                                                               */
       /*==================================================================================*/

       INSERT INTO CARTERA_DISPONIBLE (
                                        dirutcart,
                                        ditipcart,
                                        dinumdocu,
                                        dicorrela,
                                        dinumdocuo,
                                        dicorrelao,
                                        ditipoper,
                                        diserie,
                                        diinstser,
                                        digenemi,
                                        dinemmon,
                                        dinominal,
                                        ditircomp,
                                        dipvpcomp,
                                        divptirc,
                                        dipvpmcd,
                                        ditirmcd,
                                        divpmcd100,
                                        divpmcd,
                                        divptirci,
                                        difecsal,
                                        dinumucup,
                                        dicapitalc,
                                        diinteresc,
                                        direajustc,
                                        dicapitaci,
                                        diintereci,
                                        direajusci,
                                        dibase,
                                        dimoneda,
                                        diintermes,
                                        direajumes,
                                        codigo_carterasuper,
                                        Tipo_Cartera_Financiera,
                                        Mercado,
                                        Sucursal,
                                        Id_Sistema,
                                        Fecha_PagoMañana,
                                        Laminas,
                                        Tipo_Inversion,
                                        Estado_Operacion_Linea,
                                        divalvenc,
                                        premio,   
                                        descuento,
					monto_fli
                                  )
              SELECT                    rutcart,
                                        tipcart,
                                        numdocu,
                                        correla,
                                        numdocuo,
                                        correlao,
                                        tipoper,
                                        serie,
                                        instser,
                                        genemi,
                                        nemmon,
                                        nominal,
                                        tircomp,
                                        pvpcomp,
                                        vptirc,
                                        pvpmcd,
                                        tirmcd,
                                        vpmcd100,
                                        vpmcd,
                      vptirci,
                                        fecsal,
                                        numucup,
                                        capitalc,
                                        interesc,
                                        reajustc,
                                        capitaci,
                                        intereci,
                                        reajusci,
                                        base,
                                        moneda,
                                        intermes,
                                        reajumes,
                                        codigo_carterasuper,
                                        Tipo_Cartera_Financiera,
                                        Mercado,
                                        Sucursal,
                                        Id_Sistema,
                                        Fecha_PagoMañana,
                                        Laminas,
                                        Tipo_Inversion,
                                        Estado_Operacion_Linea,
                                        valvenc,
                                        premio,
                                        descuento,
					valvenp
                     FROM  CARTERA_HISTORICA_TRADER
                     WHERE fecha_proceso  = @iFecha_fin_Mes  AND
                           codigo_cartera = 'DI'

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Historico a Disponible.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Cartera Propia                                                                   */
       /*==================================================================================*/
       INSERT INTO CARTERA_PROPIA ( 
                                    cprutcart,
                                    cptipcart,
                                    cpnumdocu,
                                    cpcorrela,
                                    cpnumdocuo,
                                    cpcorrelao,
                                    cprutcli,
                                    cpcodcli,
                                    cpinstser,
                                    cpmascara,
                                    cpnominal,
                                    cpfeccomp,
                                    cpvalcomp,
                                    cpvalcomu,
                                    cpvcum100,
                                    cptircomp,
                                    cptasest,
                                    cppvpcomp,
                                    cpvpcomp,
                                    cpnumucup,
                                    cpfecemi,
                                    cpfecven,
                                    cpseriado,
                                    cpcodigo,
                                    cpvptirc,
                                    cpcapitalc,
                                    cpinteresc,
                                    cpreajustc,
                                    cpcontador,
                                    cpfecucup,
                                    cpfecpcup,
                                    cpvcompori,
                                    cpdcv,
                                    cpdurat,
                                    cpdurmod,
                                    cpconvex,
                                    cpintermes,
                                    cpreajumes,
                                    fecha_compra_original,
                                    valor_compra_original,
                                    valor_compra_um_original,
     tir_compra_original,
                                    valor_par_compra_original,
                                    porcentaje_valor_par_compra_original,
                                    codigo_carterasuper,
                                    Tipo_Cartera_Financiera,
                                    Mercado,
                                    Sucursal,
                                    Id_Sistema,
                                    Fecha_PagoMañana,
                                    Laminas,
                                    Tipo_Inversion,
                                    Estado_Operacion_Linea,
                                    cpvalvenc,
                                    Tipo_Operacion,
                                    premio,
                                    descuento,
                                    monto_letra_sorteo,
                                    keyid_desk_manager,
                                    libro_desk_manager,
                                    numero_pu,
                                    codigo_area
                                  )
              SELECT                rutcart,
                                    tipcart,
                                    numdocu,
                                    correla,
                                    numdocuo,
                                    correlao,
                                    rutcli,
                                    codcli,
                                    instser,
                                    mascara,
                                    nominal,
                                    feccomp,
                                    valcomp,
                                    valcomu,
                                    vcum100,
                                    tircomp,
                                    tasest,
                                    pvpcomp,
                                    vpcomp,
                                    numucup,
                                    fecemi,
                                    fecven,
                                    seriado,
                                    codigo,
                                    vptirc,
                                    capitalc,
                                    interesc,
                                    reajustc,
                                    contador,
                                    fecucup,
                                    fecpcup,
                                    vcompori,
                                    dcv,
                                    durat,
                                    durmod,
                                    convex,
                                    intermes,
                                    reajumes,
                                    fecha_compra_original,
                                    valor_compra_original,
                                    valor_compra_um_original,
                                    tir_compra_original,
                                    valor_par_compra_original,
                                    porcentaje_valor_par_compra_original,
                                    codigo_carterasuper,
                                    Tipo_Cartera_Financiera,
                                    Mercado,
                                    Sucursal,
                                    Id_Sistema,
                                    Fecha_PagoMañana,
                                    Laminas,
                                    Tipo_Inversion,
                                    Estado_Operacion_Linea,
                                    valvenc,
                                    tipoper,
                                    premio,
                                    descuento,
                                    monto_letra_sorteo,
		                    keyid_desk_manager,
                                    libro_desk_manager,
                                    numero_pu,
                                    codigo_area
		     FROM  CARTERA_HISTORICA_TRADER
                     WHERE fecha_proceso  = @iFecha_fin_Mes  AND
                           codigo_cartera = 'CP'             AND
                           tipoper        In ('CP','TI','CFM')     AND
                           Cartera        = '111'
    
       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Historico a Cartera de Compras Propias.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Cartera con Pacto                                                                */
       /*==================================================================================*/
       INSERT INTO CARTERA_COMPRA_PACTO (
                                          cirutcart,
                                          citipcart,
                                          cinumdocu,
                                          cicorrela,
                                          cinumdocuo,
                                          cicorrelao,
                                          cirutcli,
                                          cicodcli,
                                          ciinstser,
                                          cimascara,
                                          cinominal,
                                          cifeccomp,
                                          civalcomp,
                                          civalcomu,
                                          civcum100,
                                          citircomp,
                                          citasest,
                                          cipvpcomp,
                                          civpcomp,
                                          cifecemi,
                                          cifecven,
                                          ciseriado,
                                          cicodigo,
                                          cifecinip,
                                          cifecvenp,
                                          civalinip,
                                          civalvenp,
                                          citaspact,
                                          cibaspact,
                                          cimonpact,
                                          civptirc,
                                          cicapitalc,
                                          ciinteresc,
                                          cireajustc,
                                          ciintermes,
                                          cireajumes,
                                          cicapitalci,
                                          ciinteresci,
                                          cireajustci,
                                          civptirci,
                                          cinumucup,
                                          cirutemi,
                                          cimonemi,
                                          cicontador,
                                          cifecucup,
                                          cinominalp,
                                          ciforpagi,
                                          ciforpagv,
                                          cifecpcup,
                                          cidcv,
                                          cidurat,
                                          cidurmod,
                                          ciconvex,
                                          fecha_compra_original,
                                          valor_compra_original,
                                          valor_compra_um_original,
                                          tir_compra_original,
                                          valor_par_compra_original,
                                          porcentaje_valor_par_compra_original,
                                          codigo_carterasuper,
                                          Tipo_Cartera_Financiera,
                                          Mercado,
                                          Sucursal,
                                          Id_Sistema,
                                          Fecha_PagoMañana,
                                          Laminas,
                                          Tipo_Inversion,
                                          Cuenta_Corriente_Inicio,
                                          Cuenta_Corriente_Final,
                                          Sucursal_Inicio,
                                          Sucursal_Final,
                                          Estado_Operacion_Linea,
                                          civalvenc,
                                          Tipo_Operacion,
                                          keyid_desk_manager,
                                          libro_desk_manager,
                                          numero_pu,
                                          Precio_Transferencia,
                                          codigo_area
                                        )
              SELECT                      rutcart,
                                          tipcart,
                                          numdocu,
                                          correla,
                                          numdocuo,
                                          correlao,
                                          rutcli,
                                          codcli,
                                          instser,
                                          mascara,
                                          nominal,
                                          feccomp,
                                          valcomp,
                                          valcomu,
                                          vcum100,
                                          tircomp,
                                          tasest,
                                          pvpcomp,
                                          vpcomp,
                                          fecemi,
                                          fecven,
                                          seriado,
                                          codigo,
                                          fecinip,
                                          fecvenp,
                                          valinip,
                                          valvenp,
                                          taspact,
                                          baspact,
                                          monpact,
                                          vptirc,
                                          capitalc,
                                          interesc,
                                          reajustc,
                                          intermes,
                                          reajumes,
                                          capitalci,
                                          interesci,
                                          reajustci,
                                          vptirci,
                                          numucup,
                                          rutemi,
                                          monemi,
                                          contador,
                                          fecucup,
                                          nominalp,
                                          forpagi,
                             forpagv,
                                          fecpcup,
                                          dcv,
                                          durat,
                                          durmod,
                                          convex,
                                          fecha_compra_original,
                                          valor_compra_original,
                                          valor_compra_um_original,
                                          tir_compra_original,
                                          valor_par_compra_original,
                                          porcentaje_valor_par_compra_original,
                                          codigo_carterasuper,
                                          Tipo_Cartera_Financiera,
                                          Mercado,
                                          Sucursal,
                                          Id_Sistema,
                                          Fecha_PagoMañana,
                                          Laminas,
                                          Tipo_Inversion,
                                          Cuenta_Corriente_Inicio,
                                          Cuenta_Corriente_Final,
                                          Sucursal_Inicio,
                                          Sucursal_Final,
                                          Estado_Operacion_Linea,
                                          valvenc,
                                          CASE WHEN mnextranj = "0" THEN "CIX" ELSE "CI" END,--tipoper,
                                          keyid_desk_manager,
                                          libro_desk_manager,
                                          numero_pu,
                                          Precio_Transferencia,
                                          codigo_area
                     FROM  CARTERA_HISTORICA_TRADER,VIEW_MONEDA
                     WHERE fecha_proceso  = @iFecha_fin_Mes  AND
                           codigo_cartera = 'CI'             AND
                           tipoper        = 'CI'             AND
                           Cartera        = '112'            AND
                           mncodmon       = monpact

       IF @@ERROR<>0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Historico a Cartera de Compras con Pacto.'
          SET NOCOUNT OFF
          RETURN

       END   

       /*==================================================================================*/
       /* Cartera Interbancaria                                                            */
       /*==================================================================================*/
       INSERT INTO CARTERA_INTERBANCARIA (
                                           rut_cartera,
                                           tipo_cartera,
                                           numero_operacion,
                                           correlativo_operacion,
                                           numero_documento,
                                           rut_cliente,
                                           codigo_cliente,
                                           Serie,
                                           mascara,
                                           nominal,
                                           fecha_inicio_pacto,
                                           valor_compra,
                                           valor_compra_um,
                                           tir_compra,
                                           fecha_vencimiento_pacto,
                                           codigo,
                                           valor_inicial,
                                           valor_final,
                                           tasa_pacto,
                                           base_pacto,
                                           moneda_pacto,
                                           valor_presente_tir_compra,
                                           capital_compra,
                                           interes_compra,
                                           reajuste_compra,
                                           interes_mes,
                                           reajuste_mes,
                                           capital_pacto,
                                           interes_pacto,
                                           reajuste_pacto,
                                           valor_presente_tir_pacto,
                                           nominal_pesos,
                                           forma_pago_inicio,
                                           forma_pago_vencimiento,
                                           dcv,
                                           Tipo_Cartera_Financiera,
                                           Mercado,
                                           Sucursal,
                                           Id_Sistema,
                                           Fecha_PagoMañana,
                                           Laminas,
                                           Tipo_Inversion,
                                           Cuenta_Corriente_Inicio,
                                           Cuenta_Corriente_Final,
                                           Sucursal_Inicio,
                                           Sucursal_Final,
                                           Estado_Operacion_Linea,
                                           valor_vencimiento,
                                           Tipo_Operacion,
                                           keyid_desk_manager,
                                           libro_desk_manager,
                                           numero_pu,
                                           codigo_area
                                         )
              SELECT                       rutcart,
                                           tipcart,
                                           numdocu,
                                           correla,
                                           numoper,
                                           rutcli,
                                           codcli,
                                           instser,
                                           mascara,
                                           nominal,
                                           feccomp,
                                           valcomp,
                                           valcomu,
                                           tircomp,
                                           fecven,
                                           codigo,
                                           valinip,
                                           valvenp,
                                           taspact,
                                           baspact,
                                           monpact,
                                           vptirc,
                                           capitalc,
                                           interesc,
                                           reajustc,
                                           intermes,
                                           reajumes,
                                           capitalci,
                                           interesci,
                                           reajustci,
                                           vptirci,
                                           nominalp,
                                           forpagi,
                                           forpagv,
                                           dcv,
                                           Tipo_Cartera_Financiera,
                                           Mercado,
                                           Sucursal,
                     Id_Sistema,
                                           Fecha_PagoMañana,
                                           Laminas,
                                           Tipo_Inversion,
                                           Cuenta_Corriente_Inicio,
                                           Cuenta_Corriente_Final,
                                           Sucursal_Inicio,
                                           Sucursal_Final,
                                           Estado_Operacion_Linea,
                                           valvenc,
                                           tipoper,
                                           keyid_desk_manager,
                                           libro_desk_manager,
                                           numero_pu,
                                           codigo_area
                     FROM  CARTERA_HISTORICA_TRADER
                     WHERE fecha_proceso  = @iFecha_fin_Mes  AND
                           codigo_cartera = 'IB'             AND
    --                           tipoper        = 'IB'             AND
                           Cartera        = '121'
    
       IF @@ERROR<>0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Historico a Cartera Interbancaria.'
          SET NOCOUNT OFF
          RETURN

       END   

       /*==================================================================================*/
       /* Cartera Venta con Pacto                  */
       /*==================================================================================*/
       INSERT INTO CARTERA_VENTA_PACTO (
                                         virutcart,
                                         vinumdocu,
                                         vicorrela,
                                         vinumoper,
                                         vitipoper,
                                         virutcli,
                                         vicodcli,
                                         viinstser,
                                         vinominal,
                                         vifecinip,
                                         vifecvenp,
                                         vivalinip,
                                         vivalvenp,
                                         vitaspact,
                                         vibaspact,
                                         vimonpact,
                                         vivptirc,
                                         vivptirci,
                                         vivptirv,
                                         vivptirvi,
                                         vivalcomu,
                                         vivalcomp,
                                         vicapitalv,
                                         viinteresv,
                                         vireajustv,
                                         viintermesv,
                                         vireajumesv,
                                         vicapitalvi,
                                         viinteresvi,
                                         vireajustvi,
                                         viintermesvi,
                                         vireajumesvi,
                                         vivalvent,
                                         vivvum100,
                                         vivalvemu,
                                         vitirvent,
                                         vitasest,
                                         vipvpvent,
                                         vivpvent,
                                         vinumucupc,
                                         vinumucupv,
                                         virutemi,
                                         vimonemi,
                                         vifecemi,
                                         vifecven,
                                         vifecucup,
                                         vicodigo,
                                         vitircomp,
                                         vifeccomp,
                                         viseriado,
                                         vimascara,
                                         vivalinipci,
                                         vivalvenpci,
                                         vifecinipci,
                                         vifecvenpci,
                                         vitaspactci,
                                         vibaspactci,
                                         viinteresci,
                                         vicorvent,
                                         vinominalp,
                                         viforpagi,
                                         viforpagv,
                                         vicorrvent,
                                         vifecpcup,
                                         vivcompori,
                                         vivpcomp,
                                         vidurat,
                                         vidurmod,
                                         viconvex,
                                         viintacumcp,
                                         vireacumcp,
                                         viintacumvi,
                                         vireacumvi,
                                         viintacumci,
                                         vireacumci,
                                         fecha_compra_original,
                                         valor_compra_original,
                                         valor_compra_um_original,
                                         tir_compra_original,
                                         valor_par_compra_original,
                                         porcentaje_valor_par_compra_original,
                                         codigo_carterasuper,
                                         Tipo_Cartera_Financiera,
                                         Mercado,
                                         Sucursal,
                                         Id_Sistema,
                                         Fecha_PagoMañana,
                                         Laminas,
                                         Tipo_Inversion,
                                         Cuenta_Corriente_Inicio,
                                         Cuenta_Corriente_Final,
                                         Sucursal_Inicio,
                                         Sucursal_Final,
                                         vivalvenc,
                                         Tipo_Operacion,
                                         keyid_desk_manager,
                                         libro_desk_manager,
                                         numero_pu,
                                         Precio_Transferencia,
                                         codigo_area
                                       )
              SELECT                     rutcart,
                                         numdocu,
                                         correla,
                                         numoper,
                                         tipoper,
                                         rutcli,
                                         codcli,
                                         instser,
                                         nominal,
                                         fecinip,
                                         fecvenp,
                                         valinip,
                                         valvenp,
                                         taspact,
                                         baspact,
                                         monpact,
                                         vptirc,
                                         vptirci,
                                         vptirv,
                                         vptirvi,
                                         valcomu,
                                         valcomp,
                                         capitalv,
                                         interesv,
                                         reajustv,
                                         intermesv,
                                         reajumesv,
                                         capitalvi,
                                         interesvi,
                                         reajustvi,
                                         intermesvi,
                                         reajumesvi,
                                         valvent,
                                         vvum100,
                                         valvemu,
                                         tirvent,
                                         tasest,
                                         pvpvent,
                                         vpvent,
                                         numucupc,
                                         numucupv,
                                         rutemi,
                                         monemi,
                                         fecemi,
                                         fecven,
                                         fecucup,
                                         codigo,
                                         tircomp,
                                         feccomp,
                                         seriado,
                                         mascara,
                                         valinipci,
                                         valvenpci,
                                         fecinipci,
                                         fecvenpci,
                                         taspactci,
                                         baspactci,
                                         interesci,
                                         corvent,
                                         nominalp,
                                         forpagi,
                                         forpagv,
                                         corrvent,
                                         fecpcup,
                                         vcompori,
                                         vpcomp,
                                         durat,
                                         durmod,
                                         convex,
                                         intacumcp,
                                         reacumcp,
                                         intacumvi,
                                         reacumvi,
                                         intacumci,
                                         reacumci,
                                         fecha_compra_original,
                                         valor_compra_original,
                                         valor_compra_um_original,
                                         tir_compra_original,
                                         valor_par_compra_original,
                                         porcentaje_valor_par_compra_original,
                                         codigo_carterasuper,
                                         Tipo_Cartera_Financiera,
                                         Mercado,
                                         Sucursal,
                                         Id_Sistema,
                                         Fecha_PagoMañana,
                                         Laminas,
                                         Tipo_Inversion,
                                         Cuenta_Corriente_Inicio,
                                         Cuenta_Corriente_Final,
                                         Sucursal_Inicio,
                                         Sucursal_Final,
                                         valvenc,
                                         codigo_subproducto,--CASE WHEN mnextranj = 0 THEN 'VIX' ELSE 'VI' END,
                                         keyid_desk_manager,
                                         libro_desk_manager,
                                         numero_pu,
                                         Precio_Transferencia,
                                         codigo_area
                     FROM  CARTERA_HISTORICA_TRADER,VIEW_MONEDA
                     WHERE fecha_proceso  = @iFecha_fin_Mes  AND
                           codigo_cartera = 'VI'             AND
                           Cartera        = '115'            AND
                           mncodmon       = monpact
    
       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Cartera de Historica a Ventas con Pacto.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Cortes                                                                           */
       /*==================================================================================*/
       INSERT INTO CORTE (
                       corutcart,
                       conumdocu,
                       cocorrela,
                       comtocort,
                       cocantcortd,
                       cocantcorto,
                       keyid_desk_manager,
                       libro_desk_manager,
                       numero_pu
                     )
          SELECT       corutcart,
                       conumdocu,
                       cocorrela,
                       comtocort,
                       cocantcortd,
                       cocantcorto,
                       keyid_desk_manager,
                       libro_desk_manager,
                       numero_pu
                 FROM  CORTE_HISTORICO
                 WHERE fecha_proceso  = @iFecha_fin_Mes AND
                       codigo_cartera in ( 'CP', 'CI' )

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Historico a Cortes.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Cortes Vendidos                                                                  */
       /*==================================================================================*/
       INSERT INTO CORTE_VENDIDO (
                               cvrutcart,
                               cvnumdocu,
                               cvcorrela,
                               cvnumoper,
                               cvcantcort,
                               cvmtocort,
                               cvstatreg,
                               cvtipoper,
                               keyid_desk_manager,
                               libro_desk_manager,
                               numero_pu
                             )
          SELECT               corutcart,
                               conumdocu,
                               cocorrela,
                               conumoper,
                               cocantcortd,
                               comtocort,
                               ' ',
                               ditipoper,
                               keyid_desk_manager,
                               libro_desk_manager,
                               numero_pu
                 FROM  CORTE_HISTORICO, CARTERA_DISPONIBLE
                 WHERE Fecha_Proceso = @iFecha_fin_Mes       AND
                       conumdocu     = dinumdocu               AND
                       cocorrela     = dicorrela               AND
                       corutcart     = dirutcart               AND
                       tipoper       = 'VI'

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se pudo traspasar Cortes Vendidos a Historico.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Limpieza de la tabla Corte Historico                                             */
       /*==================================================================================*/
       DELETE FROM CORTE_HISTORICO       WHERE fecha_proceso  >= @iFecha_fin_Mes

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se puede limipiar cortes historico.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Limpieza de la cartera historica de trader                                       */
       /*==================================================================================*/
       DELETE FROM CARTERA_HISTORICA_TRADER WHERE fecha_proceso >= @iFecha_fin_Mes

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se puede limipiar cartera historica'
          SET NOCOUNT OFF
          RETURN

       END
       /*==================================================================================*/
       /*==================================================================================*/
       INSERT INTO NOSERIE SELECT * FROM #PASONOSERIE WHERE nsfecemi <= @iFecha_fin_Mes

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'No se puede limpiar Datos No seriados.'
          SET NOCOUNT OFF
          RETURN

       END

       /*==================================================================================*/
       /* Limpieza de la tabla Resultado                                                   */
       /*==================================================================================*/
       DELETE FROM RESULTADO_DEVENGO  WHERE rsfecha  >= @iFecha_fin_Mes
    
       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se puede limipiar resultados.'
          SET NOCOUNT OFF
          RETURN

       END

       INSERT DOCUMENTO_BLOQUEADO SELECT * FROM #BLOQUEADO 
       WHERE EXISTS(SELECT DINUMDOCU FROM CARTERA_DISPONIBLE
                    WHERE dinumdocu = blnumdocu
                    AND   dicorrela = blcorrela)

   END 
 END


 IF @iSistema =  'INV' BEGIN

  IF EXISTS(SELECT 1 FROM VIEW_CARTERA_INVERSION_EXTERIOR_HISTORICA WHERE cpfecproc = @iFecha_fin_Mes) BEGIN             

   /*==================================================================================*/
   /* Limpiar Cartera.                                                                 */
   /*==================================================================================*/
   DELETE FROM VIEW_CARTERA_INVERSION_EXTERIOR

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limpiar cartera.'
      SET NOCOUNT OFF
      RETURN 

   END

   /*==================================================================================*/
   /* Insertar Cartera Historica a la Cartera.                                         */
   /*==================================================================================*/
   INSERT INTO VIEW_CARTERA_INVERSION_EXTERIOR (
                                                 cprutcart,
                                                 cpnumdocu,
                                                 cprutcli,
                                                 cpcodcli,
                                                 cpcodemi,
                                                 cod_familia,
                                                 cod_nemo,
                                                 id_instrum,
                                                 cpnominal,
                                                 cpnomi_vta,
                                                 cpvalvenc,
       cpfecneg,
                                                 cpfecpago,
                                                 cpfeccomp,
                                                 cpint_compra,
                                                 cpprincipal,
                                                 cpvalcomp,
                                                 cpvalcomu,
                                                 cptircomp,
                                                 cppvpcomp,
                                                 cpvpcomp,
                                                 cpfecemi,
                                                 cpfecven,
                                                 cptasemi,
                                                 cpbasemi,
                                                 cprutemi,
                                                 cpmonemi,
                                                 cpmonpag,
                                                 cpvptirc,
                                                 cpcapital,
                                                 cpinteres,
                                                 cpreajust,
                                                 cpnumucup,
                                                 cpnumpcup,
                                                 cpfecucup,
                                                 cpfecpcup,
                                                 cptirmerc,
                                                 cppvpmerc,
                                                 cpvalmerc,
                                                 basilea,
                                                 tipo_tasa,
                                                 encaje,
                                                 monto_encaje,
                                                 codigo_carterasuper,
                                                 tipo_cartera_financiera,
                                                 sucursal,
                                                 calce,
                                                 tipo_inversion,
                                                 para_quien,
                                                 nombre_custodia,
                                                 forma_pago,
                                                 confirmacion,
                                                 base_tasa,
                                                 operador_contra,
                                                 operador_banco,
                                                 monto_emision,
                                                 corr_cli_nombre,
                                                 corr_cli_cta,
                                                 corr_cli_aba,
                                                 corr_cli_pais,
                                                 corr_cli_ciud,
                                                 corr_cli_swift,
                                                 corr_cli_ref,
                                                 cpfectraspaso,
                                                 cpajuste_traspaso,
                                                 cusip,
                                                 Codigo_SubProducto,
						 keyid_desk_manager,
						 libro_desk_manager,
						 numero_pu,
						 correlativo,
						 numero_operacion,
						 forma_pago_recibimos 
						)
          SELECT                                 cprutcart,
                                                 cpnumdocu,
                                                 cprutcli,
                                                 cpcodcli,
                                                 cpcodemi,
                                                 cod_familia,
                		                 cod_nemo,
		                                 id_instrum,
                                                 cpnominal,
                                                 cpnomi_vta,
                                                 cpvalvenc,
                                                 cpfecneg,
                                                 cpfecpago,
                                                 cpfeccomp,
                                                 cpint_compra,
                                                 cpprincipal,
                                                 cpvalcomp,
                                                 cpvalcomu,
                                                 cptircomp,
                                                 cppvpcomp,
                                                 cpvpcomp,
                                                 cpfecemi,
                                                 cpfecven,
                                                 cptasemi,
                                                 cpbasemi,
                                                 cprutemi,
                                                 cpmonemi,
                                                 cpmonpag,
                                                 cpvptirc,
                                                 cpcapital,
                                                 cpinteres,
                                                 cpreajust,
                                                 cpnumucup,
                                                 cpnumpcup,
                                                 cpfecucup,
                                                 cpfecpcup,
                                                 cptirmerc,
                                                 cppvpmerc,
                                                 cpvalmerc,
                                                 basilea,
                                                 tipo_tasa,
                                                 encaje,
                                                 monto_encaje,
                                                 codigo_carterasuper,
                                                 tipo_cartera_financiera,
                                                 sucursal,
                                                 calce,
                                                 tipo_inversion,
                                                 para_quien,
                                                 nombre_custodia,
                                                 forma_pago,
                                                 confirmacion,
                                                 base_tasa,
                                                 operador_contra,
                                                 operador_banco,
                                                 monto_emision,
                                                 corr_cli_nombre,
                                                 corr_cli_cta,
                                                 corr_cli_aba,
                                                 corr_cli_pais,
                                                 corr_cli_ciud,
                                                 corr_cli_swift,
                                                 corr_cli_ref,
                                                 cpfectraspaso,
                                                 cpajuste_traspaso,
                                                 cusip,
                                                 Codigo_SubProducto,
						 keyid_desk_manager,
						 libro_desk_manager,
						 numero_pu,
						 correlativo,
						 numero_operacion,
						 forma_pago_recibimos 
                 FROM  VIEW_CARTERA_INVERSION_EXTERIOR_HISTORICA
                 WHERE cpfecproc = @iFecha_fin_Mes

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede insertar cartera historica a la cartera.'
      SET NOCOUNT OFF
      RETURN 

   END

   /*==================================================================================*/
   /* Limpia cartera historica.                                                        */
   /*==================================================================================*/
   DELETE FROM VIEW_CARTERA_INVERSION_EXTERIOR_HISTORICA WHERE cpfecproc = @iFecha_fin_Mes

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limpiar cartera historica.'
      SET NOCOUNT OFF
      RETURN 

   END
   /*==================================================================================*/
   /* Limpieza de la tabla Resultado                                                   */
   /*==================================================================================*/
       DELETE FROM VIEW_RESULTADO_INVERSION_EXTERIOR WHERE rsfecpro  >= @iFecha_fin_Mes
    
       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se puede limipiar resultados.'
          SET NOCOUNT OFF
          RETURN

       END

  END  
 END


 IF @iSistema =  'PSV' BEGIN

  IF EXISTS(SELECT 1 FROM VIEW_CARTERA_PASIVO_HISTORICA WHERE fecha_cartera = @iFecha_fin_Mes) BEGIN             

   /*==================================================================================*/
   /* Limpiar Cartera.                                                                 */
   /*==================================================================================*/
   DELETE FROM VIEW_CARTERA_PASIVO

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limpiar cartera Historica Pasivo.'
      SET NOCOUNT OFF
      RETURN 

   END

   /*==================================================================================*/
   /* Insertar Cartera Historica a la Cartera.                                         */
   /*==================================================================================*/

   INSERT INTO VIEW_CARTERA_PASIVO (
							entidad_cartera
						,	codigo_instrumento
						,	numero_operacion
						,	numero_correlativo
						,	numero_contrato
						,	nombre_serie
						,	fecha_emision_papel
						,	fecha_vencimiento
						,	fecha_proximo_cupon
						,	fecha_anterior_cupon
						,	fecha_colocacion
						,	rut_emisor
						,	rut_cliente
						,	codigo_cliente
						,	numero_cuotas
						,	perido_amortizacion
						,	moneda_emision
						,	nominal
						,	nominal_pesos
						,	tasa_emision
						,	codigo_base
						,	valor_emision_pesos
						,	valor_emision_um
						,	saldo_flujo_emision
						,	reajuste_emision
						,	interes_emision
						,	presente_emision
						,	proximo_emision
						,	valor_par_emision
						,	tasa_colocacion
						,	base_colocacion
						,	valor_colocacion_clp
						,	valor_colocacion_um
						,	reajuste_colocacion
						,	interes_colocacion
						,	presente_colocacion
						,	proximo_colocacion
						,	valor_par_colocacion
						,	forma_pago
						,	tipo_tasa
						,	spread
						,	retiro_documento
						,	rut_acreedor
						,	dv_acreedor
						,	nombre_acreedor
						,	codigo_area
						,	sucursal
						,	observacion
						,	numero_pu
						,	keyid_deskmanager
						,	libro_deskmanager
						,	premio
						,	descuento
						,	numero_anterior
						)
			SELECT
							entidad_cartera
						,	codigo_instrumento
						,	numero_operacion
						,	numero_correlativo
						,	numero_contrato
						,	nombre_serie
						,	fecha_emision_papel
						,	fecha_vencimiento
						,	fecha_proximo_cupon
						,	fecha_anterior_cupon
						,	fecha_colocacion
						,	rut_emisor
						,	rut_cliente
						,	codigo_cliente
						,	numero_cuotas
						,	perido_amortizacion
						,	moneda_emision
						,	nominal
						,	nominal_pesos
						,	tasa_emision
						,	codigo_base
						,	valor_emision_pesos
						,	valor_emision_um
						,	saldo_flujo_emision
						,	reajuste_emision
						,	interes_emision
						,	presente_emision
						,	proximo_emision
						,	valor_par_emision
						,	tasa_colocacion
						,	base_colocacion
						,	valor_colocacion_clp
						,	valor_colocacion_um
						,	reajuste_colocacion
						,	interes_colocacion
						,	presente_colocacion
						,	proximo_colocacion
						,	valor_par_colocacion
						,	forma_pago
						,	tipo_tasa
						,	spread
						,	retiro_documento
						,	rut_acreedor
						,	dv_acreedor
						,	nombre_acreedor
						,	codigo_area
						,	sucursal
						,	observacion
						,	numero_pu
						,	keyid_deskmanager
						,	libro_deskmanager
						,	premio
						,	descuento
						,	numero_anterior
				FROM 	VIEW_CARTERA_PASIVO_HISTORICA
        	        	 WHERE fecha_cartera = @iFecha_fin_Mes

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede insertar cartera historica a la cartera Pasivo.'
      SET NOCOUNT OFF
      RETURN 

   END

   /*==================================================================================*/
   /* Limpia cartera historica.                                                        */
   /*==================================================================================*/
   DELETE FROM VIEW_CARTERA_PASIVO_HISTORICA WHERE fecha_cartera = @iFecha_fin_Mes

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limpiar cartera historica Pasivo.'
      SET NOCOUNT OFF
      RETURN 

   END
   /*==================================================================================*/
   /* Limpieza de la tabla Resultado                                                   */
   /*==================================================================================*/
       DELETE FROM VIEW_RESULTADO_PASIVO WHERE fecha_calculo  >= @iFecha_fin_Mes

       IF @@ERROR <> 0
       BEGIN
          SELECT 'NO', 'Error: No se puede limipiar resultados Pasivo.'
          SET NOCOUNT OFF
          RETURN

       END

  END  
 END


        SELECT 'OK'
END







GO
