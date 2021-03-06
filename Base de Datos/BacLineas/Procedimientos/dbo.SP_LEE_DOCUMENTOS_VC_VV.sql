USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DOCUMENTOS_VC_VV]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_DOCUMENTOS_VC_VV]
		( 
			@Sistema CHAR(03) 
		)
AS
BEGIN
	
-- select * from forma_de_pago

	SET NOCOUNT ON
	SELECT   numero_operacion							--1
		,'Grabación realizada satisfactoriamente'				--2
		,'cCodeli'	= ' '							--3
                ,'nTipdoc'	= (CASE WHEN tipo_documento IN (5) THEN '3' 
                     			WHEN tipo_documento IN (4) THEN '10'
                      		        ELSE '0'
                      		   END)							--4
                ,'nCodsuc'	= '1'							--5
                ,'nNrodoc'	= '00000000000'						--6
                ,'nMtodoc'	= monto							--7
                ,'nCodbco'	= c.Cod_Inst 						--8
                ,'cDisp01'	= '      '						--9
		,'nFecemi'	= fecha_proceso						--10
                ,'nCorrel'	= folio							--11
                ,'nStatus'	= 'C'							--12
                ,'nNrocta'	= numero_cuenta_contable				--13
                ,'nRuttom'	= rut_tomador						--14
                ,'cDvtom'	= codigo_tomador					--15
                ,'cNomtom'	= nombre_tomador					--16
                ,'cNomben'	= nombre_beneficiario 					--17
                ,'nCodept'	= '320'							--18
                ,'nActben'	= codigo_actividad_beneficiario				--19
                ,'cCodemi'	= tipo_emision						--20
                ,'nHortra'	= REPLACE(CONVERT(CHAR(08),GETDATE(),108),':','')	--21
                ,'nSistem'	= (CASE WHEN @Sistema = 'BTR' THEN 'BMN'			
                        		ELSE 'BME'
                        	   END)							--22	
                ,'cDisp02'	= '  '							--23
		,'RutBenef'	= rut_Cliente 						--24
	FROM 	documento, cliente c
	WHERE 	Sistema		= @Sistema 		
	  	AND envia		<> 0
          	AND rut_cliente       = c.CLRUT 
	  	AND codigo_cliente    = c.clcodigo 
/*
	GROUP BY folio
		,tipo_documento
		,fecha_proceso
		,numero_cuenta_contable
		,rut_tomador
		,codigo_tomador
		,nombre_tomador
		,nombre_beneficiario
		,codigo_actividad_beneficiario
		,tipo_emision
                ,c.Cod_Inst 
		,rut_Cliente
*/
	IF @@ERROR = 0 BEGIN
           UPDATE documento SET envia = 0 WHERE Sistema	= @Sistema AND envia <> 0

	END
	
	SET NOCOUNT OFF
	
END


-- SELECT * FROM DOCUMENTO
-- SP_AUTORIZA_EJECUTAR 'BACUSER'
-- sp_lee_documentos_vc_vv 'BFW'
GO
