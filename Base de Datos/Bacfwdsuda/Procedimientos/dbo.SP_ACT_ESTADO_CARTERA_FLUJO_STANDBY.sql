USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_ESTADO_CARTERA_FLUJO_STANDBY]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_ESTADO_CARTERA_FLUJO_STANDBY]	(	@Nro_Credito	INTEGER
							,	@Usuario_Lock	CHAR(15)
							)
AS
BEGIN

	SET NOCOUNT ON

		UPDATE	TBL_CARTERA_FLUJOS_STANDBY
		SET	Cfs_Usuario_Lock	= @Usuario_Lock
		WHERE	Cfs_Numero_Credito	= @Nro_Credito

	SET NOCOUNT OFF

END

GO
