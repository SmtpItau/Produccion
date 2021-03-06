USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CLIENTE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--sp_helptext SP_INFORME_CLIENTE
CREATE PROCEDURE [dbo].[SP_INFORME_CLIENTE]
AS
BEGIN
 SET NOCOUNT ON
 SELECT rut = CONVERT(CHAR(10),clrut)+'-'+cldv ,
  clcodigo     ,
  clnombre     ,
  'nombreentidad' = (Select rcnombre from entidad),
  tipo = (SELECT tbglosa FROM TABLA_GENERAL_DETALLE WHERE tbcateg=72 AND tbcodigo1=cltipcli)
 FROM CLIENTE,VIEW_MDAC
 WHERE clfecingr=acfecproc
 SET NOCOUNT OFF

END
GO
