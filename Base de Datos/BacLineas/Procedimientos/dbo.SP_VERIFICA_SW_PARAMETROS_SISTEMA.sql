USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_SW_PARAMETROS_SISTEMA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VERIFICA_SW_PARAMETROS_SISTEMA] (@vcSistema as varchar(5)='PCS')
AS
BEGIN
	SET NOCOUNT ON
	IF @vcSistema = 'PCS'
					(SELECT 'cierremesa' = cierremesa FROM bacswapsuda..SwapGeneral)
	ELSE
		IF @vcSistema ='BFW'
						(SELECT 'cierremesa'= acsw_ciemefwd FROM BACfwdsuda..mfac)
		ELSE
			SELECT 'cierremesa' = -1,'Sistema no válido'
	SET NOCOUNT OFF
END
GO
