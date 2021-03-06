USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PERFIL_BUSCA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_PERFIL_BUSCA] 
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
