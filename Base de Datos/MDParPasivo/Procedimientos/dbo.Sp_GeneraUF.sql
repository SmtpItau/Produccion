USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GeneraUF]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_GeneraUF]
       (
         @nmes     INTEGER ,
         @nann     INTEGER ,
         @nvalipc  FLOAT   ,
         @valuf    FLOAT   ,
         @fecha    DATETIME
       )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @dfecha  DATETIME
   DECLARE @mes     CHAR(02)
   DECLARE @mest    CHAR(02)
   DECLARE @mesa    CHAR(02)
   DECLARE @dfini   DATETIME
   DECLARE @dffin   DATETIME
   DECLARE @xfipc   CHAR(10)
   DECLARE @xfecha  DATETIME
   DECLARE @nufini  FLOAT
   DECLARE @nddias  INTEGER
   DECLARE @nvaluf  FLOAT
   DECLARE @ntotal  FLOAT
   DECLARE @ntotal1 FLOAT
   DECLARE @nfactor FLOAT
   DECLARE @a       INTEGER
   DECLARE @xmes    CHAR(02)
   DECLARE @xdia    CHAR(02)
   DECLARE @dfec1   CHAR(08)
   DECLARE @dfec2   CHAR(08)

   /*=======================================================================*/
   /*=======================================================================*/
     SELECT @dfecha = @fecha
   /*=======================================================================*/
   /* Fecha de Inicio Mes Actual                                            */
   /*=======================================================================*/
   IF @nmes < 10 BEGIN
      SELECT @mes = RTRIM('0' + CONVERT( CHAR(1), @nmes ) )

   END ELSE BEGIN
      SELECT @mes = RTRIM( CONVERT(CHAR(2), @nmes ) )

   END

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT @dfec1 = @dfecha

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT @dfec2 = CONVERT( CHAR(04), @nann ) + @mes + '09'

--   IF @dfec2 <= @dfec1 BEGIN
--      SELECT 'Estado' = '01',
--             'Fecha' = CONVERT( CHAR(10), @dfecha, 103 ),
--             'Valor' = 0.0
--      RETURN
--
--   END

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT @dfini = CONVERT( CHAR(4), @nann ) + @mes + '09'

   /*=======================================================================*/
   /* Fecha de Termino Mes Termino                                          */
   /*=======================================================================*/
   IF @nmes = 12 BEGIN
      SELECT @mest  = '01'
      SELECT @dffin = CONVERT( CHAR(4), @nann + 1 ) + @mest + '09'
   END ELSE BEGIN
      IF @nmes >= 9 BEGIN
         SELECT @mest = RTRIM( CONVERT( CHAR(2), @nmes + 1))
      END ELSE BEGIN
         SELECT @mest = '0' + RTRIM( CONVERT( CHAR(1), @nmes + 1 ) )
      END
      SELECT @dffin = CONVERT( CHAR(4), @nann ) + @mest + '09'
   END

   /*=======================================================================*/
   /* Fecha de I.P.C. Mes Anterior                                          */
   /*=======================================================================*/
   IF @nmes = 1 BEGIN
      SELECT @mesa = '12'
   END ELSE BEGIN
      SELECT @mesa = CONVERT( CHAR(2), @nmes - 1 )
   END


   IF DATALENGTH( RTRIM( @mesa ) ) = 1 BEGIN
      SELECT @mesa = '0' + @mesa
   END

   IF @nmes = 1 BEGIN
      SELECT @xfipc = CONVERT( CHAR(4), @nann - 1 ) + @mesa + '01'
   END ELSE BEGIN
      SELECT @xfipc = CONVERT( CHAR(4), @nann ) + @mesa + '01'

   END

   /*=======================================================================*/
   /* Buscar Valor UF de Fecha de Inicio                                    */
   /*=======================================================================*/
  SELECT @nufini = @valuf

   IF @nufini = 0 OR @nufini = NULL BEGIN
      SELECT 'Estado' = '02',
             'Fecha' = CONVERT( CHAR(10), @dfecha, 103 ),
             'Valor' = 0.0
      SET NOCOUNT OFF
      RETURN
   END

   /*=======================================================================*/
   /* Grabacion de una UF                                                   */
   /*=======================================================================*/
   SELECT @xfecha  = DATEADD( DAY, 1, @dfini )
   SELECT @nddias  = DATEDIFF( DAY, @xfecha, @dffin ) + 1
   EXECUTE Sp_Div @nvalipc, 100.0, @ntotal OUTPUT
   SELECT @ntotal = @ntotal + 1
   EXECUTE Sp_Div 1 , @nddias, @ntotal1 OUTPUT
   SELECT @nfactor = POWER( @ntotal, @ntotal1 )

   SELECT @a = 0
   WHILE @a < @nddias BEGIN

      SELECT @a = @a + 1

      SELECT @nvaluf = ROUND( @nufini * ( POWER ( @nfactor, @a ) ), 2 )

      IF EXISTS(        
          SELECT       vmvalor
                        FROM  VALOR_MONEDA
                        WHERE vmcodigo = 998 AND vmfecha  = @xfecha
	) BEGIN
	  UPDATE       VALOR_MONEDA
        	SET   vmvalor = @nvaluf
                WHERE vmcodigo = 998 AND vmfecha  = @xfecha

      END ELSE BEGIN

         INSERT INTO VALOR_MONEDA   ( vmcodigo, vmvalor, vmfecha )
                VALUES              (      998, @nvaluf, @xfecha )

      END

      SELECT @xfecha = DATEADD( DAY, 1, @xfecha )

   END

   /*=======================================================================*/
   /* Grabar I.P.C.                                                         */
   /*=======================================================================*/
   IF EXISTS(
              SELECT       vmvalor
                     FROM  VALOR_MONEDA
                     WHERE vmcodigo  = 500 AND
                           vmfecha   = @xfipc 
--                         vmvalor  <> 0
            ) BEGIN
      UPDATE       VALOR_MONEDA
             SET   vmvalor = @nvalipc
             WHERE vmcodigo = 500 AND vmfecha  = @xfipc

   /*=======================================================================*/
   /*=======================================================================*/
   END ELSE BEGIN
      INSERT INTO VALOR_MONEDA   ( vmcodigo, vmvalor, vmfecha )
             VALUES              (      500, @nvalipc, @xfipc )

   END

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       'Estado' = 'SI',
                'Fecha'  = CONVERT( CHAR(10), vmfecha, 103 ),
                'Valor'  = vmvalor
          FROM  VALOR_MONEDA
          WHERE vmcodigo = 998 AND vmfecha > @dfini AND vmfecha <= @dffin
          ORDER BY vmfecha

   /*=======================================================================*/
   /*=======================================================================*/
   SET NOCOUNT OFF
   RETURN

END




GO
