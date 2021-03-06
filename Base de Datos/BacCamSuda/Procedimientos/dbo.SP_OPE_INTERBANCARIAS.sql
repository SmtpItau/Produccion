USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPE_INTERBANCARIAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OPE_INTERBANCARIAS]
AS
BEGIN

SET NOCOUNT ON

DECLARE  @sc1 NUMERIC(19,4),
	 @sc2 NUMERIC(19,4),
	 @sv1 NUMERIC(19,4),
	 @sv2 NUMERIC(19,4)


CREATE TABLE #INFOINTER (motipmer		CHAR(04)
			,monomcli		CHAR(35)
			,morutcli		NUMERIC(09)
			,mocodcli		NUMERIC(09)
			,motipope		CHAR(01)
			,moussme		NUMERIC(19,4)
			,momonpe		NUMERIC(19,4)
			,moticam		NUMERIC(19,4)
			,mofech			DATETIME
			,mocodmon		CHAR(03)
			,mocodcnv		CHAR(03)
		        ,recibe			CHAR(30)
		        ,entrega		CHAR(30)
			,mohora			CHAR(08)
			,hora_proc		CHAR(08)
			,COMPRA_MOUSSME		NUMERIC(19,4)
			,VENTA_MOUSSME		NUMERIC(19,4)
			,COMPRA_MOMONPE		NUMERIC(19,4)
			,VENTA_MOMONPE		NUMERIC(19,4)
		        ,recibe2		CHAR(30)
		        ,entrega2		CHAR(30)
			,sc1			NUMERIC(19,4)
			,sc2			NUMERIC(19,4)
			,sv1			NUMERIC(19,4)
			,sv2			NUMERIC(19,4)
			)

INSERT INTO #INFOINTER
 SELECT	motipmer,
	monomcli,
	morutcli,
	mocodcli,
	motipope,
	moussme,
	momonpe,
	moticam,
	mofech,
	mocodmon,
	mocodcnv,
        ISNULL(a.glosa,''),
        ISNULL(b.glosa,''),
	mohora,
	RIGHT(GETDATE(),8),
	CASE motipope WHEN 'C' THEN moussme ELSE 0 END,  
	CASE motipope WHEN 'V' THEN moussme ELSE 0 END,  
	CASE motipope WHEN 'C' THEN momonpe ELSE 0 END,  
	CASE motipope WHEN 'V' THEN momonpe ELSE 0 END,  
        '',
        '',
	0,
	0,	
	0,
	0
  FROM  memo LEFT OUTER JOIN  view_forma_de_pago a ON morecib = a.codigo  
       LEFT OUTER JOIN  view_forma_de_pago b ON moentre = b.codigo
  WHERE	(mocodmon = 'USD'  AND mocodcnv = 'CLP' ) AND
		 motipmer = 'PTAS' AND 
        (moestatus = ' ' OR moestatus = 'M')	

/*REQ.7619 CASS 07-01-2011
  FROM  memo , 
        view_forma_de_pago a,
        view_forma_de_pago b

  WHERE	(morecib*=a.codigo AND moentre*=b.codigo) AND 
	(mocodmon = 'USD'  AND mocodcnv = 'CLP' ) AND
	 motipmer = 'PTAS' AND 
        (moestatus = ' ' OR moestatus = 'M')	
*/


----- compra canje
INSERT INTO #INFOINTER
 SELECT	motipmer,
	monomcli,
	morutcli,
	mocodcli,
	'C',
	moussme,
	motctra*moussme, 
	motctra,
	mofech,
	mocodmon,
	mocodcnv,
        ISNULL(a.glosa,''), 
        ISNULL(b.glosa,''), 
	mohora,
	RIGHT(GETDATE(),8),
	moussme,   
	0,   
	momonpe,  
	0,  
        '',
        '',
	0,
	0,	
	0,
	0
 FROM  memo LEFT OUTER JOIN  view_forma_de_pago a ON morecib = a.codigo  
       LEFT OUTER JOIN  view_forma_de_pago b ON moentre = b.codigo
  WHERE	(mocodmon = 'USD'  AND mocodcnv = 'CLP' ) AND
		 motipmer = 'CANJ' AND 
        (moestatus = ' ' OR moestatus = 'M')	


/*REQ.7619 CASS 07-01-2011
FROM  memo, 
        view_forma_de_pago a,
        view_forma_de_pago b
WHERE	(morecib*=a.codigo AND moentre*=b.codigo) 
	AND (mocodmon = 'USD'  AND mocodcnv = 'CLP' ) 
	AND motipmer = 'CANJ' 
	AND (moestatus = ' ' OR moestatus = 'M')	
*/


----- venta canje
INSERT INTO #INFOINTER
SELECT	motipmer,
	monomcli,
	morutcli,
	mocodcli,
	'V',
	moussme,
	momonpe, 
	moticam,
	mofech,
	mocodmon,
	mocodcnv,
        '', 
        '', 
	mohora,
	RIGHT(GETDATE(),8),
	0,   
	moussme,  
	0,   
	momonpe,  
        ISNULL(a.glosa,''), 
        ISNULL(b.glosa,''),
	0,
	0,	
	0,
	0
 FROM memo LEFT OUTER JOIN  view_forma_de_pago a ON forma_pago_cli_nac = a.codigo   
			       LEFT OUTER JOIN  view_forma_de_pago b ON forma_pago_cli_ext = b.codigo
 WHERE   (mocodmon = 'USD' AND mocodcnv = 'CLP' ) 
	AND  motipmer = 'CANJ' 
	AND (moestatus= ' ' OR moestatus = 'M')	


/*REQ.7619 CASS 07-01-2011
FROM  memo, 
        view_forma_de_pago a,
        view_forma_de_pago b
WHERE	(forma_pago_cli_nac*=a.codigo AND forma_pago_cli_ext*=b.codigo) 
	AND (mocodmon = 'USD'  AND mocodcnv = 'CLP' ) 
	AND  motipmer = 'CANJ' 
	AND (moestatus = ' ' OR moestatus = 'M')	
*/

  

   SELECT  @SC1 = ISNULL(SUM(moussme) ,1)
        ,  @SC2 = ISNULL(SUM(momonpe) ,1)
   FROM    #INFOINTER  
   WHERE    motipope = 'C'

   SELECT  @SV1 = ISNULL(SUM(moussme),1)
        ,  @SV2 = ISNULL(SUM(momonpe),1)
      FROM #INFOINTER  WHERE  motipope = 'V'

   UPDATE #INFOINTER 
      SET SC1=@SC1,SC2=@SC2,SV1=@SV1,SV2=@SV2			

   UPDATE #INFOINTER 
      SET monomcli = SUBSTRING(clnombre, 1, 35)
     FROM BacParamSuda.dbo.CLIENTE 
    WHERE clrut    = morutcli 
      and clcodigo = mocodcli


	--SELECT * FROM #INFOINTER

	IF EXISTS (SELECT * FROM #INFOINTER)
		BEGIN
			SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #INFOINTER
		END
	ELSE
		BEGIN
			
			SELECT motipmer		  = '',
			       monomcli		  = '',
				   morutcli		  = 0,
			       mocodcli		  = 0,
			       motipope		  = '',
			       moussme		  = 0,
			       momonpe		  = 0,
			       moticam		  = 0,
			       mofech		  = '',
			       mocodmon		  = '',
			       mocodcnv		  = '',
		           recibe		  = '',
		           entrega		  = '',
			       mohora		  = '',
			       hora_proc	  = '',
			       COMPRA_MOUSSME = 0,
			       VENTA_MOUSSME  = 0,
			       COMPRA_MOMONPE = 0,
			       VENTA_MOMONPE  = 0,
		           recibe2		  = '',
		           entrega2		  = '',
			       sc1		 	  = 0,
			       sc2			  = 0,
			       sv1			  = 0,
			       sv2			  = 0,
				   'RazonSocial'  = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

		END


    

   SET NOCOUNT OFF
END

GO
