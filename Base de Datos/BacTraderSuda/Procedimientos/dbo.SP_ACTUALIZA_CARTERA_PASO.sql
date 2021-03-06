USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CARTERA_PASO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CARTERA_PASO]
AS
BEGIN

   SET NOCOUNT ON

   --  BEGIN TRANSACTION

   UPDATE MDCP
   SET    cpinstser 	 = rsinstcam  ,
          cpinteresc 	 = rsinteres_acum ,
          cpreajustc 	 = rsreajuste_acum ,
          cpvptirc 	 = rsvppresenx  ,
          cpvpcomp 	 = CASE WHEN rsrutemis = 97023000 and rscodigo = 20 THEN valor_par ELSE rsvpcomp END ,
          cpintermes 	 = rsintermes  ,
          cpreajumes 	 = rsreajumes  ,
          cpfecucup 	 = rsfecucup  ,
          cpfecpcup 	 = rsfecpcup  ,       
          cppvpcomp 	 = rsvpcomp  ,                  
          cpdurat   	 = rsdurat  ,		
          cpdurmod  	 = rsdurmod  ,
          cpconvex  	 = rsconvex,
          cpprimdescacum = round((prima_descuento_total/(DATEDIFF(DAY,rsfeccomp,rsfecvcto))),0)*(DATEDIFF(DAY,rsfeccomp,acfecproc))   /* se realiza formula directa para calcular prima descuento acumulado de acuerdo a fecha proceso
																 ,ya que el monto estaba desfasado en tres días*/
      --  cpprimdescacum = cpprimdescacum + prima_descuento_dia
   FROM   MDRS
   ,      MDAC
   WHERE  rsfecha        = acfecproc 
   AND    rsrutcart      = cprutcart 
   AND    rsnumdocu      = cpnumdocu 
   AND    rscorrela      = cpcorrela 
   AND    rstipoper      = 'DEV'
   AND    rscartera      = '111'
   AND    rscodigo      <> 98

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Proceso de Actualización en la cartera de compras propias a fallado.'
      SET NOCOUNT OFF
      RETURN
   END

   /*----------------------------------------------------------------------------------------------*/
   /* Actualización de la Cartera Compras Propias por Pago de Cupon    */
   /*----------------------------------------------------------------------------------------------*/

   UPDATE MDCP   -- Verificar Acumulados y cartera 111
   SET    cpinstser  = rsinstser,
          cpcapitalc = rsvalcomp,
          cpvalcomp  = rsvalcomp,
          cpvalcomu  = rsvalcomu,
          cpvpcomp   = rsvpcomp,
          cpinteresc = rsinteres_acum,
          cpreajustc = rsreajuste_acum,
          cpintermes = rsintermes,
          cpreajumes = rsreajumes,
          cpfecucup  = rsfecucup,
          cpfecpcup  = rsfecpcup,
          cppvpcomp  = rsvpcomp  
   FROM   MDRS
   ,      MDAC
   WHERE  rsfecha    = acfecproc 
   AND    rsrutcart  = cprutcart 
   AND    rsnumdocu  = cpnumdocu 
   AND    rscorrela  = cpcorrela 
   AND    rstipoper  = 'VC' 
   AND    rscartera  = '111'
   AND    rscodigo  <> 98

   IF @@ERROR<>0
   BEGIN
--           ROLLBACK TRANSACTION
      SELECT 'NO', 'Proceso de Actualización en la cartera de compras propias VC a fallado.'
      SET NOCOUNT OFF
      RETURN
   END

   /*----------------------------------------------------------------------------------------------*/
   /* Actualización de la cartera disponible.                                                      */
   /*----------------------------------------------------------------------------------------------*/

   UPDATE MDDI
   SET    diinstser  = rsinstcam,
          divptirc   = (CASE rstipopero WHEN 'CP' THEN rsvppresenx     ELSE 0 END) ,
          dicapitalc = (CASE rstipopero WHEN 'CP' THEN rsvalcomp       ELSE 0 END) ,
          diinteresc = (CASE rstipopero WHEN 'CP' THEN rsinteres_acum  ELSE 0 END) ,
          direajustc = (CASE rstipopero WHEN 'CP' THEN rsreajuste_acum ELSE 0 END) ,
          diintermes = rsintermes       ,
          direajumes = rsreajumes       ,
          divptirci  = (CASE rstipopero WHEN 'CI' THEN rsvppresenx     ELSE 0 END) ,
          dicapitaci = (CASE rstipopero WHEN 'CI' THEN rsvalcomp     ELSE 0 END) ,
          diintereci = (CASE rstipopero WHEN 'CI' THEN rsinteres       ELSE 0 END) ,
          direajusci = (CASE rstipopero WHEN 'CI' THEN rsreajuste      ELSE 0 END) ,
          divpmcd    = (CASE rstipopero WHEN 'CI' THEN 0	       ELSE Valor_Par END)
   FROM   MDRS, MDAC
   WHERE  rsfecha    = acfecproc 
   AND    rsrutcart  = dirutcart 
   AND    rsnumdocu  = dinumdocu 
   AND    rscorrela  = dicorrela 
   AND    rstipoper  = 'DEV' 
   AND    rscartera  = '111'
   AND    rscodigo  <> 98

   -- Falta Actualizar los Valores para ventas pactos de compras pacto
   IF @@ERROR<>0
   BEGIN
--           ROLLBACK TRANSACTION
      SELECT 'NO', 'Proceso de Actualización en la cartera disponible a fallado.'
      SET NOCOUNT OFF
      RETURN
   END

   UPDATE MdDi
   SET diinstser = rsinstser ,
  divptirc = rsvppresenx ,
  dicapitalc = rsvalcomp ,
  diinteresc = rsinteres ,
  direajustc = rsreajuste ,
  diintermes = rsintermes ,
  direajumes = rsreajumes
 FROM MdRs, MdAc WHERE rsfecha=acfecproc AND rsrutcart=dirutcart AND rsnumdocu=dinumdocu AND rscorrela=dicorrela AND
  rstipoper='VC' AND rscartera='111'
 AND rscodigo <> 98

 IF @@ERROR<>0
 BEGIN
--       ROLLBACK TRANSACTION
  SELECT 'NO', 'Proceso de Actualización en la cartera disponible VC a fallado.'
  SET NOCOUNT OFF
  RETURN
 END
 /*----------------------------------------------------------------------------------------------*/
 /* Actualización de la Cartera Interbancario                                                    */
 /*----------------------------------------------------------------------------------------------*/
 UPDATE MdCi
 SET civptirci = rsvppresenx  
   , civptirc = rsvppresenx  
   , cicapitalc = rsvalcomp  
   , ciinteresc = rsinteres_acum 
   , cireajustc = rsreajuste_acum 
   , ciintermes = rsintermes  
   , cireajumes = rsreajumes
 FROM MdRs, MdAc
 WHERE rsfecha=acfecproc AND rsrutcart=cirutcart AND rsnumdocu=cinumdocu AND rscorrela=cicorrela AND
  rscartera='121'

 IF @@ERROR<>0
 BEGIN
  SELECT 'NO', 'Proceso de Actualización en la cartera compra con pacto a fallado.'
  SET NOCOUNT OFF
  RETURN
 END

 /*----------------------------------------------------------------------------------------------*/
 /* Actualización de la Cartera Interbancario con el central                                                   */
 /*----------------------------------------------------------------------------------------------*/

 UPDATE MDCI
    SET civptirci = rsvppresenx  
      , civptirc = rsvppresenx  
      , cicapitalc = rsvalcomp  
      , ciinteresc = rsinteres_acum 
      , cireajustc = rsreajuste_acum 
      , ciintermes = rsintermes  
      , cireajumes = rsreajumes
   FROM MDRS, MDAC
  WHERE rsfecha=acfecproc AND rsrutcart=cirutcart AND rsnumdocu=cinumdocu AND rscorrela=cicorrela 
    AND rscartera ='130'

 IF @@ERROR<>0
 BEGIN
   SELECT 'NO', 'Proceso de Actualización en la cartera interbancaria con el Central'
   SET NOCOUNT OFF
   RETURN
 END



 /*----------------------------------------------------------------------------------------------*/
 /* Actualización de los Compras Pactos                                                          */
 /*----------------------------------------------------------------------------------------------*/
 UPDATE MdCi
 SET civptirci = rsvppresenx  ,
  civptirc = rsvppresenx  ,
  cicapitalci = CASE WHEN mnmx = 'C' and rsmonpact <> 13 THEN Round(rsvalinip/citcinicio,mndecimal)
		ELSE rsvalinip END  ,
  ciinteresci = rsinteres_acum ,
  cireajustci = rsreajuste_acum ,
  ciintermes = rsintermes  ,
  cireajumes = rsreajumes
 FROM MdRs, MdAc,View_Moneda
 WHERE rsfecha=acfecproc AND rsrutcart=cirutcart AND rsnumdocu=cinumdocu AND rscorrela=cicorrela AND
  rstipopero='CI' AND rscartera='112' AND rsmonpact = mncodmon

 IF @@ERROR<>0
 BEGIN
--       ROLLBACK TRANSACTION
  SELECT 'NO', 'Proceso de Actualización en la cartera compra con pacto a fallado.'
  SET NOCOUNT OFF
  RETURN
 END
 UPDATE MdVi
 SET viinstser = rsinstcam  ,
  viinteresv   = rsinteres_acum ,
  vireajustv   = rsreajuste_acum ,
  vivptirv     = rsvppresenx  ,
  vivpvent     = rsvalcomp  ,
  vivptirc = rsvppresenx  ,
  viintermesv  = rsintermes  ,
  vireajumesv  = rsreajumes  ,
  vifecucup    = rsfecucup  ,
  vifecpcup    = rsfecpcup  ,
  porcentaje_valor_par_compra_original = rsvpcomp  ,
  vidurat      = rsdurat  ,
  vidurmod     = rsdurmod  ,
  viconvex     = rsconvex
 FROM MdRs, MdAc
 WHERE rsfecha=acfecproc AND rsrutcart=virutcart AND rsnumdocu=vinumdocu AND rscorrela=vicorrela AND
  rsnumoper=vinumoper AND rstipoper='DEV' AND rscartera='114'

 IF @@ERROR<>0
 BEGIN
--       ROLLBACK TRANSACTION
  SELECT 'NO', 'Proceso de Actualización en la cartera venta con pacto a fallado.'
  SET NOCOUNT OFF
  RETURN
 END
 UPDATE MdVi
 SET viintermesvi = rsintermes  ,
  vireajumesvi = rsreajumes  ,
  vicapitalvi = CASE WHEN mnmx = 'C' and rsmonpact <> 13 THEN Round(rsvalinip/vitcinicio,mndecimal)
		ELSE rsvalinip END ,-- VGS rsvalinip  ,
  viinteresvi = rsinteres_acum ,
  vireajustvi = rsreajuste_acum ,
  vivptirvi = rsvppresenx
 FROM MdRs, MdAc,view_moneda
 WHERE rsfecha=acfecproc AND rsrutcart=virutcart AND rsnumdocu=vinumdocu AND rscorrela=vicorrela AND
  rsnumoper=vinumoper AND rstipoper='DEV' AND rscartera='115' AND rsmonpact = mncodmon
 IF @@ERROR<>0
 BEGIN
--       ROLLBACK TRANSACTION
  SELECT 'NO', 'Proceso de Actualización en la cartera venta con pacto a fallado.'
  SET NOCOUNT OFF
 RETURN
 END

 UPDATE MdVi
 SET viinstser                         = rsinstser       ,
  vicapitalv                           = rsvalcomp   ,
  vivalcomu                            = rsvalcomu       ,
  vivalcomp                    = rsvalcomp       ,
  viinteresv                = rsinteres_acum  ,
  vireajustv     = rsreajuste_acum ,
  vivptirv                             = rsvppresenx     ,
  vivpvent                             = rsvalcomp       ,
  vivptirc                             = rsvppresenx     ,
  viintermesv                          = rsintermes      ,
  vireajumesv                          = rsreajumes      ,
  vifecucup                            = rsfecucup       ,
  vifecpcup                            = rsfecpcup       ,
  porcentaje_valor_par_compra_original = rsvpcomp
 FROM MdRs, MdAc
 WHERE rsfecha=acfecproc AND rsrutcart=virutcart AND rsnumdocu=vinumdocu AND rscorrela=vicorrela AND
  rsnumoper=vinumoper AND rstipoper='VC' AND rscartera='114'

 IF @@ERROR<>0
 BEGIN
--      ROLLBACK TRANSACTION
  SELECT 'NO', 'Proceso de Actualización en la cartera venta con pacto a fallado.'
  SET NOCOUNT OFF
  RETURN
 END


 SELECT 'SI','Proceso terminado con exito.'
 RETURN

END

GO
