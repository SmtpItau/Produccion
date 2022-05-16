USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_APODERADO]    Script Date: 13-05-2022 10:34:12 ******/
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
	 ,fecha_escritura
   FROM BACPARAMSUDA..CLIENTE_APODERADO

GO
