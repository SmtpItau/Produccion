USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCODIGOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEERCODIGOS] (@cod_cat  NUMERIC(6))
AS
BEGIN   
 SELECT  
  tbcateg ,
  tbcodigo1 ,
  tbtasa ,
  tbfecha ,
  tbvalor ,
  tbglosa ,
   nemo 
 
        FROM
         VIEW_TABLA_GENERAL_DETALLE
      WHERE
         tbcateg = @cod_cat
      
 ORDER BY tbglosa
   RETURN
END  



GO
