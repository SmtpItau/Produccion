USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TIPO_OPERACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONSULTA_TIPO_OPERACIONES]
as 
begin
set nocount on 
  select distinct CATIPOPER from MDCA 
set nocount off
end
-- Sp_Consulta_tipo_Operaciones


GO
