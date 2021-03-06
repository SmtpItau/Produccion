USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Perfil_Busca]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Leer_Perfil_Busca] 
  (
   @varsistema CHAR(03) , 
   @varmovimiento CHAR(03) ,
   @vartipoper CHAR(05) ,
   @varinstr CHAR(06) ,
   @varmoneda CHAR(03)
  )
AS
BEGIN
 SELECT folio_perfil 
 FROM PERFIL_CNT
 WHERE id_sistema=@varsistema 
   AND tipo_movimiento  = @varmovimiento 
   AND tipo_operacion  = @vartipoper 
   AND codigo_instrumento = @varinstr 
   AND ltrim(moneda_instrumento) = ltrim(@varmoneda)
END






GO
