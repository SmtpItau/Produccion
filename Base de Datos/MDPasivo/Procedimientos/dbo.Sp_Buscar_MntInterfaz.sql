USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_MntInterfaz]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Buscar_MntInterfaz]
               (
                   @entidad       NUMERIC      (09)
               ,   @sistema       CHAR         (03)
               ,   @area          VARCHAR      (05) = ''
               )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


   SELECT
          codigo_interfaz        --1
      ,   nombre                 --2
      ,   descripcion            --3
      ,   ruta_acceso            --4
      ,   tipo_interfaz          --5
      ,   codigo_cartera         --6
      ,   'Count' = (SELECT COUNT(*) FROM INTERFAZ WHERE    rut_entidad     = @entidad
                                                      AND   id_sistema      = @sistema  ) --7
      ,   Diaria                 --8
      ,   'Dias' = CASE WHEN Dias = '' THEN '' ELSE ISNULL(LTRIM(RTRIM(Dias)) +  '.','')        END     --9
      ,   Mensual                --10
      ,   Casilla                --11
      ,   Nemotecnico            --12
      ,   Path_Inicio            --13
      ,   Archivo_Inicio         --14
      ,   Fijo_Inicio            --15
      ,   Fecha_Inicio           --16
      ,   Extencion_Inicio       --17
      ,   Path_Final             --18
      ,   Archivo_Final          --19
      ,   Fijo_Final             --20
      ,   Fecha_Final            --21
      ,   Extencion_Final        --22

   FROM INTERFAZ
   
   WHERE    rut_entidad     = @entidad
      AND   id_sistema      = @sistema   


END





GO
