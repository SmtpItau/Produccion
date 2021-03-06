USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCEOPERACIONES]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_CALCEOPERACIONES]
       (
        @noperacion  NUMERIC(10)
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @nnumoper    NUMERIC(10)
   DECLARE @nnumero     NUMERIC(10)
   DECLARE @nmtocompra  NUMERIC(21,4)
   DECLARE @nmtoventa   NUMERIC(21,4)
   DECLARE @dfecvcto    DATETIME
   DECLARE @ctipoper    CHAR(01)
   DECLARE @ncodpos     NUMERIC(03)
   DECLARE @ncodmda     NUMERIC(03)
   DECLARE @ntotregist  INT
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       @dfecvcto = cafecvcto,
                @ncodpos  = cacodpos1,
                @ncodmda  = cacodmon2,
                @ctipoper = catipoper
          FROM  MFCA
          WHERE canumoper = @noperacion
  
   /*=======================================================================*/
   /*=======================================================================*/
   CREATE TABLE tmpcalces
          (
           tmpnumoper    NUMERIC(10)    NOT NULL,
           tmpnombre     CHAR(40)       NOT NULL,
           tmptipoper    CHAR(01)       NOT NULL,
           tmpfecvcto    CHAR(10)       NOT NULL,
           tmpnemo       CHAR(08)       NOT NULL,
           tmpmonto      NUMERIC(24,4)  NOT NULL,
           tmpglosa      CHAR(40)       NOT NULL,
           tmpsaldo      NUMERIC(24,4)  NOT NULL,
		   tmpcacodpos1  NUMERIC(10)    NOT NULL,
		   tmpcacalvtadol NUMERIC(10)    NOT NULL   --> PRD 21645
          )
   /*=======================================================================*/
   /*=======================================================================*/
   INSERT INTO tmpcalces
          SELECT       a.canumoper                                ,
                       b.clnombre                                 ,
                       a.catipoper                                ,
                       CONVERT( CHAR(10), a.cafecvcto, 103 )      ,
                       c.mnnemo                                   ,
                       a.camtomon1                                ,
                       d.tbglosa                                  ,
                       a.camtomon1								  ,
					   a.cacodpos1								  ,
					   a.cacalvtadol                        --> PRD 21645      
                 FROM  MFCA   a,
                       VIEW_CLIENTE b,
                       VIEW_MONEDA      c,
                       VIEW_TABLA_GENERAL_DETALLE  d
                 WHERE a.cacodigo   = b.clrut        AND
                       a.cacodmon2  = c.mncodmon     AND
                       d.tbcateg   = 250             AND
                       convert(numeric(6),d.tbcodigo1)   = a.cacodpos1    AND
                       a.cacodpos1  = @ncodpos       AND
                       a.cacodmon2  = @ncodmda       AND
                       a.catipoper <> @ctipoper      AND
                       a.cafecvcto  = @dfecvcto
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT @ntotregist = COUNT(tmpmonto) FROM tmpcalces
   
   /*=======================================================================*/
   /*=======================================================================*/
   IF @ntotregist = 0 BEGIN
      /*====================================================================*/
      /*====================================================================*/
      SELECT '0', 'No existen operaciones en cartera'
      /*====================================================================*/
      /*====================================================================*/
      DROP TABLE tmpcalces
 
      /*====================================================================*/
      /*====================================================================*/
      RETURN 0
   END
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT @nnumero  = 0
   /*=======================================================================*/
   /*=======================================================================*/
   WHILE (1 = 1) BEGIN
      /*====================================================================*/
      /*====================================================================*/
      SELECT @nnumoper = 0
      /*====================================================================*/
      /*====================================================================*/
      SET ROWCOUNT 1
      SELECT          @nnumoper = canumoper
             FROM     MFCA
             WHERE    cacodpos1  = @ncodpos       AND
                      cacodmon2  = @ncodmda       AND
                      catipoper <> @ctipoper      AND
                      cafecvcto  = @dfecvcto      AND 
                      canumoper  > @nnumero
             ORDER BY canumoper
      SET ROWCOUNT 0
      /*====================================================================*/
      /*====================================================================*/
      IF @nnumoper = 0 BEGIN
         BREAK
  
      END
      /*====================================================================*/
      /*====================================================================*/
      SELECT @nnumero = @nnumoper
      SELECT @nmtocompra = 0.0
      SELECT @nmtoventa  = 0.0
      /*====================================================================*/
      /* Sumatoria de los calces que posee la operaci«n                     */
      /*====================================================================*/
      IF @ctipoper = 'C' OR @ctipoper = 'O' BEGIN
 
         /*=================================================================*/
         /*=================================================================*/
         SELECT       @nmtocompra = SUM( ccmonto ) 
                FROM  MFCC
                WHERE ccopevta    = @nnumoper
         /*=================================================================*/
         /*=================================================================*/
         IF @nmtocompra <> NULL BEGIN
            /*==============================================================*/
            /*==============================================================*/
            UPDATE       tmpcalces
                   SET   tmpsaldo     = tmpmonto - ISNULL( @nmtocompra, 0 )
                   WHERE tmpnumoper   = @nnumoper
         END
      /*====================================================================*/
      /*====================================================================*/
      END ELSE IF @ctipoper = 'V' OR @ctipoper = 'A' BEGIN
         /*=================================================================*/
         /*=================================================================*/
         SELECT       @nmtoventa  = SUM( ccmonto ) 
                FROM  MFCC
                WHERE ccopecmp    = @nnumoper
         /*=================================================================*/
         /*=================================================================*/
         IF @nmtoventa <> NULL BEGIN
            /*==============================================================*/
            /*==============================================================*/
            UPDATE       tmpcalces
                   SET   tmpsaldo     = tmpmonto - ISNULL( @nmtoventa, 0 )
                   WHERE tmpnumoper   = @nnumoper
         END
      END
   END
   /*=======================================================================*/
   /* Eliminaci«n  de todas  aquellas operaciones que  tengan saldo  0 y no */
   /* esten enlazada con la operaci«n a consultar.                          */
   /*=======================================================================*/
   IF @ctipoper = 'C' OR @ctipoper = 'O' BEGIN
      DELETE       tmpcalces
             WHERE tmpsaldo = 0 AND 
                   NOT EXISTS( 
                              SELECT       ccusuario
                                     FROM  MFCC
                                     WHERE tmpnumoper = ccopevta  AND
                                           ccopecmp   = @noperacion
                             )
   /*=======================================================================*/
   /*=======================================================================*/
   END ELSE IF @ctipoper = 'V' OR @ctipoper = 'A' BEGIN
      DELETE       tmpcalces 
             WHERE tmpsaldo = 0 AND 
                   NOT EXISTS( 
                              SELECT       ccusuario
                                     FROM  MFCC
                                     WHERE ccopecmp = tmpnumoper  AND
                                           ccopevta = @noperacion
                             )
   END
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT          'OK',
                   tmpnumoper,
                   tmpnombre,
                   tmptipoper,
                   tmpfecvcto,
                   tmpnemo,
                   tmpmonto,
                   tmpglosa,
                   tmpsaldo,
				   tmpcacodpos1,
				   tmpcacalvtadol           --> PRD 21645                     
          FROM     tmpcalces
          ORDER BY tmpnumoper
   /*=======================================================================*/
   /*=======================================================================*/
   DROP TABLE tmpcalces
   /*=======================================================================*/
   /*=======================================================================*/
 set nocount off  
 RETURN 0
END
GO
