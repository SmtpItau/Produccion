USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Eliminar_Area_Producto]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Eliminar_Area_Producto]
                (
                 @codigo_area     VARCHAR  (05) ,
                 @descripcion     VARCHAR  (50) ,
                 @iConsulta       CHAR(1) = 'N' 
                )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
	IF NOT EXISTS (SELECT 1 FROM CONFIGURACION_DE_VALORES WHERE nombre_original_campo = 'codigo_area' AND valor_caracter = @codigo_area) AND
 	   NOT EXISTS (SELECT 1 FROM DATOS_GENERALES WHERE codigo_area = @codigo_area) BEGIN

              IF @IConsulta = 'N' BEGIN                                 
	        DELETE FROM AREA_PRODUCTO  WHERE codigo_area = @codigo_area AND  descripcion = @descripcion
              END
             
              SELECT 'OK'  

        END ELSE
		SELECT 2
	RETURN
SET NOCOUNT OFF
END 

GO
