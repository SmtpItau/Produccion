USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICAR_TRASPASOS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[SP_VERIFICAR_TRASPASOS]
            (   @dFecha     DATETIME
            ,   @cSistema   CHAR(03)
            ,   @nNumoper   NUMERIC(10,0)
            )
AS
BEGIN

   SET NOCOUNT ON

   SELECT nombre_sistema
      ,   montotraspasado
   FROM   LINEA_TRASPASO      a
      ,   VIEW_SISTEMA_CNT    b
   WHERE fechainicio     = @dFecha
     AND sistemarecibio  = @cSistema
     AND numerooperacion = @nNumoper
     AND a.id_sistema    = b.id_sistema

   SET NOCOUNT OFF

END





GO
