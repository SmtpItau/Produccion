USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEMONEDAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--select * from View_moneda 
--SP_TRAEMONEDAS
CREATE PROCEDURE [dbo].[SP_TRAEMONEDAS]
AS
BEGIN
 
SET NOCOUNT ON
select mncodmon, mnglosa from view_moneda
 
SET NOCOUNT OFF
END

GO
