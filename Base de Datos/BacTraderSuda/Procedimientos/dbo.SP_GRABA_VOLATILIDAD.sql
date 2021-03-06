USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_VOLATILIDAD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_VOLATILIDAD]( @moneda       numeric(3)  ,
                                  @volatilidad  float       )
as
begin
if not exists(select * from MD_VOLATILIDAD where moneda = @moneda)
   
   insert MD_VOLATILIDAD( moneda,
                          volatilidad )
                  values( @moneda,
                          @volatilidad )
else
   update MD_VOLATILIDAD set volatilidad = @volatilidad 
                       where moneda = @moneda
return 0
end   /* fin procedimiento */

GO
