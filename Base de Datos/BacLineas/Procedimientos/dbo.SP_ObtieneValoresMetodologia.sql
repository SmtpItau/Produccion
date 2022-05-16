USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtieneValoresMetodologia]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sandra Vásquez K.
-- Create date: 23-10-2014
-- Description:	Obtiene valores Metodologia 6 - usuario en BacCalculoRec
-- =============================================
CREATE PROCEDURE [dbo].[SP_ObtieneValoresMetodologia]
AS
BEGIN

	SELECT * FROM TBL_RIEFIN_Parametros_Metodologia with (nolock)

END

GO
