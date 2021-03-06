USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CreaPRC]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_CreaPRC]
   (   @cInstser CHAR(10)
   )
AS
BEGIN

   SET DATEFORMAT DMY

   DECLARE @nTasemi   FLOAT
   DECLARE @nCupones  INTEGER
   DECLARE @nCortes   INTEGER
   DECLARE @nTasper   FLOAT
   DECLARE @nFlujo    FLOAT
   DECLARE @nSalaux   FLOAT
   DECLARE @dFecemi   DATETIME
   DECLARE @Sa_aux    FLOAT
   DECLARE @nContador INTEGER
   DECLARE @dFecaux1  DATETIME  
   DECLARE @dFecaux2  DATETIME
   DECLARE @nDias     INTEGER
   DECLARE @Ft        DATETIME
   DECLARE @Fl        FLOAT
   DECLARE @Am        FLOAT
   DECLARE @It        FLOAT
   DECLARE @Sa        FLOAT
   DECLARE @dFecven   DATETIME
   DECLARE @Decs      INTEGER
   DECLARE @jVan      FLOAT
   DECLARE @tkl       FLOAT
   DECLARE @me        FLOAT
   DECLARE @ma        FLOAT
   DECLARE @cMascara  CHAR(10)
   DECLARE @ut        FLOAT
   DECLARE @nTera     FLOAT
   DECLARE @De        FLOAT
   DECLARE @x1        FLOAT
   DECLARE @x2        FLOAT

   SET NOCOUNT ON

   SELECT @nTasemi  = CASE WHEN SUBSTRING(@cInstser,5,1) = '1' THEN 6.5
                           WHEN SUBSTRING(@cInstser,5,1) = '2' THEN 5.0
                           WHEN SUBSTRING(@cInstser,5,1) = '3' THEN 5.0
                           WHEN SUBSTRING(@cInstser,5,1) = '4' THEN 6.5
                           WHEN SUBSTRING(@cInstser,5,1) = '5' THEN 6.5
                           WHEN SUBSTRING(@cInstser,5,1) = '6' THEN 6.5
                           WHEN SUBSTRING(@cInstser,5,1) = '7' THEN 6.5
                      END

   SELECT @nCupones = CASE WHEN SUBSTRING(@cInstser,5,1) = '1' THEN 20
                           WHEN SUBSTRING(@cInstser,5,1) = '2' THEN 8
                           WHEN SUBSTRING(@cInstser,5,1) = '3' THEN 12
                           WHEN SUBSTRING(@cInstser,5,1) = '4' THEN 16
                           WHEN SUBSTRING(@cInstser,5,1) = '5' THEN 24
                           WHEN SUBSTRING(@cInstser,5,1) = '6' THEN 28
                           WHEN SUBSTRING(@cInstser,5,1) = '7' THEN 40
                      END

   SELECT @nCortes =  CASE WHEN SUBSTRING(@cInstser,6,1) = 'A' THEN 500.0
                           WHEN SUBSTRING(@cInstser,6,1) = 'B' THEN 1000.0
                           WHEN SUBSTRING(@cInstser,6,1) = 'C' THEN 5000.0
                           WHEN SUBSTRING(@cInstser,6,1) = 'D' THEN 10000.0
                      END

   IF ISDATE('01/' + SUBSTRING(@cInstser, 7, 2) + '/' + SUBSTRING(@cInstser, 9, 2)) = 1
   BEGIN

      SELECT @dFecemi  = '01/' + SUBSTRING(@cInstser, 7, 2) + '/' + SUBSTRING(@cInstser, 9, 2)

   END ELSE BEGIN

      SET NOCOUNT OFF
      SELECT 'OK'
      RETURN 15

   END    

   SELECT @nTasper  = POWER( 1.0 + @nTasemi / 100.0, 0.5 ) -1.0
   SELECT @nFlujo   = ROUND(@nCortes * @nTasper * POWER((1 + @nTasper), @nCupones) / (POWER(1 + @nTasper, @nCupones) - 1), 2)
   SELECT @nSalaux  = @nCortes
   SELECT @dFecaux1 = @dFecemi
   SELECT @Sa_aux   = 100.0

   DELETE TABLA_DESARROLLO WHERE tdmascara = @cInstser

   SELECT @nContador = 1
 
   WHILE @nContador <= @nCupones
   BEGIN

      SELECT @dFecaux2 = DATEADD(DAY, 190, @dFecaux1)
      SELECT @Ft       = DATEADD(DAY, (DATEPART(DAY, @dFecaux2) - 1 ) * -1, @dFecaux2)
      SELECT @nDias    = DATEDIFF(DAY, @dFecaux1, @Ft)
      SELECT @dFecaux1 = @Ft
      SELECT @De       = DATEDIFF(DAY, @dFecemi, @Ft) / 365.0
      SELECT @Fl       = @nFlujo
      SELECT @It       = ROUND((POWER(1 + @nTasemi / 100.0, @nDias / 360.0) -1) * @nSalaux, 2)
      SELECT @Am       = @Fl - @It
      SELECT @Sa       = @nSalaux - @Am
      SELECT @nSalaux  = @Sa
      SELECT @It       = @It / @nCortes * 100.0

      IF @nContador = @nCupones
      BEGIN

         SELECT @Am = @Sa_aux
         SELECT @Fl = @Am + @It
         SELECT @Sa = 0.0

      END ELSE BEGIN

         SELECT @Am = @Am / @nCortes * 100.0
         SELECT @Fl = @Fl / @nCortes * 100.0
         SELECT @Sa = @Sa / @nCortes * 100.0

 END

      INSERT INTO TABLA_DESARROLLO
         (   tdmascara
         ,   tdcupon
         ,   tdfecven
         ,   tdinteres
         ,   tdamort
         ,   tdflujo
         ,   tdsaldo
         ,   spread_tasa_variable
         )
      VALUES
         (   @cInstser
         ,   @nContador
         ,   @Ft
         ,   @It
         ,   @Am
         ,   @Fl
         ,   @Sa
         ,   0
         )

      SELECT @Sa_aux = @Sa
      SELECT @nContador = @nContador + 1

   END

   SELECT @dFecven = @Ft

   -- CALCULO DE LA TERA
   ---------------------
   SELECT @Decs  = 8
   SELECT @tkl   = 6.5
   SELECT @ut    = @tkl
   SELECT @me    = 0.0
   SELECT @ma    = 15
   SELECT @nTera = 0.0

   SELECT @nContador = 1

   WHILE @nContador <= 80
   BEGIN

      -- Van PRC --------
      SELECT @jVan = 0.0
 
      SELECT @jVan = SUM(tdflujo / POWER(1.0 + @tkl / 100.0, DATEDIFF(DAY, @dfecemi, tdfecven) / 365.0))
      FROM   TABLA_DESARROLLO
      WHERE  tdmascara = @cInstser

      ------------------
      SELECT @ut = ROUND(@tkl, @decs)

      IF @jvan < 100.0 SELECT @ma = @tkl ELSE SELECT @me = @tkl

      SELECT @tkl = (@ma - @me) / 2.0 + @me

      IF @ut = ROUND(@tkl, @decs)
      BEGIN

         SELECT @nTera = ROUND(@ut, 4)
         BREAK

      END

   END

   /* AGREGADO POR KF EN SERIE -- TABLA_DESARROLLO */

   SELECT tdmascara
      ,   tdcupon
      ,   tdfecven
      ,   tdinteres
      ,   tdamort
      ,   tdflujo
      ,   tdsaldo
      ,   spread_tasa_variable
   INTO   #TD
   FROM   TABLA_DESARROLLO
   WHERE  tdmascara = @cInstser

   DELETE TABLA_DESARROLLO
   WHERE tdmascara = @cInstser

   /* FIN */

   DELETE SERIE WHERE semascara = @cInstser

   INSERT INTO SERIE
      (   secodigo
      ,   semascara
      ,   serutemi
      ,   setasemi
      ,   sebasemi
      ,   semonemi
      ,   setera
      ,   setipamort
      ,   seplazo
      ,   sepervcup
      ,   secupones
      ,   sefecven
      ,   sefecemi
      ,   seserie
      ,   sediavcup
      ,   senumamort
      ,   sedecs
      ,   secorte
      ,   setotalemitido
      )
   VALUES
      (   4
      ,   @cInstser
      ,   97029000
      ,   @nTasemi
      ,   365
      ,   998
      ,   @nTera
      ,   1
      ,   @nCupones / 2
      ,   6
      ,   @nCupones
      ,   @dFecven
      ,   @dFecemi
      ,   @cInstser
      ,   1
      ,   @nCupones
      ,   3
      ,   @nCortes
      ,   0
      )

   /* AGREGADO POR KF EN SERIE -- TABLA_DESARROLLO */

   INSERT INTO TABLA_DESARROLLO 
   SELECT tdmascara
      ,   tdcupon
      ,   tdfecven
      ,   tdinteres
      ,   tdamort
      ,   tdflujo
      ,   tdsaldo
      ,   spread_tasa_variable
   FROM #TD

   /* FIN */

   SET NOCOUNT OFF

   SELECT 'OK'

END



GO
