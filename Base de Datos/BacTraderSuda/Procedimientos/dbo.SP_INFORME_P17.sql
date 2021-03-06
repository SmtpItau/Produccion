USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_P17]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_P17]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecha          DATETIME
   DECLARE @dFechaProx      DATETIME
   DECLARE @dFechaFinMes    DATETIME
   DECLARE @nValComp        NUMERIC(19,0)
   DECLARE @nReajuste       NUMERIC(19,0)
   DECLARE @nInteres        NUMERIC(19,0)
   DECLARE @nValPres        NUMERIC(19,0)
   DECLARE @nAjuste         NUMERIC(19,0)
   DECLARE @nValPres2       NUMERIC(19,0)
   DECLARE @nAjuste2        NUMERIC(19,0)
   DECLARE @cSw             CHAR(01)

   /*****************************************************************************************/
   /*****************************************************************************************/
   CREATE TABLE #Informe_P17
          (
           PARTIDA          CHAR(4),
           CODIGO           CHAR(5),
           GLOSA            VARCHAR(80),
           MONEDA           NUMERIC(3),
           CAPITAL          NUMERIC(19,4) DEFAULT 0,
           REAJUSTE         NUMERIC(19,4),
           INTERES          NUMERIC(19,4),
           TOT_CONTABLE     NUMERIC(19,4),
           AJUSTE           NUMERIC(19,4),
           TOTAL            NUMERIC(19,4),
           CARTERA          NUMERIC(1),
           LINEA            NUMERIC (2),
           ORDEN            NUMERIC (2)
          )

   /*****************************************************************************************/
   /*****************************************************************************************/
   INSERT INTO #Informe_P17 VALUES(' ',' ','SISTEMA NO FINANCIERO',0,0,0,0,0,0,0,0,1,1) 
   INSERT INTO #Informe_P17 VALUES(' ',' ','SECTOR PUBLICO',0,0,0,0,0,0,0,0,2,2) 
   INSERT INTO #Informe_P17 VALUES(' ',' ','Doc.Emit.x.Sector Publico con Mercado Secundario',0,0,0,0,0,0,0,0,3,3) 
   INSERT INTO #Informe_P17 VALUES('1710','11101','Pag.Desc. de Tesoreria PDT',0,0,0,0,0,0,0,2,4,4) 
   INSERT INTO #Informe_P17 VALUES('1710','11102','Pag.Reaj. de Tesoreria PRT',0,0,0,0,0,0,0,2,5,5)    
   INSERT INTO #Informe_P17 VALUES('1710','11109','Bonos Breco (Trading)'  ,995,0,0,0,0,0,0,2,6,6)
   INSERT INTO #Informe_P17 VALUES('1710','11109','Bonos Breco (Permanente)',995,0,0,0,0,0,0,1,7,7)
   INSERT INTO #Informe_P17 VALUES('1710','30001','Gobierno y Organismos Gubernament. 1710680177-1710880170'  ,0,0,0,0,0,0,0,2,85,8)
   INSERT INTO #Informe_P17 VALUES('1735','11111','Letras de Crédito'  ,0,0,0,0,0,0,0,2,8,9)
   INSERT INTO #Informe_P17 VALUES(' '   ,'11112','Pag.Conv.Deuda Externa'  ,0,0,0,0,0,0,0,2,9,10)
   INSERT INTO #Informe_P17 VALUES(' '   ,'11199','Otros'  ,0,0,0,0,0,0,0,2,10,11)
   INSERT INTO #Informe_P17 VALUES(' ',' ','Doc.Emit.x.Sector Publico sin Mercado Secundario',0,0,0,0,0,0,0,0,11,12)
   INSERT INTO #Informe_P17 VALUES('1710','11201','Pag.Tesoreria DFL 15'  ,998,0,0,0,0,0,0,2,12,13)
   INSERT INTO #Informe_P17 VALUES(' ','11202','Otros Doc de Tesoreria'  ,0,0,0,0,0,0,0,2,13,14)
   INSERT INTO #Informe_P17 VALUES(' ','11210','Tit.Deuda Externa Emit.por el Fisco'  ,0,0,0,0,0,0,0,2,14,15)
   INSERT INTO #Informe_P17 VALUES(' ','11211','Tit.Deuda Externa Emit.por otras entidades',0,0,0,0,0,0,0,2,15,16)
   INSERT INTO #Informe_P17 VALUES(' ','11299','Otros' ,0,0,0,0,0,0,0,2,16,17)
   INSERT INTO #Informe_P17 VALUES(' ',' ','SECTOR PRIVADO'  ,0,0,0,0,0,0,0,0,17,18)
   INSERT INTO #Informe_P17 VALUES('1735','12001','Bonos Empresas y Debentures (Trading)',998,0,0,0,0,0,0,2,18,19)
   INSERT INTO #Informe_P17 VALUES('1735','12001','Bonos Empresas y Debentures (Permanente)',998,0,0,0,0,0,0,1,19,20)
   INSERT INTO #Informe_P17 VALUES('1735','12001','Bonos Empresas Reaj.T/C',994,0,0,0,0,0,0,1,20,21)
   INSERT INTO #Informe_P17 VALUES('1735','12001','Otros Bonos Empresas M/X 1735582077 (Trading) ',13,0,0,0,0,0,0,2,21,22)
   INSERT INTO #Informe_P17 VALUES('1735','12001','Otros Bonos Empresas M/X 1735582077 (Permanente)',13,0,0,0,0,0,0,1,22,23)
   INSERT INTO #Informe_P17 VALUES('1735','12099','Otros ',999,0,0,0,0,0,0,0,23,24)
   INSERT INTO #Informe_P17 VALUES(' ',' ','SISTEMA FINANCIERO',0,0,0,0,0,0,0,0,24,25)
   INSERT INTO #Informe_P17 VALUES(' ',' ','SECTOR PUBLICO',0,0,0,0,0,0,0,0,25,26)
   INSERT INTO #Informe_P17 VALUES(' ',' ','Doc.Emit.por el BCCH con el Mercado Secundario',0,0,0,0,0,0,0,0,26,27)
   INSERT INTO #Informe_P17 VALUES('1705','21101','Pagarés Descontables PDBC(Inv)',999,0,0,0,0,0,0,2,27,28)
   INSERT INTO #Informe_P17 VALUES('1740','21101','Pagarés Descontables PDBC(Inter)',999,0,0,0,0,0,0,2,28,29)
   INSERT INTO #Informe_P17 VALUES('1705','21102','Pagarés Reajustables PRBC(Inv)',998,0,0,0,0,0,0,2,29,30)
   INSERT INTO #Informe_P17 VALUES('1740','21102','Pagarés Reajustables PRBC(Inter)',998,0,0,0,0,0,0,2,30,31)

   INSERT INTO #Informe_P17 VALUES('1705','21106','Bonos BCCH en UF         (Inv)',999,0,0,0,0,0,0,2,86,32)
   INSERT INTO #Informe_P17 VALUES('1740','21106','Bonos BCCH en UF         (Inter)',999,0,0,0,0,0,0,2,87,33)
   INSERT INTO #Informe_P17 VALUES('1705','21105','Bonos BCCH en Pesos      (Inv)',999,0,0,0,0,0,0,2,88,34)
   INSERT INTO #Informe_P17 VALUES('1740','21105','Bonos BCCH en Pesos      (Inter)',999,0,0,0,0,0,0,2,89,35)
   INSERT INTO #Informe_P17 VALUES('1705','21107','Bonos BCCH en Observado  (Inv)',999,0,0,0,0,0,0,2,90,36)
   INSERT INTO #Informe_P17 VALUES('1740','21107','Bonos BCCH en Observado  (Inter)',999,0,0,0,0,0,0,2,91,37)

   INSERT INTO #Informe_P17 VALUES(' ',' ','Pagarés en Dólares de los EEUU ',0,0,0,0,0,0,0,2,31,38)
   INSERT INTO #Informe_P17 VALUES('1705','21123','Cupon Cero Reaj UF(Inv)',998,0,0,0,0,0,0,2,32,39)
   INSERT INTO #Informe_P17 VALUES('1740','21123','Cupon Cero Reaj UF(Inter)',998,0,0,0,0,0,0,2,33,40)
   INSERT INTO #Informe_P17 VALUES(' ','21124','Cupon Cero Reaj T/C',994,0,0,0,0,0,0,2,34,41)
   INSERT INTO #Informe_P17 VALUES(' ','21124','Cupon Cero Reaj T/C',994,0,0,0,0,0,0,0,35,42)
   INSERT INTO #Informe_P17 VALUES('1705','21110','PRC PERMANENTE',998,0,0,0,0,0,0,1,36,43)
   INSERT INTO #Informe_P17 VALUES('1740','21110','PRC INTERMEDIADO',998,0,0,0,0,0,0,1,37,44)
   INSERT INTO #Informe_P17 VALUES('1705','21110','Pagarés Reaj. con Cupones PRC(Inv)',998,0,0,0,0,0,0,2,38,45)
   INSERT INTO #Informe_P17 VALUES('1740','21110','PRC Intermediado',998,0,0,0,0,0,0,2,39,46)
   INSERT INTO #Informe_P17 VALUES(' ','21111','Cert. Dep. Exp. US$ AC. 163-05-910110',0,0,0,0,0,0,0,2,40,47)
   INSERT INTO #Informe_P17 VALUES(' ','21120','Pag. Conv. Dda. Ext. Expresado en US$',0,0,0,0,0,0,0,2,41,48)
   INSERT INTO #Informe_P17 VALUES(' ','21121','Pag. Conv. Dda. Ext. Expresado en UF',0,0,0,0,0,0,0,2,42,49)
   INSERT INTO #Informe_P17 VALUES('1705 ','21122','PRD',994,0,0,0,0,0,0,1,43,50)
   INSERT INTO #Informe_P17 VALUES(' ','21199','Otros',0,0,0,0,0,0,0,2,44,51)
   INSERT INTO #Informe_P17 VALUES(' ',' ','Doc. Emit. por el BCCH sin Mercado Secundario',0,0,0,0,0,0,0,0,45,52)
   INSERT INTO #Informe_P17 VALUES(' ','21201','Pag. Reprog. Deudas Ac 1507 y 1578 Obt. BBCH',0,0,0,0,0,0,0,2,46,53)
   INSERT INTO #Informe_P17 VALUES(' ','21202','Pag. Reprog. Deudas Ac 1507 y 1578 Obt. 3os.',0,0,0,0,0,0,0,2,47,54)
   INSERT INTO #Informe_P17 VALUES(' ','21203','Cert. Dep. en Dólares EEUU Ac. 1649',0,0,0,0,0,0,0,2,48,55)
   INSERT INTO #Informe_P17 VALUES(' ','21204','Pagarés Acdo. 1836',0,0,0,0,0,0,0,2,49,56)
   INSERT INTO #Informe_P17 VALUES(' ','21206','Pagarés Acdo. 1691',0,0,0,0,0,0,0,2,50,57)  
   INSERT INTO #Informe_P17 VALUES(' ','21298','Pagarés Cap. XVIII (Cupos)',0,0,0,0,0,0,0,2,51,58)  
   INSERT INTO #Informe_P17 VALUES(' ','21298','Otros Inst. Transables sólo entre II.FF.',0,0,0,0,0,0,0,2,52,59)
   INSERT INTO #Informe_P17 VALUES(' ','21299','Otros Inst. Intransferibles',0,0,0,0,0,0,0,2,53,60)  
   INSERT INTO #Informe_P17 VALUES(' ',' ','Título de la Deuda Externa Emitidos por el BCCH',0,0,0,0,0,0,0,0,54,61)  
   INSERT INTO #Informe_P17 VALUES(' ','21301','Pagarés Conversión Deuda Externa',0,0,0,0,0,0,0,2,55,62)  
   INSERT INTO #Informe_P17 VALUES(' ',' ','Doc. Emit. por el Banco del Estado',0,0,0,0,0,0,0,0,56,63)  
   INSERT INTO #Informe_P17 VALUES('1725','21401','Letras de Crédito (Banco del Estado) (Trading)',998,0,0,0,0,0,0,2,57,64)
   INSERT INTO #Informe_P17 VALUES('1725','21401','Letras de Crédito (Banco del Estado) (Permanente)',998,0,0,0,0,0,0,1,58,65)
   INSERT INTO #Informe_P17 VALUES(' ','21402','Bonos',0,0,0,0,0,0,0,2,59,66)
   INSERT INTO #Informe_P17 VALUES(' ','21403','Tit. Deuda Ext. Emit. Bco. del Estado',0,0,0,0,0,0,0,2,60,67)
   INSERT INTO #Informe_P17 VALUES('1725','21498','Otras Inv. Finac. con Merc. Secundario',0,0,0,0,0,0,0,2,61,68)
   INSERT INTO #Informe_P17 VALUES(' ','21499','Otras Inv. Finac. sin Merc. Secundario',0,0,0,0,0,0,0,2,62,69)
   INSERT INTO #Informe_P17 VALUES(' ',' ','SECTOR PRIVADO',0,0,0,0,0,0,0,0,63,70)
   INSERT INTO #Informe_P17 VALUES(' ',' ','Doc. Emit. por Bancos y Financieras',0,0,0,0,0,0,0,0,64,71)
   INSERT INTO #Informe_P17 VALUES('1735','22101','LHR Propia Emisión Fg. + Viv. (Trading)',998,0,0,0,0,0,0,2,65,72)
   INSERT INTO #Informe_P17 VALUES('1735','22101','LHR Propia Emisión Fg. + Viv. (Permanente)',998,0,0,0,0,0,0,1,66,73)
   INSERT INTO #Informe_P17 VALUES('1735','22101','LHR Propia Emisión IVP (Trading)',997,0,0,0,0,0,0,2,67,74)
   INSERT INTO #Informe_P17 VALUES('1735','22101','LHR Propia Emisión IVP (Permanente)',997,0,0,0,0,0,0,1,68,75)
   INSERT INTO #Informe_P17 VALUES(' ','22102','Bonos de Propia Emisión',0,0,0,0,0,0,0,2,69,76)
   INSERT INTO #Informe_P17 VALUES('1725','22103','Letras de Crédito Emit. por Terceros (Trading)',998,0,0,0,0,0,0,2,70,77)
   INSERT INTO #Informe_P17 VALUES('1725','22103','Letras de Crédito Emit. por Terceros (Permanente)',998,0,0,0,0,0,0,1,71,78)
   INSERT INTO #Informe_P17 VALUES('1725','22104','Bonos Emit. por Terceros ',998,0,0,0,0,0,0,2,72,79)
   INSERT INTO #Informe_P17 VALUES(' ','22105','Pag. Sustitución Deuda Externa',0,0,0,0,0,0,0,2,73,80)
   INSERT INTO #Informe_P17 VALUES(' ','22110','Tít. Deuda Extrena',0,0,0,0,0,0,0,2,74,81)
   INSERT INTO #Informe_P17 VALUES('1725','22198','Otros Inst. con Mercado Secundario (DPF)',999,0,0,0,0,0,0,2,75,82)
   INSERT INTO #Informe_P17 VALUES('1725','22198','Otros Inst. con Mercado Secundario',998,0,0,0,0,0,0,2,76,83)
   INSERT INTO #Informe_P17 VALUES('1725','22198','Otros Inst. con Mercado Secundario',994,0,0,0,0,0,0,2,77,84)
   INSERT INTO #Informe_P17 VALUES('1725','22199','Otros Inst. sin Mercado Secundario',0,0,0,0,0,0,0,2,78,85)
   INSERT INTO #Informe_P17 VALUES(' ',' ','Total Doc. Emit. Otras Entidades',0,0,0,0,0,0,0,0,79,86)
   INSERT INTO #Informe_P17 VALUES(' ',' ','SECTOR EXTERNO',0,0,0,0,0,0,0,0,80,87)
   INSERT INTO #Informe_P17 VALUES('1730','30001','Gobierno y Organismos Gubernament. (Trading)',13,0,0,0,0,0,0,2,81,88)
   INSERT INTO #Informe_P17 VALUES('1730','30001','Gobierno y Organismos Gubernament. (1730582079)',13,0,0,0,0,0,0,1,82,89)
   INSERT INTO #Informe_P17 VALUES('1730','30002','Bancos del Exterior (DPX) Capital * T/C',13,0,0,0,0,0,0,2,83,90)
   INSERT INTO #Informe_P17 VALUES('1735','30099','Otros Agentes Económicos',13,0,0,0,0,0,0,1,84,91)

   /*****************************************************************************************/
   /*****************************************************************************************/
   SELECT @dFecha = acfecproc, @dFechaProx = acfecprox, @cSw = acsw_fd FROM mdac

   IF DATEPART(MONTH,@dFecha) <>  DATEPART(MONTH,@dFechaProx)
   BEGIN

      SELECT @dFechaFinMes = @dFecha

      EXECUTE sp_check_cierre_de_mes @dFechaFinMes OUTPUT

   END
   ELSE
   BEGIN

      SELECT @dFechaFinMes = DATEADD(DAY, DATEPART(DAY,@dFecha) * (-1) , @dFecha)

   END

-- OJO
--   SELECT @dFechaFinMes = ACFECPROX FROM MDAC

   /*****************************************************************************************/
   /* Cartera                                                                               */
   /*****************************************************************************************/
   /*****************************************************************************************/
   /*****************************************************************************************/
   SELECT  TOP 1      rsnumdocu,
                      rscorrela,
                      rscodigo,
                      inserie,
                      rscartera,
                      rsmonemi,
                      codigo_carterasuper,
                      rsrutemis,
                      rstipoletra,
                      'rsvalcomp' = CASE WHEN rscartera = '111' THEN rsvalcomp
					 WHEN rscartera = '114' THEN rsvalcomp
    			   		                        ELSE 0
                                    END,
                      rsreajuste_acum,
                      rsreajuste,
                      rsinteres_acum,
                      rsinteres,
                      rstipoper,
                      rsrutcli,
                      'Mascara' = rsmascara
             INTO     #mdrs_informe_p17
             FROM     mdrs, view_instrumento
             WHERE    incodigo            = rscodigo      AND
                      rsfecha             = @dFechaFinMes AND
                      (rscartera          = '111'          OR
                      rscartera           = '114')	  AND
                      rstipoper           = 'DEV'
             ORDER BY rscodigo,
                      inserie,
                      rscartera,
                      rsmonemi,
                      codigo_carterasuper,
                      rsrutemis,
                      rstipoletra

   DELETE #mdrs_informe_p17

   IF @dFechaFinMes = @dFecha BEGIN
      INSERT INTO #mdrs_informe_p17
      SELECT             cpnumdocu,
                         cpcorrela,
                         cpcodigo,
                         inserie,
                         '111',
                         0,
                         codigo_carterasuper,
                         0,
                         cptipoletra,
                         'rsvalcomp' = CPvalcomp,
                         cpreajustc,
	   	         cpreajustc,
                         cpinteresc,
                         cpinteresc,
                         'CP',
                         cprutcli,
                         cpmascara
                FROM     mdcp, view_instrumento
                WHERE    cpcodigo  = incodigo

      INSERT INTO #mdrs_informe_p17
      SELECT             vinumdocu,
                         vicorrela,
                         vicodigo,
                         inserie,
                         '114',
                         0,
                         codigo_carterasuper,
                         0,
                         ' ',
                         'rsvalcomp' = vivalcomp,
                         vireajustv,
	   	         vireajustv,
                         viinteresv,
                         viinteresv,
                         'VI',
                         virutcli,
                         vimascara
                FROM     mdvi, view_instrumento
                WHERE    vicodigo            = incodigo

      UPDATE #mdrs_informe_p17
             SET   rsmonemi  = nsmonemi,
                   rsrutemis = nsrutemi
             FROM  view_noserie, view_instrumento
             WHERE rscodigo  = incodigo    AND
                   inmdse    = 'N'         AND
                   rsnumdocu = nsnumdocu   AND
                   rscorrela = nscorrela

      UPDATE #mdrs_informe_p17
             SET   rsmonemi  = semonemi,
                   rsrutemis = serutemi
             FROM  view_serie, view_instrumento
             WHERE rscodigo  = incodigo    AND
                   inmdse    = 'S'         AND
                   Mascara   = semascara
   
   END ELSE BEGIN
      INSERT INTO #mdrs_informe_p17
      SELECT             rsnumdocu,
                         rscorrela,
                         rscodigo,
                         inserie,
                         rscartera,
                         rsmonemi,
                         codigo_carterasuper,
                         rsrutemis,
                         rstipoletra,
                         'rsvalcomp' = CASE WHEN rscartera = '111' THEN rsvalcomp
                                            WHEN rscartera = '114' THEN rsvalcomp
       			   		                        ELSE 0
                                       END,
                         rsreajuste_acum,
	   	         rsreajuste,
			 rsinteres_acum,
                         rsinteres,
                         rstipoper,
                         rsrutcli,
                         rsmascara
                FROM     mdrs, view_instrumento
                WHERE    incodigo            = rscodigo      AND
                         rsfecha             = @dFechaFinMes AND
                         (rscartera          = '111'          OR
                         rscartera           = '114')	  AND
		         rstipoper           = 'DEV'
                ORDER BY rscodigo,
                         inserie,
                         rscartera,
                         rsmonemi,
                         codigo_carterasuper,
                         rsrutemis,
                         rstipoletra

   END

   /*****************************************************************************************/
   /* BR                                                                                    */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 06                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscodigo            = 888

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  6

   /*****************************************************************************************/
   /* BR                                                                                    */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 07                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscodigo            = 888

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  7


   /*****************************************************************************************/
   /* BONOS (UF)                                                                            */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Traiding                                                                              */
   /* Línea Nro. 18                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres)
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
    rsmonemi            = 998         AND
                rscodigo            = 15

UPDATE       #Informe_P17
   SET  CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  18

   /*****************************************************************************************/
   /* BONOS (UF)                                                                            */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 19                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres)
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rsmonemi            = 998         AND
                rscodigo            = 15

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  19

   /*****************************************************************************************/
   /* BONOS (USD)                                                                           */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 20                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres)
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rsmonemi            = 994         AND
                rscodigo            = 15

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  20

   /*****************************************************************************************/
   /* BONOS (USD)                                                                           */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 21                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rsmonemi            = 13          AND
                rscodigo            = 15

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  21

   /*****************************************************************************************/
   /* BONOS (USD)           */
   /* Compras Propias y Ventas con Pacto                            */
   /* Permanente                                          */
   /* Línea Nro. 22                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
   FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rsmonemi            = 13          AND
                rscodigo            = 15

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  22

   /*****************************************************************************************/
   /* FMUTUOS                                                                               */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 23                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscodigo            = 98

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  23

   /*****************************************************************************************/
   /* PDBC                                                                                  */
   /* Compras Propias                                                                       */
   /* Línea Nro. 27                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '111'       AND
                rscodigo            = 6

   SELECT       @nValComp  = @nValComp  + ISNULL( SUM( rsvalcomp ), 0.0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0.0 ), -- - rsreajuste),
                @nInteres  = @nInteres  + ISNULL( SUM( rsinteres_acum ), 0.0 ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 6           AND
                rsrutcli   = 97029000

/*select sum(rsvalcomp),SUM(rsreajuste_acum),SUM(rsinteres_acum) 
       from mdrs WHERE rsfecha = '20020331' and rscartera = '111' and rscodigo = 6 and rsrutcli = 97029000
*/
   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  27

   /*****************************************************************************************/
   /* PDBC                                                                                  */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 28                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
            @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 6           AND
                rsrutcli  <> 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  28

   /*****************************************************************************************/
   /* PRBC                                                                                  */
   /* Compras Propias                                                                       */
   /* Línea Nro. 29                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '111'       AND
                rscodigo            = 7

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  29

   /*****************************************************************************************/
  /* PRBC                                                                                  */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 30                    */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '114'       AND
                rscodigo            = 7

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  30

   /*****************************************************************************************/
   /* CERO                                                                                  */
   /* Compras Propias                                                                       */
   /* Línea Nro. 32                                                                         */
   /*****************************************************************************************/

   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '111'       AND
                rscodigo            = 300

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  32

   /*****************************************************************************************/
   /* Cero                                                                                  */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 33                                                                         */
   /*****************************************************************************************/

   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '114'       AND
                rscodigo            = 300

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  33

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Compras Propias                                                                       */
   /* Permanente                                                                            */
   /* Línea Nro. 36                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '111'       AND
                rscodigo            = 4

  UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  36

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Ventas con Pacto                                                                   */
   /* Permanente                                                                            */
   /* Línea Nro. 37                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '114'       AND
                rscodigo            = 4

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  37

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Compras Propias                                                                       */
   /* Trading                                                                               */
   /* Línea Nro. 38                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )

          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera  = '111'       AND
                rscodigo            = 4

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  38

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Trading                                                                               */
   /* Línea Nro. 39                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '114'       AND
                rscodigo            = 4

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  39

   /*****************************************************************************************/
   /* PRD                                                                                   */
   /* Compras Propias y Ventas con Pacto                                 */
   /* Línea Nro. 43                      */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste ),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscodigo            = 31

   UPDATE       #Informe_P17
           SET  CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  43

   /*****************************************************************************************/
   /* LCHR (97030000-E-T)                                                                   */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 57                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste ),
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres  )
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '114'       AND
                rscodigo            = 20          AND
                rsrutemis           = 97030000
                
   SELECT       @nValComp  = @nValComp  + ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste 
                @nInteres  = @nInteres  + ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres 
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '111'       AND
                rscodigo            = 20          AND
                rstipoletra         = 'E'

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  57

   /*****************************************************************************************/
   /* LCHR (97030000-E-P)                                                                   */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 58                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres 
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '114'       AND
                rscodigo            = 20          AND
                rsrutemis           = 97030000
                
   SELECT       @nValComp  = @nValComp  + ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = @nInteres  + ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '111'       AND
                rscodigo            = 20          AND
                rstipoletra         = 'E'

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  58

   /*****************************************************************************************/
   /* LCHR (97018000-E-T)                                                                   */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 65                                                                         */
   /*****************************************************************************************/
   SELECT  @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), --  - rsreajuste
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '114'       AND
                rscodigo            = 20          AND
                rsrutemis           = 97018000
                
   SELECT       @nValComp  = @nValComp  + ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = @nInteres  + ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '111'       AND
                rscodigo            = 20          AND
               (rstipoletra         = 'V'          OR
                rstipoletra         = 'F')

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      = 65

   /*****************************************************************************************/
   /* LCHR (97018000-E-P)                                                                   */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 66                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(      rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste 
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '114'       AND
                rscodigo            = 20          AND
                rsrutemis           = 97018000
                
   SELECT       @nValComp  = @nValComp  + ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = @nInteres  + ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '111'       AND
                rscodigo            = 20          AND
               (rstipoletra         = 'V'          OR
                rstipoletra         = 'F')

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      = 66

   /*****************************************************************************************/
   /* LCHR (<>97030000 y 97018000-O-T)                                                      */
   /* Compras Propias y Ventas con Pacto            */
   /* Línea Nro. 70                                    */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '114'       AND
                rscodigo            = 20          AND
               (rsrutemis          <> 97030000    AND
                rsrutemis          <> 97018000)
                
   SELECT       @nValComp  = @nValComp  + ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = @nInteres  + ISNULL( SUM(  rsinteres_acum ), 0 )  -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'T'         AND
                rscartera           = '111'       AND
                rscodigo            = 20          AND
                rstipoletra         = 'O'

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      = 70

   /*****************************************************************************************/
   /* LCHR (<>97030000 y 97018000-O-P)                                                      */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 71                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '114'       AND
                rscodigo            = 20          AND
               (rsrutemis          <> 97030000    AND
                rsrutemis          <> 97018000)
                
   SELECT      @nValComp  = @nValComp  + ISNULL( SUM(      rsvalcomp ), 0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = @nInteres  + ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE codigo_carterasuper = 'P'         AND
                rscartera           = '111'       AND
                rscodigo            = 20          AND
                rstipoletra         = 'O'

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      = 71


   /*****************************************************************************************/
   /* DPF		                                                                   */
   /* Línea Nro. 75                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17
          WHERE rscartera          IN('111','114')AND
                rscodigo            = 9    

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  75


   /*****************************************************************************************/
   /* DPR		                                                                   */
   /* Línea Nro. 76                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ISNULL( SUM(       rsvalcomp ), 0 ),
                @nReajuste = ISNULL( SUM( rsreajuste_acum ), 0 ), -- - rsreajuste 
                @nInteres  = ISNULL( SUM(  rsinteres_acum ), 0 ) -- - rsinteres  
          FROM  #mdrs_informe_p17
          WHERE rscartera          IN('111','114')AND
                rscodigo            = 11

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  76





   /*****************************************************************************************/
   /* DPX                                                                                   */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 83                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = ROUND( SUM(       rsvalcomp * vmvalor ), 0 ),
                @nReajuste = ROUND( SUM( (rsreajuste_acum ) * vmvalor ), 0 ), -- - rsreajuste
                @nInteres  = ROUND( SUM(  (rsinteres_acum) * vmvalor ), 0 ) -- - rsinteres
          FROM  #mdrs_informe_p17, view_valor_moneda
          WHERE (rscodigo  = 50               OR
                 rscodigo  = 51               OR
                 rscodigo  = 52               OR
                 rscodigo  = 54)             AND
                 994       = vmcodigo        AND
                 vmfecha   = @dFechaFinMes

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
         REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  83

   /*****************************************************************************************/
   /* BCU                                                                                   */
   /* Compras Propias                                                                       */
   /* Línea Nro. 86                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '111'       AND
                rscodigo            = 32

   SELECT       @nValComp  = @nValComp  + ISNULL( SUM( rsvalcomp ), 0.0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0.0 ), -- - rsreajuste),
                @nInteres  = @nInteres  + ISNULL( SUM( rsinteres_acum ), 0.0 ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 32          AND
                rsrutcli   = 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  86

   /*****************************************************************************************/
   /* BCU                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 87                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
            @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 32          AND
                rsrutcli  <> 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  87


   /*****************************************************************************************/
   /* BCP                                                                                   */
   /* Compras Propias                                                                       */
   /* Línea Nro. 88                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '111'       AND
                rscodigo            = 33

   SELECT       @nValComp  = @nValComp  + ISNULL( SUM( rsvalcomp ), 0.0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0.0 ), -- - rsreajuste),
                @nInteres  = @nInteres  + ISNULL( SUM( rsinteres_acum ), 0.0 ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 33          AND
                rsrutcli   = 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  88

   /*****************************************************************************************/
   /* BCP                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 89                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
            @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 33          AND
                rsrutcli  <> 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  89

   /*****************************************************************************************/
   /* BCD                                                                                   */
   /* Compras Propias                                                                       */
   /* Línea Nro. 90                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
                @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera           = '111'       AND
                rscodigo            = 34

   SELECT       @nValComp  = @nValComp  + ISNULL( SUM( rsvalcomp ), 0.0 ),
                @nReajuste = @nReajuste + ISNULL( SUM( rsreajuste_acum ), 0.0 ), -- - rsreajuste),
                @nInteres  = @nInteres  + ISNULL( SUM( rsinteres_acum ), 0.0 ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 34          AND
                rsrutcli   = 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  90

   /*****************************************************************************************/
   /* BCU                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 91                                                                         */
   /*****************************************************************************************/
   SELECT       @nValComp  = SUM( rsvalcomp ),
	        @nReajuste = SUM( rsreajuste_acum ), -- - rsreajuste),
                @nInteres  = SUM( rsinteres_acum ) -- - rsinteres )
          FROM  #mdrs_informe_p17
          WHERE rscartera  = '114'       AND
                rscodigo   = 34          AND
                rsrutcli  <> 97029000

   UPDATE       #Informe_P17
          SET   CAPITAL    = ISNULL(  @nValComp, 0 ),
                REAJUSTE   = ISNULL( @nReajuste, 0 ),
                INTERES    = ISNULL(  @nInteres, 0 )
          WHERE Linea      =  91

   /*****************************************************************************************/
   /* Tasa Mercado                                                                          */
   /*****************************************************************************************/
   SELECT       rmcodigo,
                tipo_operacion,
                codigo_carterasuper,
                moneda_emision,
                rut_emisor,
                valor_presente,
                diferencia_mercado,
                rmrutcart,
                rmnumdocu,
                rmcorrela,
                rmnumoper
          INTO  #tmp_tasa_mercado
          FROM  Valorizacion_Mercado
          WHERE fecha_valorizacion = @dFechaFinMes

   /*****************************************************************************************/
   /* BR                                                                                    */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 06                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'T'         AND
                rmcodigo            = 888

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  6

   /*****************************************************************************************/
   /* BR                                                                                    */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 07                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'P'         AND
                rmcodigo            = 888

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  7

   /*****************************************************************************************/
   /* BONOS (UF)                                                                            */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 18                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'T'         AND
                rmcodigo            = 15          AND
                moneda_emision      = 998

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  18

   /*****************************************************************************************/
   /* BONOS (UF)                                                                            */
   /* Compras Propias y Ventas con Pacto       */
   /* Permanente                                                                            */
   /* Línea Nro. 19                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'P'         AND
                rmcodigo            = 15          AND
                moneda_emision      = 998

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  19

   /*****************************************************************************************/
   /* BONOS (USD)                                                                           */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 20                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'P'         AND
                rmcodigo            = 15          AND
                moneda_emision      = 994

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  20

   /*****************************************************************************************/
   /* BONOS (USD)                                                                           */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 21                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'T'         AND
                rmcodigo            = 15          AND
                moneda_emision      = 13

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  21

   /*****************************************************************************************/
   /* BONOS (USD)                                                                           */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 22                                                                         */
   /*****************************************************************************************/
   SELECT     @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE codigo_carterasuper = 'P'         AND
                rmcodigo            = 15          AND
                moneda_emision      = 13

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  22

   /*****************************************************************************************/
   /* BONOS (USD)                                                                           */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 22                                                                         */
   /*****************************************************************************************/
   SELECT     @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 98

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  23

   /*****************************************************************************************/
   /* PDBC                                                                                  */
   /* Compras Propias                                                                       */
   /* Línea Nro. 27                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 6           AND
                tipo_operacion      = 'CP'

   SELECT       @nValPres  = @nValPres + ISNULL( SUM( valor_presente ), 0.0 ),
                @nAjuste   = @nAjuste  + ISNULL( SUM( diferencia_mercado ), 0.0 )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 6             AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli            = 97029000      AND
                rscodigo            = 6

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  27

   /*****************************************************************************************/
   /* PDBC                                                                                  */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 28                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 6             AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli           <> 97029000      AND
                rscodigo            = 6

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  28

   /*****************************************************************************************/
   /* PDBC                                                                                  */
   /* Compras Propias                                                                       */
   /* Línea Nro. 29                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
      WHERE rmcodigo            = 7           AND
                tipo_operacion      = 'CP'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  29

   /*****************************************************************************************/
   /* PDBC                                                                                  */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 30                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 7           AND
                tipo_operacion      = 'VI'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  30

   /*****************************************************************************************/
   /* CERO                                                       */
   /* Compras Propias                                            */
   /* Línea Nro. 32                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 300         AND
                tipo_operacion      = 'CP'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  32

   /*****************************************************************************************/
   /* CERO                                                                                  */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 33                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 300         AND
                tipo_operacion      = 'VI'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  33

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Compras Propias                                      */
   /* Permanente                                                                            */
   /* Línea Nro. 36                       */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 4           AND
                tipo_operacion      = 'CP'        AND
                codigo_carterasuper = 'P'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  36

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Permanente                                                                            */
   /* Línea Nro. 37                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 4           AND
                tipo_operacion      = 'VI'        AND
                codigo_carterasuper = 'P'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  37

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Compras Propias                                                                   */
   /* Trading                                                    */
   /* Línea Nro. 38                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 4           AND
                tipo_operacion      = 'CP'        AND
                codigo_carterasuper = 'T'
                
   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  38

   /*****************************************************************************************/
   /* PRC                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Trading                                                                               */
   /* Línea Nro. 39                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 4           AND
                tipo_operacion      = 'VI'        AND
                codigo_carterasuper = 'T'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  39

   /*****************************************************************************************/
   /* PRD                                                  */
   /* Compras Propias y Ventas con Pacto                                */
   /* Línea Nro. 43               */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 31

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste    = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  43

   /*****************************************************************************************/
   /* LCHR (Emisor = 97030000)                                                              */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 57                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 20          AND
                rut_emisor          = 97030000    AND
                codigo_carterasuper = 'T'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  57

   /*****************************************************************************************/
   /* LCHR (Emisor = 97030000)                                                              */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                          */
   /* Línea Nro. 58                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 20          AND
                rut_emisor          = 97030000    AND
                codigo_carterasuper = 'P'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  58

   /*****************************************************************************************/
   /* LCHR (Emisor = 97018000)                                                              */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 65                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 20          AND
                rut_emisor          = 97018000    AND
                codigo_carterasuper = 'T'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        = 65

   /*****************************************************************************************/
   /* LCHR (Emisor = 97018000)                                                              */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 66                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 20          AND
                rut_emisor          = 97018000    AND
                codigo_carterasuper = 'P'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        = 66

   /*****************************************************************************************/
   /* LCHR (Emisor <> 97018000 y 97030000)                                                  */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Trading                                                                               */
   /* Línea Nro. 70                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 20          AND
               (rut_emisor         <> 97018000    AND
                rut_emisor         <> 97030000)   AND
                codigo_carterasuper = 'T'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        = 70

   /*****************************************************************************************/
   /* LCHR (Emisor <> 97018000 y 97030000)                                                  */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Permanente                                                                            */
   /* Línea Nro. 71                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 20          AND
               (rut_emisor         <> 97018000    AND
                rut_emisor         <> 97030000)   AND
                codigo_carterasuper = 'P'

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        = 71


   /*****************************************************************************************/
   /* DPF		                                                                   */
   /* Línea Nro. 75                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 9

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        = 75


   /*****************************************************************************************/
   /* DPR		                                                                   */
   /* Línea Nro. 76                             */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
     WHERE rmcodigo            = 11

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        = 76

   /*****************************************************************************************/
   /* DPX                                                                                   */
   /* Compras Propias y Ventas con Pacto                                                    */
   /* Línea Nro. 83                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = ROUND( SUM(     valor_presente * vmvalor ), 0 ),
                @nAjuste   = ROUND( SUM( diferencia_mercado * vmvalor ), 0 )
          FROM  #tmp_tasa_mercado, view_valor_moneda
          WHERE (rmcodigo  = 50               OR
                 rmcodigo  = 51               OR
                 rmcodigo  = 52               OR
                 rmcodigo  = 54)             AND
                 vmcodigo  = 994             AND
                 vmfecha   = @dFechaFinMes

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  83

   /*****************************************************************************************/
   /* BCU                                                                                   */
   /* Compras Propias                                                                       */
   /* Línea Nro. 86                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 32          AND
                tipo_operacion      = 'CP'

   SELECT       @nValPres  = @nValPres + ISNULL( SUM( valor_presente ), 0.0 ),
                @nAjuste   = @nAjuste  + ISNULL( SUM( diferencia_mercado ), 0.0 )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 32            AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli            = 97029000      AND
                rscodigo            = 32

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  86

   /*****************************************************************************************/
   /* BCU                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 87                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 32            AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli           <> 97029000      AND
                rscodigo            = 32

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  87

   /*****************************************************************************************/
   /* BCP                                                                                   */
   /* Compras Propias                                                                       */
   /* Línea Nro. 88                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 33          AND
                tipo_operacion      = 'CP'

   SELECT       @nValPres  = @nValPres + ISNULL( SUM( valor_presente ), 0.0 ),
                @nAjuste   = @nAjuste  + ISNULL( SUM( diferencia_mercado ), 0.0 )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 33            AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli            = 97029000      AND
                rscodigo            = 33

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  88


   /*****************************************************************************************/
   /* BCP                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 89                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 33            AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli           <> 97029000      AND
                rscodigo            = 33

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  89

   /*****************************************************************************************/
   /* BCD                                                                                   */
   /* Compras Propias                                                                       */
   /* Línea Nro. 90                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado
          WHERE rmcodigo            = 34          AND
                tipo_operacion      = 'CP'

   SELECT       @nValPres  = @nValPres + ISNULL( SUM( valor_presente ), 0.0 ),
                @nAjuste   = @nAjuste  + ISNULL( SUM( diferencia_mercado ), 0.0 )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 34            AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli            = 97029000      AND
                rscodigo            = 34

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  90

   /*****************************************************************************************/
   /* BCU                                                                                   */
   /* Ventas con Pacto                                                                      */
   /* Línea Nro. 91                                                                         */
   /*****************************************************************************************/
   SELECT       @nValPres  = SUM( valor_presente ),
                @nAjuste   = SUM( diferencia_mercado )
          FROM  #tmp_tasa_mercado, mdrs
          WHERE rmcodigo            = 34            AND
                tipo_operacion      = 'VI'	    AND
                rsfecha             = @dFechaFinMes AND
                rscartera           = '114'         AND
                rstipoper           = 'DEV'         AND
                rsrutcart           = rmrutcart     AND
                rsnumdocu           = rmnumdocu     AND
                rscorrela           = rmcorrela     AND
                rsnumoper           = rmnumoper     AND
                rsrutcli           <> 97029000      AND
                rscodigo            = 34

   UPDATE       #Informe_P17
          SET   tot_contable = ISNULL( @nValPres, 0 ),
                ajuste       = ISNULL(  @nAjuste, 0 )
          WHERE Linea        =  91

   /*****************************************************************************************/
   /*****************************************************************************************/
   UPDATE       #Informe_P17
          SET   total = tot_contable + ajuste


   SELECT * FROM #Informe_P17 ORDER BY orden

   /*****************************************************************************************/
  /*****************************************************************************************/

   DROP TABLE #Informe_P17
   DROP TABLE #mdrs_informe_p17
   DROP TABLE #tmp_tasa_mercado

   SET NOCOUNT OFF

END

-- select * from mdrs where rsfecha='20011130' and rscodigo=52
-- select * from mdrs where rsfecha='20011203' and rstipoper = 'VC' and rscodigo = 300
-- select * from mdrs where rsfecha='20011203' and rscartera = '114' and rstipoper = 'DEV' and rscodigo = 300
-- select sum(rsnominal),sum(rsvppresen),sum(rsvalcomp),SUM(rsinteres_acum-rsinteres) from mdrs where rsfecha='20011203' and rscartera = '114' and rstipoper = 'DEV' and rscodigo = 300
-- select * from bacuser.mdrs1130
-- insert into mdrs select * from bacuser.mdrs1130
-- sp_helptext sp_check_cierre_de_mes
-- delete mdrs
-- select * from valorizacion_mercado
-- sp_autoriza_ejecutar 'BACUSER'
-- sp_informe_p17
-- SELECT * FROM MDMO WHERE MOTIPOPER = 'VI' 2000401



GO
