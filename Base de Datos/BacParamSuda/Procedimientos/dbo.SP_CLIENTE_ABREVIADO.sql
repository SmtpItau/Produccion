USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTE_ABREVIADO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTE_ABREVIADO]( @glosa  CHAR(40) )
AS BEGIN
 SET NOCOUNT ON
 SELECT  clrut  ,
  Cldv  ,
  clnombre ,
  clcodigo
 FROM  cliente   ,
  abreviatura_cliente 
 WHERE claglosa = @glosa AND
  ( clarutcli = clrut  AND
  clacodigo = clcodigo )
 SET NOCOUNT OFF
END
-- sp_Cliente_Abreviado 100
GO
