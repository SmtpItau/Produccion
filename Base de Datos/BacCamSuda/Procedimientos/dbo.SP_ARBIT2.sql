USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARBIT2]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC SP_ARBIT2

CREATE PROCEDURE [dbo].[SP_ARBIT2]
AS
BEGIN

	DECLARE @COUNT INTEGER
	SET @COUNT = (	SELECT COUNT(*)
                      FROM MEMO
                     WHERE MOTIPMER   =  'ARBI' 
	                   AND MOCODMON   <> 'USD' 
	                   AND MOCODCNV   <> 'CLP' 
	                   AND (MOESTATUS = ' ' OR MOESTATUS ='M'))


	IF @COUNT <> 0

		BEGIN

			SELECT MOTIPOPE,
				   MOFECH,
				   'VALUTA' = CASE WHEN MOVALUTA1 > MOVALUTA2 THEN MOVALUTA1 ELSE MOVALUTA2 END,
				   LTRIM(RTRIM(MONUMOPE)) + ' - ' + MONOMCLI,
				   MOCODMON,
				   MOCODCNV,
				   MOMONMO,
				   MOPARTR,
				   MOUSSME,
				   HORA_PROC= RIGHT(GETDATE(),8),
				  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
			  FROM MEMO
			 WHERE MOTIPMER   =  'ARBI' 
			   AND MOCODMON   <> 'USD' 
			   AND MOCODCNV   <> 'CLP' 
			   AND (MOESTATUS = ' ' OR MOESTATUS ='M')

	    END

	ELSE

		BEGIN

		    SELECT MOTIPOPE = '',
				   MOFECH = '',
				   'VALUTA' = '',
				   MONUMOPE = '0' + ' - ' + '',
				   MOCODMON = '',
				   MOCODCNV = '',
				   MOMONMO = 0,
				   MOPARTR = 0,
				   MOUSSME = 0,
				   HORA_PROC= '',
				  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)


		END
END

GO
