USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VOLATILIDAD]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_VOLATILIDAD]( @moneda numeric(3) )
as
begin
select volatilidad from MD_VOLATILIDAD where moneda = @moneda
end   /* fin procedimiento */


GO
