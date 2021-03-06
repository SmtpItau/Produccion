USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GBR_FLJ_PSS]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_GBR_FLJ_PSS]
                (@Usuario CHAR(20))
AS

-- Autor		: 
-- Objetivo		: Eliminacion de serie en tabla modificacion
-- Fecha de Creacion	: 16-03-2004
-- Modificaciones	: 
-- Primera Modificacion	: 16-03-2004
-- Segunda Modificacion	: 16-03-2004
-- Antecedentes Generales : 

BEGIN

SET NOCOUNT ON

  DECLARE @x           INTEGER      ,
          @Marca       CHAR(01)     ,
          @Instrumento CHAR(20)     ,
          @Moneda      CHAR(03)     ,
          @Emisor      CHAR(10)     ,
          @Nominal     NUMERIC(21,8),
          @Tir         NUMERIC(19,4),
          @Vpar        NUMERIC(19,4),
          @Mt          NUMERIC(19,4),
          @Custodia    CHAR(15)     ,
          @ClaveDcv    CHAR(15)     ,
          @TirCmp      NUMERIC(19,4),
          @VparCmp     NUMERIC(19,4),
          @MTCmp       NUMERIC(19,4),
          @Utilidad    NUMERIC(19,4),
          @Clasificacion CHAR(15)   ,
          @NumeroOP    NUMERIC(10)  ,
          @Correlativo NUMERIC(03)  ,
          @cant_reg    INTEGER      




   CREATE TABLE #TEMP1 (
		nerror		numeric (02,0)		null,hwnd2		numeric (09,0)		null,
                usuario2	char    (20)		null,rutcart		numeric(9,0)		null,
            	tipcart		numeric(1,0)		null,numdocu		numeric(10,0)		null,
                correla		numeric(3,0)		null,numdocuo	        numeric(10,0)		null,
                correlao	numeric(3,0)		null,tipoper		char    (03)		null,
                serie		char(12)		null,instser		char(12)		null,
                genemi		char(05)		null,nemmon		char(05)		null,
                nominal		numeric(19,4)		null,tircomp		numeric(19,4)		null,
                pvpcomp		numeric(19,4)		null,vptirc		numeric(19,4)		null,
                pvpmcd		numeric(19,4)		null,tirmcd		numeric(19,4)		null,
                vpmcd100	numeric(19,4)		null,vpmcd		numeric(19,4)		null,
                vptirci		numeric(19,4)		null,fecsal		char(10)		null,
                numucup		numeric( 5,0)		null,interesc	        numeric(19,4)		null,
                reajustc	numeric(19,4)		null,intereci	        numeric(19,4)		null,
                reajusci	numeric(19,4)		null,capitalc	        numeric(19,4)		null,
                capitaci	numeric(19,4)		null,codigo		numeric(05,0)		null,
                mascara		char(12)		null,tasest		numeric(19,4)		null,
                rutemi		numeric( 9,0)		null,monemi		numeric(03,0)		null,
	        tasemi		numeric(09,4)		null,basemi		numeric(03,0)		null,
                fecemi		char(10)		null,fecven		char(10)		null,
		fecpcup		char(10)		null,bloq		char(1)			null,
		diasdisp	numeric( 5,0)		null,custodia_dcv	char(01)		null,
		seriados	char(01)		null,convexidad	        float			null,
		durationmac	float			null,durationmod	float			null,
		nombre_carterasuper char(20) 		null,clave_dcv          char(15)		null)


  /*    CREATE TABLE #TEMP
      (
         Marca         CHAR(01)         not null,
         Instrumento   CHAR(20)         not null,
         Moneda        CHAR(03)         not null,
         Emisor        CHAR(10)         not null,
         Nominal       NUMERIC(21,8)    not null,
         Tir           NUMERIC(19,4)    not null,
         Vpar          NUMERIC(19,4)    not null,
         Mt            NUMERIC(19,4)    not null,
         Custodia      CHAR(15)         not null,
         ClaveDcv      CHAR(15)         not null,
         TirCmp        NUMERIC(19,4)    not null,
         VparCmp       NUMERIC(19,4)    not null,
         MTCmp         NUMERIC(19,4)    not null,
         Utilidad      NUMERIC(19,4)    not null,
         Clasificacion CHAR(15)         not null,
         NumeroOP      NUMERIC(10)      not null,
         Correlativo   NUMERIC(03)      not null,
         Switch        CHAR(01)         not null,
         Usuario       CHAR(15)         not null,
         registro      INTEGER IDENTITY(1,1) not null
      )

        INSERT #TEMP
        SELECT Marca,
            Instrumento,
               Moneda,
               Emisor,
               Nominal,
               Tir,
               Vpar,
               Mt,
               Custodia,
               ClaveDcv,
               TirCmp,
               VparCmp,
               MTCmp,
               Utilidad,
               Clasificacion,
               NumeroOP,
               Correlativo,
               '',
               Usuario
        FROM   FLJ_LQZ_MOD

   SELECT   @x   = 1
   SELECT   @cant_reg = COUNT(1) FROM #TEMP
     


   IF @cant_reg = 0 
   BEGIN
        INSERT #TEMP
        SELECT Marca,
               Instrumento,
               Moneda,
               Emisor,
               Nominal,
               Tir,
               Vpar,
               Mt,
               Custodia,
               ClaveDcv,
               TirCmp,
               VparCmp,
               MTCmp,
               Utilidad,
               Clasificacion,
               NumeroOP,
               Correlativo,
               '',
               Usuario
        FROM   FLJ_LQZ_IMD

       SELECT   @x   = 1,  @cant_reg = COUNT(1) FROM #TEMP
    END


   WHILE @x <= @cant_reg
   BEGIN

      SELECT  @Marca         = Marca,
              @Instrumento   = Instrumento,
              @Moneda        = Moneda,
              @Emisor        = Emisor,
              @Nominal       = Nominal,
              @Tir           = Tir,
              @Vpar          = Vpar,
              @Mt            = Mt,
              @Custodia      = Custodia,
              @ClaveDcv      = ClaveDcv,
              @TirCmp        = TirCmp,
              @VparCmp       = VparCmp,
              @MTCmp         = MTCmp,
              @Utilidad      = Utilidad,
              @Clasificacion = Clasificacion,
              @NumeroOP      = NumeroOP,
              @Correlativo   = Correlativo
      FROM   #TEMP      WHERE registro = @x

      IF EXISTS(SELECT 1 FROM #TEMP WHERE Instrumento = @Instrumento AND Switch = '' AND Usuario = @Usuario)
      BEGIN
         
         UPDATE #TEMP SET Switch = 'X' WHERE  Usuario = @Usuario
         INSERT FLJ_LQZ_MOD
         SELECT N.*
         FROM   FLJ_LQZ_IMD N
         WHERE  NOT EXISTS(SELECT 1 FROM FLJ_LQZ_MOD M
                           WHERE  M.NumeroOP    = N.NumeroOP
                             AND  M.Correlativo = N.Correlativo)
      END
      SELECT @x = @x + 1
   END*/
   


      CREATE TABLE #TEMP
      (
         Marca         CHAR(01)         not null,
         Instrumento   CHAR(20)         not null,
         Moneda        CHAR(03)         not null,
         Emisor        CHAR(10)         not null,
         Nominal       NUMERIC(21,8)    not null,
         Tir           NUMERIC(19,4)    not null,
         Vpar          NUMERIC(19,4)    not null,
         Mt            NUMERIC(19,4)    not null,
         Custodia  CHAR(15)         not null,
         ClaveDcv      CHAR(15)         not null,
         TirCmp        NUMERIC(19,4)    not null,
         VparCmp       NUMERIC(19,4)    not null,
         MTCmp         NUMERIC(19,4)    not null,
         Utilidad      NUMERIC(19,4)    not null,
         Clasificacion CHAR(15)         not null,
         NumeroOP      NUMERIC(10)      not null,
         Correlativo   NUMERIC(03)      not null,
         Switch        CHAR(01)         not null,
         Usuario       CHAR(15)         not null,
         registro      INTEGER IDENTITY(1,1) not null
      )


        INSERT #TEMP
        SELECT Marca,
               Instrumento,
               Moneda,
               Emisor,
               Nominal,  
               Tir,
               Vpar,
               Mt,
               Custodia,
               ClaveDcv,
               TirCmp,
               VparCmp,
               MTCmp,
               Utilidad,
               Clasificacion,
	       NumeroOP,
               Correlativo,
   '',
       Usuario
           FROM   FLJ_LQZ_IMD

   SELECT   @x   = 1
   SELECT   @cant_reg = COUNT(1) FROM #TEMP
     
   WHILE @x <= @cant_reg
   BEGIN
      SELECT  @Marca         = Marca,
              @Instrumento   = Instrumento,
              @Moneda        = Moneda,
              @Emisor        = Emisor,
              @Nominal       = Nominal,
              @Tir           = Tir,
              @Vpar          = Vpar,

              @Mt            = Mt,
              @Custodia      = Custodia,
              @ClaveDcv      = ClaveDcv,
              @TirCmp        = TirCmp,
              @VparCmp       = VparCmp,
              @MTCmp         = MTCmp,
	      @Utilidad      = Utilidad,
              @Clasificacion = Clasificacion,
              @NumeroOP      = NumeroOP,
              @Correlativo   = Correlativo
      FROM   #TEMP      WHERE registro = @x

      IF EXISTS(SELECT 1 FROM #TEMP WHERE Instrumento = @Instrumento AND Switch = '' AND Usuario = @Usuario)
      BEGIN
         DELETE FLJ_LQZ_MOD WHERE Instrumento = @Instrumento AND Usuario = @Usuario
         UPDATE #TEMP SET Switch = 'X' WHERE Instrumento = @Instrumento AND Usuario = @Usuario
         INSERT FLJ_LQZ_MOD SELECT N.* FROM FLJ_LQZ_IMD N
         WHERE  Instrumento = @Instrumento AND Usuario = @Usuario
      END
 
      SELECT @x = @x + 1
            
   END


   INSERT INTO #TEMP1
   SELECT      0	    ,		
               0	    ,
               SPACE(20)    ,
	       dirutcart    ,
               ditipcart    ,
               dinumdocu    ,
               dicorrela    ,
               0            ,
               0            ,
               ditipoper    ,
               diserie      ,
               diinstser    ,
               digenemi     ,
               dinemmon     ,
               Nominal      ,
               Tir          ,
               Vpar         ,
               Mt           ,
               dipvpmcd     ,
               ditirmcd     ,
               0	    ,
               divpmcd      ,
               Mt           ,
               convert(char(10),difecsal,103),
               dinumucup    ,
               0            ,
               0            ,
               0            ,
               0            ,
               Mt           ,
               Mt           ,
	       cpcodigo      ,
	       cpmascara     ,
	       cptasest      ,
	       0,
	       0,
	       0,
	       0,
		convert(char(10),cpfecemi,103)	,
		convert(char(10),cpfecven,103)	,
		convert(char(10),cpfecpcup,103)	,
		Marca				,
		datediff(day,acfecproc,difecsal),
                Custodia			,
		b.cpseriado			,
		b.cpconvex			,
		b.cpdurat			,
		b.cpdurmod			,	
		b.codigo_carterasuper		,
		ClaveDcv
               FROM	MDDI a , MDCP b ,
                        MDAC   , FLJ_LQZ_MOD c
            WHERE           cpnumdocu   = dinumdocu     
			and cpcorrela      = dicorrela
                        and cprutcart      = dirutcart     
                        and cpnumdocu      = dinumdocu    
                        and cpcorrela      = dicorrela
                        and cpdcv          = 'D'
                        and dirutcart      = acrutprop
                        and NumeroOP       = cpnumdocu
		        and Correlativo    = cpcorrela
                        and Usuario        = @Usuario
                        and ditipoper      = 'CP' 
                        and digenemi       = 'BCCH'
		ORDER BY dicontador,diinstser

---- Completa Información ----
   UPDATE #temp1
   SET    rutemi  = serutemi,
          monemi  = semonemi,
          tasemi  = setasemi,
          basemi  = sebasemi
   FROM   VIEW_SERIE
   WHERE  seriados = "S"           
   AND    mascara  = seserie

   UPDATE #temp1
   SET    rutemi  = nsrutemi,
          monemi  = nsmonemi,
          tasemi  = nstasemi,
          basemi  = nsbasemi
   FROM   VIEW_NOSERIE
   WHERE  seriados   = "N"           
   AND    rutcart       = nsrutcart     
   AND    numdocu       = nsnumdocu     
   AND    correla       = nscorrela


  SELECT * FROM #TEMP1

SET NOCOUNT OFF

END








GO
