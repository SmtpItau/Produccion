USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_TBVENCIMIENTOSFORWARD]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TBVENCIMIENTOSFORWARD]
AS
   SELECT 
 moentidad     ,
 motipmer  ,
 motipope  ,
 morutcli     ,
 mocodcli     ,
 mocodmon  ,
 mocodcnv  ,
 momonmo         ,     
 moticam         ,     
 moparme         ,     
 moprecio        ,     
 moussme         ,     
 momonpe  ,
 moentre  ,
 morecib  ,
 movaluta1       ,           
 movaluta2       ,           
 mooper      ,
 mofech          ,
 mohora    ,
 moterm       ,
 motipcar  ,
 monumfut    ,
 mofecini 
     FROM BACCAMSUDA..TBVENCIMIENTOSFORWARD

GO
