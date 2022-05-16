USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEPA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LeePa    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LeePa    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEEPA] (@emnombre1 NUMERIC(3))
AS
BEGIN   
 SELECT  tbcateg,
  tbcodigo1,
  tbtasa,
  tbfecha,
  tbvalor,
  tbglosa,
  nemo
 FROM TABLA_GENERAL_DETALLE WHERE tbcateg=@emnombre1 order by tbglosa
 RETURN
END
GO
