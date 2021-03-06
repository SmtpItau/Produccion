USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMELOG]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_InformeLog    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_InformeLog    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_INFORMELOG]( @xFechaDesde  DATETIME  ,
    @xFechaHasta  DATETIME  )
AS
BEGIN
set nocount on
  SELECT nombre_sistema   ,
   loguser    ,
   logfecha   ,
   logfechaapp   ,
   loghora    ,
   logevento
   FROM LOG_USUARIO,SISTEMA_CNT
   WHERE logfecha >= @xFechaDesde AND
         logfecha <= @xFechaHasta  AND
         logsistema=id_sistema
    ORDER BY nombre_sistema,logfecha
END
--Sp_InformeLog '20000601','20000630'
GO
