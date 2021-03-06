USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BSKFECHAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BSKFECHAS]
AS 
BEGIN
 DECLARE @dfecbaskie  DATETIME ,
  @dfechoybactrader DATETIME ,
  @dfechoybaccambios DATETIME ,
  @dfecantbactrader DATETIME ,
  @dfecantbaccambios DATETIME 
     /* Saco fecha de BACTRADER  
 =======================  */
 SELECT 
  @dfecbaskie   =  acfecproc ,
  @dfechoybactrader  =  acfecproc ,
  @dfecantbactrader  =  acfecante
 FROM 
  MDAC
     /* Saco fecha de BACCAMBIOS  
 ========================  */
 SELECT 
  @dfechoybaccambios  =  acfecpro ,
  @dfecantbaccambios =  acfecpro 
 FROM 
  VIEW_MEAC
                  
     /* Verificaci¢n de sistemas BACTRADER y BACCAMBIOS 
 =============================================== */ 
 IF  @dfechoybactrader <> @dfechoybaccambios BEGIN
  SELECT 'ERROR' = 'SIS', 'DESC'= 'FECHAS DE BAC-TRADER Y BAC-CAMBIOS, SON DISTINTAS, VERIFIQUE',
  'fechoybaskie'   = @dfecbaskie  ,
  'fechoybactrader'   = @dfechoybactrader ,
  'fechoybaccambios' = @dfechoybaccambios ,
  'fecantbactrader' = @dfecantbactrader ,
  'fecantbaccambios' = @dfecantbaccambios 
  RETURN
 END
 IF  @dfechoybactrader <> @dfecbaskie BEGIN  
  SELECT 'ERROR' = 'SIN', 'DESCRIPCION'= 'FECHAS DE BAC-TRADER Y BASKIE, SON DISTINTAS, DEBE REALIZAR FIN DE D¡A EN BASKIE',
  'fechoybaskie'   = @dfecbaskie  ,
  'fechoybactrader'   = @dfechoybactrader ,
  'fechoybaccambios' = @dfechoybaccambios ,
  'fecantbactrader' = @dfecantbactrader ,
  'fecantbaccambios' = @dfecantbaccambios 
  RETURN
 END
 IF  @dfechoybaccambios <> @dfecbaskie BEGIN  
  SELECT 'ERROR' = 'SIN', 'DESCRIPCION'= 'FECHAS DE BAC-CAMBIOS Y BASKIE, SON DISTINTAS, DEBE REALIZAR FIN DE D¡A EN BASKIE',
  'fechoybaskie'   = @dfecbaskie  ,
  'fechoybactrader'   = @dfechoybactrader ,
  'fechoybaccambios' = @dfechoybaccambios ,
  'fecantbactrader' = @dfecantbactrader ,
  'fecantbaccambios' = @dfecantbaccambios 
  RETURN
 END
 SELECT 
  'ERROR'     = 'NOC'   ,
  'descripcion'  = 'OK'   , 
  'fechoybaskie'   = @dfecbaskie  ,
  'fechoybactrader'   = @dfechoybactrader ,
  'fechoybaccambios' = @dfechoybaccambios ,
  'fecantbactrader' = @dfecantbactrader ,
  'fecantbaccambios' = @dfecantbaccambios 
  
END
/*
EXECUTE SP_BSKFECHAS
*/

GO
