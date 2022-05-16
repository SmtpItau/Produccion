USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_SEGMENTOSCOMERCIALES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_DEL_SEGMENTOSCOMERCIALES]	( @Opcion INT =0,
						  @SgmCod CHAR(6)
					)
AS
BEGIN

	SET NOCOUNT ON 
	
       IF @OPCION = 1
	  BEGIN

		DELETE	 TBL_SEGMENTOSCOMERCIALES
		WHERE	 SgmCod = @SgmCod
	
       END

       IF @OPCION = 2
	  BEGIN

		DECLARE @EXISTE INT 
		SET @EXISTE = 0
		SELECT @EXISTE = 1
		FROM CLIENTE  WHERE seg_comercial = @SgmCod 
      
      
		IF @EXISTE = 0
	           BEGIN 
	
			DELETE	 TBL_SEGMENTOSCOMERCIALES
			WHERE	 SgmCod = @SgmCod
		END
		ELSE
	           BEGIN
	            SELECT 15, 'Clientes Tienen asignado este segmento, No se puede Eliminar'
		END 
	END

	

	SET NOCOUNT OFF


END
GO
