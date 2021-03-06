USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCODIGOS2]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERCODIGOS2] 
                  (
                    @cod_cat  VARCHAR(5)
                  )
AS
BEGIN   
	SELECT codigo_clasificacion 
            ,  codigo_clasificacion_detalle 
            ,  descripcion
          FROM VIEW_CLIENTE_CLASIFICACION_DETALLE
     	 WHERE codigo_clasificacion = @cod_cat
     	
	ORDER BY descripcion
END
GO
