USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TCLEECODIGOS1]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TCLEECODIGOS1] (
     @tccodtab1 NUMERIC (04,0)--original  NUMERIC(03,0), MODIFICADO PARA FUSIÓN-18-11-2015
     )
AS
BEGIN
SET NOCOUNT ON
 IF @tccodtab1=1
  SELECT tbcateg  --campo insertado
   tbcodigo1 ,
   tbtasa  ,--campo insertado
   tbfecha  ,--campo insertado
   tbvalor  ,--campo insertado
   tbglosa  ,
   nemo   --campo insertado
   --tcSistema ,--campo insertado
   --Tbcateg ,--campo insertado
   --tbcodigo1 ,--campo insertado
   --tcglosa  --campo insertado
   
   
  FROM TABLA_GENERAL_DETALLE
  WHERE tbcateg=@tccodtab1
  ORDER BY tbglosa,tbcodigo1
 ELSE
  SELECT tbcodigo1 ,
   tbglosa
  FROM TABLA_GENERAL_DETALLE
  WHERE tbcateg=@tccodtab1
  ORDER BY tbcodigo1
 
       RETURN
SET NOCOUNT OFF
END

GO
