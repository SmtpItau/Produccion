USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_PlanillaOperacion]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Elimina_PlanillaOperacion]
      (
            @CODIGO_PRODUCTO         VARCHAR(5)
        ,   @MONEDA                  CHAR(3)
        ,   @VCTO_FISICO             CHAR(1)
        ,   @TIP_OPE                 CHAR(1)
        ,   @TIP_CLI                 NUMERIC(5)
        ,   @COD_COM                 CHAR(6)
--        ,   @COD_CON                 CHAR(3)
        ,   @CONDICION               VARCHAR(10)
      )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

     IF NOT EXISTS ( SELECT 1 FROM CODIGO_PLANILLA_AUTOMATICA
                              WHERE   codigo_producto         =   @CODIGO_PRODUCTO
                              AND     tipo_cliente            =   @TIP_CLI
                              AND     tipo_operacion          =   @TIP_OPE
                              AND     codigo_moneda           =   @MONEDA
                              AND     vencimiento_fisico      =   @VCTO_FISICO
                  )
     BEGIN
		SELECT 'NO','NO EXISTE CODIGO DE PLANILLA'	
     END ELSE BEGIN
     
             DELETE CODIGO_PLANILLA_AUTOMATICA   
             WHERE  codigo_producto         =   @CODIGO_PRODUCTO
             AND    tipo_cliente            =   @TIP_CLI
             AND    tipo_operacion          =   @TIP_OPE
             AND    codigo_moneda           =   @MONEDA
             AND    vencimiento_fisico      =   @VCTO_FISICO

              SELECT  'OK', 'Eliminación Exitosa ... !'
              RETURN 
     END

SET NOCOUNT OFF
END

GO
