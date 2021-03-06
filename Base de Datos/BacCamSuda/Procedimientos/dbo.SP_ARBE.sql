USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARBE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC SP_ARBE

CREATE PROCEDURE [dbo].[SP_ARBE]
AS
BEGIN

 DECLARE @COUNT INT
 SET @COUNT = (SELECT COUNT(*) FROM  MEMO,MEAC WHERE MOTIPMER = 'EMPR' AND MOCODMON <> 'USD' AND (MOESTATUS = ' ' OR MOESTATUS = 'M') )


 IF @COUNT <> 0

 BEGIN

	SELECT  ACNOMBRE,
                MOTIPOPE,
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
		HORA_PROC= CONVERT(CHAR(08),GETDATE(),108),
		MONUMOPE,
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	  FROM  MEMO,MEAC
          WHERE MOTIPMER = 'EMPR' AND
		MOCODMON <> 'USD' AND
	       (MOESTATUS = ' ' OR MOESTATUS = 'M')       
		   
 END
 
 ELSE
 
 BEGIN

	SELECT  ACNOMBRE = '',
                MOTIPOPE = '',
		MOFECH = '',
		'VALUTA' = '',
		MONOMCLI = '',
		MOCODMON = '',
		MOMONMO = '',
		MOPARTR = '',
		MOUSSME = '',                    --RES = MOMONMO/MOPARTR,
		HORA_PROC  = '',
		MONUMOPE = 0,
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 
 
 END		   		      
    
END

GO
