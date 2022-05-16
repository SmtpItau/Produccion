USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARIDAD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_PARIDAD]
 ( @moneda char(3)
         ,@fecha        char(8) )
as
begin
set nocount on
 select vmparidad 
 from VIEW_POSICION_SPT 
 where vmcodigo = @moneda and
              vmfecha  = @fecha
set nocount off
end
--  SP_PARIDAD 'DEM', '20010830' sp_autoriza_ejecutar 'BACUSER'



GO
