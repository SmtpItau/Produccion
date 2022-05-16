USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONESVB2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[SP_OPERACIONESVB2]
As
Begin
Select  MOCODMON,
 MOTIPMER,
 MOTIPOPE,
 MOMONMO,
 MOTICAM,
 MONOMCLI,
 MORUTCLI,
 MOCODCLI,
 MOENTIDAD,
 MOOPER,
 MOTERM,
 MOHORA,
 MOFECH
from MEMO where mocodmon = 'USD' and
 motipmer = 'VB2' and
 (motipope = 'I' or motipope ='R')
end 


GO
