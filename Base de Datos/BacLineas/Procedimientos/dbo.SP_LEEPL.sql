USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEPL]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LeePl    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LeePl    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEEPL] (@emnombre1 CHAR (40))
AS
BEGIN   
set nocount on
 SELECT  a.codigo, a.descri, b.descor, a.pais  
 FROM METB04 a  , METB03 b  
      
        WHERE  a.descri  > @emnombre1 and a.pais = b.codigo
      ORDER BY a.descri
set nocount off
END  
--sp_leemo 'J'
--SP_HELP METB04
--select * from METB03
GO
