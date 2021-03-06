USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PERFIL]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_PERFIL]( @crear_perfil           CHAR(1)    ,
                             @folio_original         NUMERIC(10),
                             @sistema                CHAR(3)    ,
                             @tipo_movimiento        CHAR(3)    ,
                             @tipo_operacion         CHAR(5)    ,
                             @codigo_instrumento     CHAR(10)   ,
                             @moneda                 CHAR(4)    ,
                             @tipo_voucher           CHAR(1)    ,
                             @glosa_perfil           CHAR(40)   ,
                             @codigo_campo           NUMERIC(3) ,
                             @movimiento_cuenta      CHAR(1)    ,
                             @perfil_fijo            CHAR(1)    ,
                             @codigo_cuenta          CHAR(15)   ,
                             @correlativo            NUMERIC(10),
                             @codigo_campo_variable  NUMERIC(3) ,
			     @Usuario		     CHAR(20)	,
			     @graba_detalle	     CHAR(1)	)
AS 
BEGIN
   SET NOCOUNT ON


	DECLARE @campo         CHAR(30)   ,
        @folio_perfil NUMERIC(10)

	IF @crear_perfil = 'S' 
	BEGIN


   		IF @folio_original > 0
		BEGIN
	      		SELECT @folio_perfil = @folio_original
		END ELSE BEGIN 
			SELECT @folio_perfil = ISNULL(MAX(folio_perfil),0) + 1 FROM PERFIL_CNT
		END

   		INSERT PERFIL_CNT(id_sistema 	,
			 tipo_movimiento 	,
			 tipo_operacion 	,
			 folio_perfil 		,
			 codigo_instrumento 	,
			 moneda_instrumento 	,
			 tipo_voucher	 	,
			 glosa_perfil           )
		  VALUES(@sistema               ,
                         @tipo_movimiento       ,
                         @tipo_operacion        , 
                         @Folio_Perfil          ,
                         @Codigo_instrumento    ,
                         @Moneda                ,
                         @Tipo_Voucher          ,
                         @Glosa_Perfil          ) 


   		IF @@ERROR <> 0
   		BEGIN
      		SET NOCOUNT OFF
     			PRINT 'ERROR_PROC FALLA AGREGANDO PERFIL.'
      			SELECT 'ERR'
      			RETURN 1
   		END

  	END ELSE BEGIN

   		SELECT @folio_perfil = folio_perfil 
     		FROM PERFIL_CNT
    		WHERE id_sistema         = @sistema
      		AND tipo_movimiento    = @tipo_movimiento
      		AND tipo_operacion     = @tipo_operacion
      		AND codigo_instrumento = @codigo_instrumento
      		AND moneda_instrumento = @moneda

  	END

	SELECT @campo = descripcion_campo 
  	FROM CAMPO_CNT
 	WHERE id_sistema      = @sistema
   	AND tipo_movimiento = @tipo_movimiento
   	AND tipo_operacion  = @tipo_operacion
   	AND codigo_campo    = @codigo_campo


	


		INSERT Perfil_Detalle_Cnt 
		( 
				folio_perfil      		,
				codigo_campo          		, 
				tipo_movimiento_cuenta		, 
				perfil_fijo           		,
				codigo_cuenta         		,
				correlativo_perfil    		,
				codigo_campo_variable 
		)
             	VALUES
		( 
				@folio_perfil         		,
                                @codigo_campo         		,
                                @movimiento_cuenta    		,
                                @perfil_fijo          		,
                                @codigo_cuenta        		,
                                @correlativo          		,
                                @codigo_campo_variable
		)

		IF @@ERROR <> 0
		BEGIN
   		SET NOCOUNT OFF
   			PRINT 'ERROR_PROC FALLA AGREGANDO DETALLE PERFIL.'
   			SELECT 'ERR'
   			RETURN 1
		END

	


	IF @graba_detalle = 'S' 
	BEGIN


		INSERT INTO PERFIL_VARIABLE_CNT 
		SELECT 	@folio_perfil	,
			@correlativo	,
			valor		,
			cuenta		
	
		FROM 	PASO_CNT 
		WHERE fila       = @correlativo
		AND ID_SISTEMA = @Sistema
		AND USUARIO    = @Usuario

		DELETE PASO_CNT 
		WHERE  FILA       = @Correlativo
  		AND  ID_SISTEMA = @Sistema
  		AND  USUARIO    = @Usuario
	
	END


SET NOCOUNT OFF
SELECT 'OK'
RETURN 0

END 
GO
