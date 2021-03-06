USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Area_Producto]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Grabar_Area_Producto]
                ( 
                   @codigo_area      VARCHAR   (05) ,   
                   @descripcion      VARCHAR   (50),
                   @Posicion_Cambio  CHAR(1),
                   @Posicion_Futuro  CHAR(1),
                   @Contabilidad_Btr CHAR(1),
                   @Contabilidad_Inv CHAR(1)
                 )

AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy


   DECLARE @Descripcion_anterior VARCHAR(50) 
   DECLARE @Posicion_Cambio_anterior CHAR(1) 
   DECLARE @Posicion_Futuro_anterior CHAR(1) 
   DECLARE @Contabilidad_Inv_anterior CHAR(1)
   DECLARE @Contabilidad_Btr_anterior CHAR(1)

   IF EXISTS (SELECT codigo_area FROM AREA_PRODUCTO WHERE codigo_area = @codigo_area)  
   BEGIN

        SELECT @Descripcion_anterior      = descripcion ,
               @Posicion_Cambio_anterior  = posicion_cambio,
               @Posicion_Futuro_anterior  = posicion_Futuro,
               @Contabilidad_Btr_anterior  = Contabilidad_Btr ,
               @Contabilidad_Inv_anterior          = Contabilidad_Inv
        FROM AREA_PRODUCTO
        WHERE  codigo_area = @codigo_area

        IF @Descripcion_anterior <> @descripcion OR  @Posicion_Cambio_anterior <> @posicion_cambio  or @Posicion_Futuro_anterior  <> @Posicion_Futuro or 
           @Contabilidad_Btr_anterior  <> @Contabilidad_Btr or  @Contabilidad_Inv_anterior  <> @Contabilidad_Inv
        BEGIN 

            UPDATE AREA_PRODUCTO SET 
                    codigo_area          = @codigo_area  
                ,   descripcion          = @descripcion
                ,   posicion_cambio      = @posicion_cambio
                ,   posicion_Futuro      = @Posicion_Futuro
                ,   contabilidad_Btr     = @contabilidad_btr
                ,   contabilidad_Inv     = @contabilidad_Inv
            WHERE  codigo_area = @codigo_area
        
            SELECT "MOD"      

        END ELSE BEGIN

            SELECT "OK"
        END

   END ELSE BEGIN

      INSERT AREA_PRODUCTO
            (   codigo_area
            ,   descripcion
            ,   posicion_cambio
            ,   posicion_futuro
            ,   contabilidad_btr
            ,   contabilidad_inv
            )
         VALUES 
            (   @codigo_area
            ,   @descripcion
            ,   @posicion_cambio
            ,   @Posicion_Futuro
            ,   @contabilidad_btr
            ,   @contabilidad_inv
            )
        SELECT "SI"
   END

   SET NOCOUNT  OFF



END



GO
