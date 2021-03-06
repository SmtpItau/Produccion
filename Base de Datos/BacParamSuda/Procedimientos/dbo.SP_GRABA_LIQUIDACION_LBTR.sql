USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_LIQUIDACION_LBTR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_LIQUIDACION_LBTR]
		(
		@par_sistema		CHAR	(03),
		@par_num_operacion	NUMERIC	(9,0),
		@marca			CHAR    (01)
		)
AS BEGIN
SET NOCOUNT ON

	UPDATE MDLBTR	SET liquidada=@marca
	WHERE	sistema		 = @par_sistema	AND
		numero_operacion = @par_num_operacion
SET NOCOUNT OFF
END
GO
