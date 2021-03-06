USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDVMLEER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDVMLEER]
       (
        @dFecpro1  CHAR(10)
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @dFecpro  DATETIME
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT @dFecpro  = CONVERT(DATETIME,@dFecpro1)
   /*=======================================================================*/
   /*=======================================================================*/
   CREATE TABLE #tmpvaloresmoneda
          (
            tmpcodigo       NUMERIC(04)  NOT NULL,
            tmpglosa        CHAR(40)     NOT NULL,
            tmpvalor        FLOAT        NOT NULL,
            tmpptacmp       FLOAT        NOT NULL,
            tmpptavta       FLOAT        NOT NULL
          )
   /*=======================================================================*/
   /*=======================================================================*/
   INSERT INTO   #tmpvaloresmoneda
          SELECT       mncodmon,
                       mnglosa,
                       0,
                       0,
                       0 
                 FROM  VIEW_MONEDA
                 WHERE  MNREFMERC='1' or mncodmon=998 
                 --mningval = 2
   /*=======================================================================*/
   /*=======================================================================*/
   UPDATE        #tmpvaloresmoneda
          SET    tmpvalor  = vmvalor,
                 tmpptacmp = vmptacmp,
                 tmpptavta = vmptavta
          FROM   VIEW_VALOR_MONEDA
          WHERE  tmpcodigo = vmcodigo  AND
                 vmfecha  = @dfecpro1
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT      tmpcodigo,
               tmpglosa,
               tmpvalor,
               tmpptacmp,
               tmpptavta 
          FROM #tmpvaloresmoneda
   /*=======================================================================*/
   /*=======================================================================*/
   SET NOCOUNT OFF
END

GO
