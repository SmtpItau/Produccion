USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSICION_SPOT]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_POSICION_SPOT]
AS
BEGIN
 SET NOCOUNT ON
 SELECT  acposini  ,
         acposic   ,
         acpmeco   ,
         acpmeve   ,
         actotco   ,
         actotve   ,
         acutili   ,
         acpreini    ,
         acprecie  ,
         0           ,
         achedgeinicialfuturo ,
         achedgeinicialspot ,
         achedgeactualfuturo ,
         achedgeactualspot ,
         achedgeprecioinicial ,
         achedgeutilidad  ,
         acultpta  ,
         acultmon  ,
         acultpre  ,
         accoscomp ,
         accosvent ,
	 achedgevctofuturo		

         FROM  view_meac_spot
 SET NOCOUNT OFF
END

GO
