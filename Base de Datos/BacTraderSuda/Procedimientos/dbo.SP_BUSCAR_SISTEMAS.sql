USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_SISTEMAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAR_SISTEMAS]
as
begin
   select id_sistema, nombre_sistema from  VIEW_SISTEMA_CNT 
  where operativo = 'S'
end 


GO
