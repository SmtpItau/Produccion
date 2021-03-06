USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_DOCUMENTOS_PP]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_DOCUMENTOS_PP]
			( 	@sistema 		CHAR(3)		,
				@numero_operacion	NUMERIC(10)	,
				@folio			NUMERIC(10)	,
				@nombre_beneficiario	CHAR(60)	,
				@codigo_tomador		NUMERIC(09)	,
				@fecha_documento	CHAR(8)		,
				@envia			NUMERIC(1)	,
				@monto			NUMERIC(19)	,
				@tipo_operacion		CHAR(40)	,
				@tipo_documento		NUMERIC(3)	,
				@tipo_emision		CHAR(1)		,
				@usuario		CHAR(15)	,
				@rut_tomador		CHAR(60)	,
				@rescata_folio		CHAR(1)		,
				@valor_inicial		NUMERIC(21)	,
				@valor_nominal		NUMERIC(21)	,
				@tir			NUMERIC(19,4)	,
				@agrupa			CHAR(1)
									
			)
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @folio_nuevo 	NUMERIC(10)
		
	SELECT @folio_nuevo 	= 0
		
	IF NOT EXISTS(SELECT 1 FROM DOCUMENTO WHERE Sistema		= @Sistema 		
					  AND	 Numero_Operacion	= @Numero_Operacion	
					  AND	 Folio			= @Folio  
		)
	BEGIN

			--Agregar folio_nuevo
			IF @rescata_folio = 'S' BEGIN

				UPDATE 	entidad
				SET	rcnumoper = rcnumoper + 1

				SELECT 	@folio_nuevo = rcnumoper 
				FROM 	entidad

			END ELSE BEGIN

				UPDATE 	entidad	
				SET	rcnumoper 	= 	@folio
				, 	@folio_nuevo	=	@folio
				

			END				
			
			INSERT INTO documento
					(	
						Sistema			,
						Numero_Operacion	,
						Folio			,
						Nombre_Beneficiario	,
						Codigo_Tomador		,
						fecha_proceso		,
						Envia			,
						Estado			,
						Monto			,
						Tipo_Operacion		,
						Tipo_Documento		,
						Tipo_Emision		,
						Usuario			,
						Rut_Tomador		,
						Nombre_Tomador		,
						hora_traspaso		,
						valor_nominal           ,
						valor_inicial           ,
						tir			,
						agrupa			
												
							
					)

			SELECT	@Sistema				,
				@Numero_Operacion			,
				@folio_nuevo				,
				@Nombre_Beneficiario			,
				@codigo_Tomador				,
				@Fecha_documento			,
				'1'					,
				'E'					,
				@Monto					,
				@Tipo_Operacion				,
				@Tipo_Documento				,
				@Tipo_Emision				,
				@Usuario				,
				@Rut_Tomador				,	
				(SELECT clnombre FROM CLIENTE WHERE clrut = @rut_tomador AND clcodigo = @codigo_tomador),
				CONVERT(CHAR(10),GETDATE(),108)		,
				@valor_inicial				,
				@valor_nominal				,
				@tir					,
				@agrupa					
			
			IF @@ERROR <> 0 BEGIN
				SELECT '1','Problemas al grabar en documento'
			END ELSE BEGIN
				SELECT   '0'
					,'Grabación realizada satisfactoriamente'
					, '@cCodeli'	= ' '
                        		,'@nTipdoc'	= (CASE WHEN tipo_documento IN (5) THEN '2' 
                        					WHEN tipo_documento IN (4) THEN '3'
                        					ELSE '0'
                        				   END)
                        		,'@nCodsuc'	= '0'
                        		,'@nNrodoc'	= '00000000000'
                        		,'@nMtodoc'	= monto
                        		,'@nCodbco'	= '000'
                        		,'@cDisp01'	= '      '
                        		,'@nFecemi'	= fecha_proceso
                        		,'@nCorrel'	= folio
                        		,'@nStatus'	= '0'
                        		,'@nNrocta'	= numero_cuenta_contable
                        		,'@nRuttom'	= rut_tomador
                        		,'@cDvtom'	= ' '
                        		,'@cNomtom'	= nombre_tomador
                        		,'@cNomben'	= nombre_beneficiario 
                        		,'@nCodept'	= '11'
                        		,'@nActben'	= codigo_actividad_beneficiario
                        		,'@cCodemi'	= tipo_emision
                        		,'@nHortra'	= REPLACE(hora_traspaso,':','')
                        		,'@nSistem'	= (CASE WHEN @Sistema = 'BCC' THEN '01'
                                                                WHEN @Sistema = 'BFW' THEN '02'
                        					WHEN @Sistema = 'BTR' THEN '03'
                        					ELSE '00'
                        				   END)
                        		,'@cDisp02'	= '  '
				FROM documento
				WHERE Sistema		= @Sistema 		
					  AND	 Numero_Operacion	= @Numero_Operacion	
					  AND	 Folio			= @Folio_nuevo  
			END

	END ELSE BEGIN

		UPDATE 	documento 
		SET 	Estado 	= 'E' 	,
			Envia 	= '2' 
		
		WHERE 	Sistema			= @Sistema 		AND
			Numero_Operacion	= @Numero_Operacion	AND
			Folio			= @Folio

		IF @@ERROR <> 0 BEGIN
				SELECT '1','Problemas al grabar en documento'
			END ELSE BEGIN
				SELECT '0'
					,'Grabación realizada satisfactoriamente'
					,'@cCodeli'	= ' '
                        		,'@nTipdoc'	= (CASE WHEN tipo_documento IN (5) THEN '2' 
                        					WHEN tipo_documento IN (4) THEN '3'
                        					ELSE '0'
                        				   END)
                        		,'@nCodsuc'	= '0'
                        		,'@nNrodoc'	= '00000000000'
                        		,'@nMtodoc'	= monto
                        		,'@nCodbco'	= '000'
                        		,'@cDisp01'	= '      '
                        		,'@nFecemi'	= fecha_proceso
                        		,'@nCorrel'	= folio
                        		,'@nStatus'	= '0'
                        		,'@nNrocta'	= numero_cuenta_contable
                        		,'@nRuttom'	= rut_tomador
                        		,'@cDvtom'	= ' '
                        		,'@cNomtom'	= nombre_tomador
                        		,'@cNomben'	= nombre_beneficiario 
                        		,'@nCodept'	= '11'
                        		,'@nActben'	= codigo_actividad_beneficiario
                        		,'@cCodemi'	= tipo_emision
                        		,'@nHortra'	= REPLACE(hora_traspaso,':','')
                        		,'@nSistem'	= (CASE WHEN @Sistema = 'BCC' THEN '01'
                                                                WHEN @Sistema = 'BFW' THEN '02'
                        					WHEN @Sistema = 'BTR' THEN '03'
                        					ELSE '00'
                        				   END)
                        		,'@cDisp02'	= '  '
				FROM documento
				WHERE Sistema		= @Sistema 		
					  AND	 Numero_Operacion	= @Numero_Operacion	
					  AND	 Folio			= @Folio

			END

	END
	 

	-- ENVIAR AL AS400
	-- MODIFICAR ENVIA
/*
	UPDATE 	documento 
	SET 	Envia = 0
	WHERE 	Sistema	= @Sistema AND
		Envia   = 1
		
*/
	
	SET NOCOUNT OFF
	
END
--SELECT monto,total_agrupado,* FROM documento
--DELETE documento
--select rcnumoper from entidad
GO
