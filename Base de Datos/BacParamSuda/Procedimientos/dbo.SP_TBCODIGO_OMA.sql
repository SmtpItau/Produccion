USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TBCODIGO_OMA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TBCODIGO_OMA    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
create procedure [dbo].[SP_TBCODIGO_OMA]
as
begin
 set nocount off
 sELECT codigo_numerico,codigo_caracter,glosa
 FROM TBCODIGOSOMA 
 ORDER BY codigo_numerico
 set nocount on
end
GO
