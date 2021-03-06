USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Planilla_Operacion]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Planilla_Operacion]
      (
             @codigo_producto     VARCHAR(5)
            ,@tipo_cliente        NUMERIC(5,0)
            ,@tipo_operacion      CHAR(1)   
            ,@codigo_moneda       CHAR(3)   
            ,@vencimiento_fisico  CHAR(1)   
      )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON
	
      SELECT  a.comercio
      ,       A.CONDICION
      ,       b.glosa
      ,       0
      ,       0
     
      FROM    CODIGO_PLANILLA_AUTOMATICA  a
      ,       CODIGO_COMERCIO             b
      
      WHERE 
            codigo_producto    = @codigo_producto    AND 
            tipo_cliente       = @tipo_cliente       AND 
            tipo_operacion     = @tipo_operacion     AND 
            codigo_moneda      = @codigo_moneda      AND
            vencimiento_fisico = @vencimiento_fisico AND   
            A.comercio         = B.comercio

END


GO
