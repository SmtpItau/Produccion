USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAOPERACION]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BUSCAOPERACION]
   (   @nnumoper      NUMERIC(10,0)
   ,   @Cat_CartFin   CHAR(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @ctipoper CHAR(03)
   DECLARE @clcgp	 CHAR(01)	--20190117.rch.lcgp

   IF EXISTS(SELECT monumoper FROM MDMO WHERE monumoper = @nnumoper AND mostatreg <> 'A' AND (moinstser = 'ICAP' or moinstser = 'ICOL'))
   BEGIN
      SET NOCOUNT OFF
      SELECT 'NO', 'número de operación corresponde a una operación de interbancario' 
      RETURN
   END

   IF EXISTS(SELECT monumoper FROM MDMO WHERE monumoper = @nnumoper AND (motipoper = 'RC' OR motipoper = 'RV'))
   BEGIN
      SET NOCOUNT OFF
      SELECT 'NO', 'número de operación corresponde a una operación de vencimiento de pacto'
      RETURN
   END

   IF EXISTS(SELECT monumoper FROM MDMO WHERE monumoper = @nnumoper AND motipoper = 'IC')
   BEGIN
      SET NOCOUNT OFF
      SELECT 'NO','OPERACIóN CORRESPONDE A UNA CAPTACIóN'
      RETURN
   END

   IF EXISTS(SELECT operacion FROM GEN_OPERACIONES WHERE operacion = @nnumoper AND cerrada = 'S' AND id_sistema = 'BTR')
   BEGIN
      SET NOCOUNT OFF
      SELECT 'NO','OPERACIóN YA ESTA CERRADA. NO PUEDE ANULAR'
      RETURN
   END

   IF EXISTS(SELECT monumoper FROM MDMO WHERE monumoper = @nnumoper AND mostatreg <> 'A')
   BEGIN
      SELECT @ctipoper		=	motipoper
			,@clcgp			=	ISNULL((SELECT TOP 1 1 FROM LCGP_VI WHERE LCGP_OPERACION=monumoper),0)	--20190117.rch.lcgp
      FROM   MDMO
      WHERE  monumoper = @nnumoper 
      AND    mostatreg <> 'A'

      SELECT 'nooperacion'       = @nnumoper     ,-- 1
             'tipo_operacion'    = CASE WHEN motipoper = 'CI'  THEN 'COMPRAS CON PACTO'
                                        WHEN motipoper = 'CP'  THEN 'COMPRAS DEFINITIVAS'
                                        WHEN motipoper = 'VP'  THEN 'VENTAS DEFINITIVAS'
                                        WHEN motipoper = 'ST'  THEN 'SORTEO DE LETRAS'
                                        WHEN motipoper = 'RVA' THEN 'REVENTA ANTCICIPADA'
                                        WHEN motipoper = 'RCA' THEN 'RECOMPRA ANTICIPADA'
                                        WHEN motipoper = 'VI' AND @clcgp='1'  THEN 'VENTAS CON PACTO / LCGP' 	--20190117.rch.lcgp
										ELSE 'VENTAS CON PACTO'													--20190117.rch.lcgp
                                   END      ,-- 2
            'rut_cartera'        = CONVERT(CHAR(9),morutcart),-- 3
            'dig_cartera'        = rcdv,-- 4
            'nom_cartera'        = rcnombre,-- 5
            'tip_cartera'        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_CartFin AND tbcodigo1 = motipcart),''),
            'rut_cliente'        = CONVERT(CHAR(9),morutcli),-- 7
            'cod_cliente'        = clcodigo,-- 8
            'nom_cliente'        = clnombre,-- 9
            'serie'              = moinstser,--10
            'emisor'             = ISNULL(emgeneric,''),--11
            'moneda'             = mnnemo,--12
            'nominal'            = monominal,--13
            'tir'                = motir,--14
            'pvpar'              = mopvp,--15
            'valor_presente'     = movpresen,--16
            'tip_oper'           = motipoper,--17
            'rut_emisor'         = ISNULL(emrut,0),--18
            'fp_vcto'            = ISNULL(moforpagv,0),--19
            'fp_inic'            = moforpagi,--20
            'valor_vta'          = movalven,--21
            'fecha_vitm'         = CONVERT(CHAR(10),mofecven,103),--22 
            'series'             = inserie,
            'duration'           = CONVERT(FLOAT,0),
            'codmoneda'          = momonemi,
            'correla'            = mocorrela,
            'docu'               = monumdocu,
            'pfe'                = momtopfe,
            'cce'                = momtocce,
            'fecha_vp'           = CONVERT(CHAR(10),mofecvenp,103),
            'NumDocu'            = monumdocu,
            'Correlativo'        = mocorrela
            INTO    #TEMP
            FROM    MDMO
                    INNER JOIN  VIEW_CLIENTE     ON morutcli = clrut AND mocodcli = clcodigo
                    LEFT  JOIN  VIEW_EMISOR      ON morutemi = emrut 
                    INNER JOIN  VIEW_MONEDA      ON momonemi = mncodmon
                    INNER JOIN  VIEW_INSTRUMENTO ON incodigo = mocodigo
                    INNER JOIN  VIEW_ENTIDAD     ON rcrut    = morutcart
           WHERE    motipoper  IN('CI','VI','CP','VP','RVA','RCA') 
           AND      mostatreg  <> 'A' 
           AND      monumoper  =  @nnumoper 

      IF @ctipoper ='CI' 
      BEGIN
         UPDATE #TEMP SET duration = cidurmod FROM MDCI WHERE cinumdocu = nooperacion AND cicorrela = correla
      END
      IF @ctipoper ='VI' 
      BEGIN   
         UPDATE #TEMP SET duration = vidurmod FROM MDVI WHERE vinumoper = nooperacion AND vicorrela = correla AND vinumdocu = docu
      END
      SELECT * FROM #TEMP
   END ELSE
   BEGIN
      IF EXISTS(SELECT monumoper FROM mdmopm WHERE monumoper = @nnumoper AND mostatreg <> 'A')
      BEGIN
         DECLARE @dFechaProceso     DATETIME
         DECLARE @dFechaPagoMañana  DATETIME
             SET @dFechaProceso   = (SELECT acfecproc FROM MDAC)

          SELECT @ctipoper           = motipoper 
             ,   @dFechaPagoMañana   = Fecha_PagoMañana
            FROM MDMOPM 
           WHERE monumoper = @nnumoper AND mostatreg <> 'A'

            IF @dFechaPagoMañana < @dFechaProceso
            BEGIN
               SET NOCOUNT OFF
               SELECT 'NO', 'Operacion no se puede Anular. (Fecha Pago Mañana)'
               RETURN
            END


         SELECT 'nooperacion'       = @nnumoper     ,-- 1
                'tipo_operacion'    = case WHEN motipoper = 'CI'  THEN 'COMPRAS CON PACTO'
                                           WHEN motipoper = 'CP'  THEN 'COMPRAS DEFINITIVAS'
                                           WHEN motipoper = 'VP'  THEN 'VENTAS DEFINITIVAS'
                                           WHEN motipoper = 'ST'  THEN 'SORTEO DE LETRAS'
                                           WHEN motipoper = 'RVA' THEN 'REVENTA ANTCICIPADA'
                                           WHEN motipoper = 'RCA' THEN 'RECOMPRA ANTICIPADA'
                                           ELSE                        'VENTAS CON PACTO'
                                      END      ,-- 2
               'rut_cartera'        = CONVERT(CHAR(9),morutcart),-- 3
               'dig_cartera'        = rcdv,-- 4
               'nom_cartera'        = rcnombre,-- 5
               'tip_cartera'        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_CartFin AND tbcodigo1 = motipcart),''),
               'rut_cliente'        = CONVERT(CHAR(9),morutcli),-- 7
               'cod_cliente'        = clcodigo,-- 8
               'nom_cliente'        = clnombre,-- 9
               'serie'              = moinstser,--10
               'emisor'             = ISNULL(emgeneric,''),--11
               'moneda'             = mnnemo,--12
               'nominal'            = monominal,--13
               'tir'                = motir,--14
               'pvpar'              = mopvp,--15
               'valor_presente'     = movpresen,--16
               'tip_oper'           = motipoper,--17
               'rut_emisor'         = ISNULL(emrut,0),--18
               'fp_vcto'            = ISNULL(moforpagv,0),--19
               'fp_inic'            = moforpagi,--20
               'valor_vta'          = movalven,--21
               'fecha_vitm'         = CONVERT(CHAR(10),mofecven,103),--22 
               'series'             = inserie,
               'duration'           = CONVERT(FLOAT,0),
               'codmoneda'          = momonemi,
               'correla'            = mocorrela,
               'docu'               = monumdocu,
               'pfe'                = momtopfe,
               'cce'                = momtocce,
               'fecha_vp'           = CONVERT(CHAR(10),mofecvenp,103),
               'NumDocu'            = monumdocu,
               'Correlativo'        = mocorrela
               INTO #TEMP2
               FROM MDMOPM
                    INNER JOIN VIEW_CLIENTE       ON morutcli = clrut AND mocodcli = clcodigo
                    LEFT  JOIN VIEW_EMISOR        ON morutemi = emrut 
                    INNER JOIN VIEW_MONEDA        ON momonemi = mncodmon
                    INNER JOIN VIEW_INSTRUMENTO   ON incodigo = mocodigo
                    INNER JOIN VIEW_ENTIDAD       ON rcrut    = morutcart
       WHERE motipoper  IN('CI','VI','CP','VP','RVA','RCA') 
              AND   mostatreg  <> 'A' 
              AND   monumoper   = @nnumoper 
   
         SELECT * FROM #TEMP2 #TEMP
      END ELSE
      BEGIN
         SELECT 'NO', 'NUMERO DE OPERACION ' + RTRIM(CONVERT(CHAR(10),@nnumoper))+' NO EXISTE'
      END
   END

END

GO
