USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_PLAZA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CORRESPONSALES_PLAZA    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
create procedure [dbo].[SP_CORRESPONSALES_PLAZA]
as 
begin
set nocount on
select codigo_plaza,glosa,codigo_pais
from PLAZA where codigo_pais = ' & cmb_Pais & ' order by glosa
set nocount off
end 

GO
