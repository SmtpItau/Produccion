USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ChkInstSer]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ChkInstSer]
       (@cinstser    CHAR(12)  )
AS
BEGIN
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @nerror      INTEGER
   DECLARE @cmascara    CHAR(12)
   DECLARE @cinstaux    CHAR(12)
   DECLARE @cinstaux2   CHAR(12)
   DECLARE @carchivo    CHAR(2)
   DECLARE @cmesaux     CHAR(2)
   DECLARE @canoaux     CHAR(4)
   DECLARE @dfecaux     DATETIME
   DECLARE @ncodigo     INTEGER
   DECLARE @cserie      CHAR(12)
   DECLARE @crefnomi    CHAR(1)
   DECLARE @cprog       CHAR(8)
   DECLARE @ntipfec     INTEGER
   DECLARE @ndiavcup    INTEGER
   DECLARE @npervcup    INTEGER
   DECLARE @ncupones    INTEGER
   DECLARE @nrutemi     NUMERIC(9,0)
   DECLARE @nmonemi     INTEGER
   DECLARE @ftasemi     FLOAT
   DECLARE @nbasemi     NUMERIC(3,0)
   DECLARE @dfecemi     DATETIME
   DECLARE @dfecven     DATETIME
   DECLARE @cgenemi     CHAR(10)
   DECLARE @cnemmon     CHAR(5)
   DECLARE @ncorte      NUMERIC(19,4)
   DECLARE @cseriado    CHAR(1)
   DECLARE @clecemi     CHAR(6)
   DECLARE @dfecpro     DATETIME
   DECLARE @cfecaux     CHAR(10)
   DECLARE @nlutil      INTEGER
   DECLARE @nlutiling   INTEGER
   DECLARE @j           INTEGER
   DECLARE @cfamilia    CHAR(12)
   DECLARE @nmes        INTEGER
   DECLARE @nmes_a      INTEGER
   DECLARE @nano        INTEGER
   DECLARE @cano        CHAR(04)
   DECLARE @cmascaux    CHAR(12)

   /*=======================================================================*/
   /* Definici¢n de variables para los instrumentos PDP                     */
   /*=======================================================================*/
   DECLARE @cultdia     CHAR(24)
   DECLARE @nanoemi     INTEGER
   DECLARE @nmesemi     INTEGER
   DECLARE @ndiaemi     INTEGER

   /*=======================================================================*/
   /* Definici¢n de variables para los instrumentos BR                      */
   /*=======================================================================*/
   DECLARE @iextrae     INTEGER
   DECLARE @imesemi     INTEGER
   DECLARE @ianovto     INTEGER
   DECLARE @ianoemi     INTEGER
   DECLARE @imesman     INTEGER
   DECLARE @cfecven     CHAR(10)
   DECLARE @cfecman     CHAR(10)
   DECLARE @cfecemi     CHAR(10)
   DECLARE @dfecman     DATETIME

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT      @dfecpro = Fecha_Proceso
          FROM DATOS_GENERALES

   /*=======================================================================*/
   /* guardar la serie, en este punto, llamar a sp_nemosinast(cinstser)     */
   /* para LCHR-CHILE.-                                                     */
   /*=======================================================================*/
   SELECT @cinstaux2 = @cinstser

   /*=======================================================================*/
   /* cambio para letras con "*" y "&" / equivale al mes ( siempre es 01)   */
   /*=======================================================================*/
   IF CHARINDEX( "*", @cinstser ) <> 0 BEGIN
      SELECT @cinstser = SUBSTRING( @cinstser, 1, 6 ) + "01" +
                         SUBSTRING( @cinstser, 9, 2 )

   END

   /*=======================================================================*/
   /* equivale al a¤o                                                       */
   /*=======================================================================*/
   IF CHARINDEX( "&", @cinstser ) <> 0 BEGIN


      /*====================================================================*/
      /*====================================================================*/
      SELECT @nmes     = CONVERT( INTEGER, SUBSTRING( @cinstser, 9, 2 ) )
      SELECT @nmes_a   = DATEPART( MONTH, @dfecpro )

      /*====================================================================*/
      /*====================================================================*/
      IF @nmes >= @nmes_a BEGIN
         SELECT @nano  = DATEPART( YEAR, @dfecpro ) - 1

      END ELSE BEGIN
         SELECT @nano  = DATEPART( YEAR, @dfecpro)

      END

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cano     = CONVERT( CHAR(04), @nano )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cinstser = SUBSTRING( @cinstser, 1, 6 ) +
                         SUBSTRING( @cinstser, 9, 2 ) +
                         SUBSTRING( @cano, 3, 2 )

   END

   /*=======================================================================*/
   /* guardar la serie, en este punto, llamar a sp_nemosinast(cinstser)     */
   /* para LCHR-CHILE.-                                                     */
   /*=======================================================================*/
   SELECT @cinstaux = @cinstser

   /*=======================================================================*/
   /* encontrar la familia                                                  */
   /*=======================================================================*/
   SELECT       @cmascara = "*"
   SELECT       @carchivo = "SE"                                             ,
                @cmascara = semascara                                        ,
                @ncodigo  = secodigo
          FROM  SERIE
          WHERE seserie   = @cinstser

   /*=======================================================================*/
   /*=======================================================================*/
   IF @cmascara = "*" BEGIN

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cfamilia = "*"

      /*====================================================================*/
      /*====================================================================*/
      IF ( SUBSTRING( @cinstaux, 1, 3 )  = 'PCD'     AND
           SUBSTRING( @cinstaux, 1, 6 ) <> 'PCDUS$' )      BEGIN
         SELECT @cfamilia = "PCDUF"

      /*====================================================================*/
      /*====================================================================*/
      END ELSE BEGIN
         SELECT @j = DATALENGTH( @cinstaux )

         WHILE  @j <> 0 BEGIN
            SELECT       @cfamilia = inserie
                   FROM  INSTRUMENTO
                   WHERE inserie   = SUBSTRING( @cinstaux, 1, @j )

            IF @cfamilia <> "*" BEGIN
               BREAK

            END

            SELECT @j=@j-1

         END

      END

      /*====================================================================*/
      /*====================================================================*/
      IF @cfamilia = "*" BEGIN
         SELECT @cfamilia = "LCHR"

      END

      /*====================================================================*/
      /*====================================================================*/
      IF ( @cfamilia = "BR"   OR @cfamilia = "PRBC" OR @cfamilia = "PDBC" OR
           @cfamilia = "DPF"  OR @cfamilia = "DPD"  OR @cfamilia = "DPR"  OR
           @cfamilia = "CERO" OR @cfamilia = "ZERO"
         ) BEGIN
         SELECT @cmascara = @cfamilia

      END

      /*====================================================================*/

      /* buscar en tabla de mascaras por msfamilia para extraer largo util  */
      /* de la serie                 */
      /*====================================================================*/
      SET ROWCOUNT 1
      SELECT       @nlutil    = DATALENGTH( LTRIM( RTRIM( msmascara ) ) ),
                   @nlutiling = DATALENGTH( LTRIM( RTRIM(    msnemo ) ) )
             FROM  MASCARA_INSTRUMENTO
             WHERE msfamilia = @cfamilia
      SET ROWCOUNT 0

      /*====================================================================*/
      /* buscar en archivo de series.                                       */
      /*====================================================================*/
      SELECT       @cmascaux = @cmascara
      SELECT       @cmascara = "*"

      /*====================================================================*/
      /*====================================================================*/
      SELECT       @carchivo = "SE",
                   @cmascara = semascara ,
                   @ncodigo  = secodigo
             FROM  SERIE
             WHERE seserie   = SUBSTRING( @cinstaux, 1, @nlutil )

      IF @nlutiling <> DATALENGTH( RTRIM( LTRIM( @cinstser ) ) ) BEGIN
         SELECT "error" = 15,
                "desc"  = "Nemotecnico ingresado incompletamente"
   SET NOCOUNT OFF
   SELECT "ERR"
         RETURN 15

      END

   END

   /*=======================================================================*/
   /*=======================================================================*/
   IF @cmascara = "*" BEGIN
      SELECT @carchivo = "IN"

   END

   /*=======================================================================*/
   /* el instrumento esta definido en la Tabla Serie.                       */
   /*=======================================================================*/
   IF @carchivo = 'SE' BEGIN
      SELECT       @ncodigo       =  B.incodigo                           ,
                   @cserie        =  B.inserie                            ,
                   @crefnomi      =  B.inrefnomi                          ,
                   @cprog         =  B.inprog                             ,
                   @ntipfec       =  B.intipfec                           ,
                   @cseriado      =  B.inmdse                             ,
                   @ndiavcup      =  A.sediavcup                          ,
                   @npervcup      =  A.sepervcup                          ,
                   @ncupones      =  A.secupones                          ,
                   @nrutemi       =  A.serutemi                           ,
                   @nmonemi       =  A.semonemi                           ,
                   @ftasemi       =  A.setasemi                           ,
                   @nbasemi       =  A.sebasemi                           ,
                   @dfecemi       =  A.sefecemi                           ,
                   @dfecven       =  A.sefecven                           ,
                   @ncorte        =  A.secorte                            ,
                   @cfamilia      =  B.inserie
             FROM  SERIE A,
		   INSTRUMENTO B
             WHERE A.semascara = @cmascara     AND
                    B.incodigo = A.secodigo

      /*====================================================================*/
      /* existe la mascara pero no esta en Tabla Serie                      */
      /*====================================================================*/
      IF @@rowcount = 0 BEGIN
   SET NOCOUNT OFF
         SELECT 'error' = 9
         RETURN 9
      END

   END

   /*=======================================================================*/
   /* el instrumento esta definido en la Tabla Serie.                       */
   /*=======================================================================*/
   IF @carchivo = 'IN' BEGIN
      SELECT       @ncodigo  = 0
      SELECT       @ncodigo  =  incodigo  ,
                   @cserie   =  inserie     ,
                   @crefnomi =  inrefnomi                                    ,
                   @cprog    =  inprog                                       ,
                   @ntipfec  =  intipfec                                     ,
                   @cseriado =  inmdse                                       ,
                   @ndiavcup =  1                                            ,
                   @npervcup =  0                                            ,
                   @ncupones =  1                                            ,
                   @nrutemi  =  inrutemi                                     ,
                   @nmonemi  =  inmonemi                                     ,
                   @ftasemi  =  0.0                                          ,
                   @nbasemi  =  inbasemi                                     ,
                   @dfecemi  =  NULL                                         ,
                   @dfecven  =  NULL                                         ,
                   @ncorte   =  0
             FROM  INSTRUMENTO
             WHERE inserie   = @cmascaux

      /*====================================================================*/
      /* existe la mascara pero no esta en Instrumento                             */
      /*====================================================================*/
      IF @ncodigo= 0 BEGIN
   SET NOCOUNT OFF
         SELECT 'error' = 8
         RETURN 8

      END

   END

   /*=======================================================================*/
   /* Problemas para el chequeo de la familia.                              */
   /*=======================================================================*/
   IF @cfamilia = NULL BEGIN
   SET NOCOUNT OFF
      SELECT 'error' = 12
      RETURN 12

   END

   /*=======================================================================*/
   /*=======================================================================*/
   IF @cfamilia = 'PTF' BEGIN

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecemi = CONVERT( DATETIME,
                                 SUBSTRING( @cinstaux, 7, 2 ) + "/01/" +
                                 SUBSTRING( @cinstaux, 9, 2 )
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecven = DATEADD( MONTH, ( @ncupones * @npervcup ), @dfecemi )


      /*====================================================================*/
      /*====================================================================*/
      IF @dfecemi = NULL OR @dfecven = NULL BEGIN
   SET NOCOUNT OFF
         SELECT 'error' = 9
         RETURN 9
      END

   /*=======================================================================*/
   /*=======================================================================*/
   END ELSE IF @cfamilia = "DPF"  OR @cfamilia = "DPR"  OR @cfamilia = "DPD"  OR
               @cfamilia = "PDBC" OR @cfamilia = "PRBC" OR @cfamilia = "CERO" OR
               @cfamilia = "ZERO" BEGIN
      SELECT @dfecemi = @dfecpro
      SELECT @dfecven = CONVERT( DATETIME,
                                 SUBSTRING( @cinstaux, 5, 2 ) + "/" +
                                 SUBSTRING( @cinstaux, 7, 2 ) + "/" +
                                 SUBSTRING( @cinstaux, 9, 2 )
                               )
   /*=======================================================================*/
   /* determina fecha de emisi¢n / vencimiento.                             */
   /*=======================================================================*/

   END ELSE BEGIN
      EXECUTE @nerror = Sp_FecEmiVen @carchivo                              ,
                                    @cmesaux                               ,
                                     @canoaux                               ,
                                     @dfecaux                               ,
                                     @crefnomi                              ,
                                     @ntipfec                               ,
                                     @ndiavcup                              ,
                                     @npervcup                              ,
                                     @ncupones                              ,
                                     @dfecemi OUTPUT                        ,
                                     @dfecven OUTPUT

      /*====================================================================*/
      /* devuelve errores desde 'Sp_FecEmiVen'                              */
      /*====================================================================*/
      IF @nerror <> 0 OR @@ERROR<>0 BEGIN
      SET NOCOUNT OFF
         SELECT 'error' = @nerror
         RETURN @nerror

      END

   END

   /*=======================================================================*/
   /* generico del emisor.                                                  */
   /*=======================================================================*/
   SELECT @cgenemi = emgeneric FROM EMISOR WHERE emrut = @nrutemi

   IF @@ROWCOUNT = 0 BEGIN
      SELECT @cgenemi = '?????'

   END

   /*=======================================================================*/
   /* nemotecnico de la moneda.                                             */
   /*=======================================================================*/
   SELECT @cnemmon = mnnemo FROM MONEDA WHERE mncodmon = @nmonemi

   IF @@rowcount = 0 BEGIN
      SELECT @cnemmon = '?????'

   END

   /*=======================================================================*/
   /* generar mascara de lectura de datos de emision.                       */
   /*=======================================================================*/
   SELECT	@cLecemi	= 'NNNNNN'

	IF @nRutemi=0
		SELECT	@cLecemi	= 'S'
	IF @nMonemi=0
		SELECT	@cLecemi	= 'S'
	IF @fTasemi=0.0 AND @cfamilia<>'PCDUF' AND @cfamilia<>'PCDUS$' AND @cfamilia<>'PRBC' AND @cfamilia<>'PDBC' AND
	   @cfamilia<>'DPR' AND @cfamilia<>'DPF' AND @cfamilia<>'DPX' AND @cfamilia<>'ECP' AND @cfamilia<>'ECU' AND @cfamilia<>'CERO'  AND @cfamilia<>'ZERO' 
		SELECT	@cLecemi	= 'S'
	IF @nBasemi=0
		SELECT	@cLecemi	= 'S'

   /*=======================================================================*/
   /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - LCHR       */
   /*=======================================================================*/
   IF @cfamilia = 'LCHR' BEGIN

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecemi = CONVERT( DATETIME,
                                 SUBSTRING( @cinstaux, 7, 2 ) + "/01/" +
                                 SUBSTRING( @cinstaux, 9, 2 )
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecven = DATEADD( MONTH, ( @ncupones * @npervcup ) , @dfecemi )

   END

   /*=======================================================================*/
   /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - PCDUF      */
   /*=======================================================================*/
   IF @cfamilia = 'PCDUF' BEGIN

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecemi = CONVERT( DATETIME,
                        SUBSTRING( @cinstaux, 7, 2 ) + "/" +
                                 SUBSTRING( @cinstaux, 5, 2 ) + "/" +
                                 SUBSTRING( @cinstaux, 9, 2)
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecven = DATEADD( MONTH, ( @ncupones * @npervcup ), @dfecemi )

   END

   /*=======================================================================*/
   /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - PDP        */
   /*=======================================================================*/
   IF @cfamilia = 'PDP' BEGIN

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cultdia = "312831303130313130313031"

      /*====================================================================*/
      /*====================================================================*/
      SELECT @nanoemi = CONVERT( INTEGER,
                                 "19" + SUBSTRING( @cinstaux, 9, 2 )
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @nmesemi = CONVERT( INTEGER, SUBSTRING( @cinstaux, 7, 2 ) )

      /*====================================================================*/
      /*====================================================================*/
      IF @nmesemi = 2 AND (@nanoemi % 4) = 0 BEGIN
         SELECT @ndiaemi = 29

      /*====================================================================*/
      /*====================================================================*/
      END ELSE BEGIN
         SELECT @ndiaemi = CONVERT( INTEGER,
                                    SUBSTRING( @cultdia, @nmesemi * 2 - 1, 2 )
                                  )

      END

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecemi = CONVERT( DATETIME,
                                 CONVERT( VARCHAR(2), @nmesemi ) + "/" +
                                 CONVERT( VARCHAR(2), @ndiaemi ) + "/" +
                                 CONVERT( CHAR(4), @nanoemi )
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecven = DATEADD( MONTH,
                                 ( @ncupones * @npervcup ),
                                 DATEADD( DAY, DATEPART( DAY, @dfecemi ) * -1,
                                          @dfecemi
                                        )
                               )

   END

   /*=======================================================================*/
   /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - BR         */
   /*=======================================================================*/
   IF @cfamilia = "BR" BEGIN

      /*====================================================================*/
      /*====================================================================*/
      SELECT @iextrae = ASCII( SUBSTRING( @cinstser,3,1 ) )

      /*====================================================================*/
      /*====================================================================*/
      IF @iextrae > 47 AND @iextrae < 58 BEGIN
         SELECT @imesemi = CONVERT( INT, CHAR( @iextrae ) )

      /*====================================================================*/
      /*====================================================================*/
      END ELSE BEGIN
         SELECT @imesemi = CONVERT( INT, @iextrae ) - 54

      END

      /*====================================================================*/
      /*====================================================================*/
      IF @imesemi > 12 BEGIN
      SET NOCOUNT OFF
         SELECT "error"=1, "desc"="serie mal ingresada"
         RETURN

      END

      /*====================================================================*/
      /*====================================================================*/
      SELECT @iextrae = ASCII( SUBSTRING( @cinstser, 4, 1 ) )

      /*====================================================================*/
      /*====================================================================*/
      IF @iextrae > 47 AND @iextrae < 58 BEGIN
         SELECT @ianoemi = 1980 + CONVERT( INT, CHAR( @iextrae ) )

      /*====================================================================*/
      /*====================================================================*/
      END ELSE BEGIN
         SELECT @ianoemi = 1980 + CONVERT( INT, @iextrae ) - 54

      END

      /*====================================================================*/
      /*====================================================================*/
      SELECT @ianovto = CONVERT( INT, SUBSTRING( @cinstser, 9, 2 ) )

      /*====================================================================*/
      /*====================================================================*/
      IF @ianovto>=0 and @ianovto<95 BEGIN
         SELECT @ianovto=2000 + @ianovto

      /*====================================================================*/
      /*====================================================================*/
      END ELSE BEGIN
         SELECT @ianovto = 1900 + @ianovto

      END

      /*====================================================================*/
      /*====================================================================*/
      SELECT @imesman = DATEPART( DAY, @dfecpro) * -1

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cfecven = SUBSTRING( @cinstser, 7, 2 ) + '/' +
                        SUBSTRING( @cinstser, 5, 2 ) + '/' +
                        CONVERT( CHAR(04), @ianovto )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cfecemi = CONVERT( CHAR(02), @imesemi ) + '/01/' +
                        CONVERT( CHAR(04), @ianoemi )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @cfecman = CONVERT( CHAR(8),
                                DATEADD( DAY, @imesman, @dfecpro ), 112
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecman = CONVERT( DATETIME,
                                 SUBSTRING( @cfecman, 5, 2) + '/01/' +
                                 SUBSTRING( @cfecman,1,4 )
                               )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecemi = CONVERT( DATETIME, @cfecemi )

      /*====================================================================*/
      /*====================================================================*/
      SELECT @dfecven = CONVERT( DATETIME, @cfecven )

--SELECT @dfecemi, @dfecven

   END

   /*=======================================================================*/
  /*=======================================================================*/
   IF @dfecemi = NULL BEGIN
      select @dfecemi = @dfecpro

   END

   /*=======================================================================*/
   /*=======================================================================*/
   IF @dfecemi > @dfecpro BEGIN
      SELECT @nerror = 12

   END

   /*=======================================================================*/
   /*=======================================================================*/
   IF @dfecven = NULL BEGIN
      SELECT  @cfecaux = SUBSTRING( @cinstser, 5 ,6 )
      EXECUTE @nerror  = Sp_EsFecdma @cfecaux, @dfecven OUTPUT

   END

   /*=======================================================================*/
   /*=======================================================================*/
   IF @dfecven <= @dfecpro BEGIN
      SELECT @nerror = 11

   END

   /*=======================================================================*/
   /* anotar el retorno.                                                    */
   /*=======================================================================*/
   SELECT 'error'    = ISNULL( @nerror, 0 )                                  ,
          'mascara'  = @cinstaux2                                            ,
          'codigo'   = @ncodigo                                              ,
          'serie'    = @cserie                                               ,
          'rutemi'   = @nrutemi                                              ,
          'monemi'   = @nmonemi                                              ,
          'tasemi'   = @ftasemi                                              ,
          'basemi'   = @nbasemi                                              ,
          'fecemi'   = CONVERT( CHAR(10), @dfecemi, 103 )                    ,
          'fecven'   = CONVERT( CHAR(10), @dfecven, 103 )                    ,
          'refnomi'  = @crefnomi                                             ,
          'genemi'   = @cgenemi                                              ,
          'nemmon'   = @cnemmon                                              ,
          'corte'    = @ncorte                                               ,
          'seriado'  = @cseriado                                             ,
          'lecemi'   = @clecemi                                              ,
          'fecpro'   = CONVERT( CHAR(10), @dfecpro, 103 )

   /*=======================================================================*/
   /*=======================================================================*/
SET NOCOUNT OFF
SELECT "OK"
   RETURN 0

END
 













GO
