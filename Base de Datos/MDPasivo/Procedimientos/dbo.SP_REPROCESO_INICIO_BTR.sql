USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPROCESO_INICIO_BTR]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REPROCESO_INICIO_BTR]
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @nNumero_Venta        NUMERIC(09)
   DECLARE @cCodigo_Producto     VARCHAR(05)

   /*==================================================================================*/
   /* Este procedimiento se encarga de realizar la transferencia de los siguientes     */
   /* Datos:                                                                           */
   /*  CP  CARTERA_HISTORICA_TRADER                ===> CARTERA_PROPIA                 */
   /*  DI  CARTERA_HISTORICA_TRADER                ===> CARTERA_DISPONIBLE             */
   /*  CI  CARTERA_HISTORICA_TRADER                ===> CARTERA_COMPRA_PACTO           */
   /*  IB  CARTERA_HISTORICA_TRADER                ===> CARTERA_INTERBANCARIA          */
   /*  VI  CARTERA_HISTORICA_TRADER                ===> CARTERA_VENTA_PACTO            */
   /*  --  CORTE_HISTORICO                         ===> CORTE                          */
   /*  --  CORTE_VENDIDO_HISTORICO                 ===> CORTE_VENDIDO                  */
   /*==================================================================================*/
   /* Ademas Limpia las siguientes tablas:                                             */
   /*      CARTERA_HISTORICA_TRADER                                                    */
   /*      MOVIMIENTO_TRADER                                                           */
   /*      RESULTADO_DEVENGO                                                           */
   /*      CORTE_HISTORICO                                                             */
   /*      CORTE_VENDIFO_HISTORICO                                                     */
   /*==================================================================================*/
   DECLARE @dFechaProceso      DATETIME
   DECLARE @dFechaAnterior     DATETIME
   DECLARE @nNumoper_ult        NUMERIC(10)

 
   SELECT      @dFechaProceso  = Fecha_Proceso,
               @dFechaAnterior  = CASE WHEN DATEPART(MONTH,Fecha_Proceso  ) <> DATEPART(MONTH, Fecha_Anterior )
                                   THEN DATEADD(DAY,-1,CONVERT(DATETIME,CONVERT(CHAR(4),DATEPART(YEAR,Fecha_Proceso)) + CASE WHEN DATEPART(MONTH,Fecha_Proceso) < 10 THEN
                                   '0' + RTRIM(CONVERT(CHAR(1),DATEPART(MONTH,Fecha_Proceso))) ELSE CONVERT(CHAR(2),DATEPART(MONTH,Fecha_Proceso)) END + '01'))
                                    ELSE Fecha_Anterior  END      
   FROM VIEW_DATOS_GENERALES

   /*==================================================================================*/
   /*==================================================================================*/
   DELETE FROM VALORIZACION_MERCADO WHERE fecha_valorizacion > @dFechaAnterior

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se pudo Limpiar los Documentos Bloqueados.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /*==================================================================================*/
   DELETE FROM DOCUMENTO_BLOQUEADO

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se pudo Limpiar los Documentos Bloqueados.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Limpieza de la cartera                                                           */
   /*==================================================================================*/
   DELETE FROM CORTE_VENDIDO

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
   /* Limpieza de la CARTERA_DISPONIBLE                                                */
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
                                    codigo_subproducto,
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
                                    codigo_subproducto,
				    valvenp
                 FROM  CARTERA_HISTORICA_TRADER
                 WHERE fecha_proceso  = @dFechaAnterior  AND
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
                                codigo_area,
                                premio_acum,
                                descuento_acum,
                                codigo_subproducto
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
                                codigo_area,
                                premio_acum,
                                descuento_acum,
                                codigo_subproducto
                 FROM  CARTERA_HISTORICA_TRADER
                 WHERE fecha_proceso  = @dFechaAnterior  AND
                       codigo_cartera = 'CP'             AND
                       tipoper       IN ('CP','TI','CFM') AND
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
                                      codigo_area,
                                      codigo_subproducto
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
                                      CASE WHEN mnextranj = 0 THEN 'CIX' ELSE 'CI' END,
                                      keyid_desk_manager,
                                      libro_desk_manager,
                                      numero_pu,
                                      Precio_Transferencia,
                                      codigo_area,
                                      codigo_subproducto
                 FROM  CARTERA_HISTORICA_TRADER,VIEW_MONEDA
                 WHERE fecha_proceso  = @dFechaAnterior  AND
                       codigo_cartera = 'CI'             AND
                       tipoper        = 'CI'             AND
                       Cartera        = '112'            AND
                  monpact        = mncodmon 

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
                                       codigo_area,
                                       codigo_subproducto
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
                                       codigo_area,
                                       codigo_subproducto
                 FROM  CARTERA_HISTORICA_TRADER
                 WHERE fecha_proceso  = @dFechaAnterior  AND
                       codigo_cartera = 'IB'             AND
--                       tipoper        = 'IB'             AND
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
                                     codigo_area,
                                     codigo_subproducto
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
                                     codigo_area,
                                     codigo_subproducto
                 FROM  CARTERA_HISTORICA_TRADER,VIEW_MONEDA
                 WHERE fecha_proceso  = @dFechaAnterior  AND
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
                 WHERE fecha_proceso  = @dFechaAnterior AND
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
                 WHERE Fecha_Proceso = @dFechaAnterior       AND
                       conumdocu     = dinumdocu               AND
                       cocorrela     = dicorrela               AND
                       corutcart     = dirutcart               AND
                       codigo_cartera = 'VI'

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se pudo traspasar Cortes Vendidos a Historico.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Limpieza de la tabla Corte Historico                                             */
   /*==================================================================================*/
   DELETE FROM CORTE_HISTORICO       WHERE fecha_proceso  >= @dFechaAnterior

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limipiar cortes historico.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Limpieza de la cartera historica de trader                                       */
   /*==================================================================================*/
   DELETE FROM CARTERA_HISTORICA_TRADER WHERE fecha_proceso >= @dFechaAnterior

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limipiar cartera historica'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Limpieza de la tabla Resultado                                                   */
   /*==================================================================================*/
   DELETE FROM VALORIZACION_MERCADO    WHERE Fecha_Valorizacion  >= @dFechaProceso

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limipiar tabla valorización.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Limpieza de la tabla Resultado                                                   */
   /*==================================================================================*/
   DELETE FROM RESULTADO_DEVENGO     WHERE rsfecha  > @dFechaProceso

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limipiar resultados.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Limpieza de la tabla movimiento                                                  */
   /*==================================================================================*/
/* NO APLICA    SELECT DISTINCT numdocu = monumdocuo
    INTO  #PRUEBA
    FROM MOVIMIENTO_TRADER a
    WHERE EXISTS(SELECT monumoper FROM MOVIMIENTO_TRADER b
             WHERE b.monumdocuo = a.monumdocuo
             AND motipoper  ='RFM' AND mofecpro = @dFechaProceso
             AND RTRIM(mostatreg) =' ')
    AND  NOT EXISTS(select monumoper from MOVIMIENTO_TRADER b
             where b.monumdocuo = a.monumdocuo
             AND motipoper  ='RFM' AND mofecpro < @dFechaProceso
             AND RTRIM(mostatreg) =' ')
    AND motipoper  ='CFM'


    UPDATE MOVIMIENTO_TRADER SET mostatreg = ' '
    FROM #PRUEBA
    WHERE numdocu = monumdocuo
    AND   motipoper = 'CFM'
    AND   mofecpro < @dFechaProceso
    AND   monumdocu = numdocu 

*/
  	
   DELETE FROM MOVIMIENTO_TRADER     WHERE mofecpro  > @dFechaAnterior

   DELETE FROM control_operacion_trader WHERE fecha_operacion  > @dFechaAnterior

   SELECT  @nnumoper_ult =  MAX(Numero_Operacion_Btr)
   FROM    control_operacion_trader
   WHERE   fecha_operacion = @dFechaAnterior  

   DELETE FROM MOVIMIENTO_TRADER     WHERE monumoper > @nnumoper_ult

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Error: No se puede limipiar movimientos.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /*==================================================================================*/

   INSERT INTO NOSERIE SELECT * FROM #PASONOSERIE WHERE nsfecemi < @dFechaProceso
						  AND  EXISTS(SELECT * FROM CARTERA_DISPONIBLE
						  WHERE NSNUMDOCU = DINUMDOCU AND NSCORRELA = DICORRELA AND NSRUTCART =DIRUTCART)

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'No se puede limpiar Datos No seriados.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Anular Ventas de Letras Hipotecarias del día.                                    */
   /*==================================================================================*/
   SELECT DISTINCT Numero_Venta,
                   Codigo_Producto
          INTO     #tmp_Letras_Venta
          FROM     LETRA_HIPOTECARIA_VENDIDA

   WHILE (1=1)
   BEGIN
      SELECT @cCodigo_Producto = '*'

      SELECT TOP 1 @nNumero_Venta    = Numero_Venta,
                   @cCodigo_Producto = Codigo_Producto
             FROM  #tmp_Letras_Venta

      IF @cCodigo_Producto = '*'
      BEGIN
         BREAK

      END

      EXECUTE sp_anulaletra @nNumero_Venta, @cCodigo_Producto


      IF @@error <>  0
      BEGIN
         SELECT 'NO', 'No se puede limpiar Datos No seriados.'
         SET NOCOUNT OFF
         RETURN

      END

      DELETE FROM  #tmp_Letras_Venta 
             WHERE Numero_Venta    = @nNumero_Venta      AND
                   Codigo_Producto = @cCodigo_Producto

   END


   DELETE FROM LETRA_HIPOTECARIA_VENDIDA  WHERE fecha_venta > @dFechaAnterior


   /*==================================================================================*/
   /*==================================================================================*/
   DELETE FROM  LETRA_HIPOTECARIA_CORTE
          FROM  LETRA_HIPOTECARIA
          WHERE LETRA_HIPOTECARIA.fecha_ingreso   > @dFechaAnterior                   AND
                LETRA_HIPOTECARIA.codigo_planilla = LETRA_HIPOTECARIA_CORTE.codigo_planilla

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'No se puede limpiar Cortes Letras Hipotecarias.'
      SET NOCOUNT OFF
      RETURN

   END

   /*==================================================================================*/
   /* Anulacion de Fondos Mutuos del día.                                              */
   /*==================================================================================*/

/*
   DECLARE @nreg_fm             NUMERIC(5)
         , @nNumero_Operacion   NUMERIC(9)
         , @cTipo_Operacion     CHAR(5)

   SELECT monumoper
        , motipoper
        , 'Registro'   = IDENTITY(INT)
     INTO #FONDOS_MUTUOS
     FROM MOVIMIENTO_TRADER WHERE mofecpro > @dFechaAnterior
      AND motipoper  IN('CFM','RFM')

   SELECT @nreg_fm = 1

    WHILE @nreg_fm <= (SELECT COUNT(1) FROM #FONDOS_MUTUOS)
    BEGIN

         SELECT @nNumero_Operacion   = monumoper
              , @cTipo_Operacion     = motipoper
           FROM #FONDOS_MUTUOS
          WHERE Registro             = @nreg_fm

           EXEC Sp_Anulacion_FM @nNumero_Operacion
                              , @cTipo_Operacion
         

         SET @nreg_fm = @nreg_fm +1

    END

 

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'No se puede limpiar Movimientos de Fondos Mutuos.'
      SET NOCOUNT OFF
      RETURN

   END
*/
   /*==================================================================================*/
   /* Eliminar Compras de Letras Hipotecarias del día.                                 */
   /*==================================================================================*/
   DELETE FROM LETRA_HIPOTECARIA WHERE fecha_ingreso > @dFechaAnterior

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'No se puede limpiar Letras Hipotecarias.'
      SET NOCOUNT OFF
      RETURN

   END


   /*==================================================================================*/
   /* Eliminar Vale Vistas del día.                                                    */
   /*==================================================================================*/

   DELETE FROM VIEW_VALE_VISTA_EMITIDO WHERE fecha_generacion > @dFechaAnterior

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'No se puede limpiar Letras Hipotecarias.'
      SET NOCOUNT OFF
      RETURN

   END


  	INSERT INTO DOCUMENTO_BLOQUEADO	(
					blrutcart	,
					blnumdocu	,
					blcorrela	,
					blhwnd		,
					blusuario
					)
	SELECT
					cprutcart	,
					cpnumdocu	,
					cpcorrela	,
					cpnumdocu	,
					'RTECNICA'
	FROM CARTERA_PROPIA
	WHERE cpcontador = 1	
		
	IF @@ERROR <> 0
	BEGIN
	      SELECT 'NO', 'Error: No se pudo traspasar Historico a Reserva tecnica.'
	      SET NOCOUNT OFF
	      RETURN
	END

  	INSERT INTO DOCUMENTO_BLOQUEADO	(
					blrutcart	,
					blnumdocu	,
					blcorrela	,
					blhwnd		,
					blusuario
					)
	SELECT
					cirutcart	,
					cinumdocu	,
					cicorrela	,
					cinumdocu	,
					'RTECNICA'
	FROM CARTERA_COMPRA_PACTO
	WHERE cicontador = 1	
		
	IF @@ERROR <> 0
	BEGIN
	      SELECT 'NO', 'Error: No se pudo traspasar Historico a Reserva tecnica.'
	      SET NOCOUNT OFF
	      RETURN
	END
   /*==================================================================================*/
   /*==================================================================================*/
   SELECT 'OK', ''
   SET NOCOUNT OFF

END




GO
