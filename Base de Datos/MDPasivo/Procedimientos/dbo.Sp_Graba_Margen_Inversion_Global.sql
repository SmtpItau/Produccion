USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Margen_Inversion_Global]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Graba_Margen_Inversion_Global]
      (
                @RUT_CARTERA            NUMERIC(9)
         ,      @ID_SISTEMA             CHAR(3)
         ,      @CODIGO_PRODUCTO        VARCHAR(5)
         ,      @SERIADO                CHAR(1)
         ,      @PLAZO_DESDE            NUMERIC(7,0)
         ,      @PLAZO_HASTA            NUMERIC(7,0)
         ,      @PORCENTAJE_ASIGNADO    NUMERIC(8,4)
         ,      @TOTALASIGNADO          NUMERIC(19,4)
         ,      @TOTALOCUPADO           NUMERIC(19,4)
         ,      @TOTALDISPONIBLE        NUMERIC(19,4)
         ,      @TOTALEXCESO            NUMERIC(19,4)
         ,      @SW                     INTEGER
      )
AS
BEGIN

  SET DATEFORMAT DMY
  SET NOCOUNT ON

   IF @SW = 2
   BEGIN
      DELETE MARGEN_INVERSION_GLOBAL
      WHERE  rut_cartera      =   @RUT_CARTERA
      AND    id_sistema       =   @ID_SISTEMA
      AND    codigo_producto  =   @CODIGO_PRODUCTO
      AND    seriado          =   @SERIADO
   END

   IF NOT EXISTS( SELECT 1 FROM   MARGEN_INVERSION_GLOBAL
                           WHERE  rut_cartera      =   @RUT_CARTERA
                           AND    id_sistema       =   @ID_SISTEMA
                           AND    codigo_producto  =   @CODIGO_PRODUCTO
                           AND    seriado          =   @SERIADO
                           AND    plazo_desde      =   @PLAZO_DESDE
            )
   BEGIN

         INSERT INTO     MARGEN_INVERSION_GLOBAL
               (         rut_cartera
                  ,      id_sistema
                  ,      codigo_producto
                  ,      seriado
                  ,      plazo_desde
                  ,      plazo_hasta
                  ,      porcentaje_asignado
                  ,      TotalAsignado
                  ,      TotalOcupado
                  ,      TotalDisponible
                  ,      TotalExceso                  
               )
          VALUES
               (
                         @RUT_CARTERA
                  ,      @ID_SISTEMA
                  ,      @CODIGO_PRODUCTO
                  ,      @SERIADO
                  ,      @PLAZO_DESDE
                  ,      @PLAZO_HASTA
                  ,      @PORCENTAJE_ASIGNADO
                  ,      @TOTALASIGNADO
                  ,      @TOTALOCUPADO
                  ,      @TOTALDISPONIBLE
                  ,      @TOTALEXCESO
               )


   END ELSE
   BEGIN

         UPDATE MARGEN_INVERSION_GLOBAL

         SET    plazo_hasta         =   @PLAZO_HASTA
         ,      porcentaje_asignado =   @PORCENTAJE_ASIGNADO
         ,      TotalAsignado       =   @TOTALASIGNADO
         ,      TotalOcupado        =   @TOTALOCUPADO
         ,      TotalDisponible     =   @TOTALDISPONIBLE
         ,      TotalExceso         =   @TOTALEXCESO

         WHERE  rut_cartera         =   @RUT_CARTERA
         AND    id_sistema          =   @ID_SISTEMA
         AND    codigo_producto     =   @CODIGO_PRODUCTO
         AND    seriado             =   @SERIADO
         AND    plazo_desde         =   @PLAZO_DESDE

   END

SET NOCOUNT OFF

END





GO
