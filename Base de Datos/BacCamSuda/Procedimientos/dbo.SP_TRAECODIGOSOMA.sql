USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECODIGOSOMA]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_TRAECODIGOSOMA]
 ( @opera numeric(9))
as
begin
 select codigo_caracter
        from VIEW_TBCODIGOOMA
        where codigo_numerico   =  @opera
end



GO
