USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Grilla_Endeu_Cliente]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Llena_Grilla_Endeu_Cliente] 
			( @sw_con as char(1))
AS

BEGIN
	SET NOCOUNT ON

	BEGIN TRANSACTION

		SELECT	clrut			,
			clcodigo
		INTO	#TMPCLIENTE
		FROM	CLIENTE
		WHERE	cltipcli<4

		SELECT	'rut_endeu'				= rut_cliente		,
			'cod_endeu'					= codigo_cliente	,
			'outstanding_endeu'			= outstanding		,
			'activo_circulante_endeu'	= activo_circulante	,
			'status'					= estado			,
			'Cap_U$$'					= Captaciones_Dolares
			
		INTO	#TMPENDEU
		FROM	LIMITE_TOTAL_ENDEUDAMIENTO with(nolock)

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN
		END

		DELETE	LIMITE_TOTAL_ENDEUDAMIENTO

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN
		END

		INSERT	INTO
		LIMITE_TOTAL_ENDEUDAMIENTO
			(
			rut_cliente		,
			codigo_cliente		,
			outstanding           	,
			activo_circulante	,
			estado			,
			Captaciones_Dolares	
			)
		SELECT	clrut			,
			clcodigo		,
			0			,
			0			,
			0			,
			0
		FROM	#TMPCLIENTE

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN
		END

		UPDATE	LIMITE_TOTAL_ENDEUDAMIENTO
		SET	outstanding		= outstanding_endeu		,
			activo_circulante	= activo_circulante_endeu	,
			Captaciones_Dolares	= Cap_U$$,
			estado			= status
		FROM	#TMPENDEU
		WHERE	rut_cliente=rut_endeu AND codigo_cliente=cod_endeu

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			RETURN
		END

		IF @SW_CON='R'
		 BEGIN
			SELECT	rut_cliente			, -- 1
				codigo_cliente			, -- 2
				clnombre				, -- 3
				outstanding           	, -- 4
				activo_circulante		, -- 5
				CASE
					WHEN estado=1 THEN 'X'
					ELSE ''
				END,			  -- 6
				Captaciones_Dolares	  -- 7
			FROM	LIMITE_TOTAL_ENDEUDAMIENTO with(nolock), CLIENTE with(nolock)
			WHERE	rut_cliente=clrut AND codigo_cliente=clcodigo and estado=1
			ORDER BY clnombre
		  end
		 else
		   begin
			SELECT	rut_cliente		, -- 1
				codigo_cliente		, -- 2
				clnombre			, -- 3
				outstanding         , -- 4
				activo_circulante	, -- 5
				CASE
					WHEN estado=1 THEN 'X'
					ELSE ''
				END,					-- 6
				Captaciones_Dolares		-- 7
			FROM	LIMITE_TOTAL_ENDEUDAMIENTO with(nolock), CLIENTE with(nolock)
			WHERE	rut_cliente=clrut AND codigo_cliente=clcodigo 
			ORDER BY clnombre

		   end

		COMMIT TRANSACTION

	SET NOCOUNT OFF
END


GO
