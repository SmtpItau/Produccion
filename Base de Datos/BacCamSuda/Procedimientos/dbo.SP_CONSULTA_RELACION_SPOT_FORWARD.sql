USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_RELACION_SPOT_FORWARD]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_RELACION_SPOT_FORWARD]
	(	@numope	NUMERIC(07)	
	)	
AS
BEGIN

	--************************************************************************************
	--Procedimiento que consulta operacion relacionada desde forward seguro de cambio																			 
	--************************************************************************************		

	SET NOCOUNT ON
	
		SELECT	monumope				
		,		motipmer				
		,		motipope				
		,		morutcli				
		,		mocodcli				
		,		monomcli				
		,		mocodmon 			
		,		mocodcnv 				
		,	    momonmo --= (SELECT CONVERT(DECIMAL(19,0),momonmo))			
		,		moticam					
		,		motctra					
		,		moparme					
		,		mopar30					
		,		mopartr					
		,		moussme					
		,		mouss30					
		,		mousstr					
		,		momonpe	--= (SELECT CONVERT(DECIMAL(19,0),momonpe))				
		,		moentre					
		,		morecib					
		,		mooper					
		,		moterm					
		,		'mohora' = Convert(NVARCHAR(8),mohora)					
		,		mofech					
		,		mocodoma				
		,		moestatus				
		,		mocodejec				
		,		movaluta1				
		,		movaluta2				
		,		morentab				
		,		moalinea				
		,		moentidad				
		,		moprecio				
		,		mopretra				
		,		id_sistema				
		,		contabiliza				
		,		observacion				
		,		swift_corresponsal		
		,		swift_recibimos			
		,		swift_entregamos		
		,		plaza_corresponsal		
		,    	plaza_recibimos			
		,    	plaza_entregamos		
		,    	forma_pago_cli_nac		
		,    	forma_pago_cli_ext		
		,    	valuta_cli_nac			
		,    	valuta_cli_ext			
		,    	codigo_area				
		,    	codigo_comercio			
		,    	codigo_concepto			
		,    	morutgir				
		,    	mocodigogirador			
		,    	mocostofo				
		,    	moutilpe				
		,    	motcfin					
		,    	mofecvcto				
		,    	modias					
		,    	movamos					
		,    	mocorres				
		,    	motipcar				
		,     	monumfut				          
		,    	mofecini				
		,    	anula_motivo			
		,    	MOTLXP1					
		--		Bac Operativo COMEX
		,		CMX_Punta_Pizarra		
		,		CMX_TC_Costo_Trad		
		,		moDifTran_Mo			
		,		moDifTran_Clp			
		,		moResultado_Comercial_Clp
		,		'Moneda' = CONVERT(NVARCHAR(3),(SELECT mncodmon FROM bacparamsuda..moneda WHERE mnnemo = mocodmon))				
		,		'MonedaConversion' = CONVERT(NVARCHAR(3),(SELECT mncodmon FROM bacparamsuda..moneda WHERE mnnemo = mocodcnv))			
		FROM	MEMO 
		WHERE	MONUMFUT = @numope
		
		
END






GO
