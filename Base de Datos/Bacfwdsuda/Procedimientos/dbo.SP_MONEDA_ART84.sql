USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONEDA_ART84]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MONEDA_ART84] (
       @Codigo as Int

)
AS
BEGIN
SET NOCOUNT ON;
Select mnnemo from BacParamSuda..MONEDA
Where mncodmon = @Codigo

END
GO
