USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_MONTOS_VP_AUTOMATICA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--sp_helptext SP_VALIDA_MONTOS_VP_AUTOMATICA

--SP_VALIDA_MONTOS_VP_AUTOMATICA 85141
--select moperdida,movalven,movpresen,* from MDMO WHERE monumoper = 85141 and  movalven <> movpresen
--select moperdida,movalven,movpresen,* from MDMO WHERE monumoper = 85141 and moperdida < 0

CREATE PROCEDURE [dbo].[SP_VALIDA_MONTOS_VP_AUTOMATICA]
(
	@NumOper as numeric
)
AS
BEGIN

SET NOCOUNT ON

	UPDATE MDMO 
	SET moperdida = 0.0000, movalven = movpresen
	--WHERE monumoper = @NumOper and moperdida < 0
	WHERE monumoper = @NumOper and movalven <> movpresen

END
GO
