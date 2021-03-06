USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_FACTOR_PONDERACION_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_DEL_FACTOR_PONDERACION_LINEAS]	(	@Id_Sistema	CHAR(03) 
							,	@Tipo		CHAR(01) = ''
							,	@CodigoMoneda	CHAR(10) = ''
							)
AS
BEGIN

	SET NOCOUNT ON
	
	IF @Tipo = 'T' OR @Tipo = '' BEGIN
		DELETE	TBL_FACTOR_PONDERACION_TASAS
		FROM	BACPARAMSUDA..MONEDA
		WHERE	Fpt_Id_Sistema		= @Id_Sistema
		AND	Fpt_Moneda              = mncodmon
		AND	(mnnemo		        = @CodigoMoneda OR @CodigoMoneda = '')
				
		IF @@ERROR <> 0 BEGIN
			PRINT 'ERROR AL INTENTAR ELIMINAR LOS REGISTROS'
			RETURN
		END
	END
					
	IF @Tipo = 'D' OR @Tipo = '' BEGIN
		DELETE	TBL_FACTOR_PONDERACION_DIVISAS
		FROM	BACPARAMSUDA..MONEDA
		WHERE	Fpd_Id_Sistema		= @Id_Sistema
		AND	Fpd_Moneda              = mncodmon
		AND	(mnnemo		        = @CodigoMoneda OR @CodigoMoneda = '')
					
		IF @@ERROR <> 0 BEGIN
			PRINT 'ERROR AL INTENTAR ELIMINAR LOS REGISTROS'
			RETURN
		END
	END
				
	SET NOCOUNT OFF	

END
GO
