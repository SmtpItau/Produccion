USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_APODERADO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_CLIENTE_APODERADO] 
AS
   SELECT aprutcli 
         ,apdvcli 
         ,apcodcli 
         ,aprutapo 
         ,apdvapo 
         ,apnombre 
         ,apcargo 
         ,apfono
         ,apemail
   FROM BACPARAMSUDA..CLIENTE_APODERADO










GO
