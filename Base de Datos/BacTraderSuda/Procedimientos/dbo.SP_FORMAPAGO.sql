USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMAPAGO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORMAPAGO]
as
begin
 select codigo,glosa from VIEW_FORMA_DE_PAGO
end

GO
