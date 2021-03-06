USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMLEERNOMBRES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_EmLeerNombres    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_EmLeerNombres    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_EMLEERNOMBRES]  (
    @emnombre1 CHAR (30)
     )
AS
BEGIN   
 SET ROWCOUNT 50
 SELECT  emcodigo  ,
         emrut     ,
         emdv      ,
         emnombre  ,
         emgeneric ,
         emdirecc  ,
         emcomuna  ,
         emtipo
      FROM
         EMISOR
      WHERE
         emnombre  > @emnombre1
      ORDER BY
         emnombre
 SET ROWCOUNT 0
   RETURN
END  
GO
