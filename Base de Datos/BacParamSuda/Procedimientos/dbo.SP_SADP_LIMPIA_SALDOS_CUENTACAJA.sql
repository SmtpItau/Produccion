USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LIMPIA_SALDOS_CUENTACAJA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LIMPIA_SALDOS_CUENTACAJA]
				(	@dFechaProceso			DATETIME
				)
AS 

	DELETE FROM dbo.SADP_CUENTA_CAJA WHERE dFechaSaldo = @dFechaProceso ;
GO
