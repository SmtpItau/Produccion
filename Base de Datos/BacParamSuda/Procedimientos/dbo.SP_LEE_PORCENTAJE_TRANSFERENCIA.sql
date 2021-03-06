USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_PORCENTAJE_TRANSFERENCIA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_PORCENTAJE_TRANSFERENCIA]
	(	@cSistema	CHAR(03)
	,	@xProducto	CHAR(05) --> @cModulo
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @iPorcentaje   NUMERIC(18,6)

	SET @iPorcentaje   = ISNULL( (SELECT ISNULL( tbvalor, 0.0) 
					FROM	BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock) 
                                        WHERE	tbcateg		= CASE @cSistema	WHEN 'BFW' THEN 8000 --> 'FWD'
											WHEN 'BTR' THEN 8001
											WHEN 'BCC' THEN 8002
											WHEN 'PCS' THEN 8003
								  END
					AND	tbcodigo1 = @xProducto), 0.0)

	SELECT 'Porcentaje' = @iPorcentaje

	SET NOCOUNT OFF
END

GO
