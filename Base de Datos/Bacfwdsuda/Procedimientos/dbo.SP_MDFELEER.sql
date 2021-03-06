USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDFELEER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDFELEER] 
       (
        @nano     NUMERIC(04,0) ,
        @cplaza   NUMERIC(03,0)
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT       feano,
                feplaza,
                feene,
                fefeb,
                femar, 
                feabr,
                femay,
                fejun,
                fejul,
                feago, 
                fesep,
                feoct,
                fenov,
                fedic
          FROM  VIEW_FERIADO
          WHERE feano   = @nano       AND   
                feplaza = @cplaza 
    /*======================================================================*/
    /*======================================================================*/
   SET NOCOUNT OFF
   
END

GO
