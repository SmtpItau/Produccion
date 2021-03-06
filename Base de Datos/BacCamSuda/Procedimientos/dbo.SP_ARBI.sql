USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARBI]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ARBI]
AS
BEGIN
SELECT MOTIPOPE,
 MOFECH,
 'VALUTA' = CASE 
                    WHEN MOVALUTA1 > MOVALUTA2 THEN MOVALUTA1
                    ELSE MOVALUTA2
                   END,
 MONOMCLI,
 MOCODMON,
 MOMONMO,
 MOPARTR,
 MOUSSME,                         --RES = MOMONMO/MOPARTR,
 HORA_PROC= RIGHT(GETDATE(),8)
     FROM MEMO
     
     WHERE MOTIPMER = 'ARBI' AND
          (MOESTATUS = ' ' OR MOESTATUS = 'M')          
    
END





GO
