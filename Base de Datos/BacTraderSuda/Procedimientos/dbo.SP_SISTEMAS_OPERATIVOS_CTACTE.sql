USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SISTEMAS_OPERATIVOS_CTACTE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_SISTEMAS_OPERATIVOS_CTACTE]
as

begin
select id_sistema, nombre_sistema from VIEW_SISTEMA_CNT
where id_sistema in('BCC','BTR','BFW')

end

GO
