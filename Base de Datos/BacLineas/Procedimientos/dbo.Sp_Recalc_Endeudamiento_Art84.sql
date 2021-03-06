USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Recalc_Endeudamiento_Art84]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Recalc_Endeudamiento_Art84]
         	(@Rut_Cliente       NUMERIC (9,0)   
		,@Codigo_Cliente    NUMERIC (9,0)   
		,@capitalbasico	    NUMERIC(19,4)
		,@Porcentaje        NUMERIC (7,4)   
		,@Garantia          NUMERIC (19,0)   
		)
AS
BEGIN

	DECLARE @Endeuda	NUMERIC (19,0)
	,       @EndeudaFinal	NUMERIC (19,0)

	IF @Garantia = 0 
	BEGIN
		UPDATE  CLIENTE_ART84 
		   SET  Endeudamiento  = ( @capitalbasico * @Porcentaje ) / 100
		 WHERE  Rut_Cliente    = @Rut_Cliente    AND 
			Codigo_Cliente = @Codigo_Cliente
	END
	ELSE BEGIN
		SELECT  @Endeuda      = ( @capitalbasico * @Porcentaje ) / 100
		SELECT  @EndeudaFinal = @Endeuda - @Garantia 

		UPDATE  CLIENTE_ART84 
		   SET  Endeudamiento  = @EndeudaFinal
                       ,Porcentaje     = ( @EndeudaFinal * @Porcentaje ) / @Endeuda
		 WHERE  Rut_Cliente    = @Rut_Cliente    AND 
			Codigo_Cliente = @Codigo_Cliente
	END

END





GO
