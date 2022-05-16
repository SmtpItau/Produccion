USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLA_VERIFICA_OPERACION]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Planilla_Verifica_Operacion    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Planilla_Verifica_Operacion    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_PLANILLA_VERIFICA_OPERACION]
               (
                  @xnumope    NUMERIC (12),
                  @xentidad   NUMERIC (12)
               )
AS
BEGIN
   SET NOCOUNT ON
   SELECT 
      'Numope' = CASE @xNumOpe
                    WHEN (SELECT monumope 
                              FROM VIEW_MEMO  --BacCambio..memo  
                              WHERE moentidad = @xentidad  
                                 AND monumope = @xNumOpe ) THEN 'MEMO'  
                    WHEN (SELECT monumope 
                              FROM VIEW_MEMOH  --BacCambio..memoh 
                              WHERE moentidad = @xentidad
                                 AND monumope = @xNumOpe ) THEN 'MEMOH' 
                 ELSE 
                    'NO' 
                 END
   SET NOCOUNT OFF
END
GO
