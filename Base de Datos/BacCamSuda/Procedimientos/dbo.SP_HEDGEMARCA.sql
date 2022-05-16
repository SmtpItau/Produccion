USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGEMARCA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGEMARCA] 
AS
BEGIN
     SET NOCOUNT ON
	SELECT  CODIGO_MONEDA
	,	ORDEN_MONEDA    
	FROM TBL_HEDGE_ORDEN_MONEDAS WITH (NOLOCK)
  
END
GO
