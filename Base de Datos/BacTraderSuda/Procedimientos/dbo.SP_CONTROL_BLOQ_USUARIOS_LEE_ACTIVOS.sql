USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS]
as
begin
 set nocount on
 select * from VIEW_USUARIO_ACTIVO order by terminal 
 set nocount off
end


GO
