USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_MFBIDASK]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MFBIDASK]
AS
   SELECT
        a.*     ,
 b.*    ,
 bidcal  = CASE  WHEN a.factor IS NULL
       THEN 0 
    ELSE a.bid /  CASE c.mnfactor WHEN 0 THEN 1 ELSE c.mnfactor END
     END,
 askcal  = CASE  WHEN a.factor IS NULL
    THEN 0
    ELSE a.ask / CASE c.mnfactor WHEN 0 THEN 1 ELSE c.mnfactor END
    END,
 fechacal = CASE  b.petipo WHEN 'D' THEN DATEADD( dd , b.penumero , a.fecha ) 
      WHEN 'M' THEN DATEADD( mm , b.penumero , a.fecha ) 
      WHEN 'Y' THEN DATEADD( yy , b.penumero , a.fecha ) 
                                  ELSE GETDATE()
      END,
 plazocal = CASE  b.petipo WHEN 'D' THEN DATEDIFF( dd, a.fecha , DATEADD( dd , b.penumero , a.fecha ) )
             WHEN 'M' THEN DATEDIFF( dd, a.fecha , DATEADD( mm , b.penumero , a.fecha ) )
                                  WHEN 'Y' THEN DATEDIFF( dd, a.fecha , DATEADD( yy , b.penumero , a.fecha ) )
                                  ELSE 0
      END
   FROM MFBIDASK a  ,
 BACPARAMSUDA..PERIODO_TASA_BIDASK b,
 VIEW_MONEDA c
   WHERE b.pecodigo = a.periodo AND
  c.mncodmon = a.moneda

GO
