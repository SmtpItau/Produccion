USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CAMPO_CONTABILIDAD]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_CAMPO_CONTABILIDAD](
                                                 @codigo_concepto      CHAR(05) = ' '
                                            ,    @id_sistema           CHAR(03) = ' '
                                            ,    @codigo_producto      CHAR(05) = ' ')
AS      
BEGIN  
  



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

        SELECT   A.concepto_programa
            ,    A.id_sistema
            ,    A.codigo_producto
            ,    A.descripcion
            ,    B.descripcion + SPACE(100) + B.nombre_campo
            ,    A.negativo
        FROM CONCEPTO_PROGRAMA_CONTABLE  A
                ,NOMBRE_CAMPO_CONTABLE     B
        WHERE (A.concepto_programa   = @codigo_concepto   OR @codigo_concepto   = ' ')
              AND (A.id_sistema        = @id_sistema        OR @id_sistema        = ' ')
              AND (A.codigo_producto   = @codigo_producto   OR @codigo_producto   = ' ')
              AND  A.id_sistema        = B.id_sistema
              AND  A.codigo_producto   = B.codigo_producto
              AND  A.nombre_campo      = B.nombre_campo
            ORDER BY A.id_sistema
                ,    A.codigo_producto
                ,    A.concepto_programa

END


GO
