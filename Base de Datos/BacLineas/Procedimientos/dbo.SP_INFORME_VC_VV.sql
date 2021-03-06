USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_VC_VV]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[SP_INFORME_VC_VV]( @Sistema CHAR(03) )
AS
BEGIN
	DECLARE @espacio CHAR(30)

	SET NOCOUNT ON
	SELECT   tipo_documento
                ,'nMtodoc'	= SUM(monto)
                ,folio
                ,numero_cuenta_contable
                ,nombre_tomador
                ,nombre_beneficiario 
                ,'tipo_emision'= (CASE tipo_emision WHEN 'N' THEN 'NOMINATIVO' ELSE 'ABIERTO' END)
                ,hora_traspaso
		,usuario
		,'fecha_proceso'=CONVERT(CHAR(10),CONVERT(DATETIME,fecha_proceso),103)
                ,'glosa' = @espacio
        INTO     #TEMP1
	FROM	 documento
	WHERE    Sistema	= @Sistema 		
	     AND estado		= 'E'
	GROUP BY folio
		,tipo_documento
		,fecha_proceso
		,numero_cuenta_contable
		,nombre_tomador
		,nombre_beneficiario
		,tipo_emision
                ,hora_traspaso
		,usuario
		,fecha_proceso	

	UPDATE   #TEMP1
	SET	 glosa = a.glosa
	FROM 	 forma_de_pago a
	WHERE	 tipo_documento = a.codigo

	SELECT	 * FROM #TEMP1

	SET NOCOUNT OFF


END




-- SP_INFORME_VC_VV 'BCC'











GO
