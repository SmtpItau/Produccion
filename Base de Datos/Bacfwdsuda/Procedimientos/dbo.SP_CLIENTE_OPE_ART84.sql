USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTE_OPE_ART84]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CLIENTE_OPE_ART84] (
       @NroOperacion as Numeric

)
AS
BEGIN
SET NOCOUNT ON;
Select M.mocodigo, C.clcodigo from Bacfwdsuda..mfmo M, BacParamSuda..Cliente C
with(nolock)
Where monumoper = @NroOperacion
and M.mocodigo = C.Clrut

END

GO
