USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_DOCUMENTOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[SP_GRABA_DOCUMENTOS]
			( 	@sistema 		CHAR(3)		,	--1
				@numero_operacion	NUMERIC(10)	,	--2
				@folio			NUMERIC(10)	,	--3
				@nombre_beneficiario	CHAR(60)	,	--4
				@codigo_Cliente		NUMERIC(09)	,	--5
				@fecha_documento	CHAR(8)		,	--6
				@envia			NUMERIC(1)	,	--7
				@monto			NUMERIC(19)	,	--8
				@tipo_operacion		CHAR(40)	,	--9
				@tipo_documento		NUMERIC(3)	,	--10
				@tipo_emision		CHAR(1)		,	--11
				@usuario		CHAR(15)	,	--12
				@rut_Cliente		NUMERIC(9)	,	--13
				@rescata_folio		CHAR(1)		,	--14
				@valor_inicial		NUMERIC(21)	,	--15
				@valor_nominal		NUMERIC(21)	,	--16
				@tir			NUMERIC(19,4)	,	--17
				@agrupa			CHAR(1)			--18
									
			)
AS
BEGIN
	
	SET NOCOUNT ON
	DECLARE @folio_nuevo 		NUMERIC(10)
	DECLARE @Cuenta			NUMERIC(09)
	DECLARE @cNombre_Tomador	VARCHAR(20)
        DECLARE @rut_tomador 	        NUMERIC(09)
        DECLARE @dv_tomador 	        CHAR(01)
	DECLARE @codigo_Tomador		NUMERIC(9)

	EXECUTE SP_CUENTA_CONTABLE_DOCUMENTOS   @rut_Cliente	,
  					        @codigo_Cliente	,
						@tipo_documento	,
						@Cuenta	OUTPUT

/*=================================
SI EL BENEFICIARIO VIENE VACIO
RESCATA EL NOMBRE DEL BENEFICIARIO
CON LOS DATOS QUE VIENEN DEL TOMADOR
=================================*/

        IF LTRIM(RTRIM(@nombre_beneficiario)) = '' 

		SET @nombre_beneficiario = (SELECT clnombre 
                	                      FROM CLIENTE 
                        	             WHERE clrut = @rut_Cliente AND clcodigo = @codigo_Cliente)

/*=================================
SE ASIGNA RUT DEL BANCO COMO 
TOMADOR DEL VV
=================================*/

        SELECT 	@rut_tomador    = rcrut ,
		@codigo_tomador     = rcdv
          FROM entidad   

/*=================================
SE ASIGNA NOMBRE DEL DEPARTAMENTO
'BACKOFFICE TREASURY' QUE ES EL QUE
TOMA EL VV
=================================*/

	SET @cNombre_Tomador     = 'BACKOFFICE TREASURY' 
	SET @folio_nuevo         = 0
		
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
						Sistema			,	--1
						Numero_Operacion	,	--2
						Folio			,	--3
						Nombre_Beneficiario	,	--4
						Codigo_Tomador		,	--5
						fecha_proceso		,	--6
						Envia			,	--7
						Estado			,	--8
						Monto			,	--9
						Tipo_Operacion		,	--10
						Tipo_Documento		,	--11
						Tipo_Emision		,	--12
						Usuario			,	--13
						Rut_Tomador		,	--14
						Nombre_Tomador		,	--15
						hora_traspaso		,	--16
						valor_nominal           ,	--17
						valor_inicial           ,	--18
						tir			,	--19
						agrupa			,	--20
						numero_cuenta_contable	,	--21
						Rut_Cliente             ,       --22
						Codigo_Cliente          ,       --23
						codigo_actividad_beneficiario,  --24
						codigo_banco			--25
					)

			SELECT	@Sistema				,	--1
				@Numero_Operacion			,	--2
				@folio_nuevo				,	--3
				@Nombre_Beneficiario			,	--4
				@codigo_Tomador				,	--5
				@Fecha_documento			,	--6
				'1'					,	--7
				'E'					,	--8
				@Monto					,	--9
				@Tipo_Operacion				,	--10
				@Tipo_Documento				,	--11
				@Tipo_Emision				,	--12
				@Usuario				,	--13
				@Rut_Tomador				,	--14
				@cNombre_Tomador                        ,	--15
				CONVERT(CHAR(10),GETDATE(),108)		,	--16
				@valor_inicial				,	--17
				@valor_nominal				,	--18
				@tir					,	--19
				@agrupa					,	--20
				@Cuenta					,	--21
				@Rut_Cliente				,	--22
				@codigo_Cliente				,	--23
				(SELECT ISNULL(CLSECTOR,0)   FROM CLIENTE WHERE 	CLRUT = @Rut_Cliente  AND CLCODIGO = @codigo_Cliente), --24
				(SELECT ISNULL(Cod_Inst,0)   FROM CLIENTE WHERE 	CLRUT = @Rut_Cliente  AND CLCODIGO = @codigo_Cliente)  --25
			
			IF @@ERROR <> 0 BEGIN
				SELECT '1','Problemas al grabar en documento'
			END ELSE BEGIN
				SELECT '0','Grabación realizada satisfactoriamente'
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
				SELECT '0','Grabación realizada satisfactoriamente'
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







/*

HSBCPARAMETROS..SP_GRABA_DOCUMENTOS 'BTR', 827038, 0,  '', 1, '20020804', 1,    7349666, 'COMPRA PROPIA', 5, 'N', 'ADMINISTRA', 97919000, 'S', 1000, 0, 0, 'N'

HSBCPARAMETROS..SP_GRABA_DOCUMENTOS 'BCC', 119184, 12, '', 1, '20020830', 1, 1420400000, 'C',             5, 'N', 'ADMINISTRA', 97004000, 'N',    0, 0, 0, 'S'
SP_HELP DOCUMENTO
SP_HELPTEXT SP_GRABA_DOCUMENTOS    
SELECT * FROM DOCUMENTO
SELECT * FROM TRUNCATE TABLE DOCUMENTO

*/







GO
