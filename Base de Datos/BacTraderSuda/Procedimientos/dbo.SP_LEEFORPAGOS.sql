USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEFORPAGOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEFORPAGOS]
as
begin
 select codigo,
         glosa +space(50) + convert(char(05),diasvalor)     ,
  cc2756
 from VIEW_FORMA_DE_PAGO
 
end


GO
