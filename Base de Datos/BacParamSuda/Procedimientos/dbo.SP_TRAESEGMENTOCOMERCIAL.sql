USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAESEGMENTOCOMERCIAL]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAESEGMENTOCOMERCIAL]
AS
BEGIN

   SET NOCOUNT ON
   --PRD-8800
   SELECT SgmDesc, SgmCod
   FROM Bacparamsuda.dbo.TBL_SEGMENTOSCOMERCIALES
   ORDER BY SgmDesc ASC

END
GO
