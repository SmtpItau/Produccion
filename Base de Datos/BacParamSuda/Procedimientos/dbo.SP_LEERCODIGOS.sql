USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCODIGOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERCODIGOS]
   (   @cod_cat  NUMERIC(6)   )
AS
BEGIN   

   IF @cod_cat = 103
   BEGIN
      SELECT tbcodigo1 
      ,      '' --> tbtasa 
      ,      tbfecha 
      ,      tbvalor 
      ,      tbglosa 
      ,      nemo 
      FROM   TABLA_GENERAL_DETALLE with(nolock)
      WHERE  tbcateg = @cod_cat
      ORDER BY tbtasa --> tbcodigo1
   END ELSE 
   BEGIN
      SELECT tbcateg 
      ,      tbcodigo1 
      ,      tbtasa 
      ,      tbfecha 
      ,      tbvalor 
      ,      tbglosa 
      ,      nemo 
      FROM   TABLA_GENERAL_DETALLE with(nolock)
      WHERE  tbcateg = @cod_cat
      ORDER BY tbglosa

   END

END

GO
