USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODIGO_PRODUCTO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CODIGO_PRODUCTO] --'COMPRA PROPIA'
  (@Codigo  varchar(50))
as 
begin
 select codigo_producto
 from   PRODUCTO
 where  descripcion=@codigo
end


GO
