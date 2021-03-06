USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CAMPOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CAMPOS]
                               (@SISTEMA          CHAR(6),
                                @TIPO_MOVIMIENTO  CHAR(6),
                                @TIPO_OPERACION   CHAR(6))
                              
AS
BEGIN
  SELECT 
         id_sistema ,
         tipo_movimiento,
         tipo_operacion,
         codigo_campo,
         descripcion_campo,
         nombre_campo_tabla,
         tipo_administracion_campo,
         isnull(tabla_campo,''),
         isnull(campo_tabla,''),
         isnull(campos_tablas,'')          
   FROM CAMPO_CNT 
   WHERE id_sistema = @SISTEMA
        AND tipo_movimiento = @TIPO_MOVIMIENTO
        AND tipo_operacion  = @TIPO_OPERACION
 AND tipo_administracion_campo = 'V' 
END 

GO
