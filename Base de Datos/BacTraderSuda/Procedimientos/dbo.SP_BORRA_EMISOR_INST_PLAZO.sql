USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_EMISOR_INST_PLAZO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BORRA_EMISOR_INST_PLAZO]( @Rut   NUMERIC(10)  ,
     @Instrumento CHAR(6)  )
AS
BEGIN
 DELETE 
  MD_EMISOR_INST_PLAZO
 WHERE 
  rut = @Rut 
 AND     instrumento = @Instrumento
END   /* FIN PROCEDIMIENTO */


GO
