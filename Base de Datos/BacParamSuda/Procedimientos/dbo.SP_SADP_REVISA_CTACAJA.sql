USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_REVISA_CTACAJA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_REVISA_CTACAJA](@dfechaproceso DATETIME)
AS
	SELECT COUNT(*) AS TotReg  FROM SADP_CUENTA_CAJA scc WHERE scc.dFechaSaldo = @dfechaproceso AND scc.bEstado=1 ; 
GO
