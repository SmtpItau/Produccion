USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Margen_Inversion_Global]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Carga_Margen_Inversion_Global]
      (
             @SISTEMA      CHAR(3) = ' '
         ,   @PRODUCTO     CHAR(5) = ' '
         ,   @SERIE        CHAR(1) = ' '
      )
AS
BEGIN

 	SET DATEFORMAT DMY
	SET NOCOUNT ON


    SELECT  rut_cartera
    ,       id_sistema
    ,       codigo_producto
    ,       seriado
    ,       plazo_desde
    ,       plazo_hasta
    ,       porcentaje_asignado
    ,       TotalAsignado
    ,       TotalOcupado
    ,       TotalDisponible
    ,       TotalExceso
    FROM    MARGEN_INVERSION_GLOBAL
    WHERE   ( id_sistema        =   @SISTEMA  OR @SISTEMA    = ' ' )
    AND     ( codigo_producto   =   @PRODUCTO OR @PRODUCTO   = ' ' )
    AND     ( seriado           =   @SERIE    OR @SERIE      = ' ' )   

END



GO
