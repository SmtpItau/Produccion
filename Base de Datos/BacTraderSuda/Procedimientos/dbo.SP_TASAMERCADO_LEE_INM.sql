USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASAMERCADO_LEE_INM]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TASAMERCADO_LEE_INM]
AS
BEGIN
 SET nocount on
 select  incodigo,
  inserie ,
  inrutemi,
  case when incodigo = 20 then 'OTROS' else '' end as generico
 into #Temp
 from mdin   -- definicion de instrumentos   bmdd_pra..tpra_inm
 where incodigo < 400
 and incodigo > 2
 and incodigo <> 5
 and incodigo <> 8 
 and  incodigo <> 13
 
 --actualizo generico del emisor
  update #temp
 set generico = EMGENERIC   --generico
 from mdem --bmdd_pra..tpra_emi
 where inrutemi = emrut
 --inserto registro en duro 
 insert into #Temp
 Select incodigo ,
  inserie  ,
  inrutemi ,
  'BECH' 
 from  mdin --bmdd_pra..tpra_inm
 where incodigo = 20
 
 SELECT incodigo,
  inserie ,
  generico,
  generico
 FROM #Temp
 Order by Inserie
  
 SET nocount OFF
END

GO
