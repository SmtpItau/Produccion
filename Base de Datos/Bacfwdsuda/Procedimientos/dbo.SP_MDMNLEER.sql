USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMNLEER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_MDMNLEER]
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   DECLARE @dfecproc    DATETIME
   /*=======================================================================*/
   SELECT @dfecproc = acfecproc FROM MFAC
   /*=======================================================================*/
   SELECT       mncodmon                                  ,
                mnglosa                                   ,
                mnnemo                                    ,
                'mnfactor' = ISNULL( mnfactor, 0 )   ,
                mnredondeo                                ,
                mncodbanco                                ,
                mncodsuper                                ,
                mnbase                                    ,
                mnrefusd  = isnull( mnrefusd, 0 )         ,
                mnlocal                                   ,
                mnextranj                                 ,
                mnvalor                                   ,
                mnrefmerc = ISNULL( mnrefmerc, 0 )  ,
                mningval                                  ,
                'mnvalor' = ISNULL( vmvalor, 0 )    ,
                mnmx                                ,
                mnrrda 
          /*FROM  VIEW_MONEDA ,
                VIEW_VALOR_MONEDA
          WHERE mncodmon  *= vmcodigo                  AND
                vmfecha    = @dfecproc */


    FROM  VIEW_MONEDA LEFT OUTER JOIN VIEW_VALOR_MONEDA ON  mncodmon = vmcodigo 
    and  vmfecha  = @dfecproc
   /*=======================================================================*/
  SET NOCOUNT OFF
END


GO
