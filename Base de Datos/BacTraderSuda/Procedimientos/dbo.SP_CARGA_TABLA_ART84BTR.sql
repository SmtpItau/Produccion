USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_ART84BTR]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_ART84BTR]
AS  
BEGIN

   SET NOCOUNT ON

   DECLARE  @fecpro       DATETIME       

    SELECT @fecpro  = acfecproc 
    FROM MDAC

   CREATE TABLE #Art84
    (
    Numdocu       NUMERIC (10,0)    ,                        -- 1
    Numoper       NUMERIC (10,0)    ,                        -- 2
    Correla       NUMERIC (03,0)    ,                        -- 3
    Modulo        CHAR    (03)      ,                        -- 4 
    Fec_Proc      datetime          ,                        -- 5 
    RutDeudor     NUMERIC (9)       ,                        -- 6
    Instrumento   CHAR (12)         ,                        -- 8
    Mascara       CHAR (12)         ,                        -- 9
    Nominal       NUMERIC (19,4)    ,                        -- 10
    Fecha_compra  datetime          ,                        -- 11    
    Fecha_emi     datetime          ,                        -- 12
    Seriado       CHAR (1)          ,                        -- 13
    Codigo        NUMERIC (5)       ,                        -- 14
    Tir           NUMERIC (19,4)    ,                        -- 15
    Moneda        NUMERIC (5)       ,                        -- 16
    Tipoper       CHAR (3)          ,                        -- 17
    Monto         NUMERIC (19,4) NULL DEFAULT (0)            -- 18

   )

 INSERT #Art84
 SELECT cpnumdocu ,
        cpnumdocu ,
        cpcorrela ,
        'BTR'     , 
        @fecpro   ,  
        CASE
            WHEN cpseriado='N' THEN isnull((SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
            ELSE                           (SELECT top 1 serutemi FROM VIEW_SERIE   WHERE semascara=cpmascara)
        END       ,
        cpinstser ,
        cpmascara ,   
        cpnominal ,
        cpfeccomp ,    
        cpfecemi  ,
        cpseriado ,
        cpcodigo  ,
        cptircomp ,
        CASE WHEN cpseriado='N' THEN isnull((SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
             ELSE                    isnull((SELECT top 1 semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
        END  ,
        'CP' ,
        cpvptirc

 FROM MDCP
 WHERE cpnominal   > 0 AND cprutcart > 0 



 INSERT #Art84
 SELECT DISTINCT 
        vinumdocu ,  
        vinumdocu ,  
        vicorrela ,  
        'BTR'     , 
        @fecpro   ,  
        CASE WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
             ELSE                    (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END       , --virutcli,
        viinstser ,
        vimascara ,
        vinominal ,
        vifeccomp , 
        vifecemi  ,
        viseriado ,   
        vicodigo  ,
        vitircomp ,
        999       , --> vimonemi, 
        'CP'      ,
        vivptirc
  FROM  MDVI
 
  --> Con Fecha: 18 de Agosto del 2008. 
  --> Se solicito la Extracción de Este Evento. (Intermediación) Ref: RutCliente : virutcli

 /*
-- inicio INTERMEDIADA 
 INSERT #Art84
 SELECT vinumdocu ,
        vinumoper ,
        vicorrela ,
        'BTR'     , 
        @fecpro   ,    
        virutcli  ,
        viinstser ,
        vimascara ,
        vinominal ,
        vifeccomp ,
        vifecemi  ,
        viseriado ,
        vicodigo  ,
        vitircomp ,
        CASE WHEN viseriado='N' THEN isnull((SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
             ELSE                    isnull((SELECT  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END  ,
        'VI' ,
        vivptirc 

 FROM MDVI 
 */
 
 INSERT #Art84
 SELECT cinumdocu ,
        cinumdocu ,
        cicorrela ,
        'BTR'     , 
        @fecpro   ,    
        cirutcli  ,
        ciinstser ,
        cimascara ,
        cinominal ,
        cifeccomp ,
        cifecemi  ,
        ciseriado ,
        cicodigo  ,
        citircomp ,
        CASE WHEN ciinstser = 'ICOL' THEN cimonpact
             ELSE                         999
        END,                              --> cimonpact,  --> 17-08-2009.
        CASE WHEN ciinstser = 'ICOL' THEN 'IB'
             ELSE                         'CI'
        END,
        civptirc  
   FROM MDCI
  WHERE ciinstser <> 'ICAP'

   INSERT INTO Margen_Articulo84 
   SELECT * FROM #Art84

END




GO
