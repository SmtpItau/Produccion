USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_PARAMETROS_LEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_PARAMETROS_LEER]
AS
BEGIN
 SET NOCOUNT ON
 
 SELECT * FROM tbtr_pra_rsv_tcn ORDER BY tipo, glosa
 SET NOCOUNT OFF
END 



GO
