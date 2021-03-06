USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONEDABIDASK]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MONEDABIDASK]
AS 
BEGIN
   SET NOCOUNT ON
   SELECT DISTINCT MFCA.cacodmon1   ,
   a.mnglosa  ,
                'valor1'=0  ,
                'valor2'=0  ,
                a.mnfactor
   FROM  MFCA    ,
  VIEW_PERIODO_TASA_BIDASK ,
                VIEW_MONEDA a
   WHERE MFCA.cacodmon1    = a.mncodmon     AND
                a.mnmx            = 'C'            AND
                a.mncodmon       <> 13
   SET NOCOUNT OFF
END

GO
