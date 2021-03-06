USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERVENLIQCON1]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERVENLIQCON1]  ( @numoper NUMERIC(08)  )
AS
BEGIN
SET NOCOUNT ON
   DECLARE @cfecha     DATETIME
   SELECT @cfecha = acfecproc
   FROM   MFAC
          SELECT   a.canumoper                                  ,                  
                   CONVERT ( CHAR ( 10 ), @cfecha  ,103)         ,
                   CONVERT ( CHAR ( 10 ), a.cafecha, 103 )      ,
                   c.acnomprop                                  ,
                   isnull(b.clnombre,' ')                    ,
                   CASE WHEN  a.caantici = 'A' THEN  a.camtoliq  else  a.camtocomp   end   ,
                   a.catipmoda                                  ,
                   a.catipoper                                ,
                   a.camtomon1                                ,
                   ISNULL(glosa,' ' )                         ,
                   a.cacodmon1                                ,
                   a.cacodmon2                                  
                  
        /*  FROM     MFCA a,
                   VIEW_CLIENTE b,
                   MFAC c,
                   VIEW_FORMA_DE_PAGO d
           WHERE    a.canumoper = @numoper   AND
                    CONVERT( CHAR(10), a.cafecvcto, 103 )  = CONVERT( CHAR(10), c.acfecproc, 103 )  AND
                   (a.cacodigo *= b.clrut    AND
                    a.cacodcli *= b.clcodigo) and
                    a.cafpagomn *= d.codigo 
          ORDER BY a.canumoper */


		  --Rq 7619
	  FROM     MFCA a LEFT OUTER JOIN  VIEW_CLIENTE b ON (a.cacodigo = b.clrut AND a.cacodcli = b.clcodigo) 
						  LEFT OUTER JOIN  VIEW_FORMA_DE_PAGO d ON  a.cafpagomn = d.codigo, 
                   MFAC c
          WHERE    a.canumoper = @numoper   AND
                    CONVERT( CHAR(10), a.cafecvcto, 103 )  = CONVERT( CHAR(10), c.acfecproc, 103 )
          ORDER BY a.canumoper
   SET NOCOUNT OFF
END

GO
