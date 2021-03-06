USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_OMA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_OMA] 
      (   
         @codigo   NUMERIC(5)
      )
AS
BEGIN
   DECLARE @CodGral NUMERIC (3)
   IF @codigo = 0
      BEGIN
         SELECT
                codigo_tabla          --TABLA
               ,codigo_numerico       --CODIGO OMA
               ,codigo_caracter       --DEPURA
               ,glosa                 --GLOSA 
           FROM VIEW_AYUDA_PLANILLA
          WHERE CODIGO_TABLA = 14
      END
   ELSE
      BEGIN
         SELECT  @CodGral = (SELECT codigo_tabla FROM VIEW_AYUDA_PLANILLA WHERE codigo_numerico = @codigo)
         SELECT
                codigo_tabla          --TABLA
               ,codigo_numerico       --CODIGO OMA
               ,codigo_caracter       --DEPURA
               ,glosa                 --GLOSA 
           FROM VIEW_AYUDA_PLANILLA
          WHERE CODIGO_TABLA = @CodGral
      END
END
-- Sp_Carga_Oma 110
-- SP_HELP VIEW_AYUDA_PLANILLA



GO
