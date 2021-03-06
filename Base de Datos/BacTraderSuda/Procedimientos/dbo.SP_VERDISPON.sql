USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERDISPON]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_VERDISPON]
                          (@rutcart NUMERIC(09,0),
                           @numdocu NUMERIC(10,0),
                           @correla NUMERIC(03,0),
                           @nominal NUMERIC(19,4),
                           @hwnd NUMERIC(10,0), 
                           @usuario CHAR(20)       )
AS
BEGIN
set nocount on

 DECLARE @retorno CHAR(2) ,
  @nomdisp NUMERIC(19,4) ,
  @tipoper CHAR(3)
 SELECT @nomdisp = dinominal, @tipoper = ditipoper FROM MDDI WHERE dirutcart = @rutcart AND dinumdocu = @numdocu AND dicorrela = @correla 
 IF @nomdisp <> @nominal
 BEGIN
    IF @nomdisp > 0
  SELECT @retorno = 'MD'
           ELSE
  SELECT @retorno = 'VE'
 
 END ELSE
  SELECT @retorno = 'SI'
 IF @retorno <> 'MD'
      SELECT @retorno
 ELSE
 BEGIN
  IF @tipoper = 'CP'
         SELECT @retorno,
               0     ,       
               ''           ,       
               dirutcart    ,
               ditipcart    ,
               dinumdocu    ,
               dicorrela    ,
               dinumdocuo   ,
               dicorrelao   ,
               ditipoper    ,
               diserie      ,
               diinstser    ,
               digenemi     ,
               dinemmon     ,
               dinominal    ,
               ditircomp    ,
               dipvpcomp    ,
               divptirc     ,
               dipvpmcd     ,
               ditirmcd     ,
               0     ,  --divpmcd100   ,
               divpmcd      ,
               divptirc     ,  --divptirci
               CONVERT(CHAR(10),difecsal,103),
               dinumucup    ,
               0            ,   --diinteresc   ,
               0,    --direajustc   ,
               0,   --diintereci   ,
               0,   --direajusci   ,
               divptirc     ,  --dicapitalc   ,
               divptirc     ,  --dicapitaci ,
         cpcodigo      ,
        cpmascara     ,
        cptasest      ,
  CASE 
     WHEN cpseriado = 'S'  THEN (SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara)
      ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CASE 
     WHEN cpseriado = 'S'  THEN (SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara)
      ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CASE 
     WHEN cpseriado = 'S'  THEN (SELECT setasemi FROM VIEW_SERIE WHERE semascara = cpmascara)
      ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CASE 
     WHEN cpseriado = 'S'  THEN (SELECT sebasemi FROM VIEW_SERIE WHERE semascara = cpmascara)
      ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CONVERT(CHAR(10),cpfecemi,103),
  CONVERT(CHAR(10),cpfecven,103),
  CONVERT(CHAR(10),cpfecpcup,103),
  CASE 
     WHEN EXISTS( SELECT * FROM MDBL WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela ) THEN '*'
    ELSE ' ' END
               FROM MDDI, MDCP
               WHERE  dirutcart = @rutcart 
   AND dinumdocu = @numdocu 
   AND dicorrela = @correla   
   AND cprutcart = dirutcart     
   AND cpnumdocu = dinumdocu    
  
   AND cpcorrela = dicorrela
  ELSE
         SELECT @retorno,
               0     ,       
               ''           ,       
        dirutcart    ,
               ditipcart    ,
               dinumdocu    ,
               dicorrela    ,
               dinumdocuo   ,
               dicorrelao   ,
               ditipoper    ,
               diserie      ,
               diinstser    ,
               digenemi     ,
               dinemmon     ,
           dinominal    ,
               ditircomp    ,
               dipvpcomp    ,
             divptirc     ,
         dipvpmcd     ,
               ditirmcd     ,
               0     ,  --divpmcd100 ,
               divpmcd      ,
               divptirc     ,  --divptirci
               CONVERT(CHAR(10),difecsal,103),
               dinumucup    ,
               0            ,   --diinteresc   ,
               0,    --direajustc   ,
               0,   --diintereci   ,
               0,   --direajusci   ,
               divptirc     ,  --dicapitalc   ,
               divptirc     ,  --dicapitaci   ,
   cicodigo      ,
  cimascara     ,
  citasest      ,
  CASE 
     WHEN ciseriado = 'S'  THEN (SELECT serutemi FROM VIEW_SERIE WHERE semascara = cimascara)
      ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CASE 
     WHEN ciseriado = 'S'  THEN (SELECT semonemi FROM VIEW_SERIE WHERE semascara = cimascara)
      ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CASE 
     WHEN ciseriado = 'S'  THEN (SELECT setasemi FROM VIEW_SERIE WHERE semascara = cimascara)
      ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CASE 
     WHEN ciseriado = 'S'  THEN (SELECT sebasemi FROM VIEW_SERIE WHERE semascara = cimascara)
      ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,
  CONVERT(CHAR(10),cifecemi,103),
  CONVERT(CHAR(10),cifecven,103),
  CONVERT(CHAR(10),cifecpcup,103),
  CASE 
     WHEN EXISTS( SELECT * FROM MDBL WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela ) THEN '*'
    ELSE ' ' END
               FROM MDDI, MDCI
               WHERE dirutcart = @rutcart 
   AND dinumdocu = @numdocu 
   AND dicorrela = @correla   
   AND cirutcart       = dirutcart     
   AND cinumdocu       = dinumdocu     
   AND cicorrela       = dicorrela
 END
SELECT 'OK'
set nocount off
END

GO
