USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TbCodigo_OMA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TbCodigo_OMA    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
create procedure [dbo].[Sp_TbCodigo_OMA]
as
begin
 set nocount off
 sELECT codigo_numerico,codigo_caracter,glosa
 FROM TBCODIGOSOMA 
 ORDER BY codigo_numerico
 set nocount on
end






GO
