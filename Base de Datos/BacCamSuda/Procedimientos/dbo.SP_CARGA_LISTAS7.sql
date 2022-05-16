USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LISTAS7]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CARGA_LISTAS7]
 ( @cod varchar(255) )
as
begin
 select 15 , * 
 from BACPARAMsuda..TBCODIGOSOMA
 where rtrim(ltrim(substring(codigo_caracter,1,2))) = @cod
end



GO
