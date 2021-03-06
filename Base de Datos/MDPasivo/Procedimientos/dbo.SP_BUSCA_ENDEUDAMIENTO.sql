USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_ENDEUDAMIENTO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_ENDEUDAMIENTO]
	                              ( @rut_cli NUMERIC(9)
                                      , @codigo  NUMERIC(9)
                                      )
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

  SELECT 'Rut_cliente1'=Rut_cliente
      ,  'Codigo_Cliente1'=Codigo_Cliente
      ,  FechaAsignacion
      ,  FechaVencimiento
      ,  Bloqueado
      ,  TotalAsignado
      ,  'productoocupado'=TotalOcupado
      ,  'otrosocupado'=0
      ,  'TotalOcupado'=TotalOcupado
      ,  TotalDisponible
      ,  TotalExceso
      ,  codigo_grupo
      ,  descripcion
      ,  monto = CONVERT(FLOAT,0)
      ,  'porcentaje1' = CONVERT(FLOAT,0)
      INTO #TEMP1
          FROM 
            LINEA_GENERAL
         ,  GRUPO_PRODUCTO
         WHERE Rut_Cliente = @rut_cli
          AND  Codigo_Cliente = @codigo

      UPDATE #TEMP1
              SET monto = A.totalocupado
              FROM LINEA_ENDEUDAMIENTO_BANCO_DETALLE A
              WHERE A.Rut_Cliente = Rut_Cliente1
              AND  A.Codigo_Cliente = Codigo_Cliente1
              AND  A.Codigo_grupo = #TEMP1.Codigo_grupo

   IF EXISTS(SELECT 1 FROM LINEA_ENDEUDAMIENTO_BANCO WHERE Rut_Cliente = @rut_cli AND Codigo_Cliente = @Codigo) BEGIN
      UPDATE #TEMP1
            SET   porcentaje1 = porcentaje
            ,     #TEMP1.TotalAsignado = A.TotalAsignado
            ,     #TEMP1.TotalDisponible = A.TotalDisponible
            ,     #TEMP1.TotalExceso = A.TotalExceso
            ,     #TEMP1.productoocupado = A.productoocupado
            ,     #TEMP1.otrosocupado = A.otrosocupado
            ,     #TEMP1.TotalOcupado = A.TotalOcupado

            FROM LINEA_ENDEUDAMIENTO_BANCO A
            WHERE A.Rut_Cliente = Rut_Cliente1
            AND  A.Codigo_Cliente = Codigo_Cliente1
   END

      SELECT * FROM #TEMP1

SET NOCOUNT OFF
END


GO
