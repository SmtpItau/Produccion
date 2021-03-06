USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARTASASMTM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARTASASMTM] ( @codigo              NUMERIC ( 05, 00 ),
                                     @plazo               NUMERIC ( 05, 00 ),
                                     @tasa_compra         FLOAT             ,
                                     @tasa_venta          FLOAT             ,
                                     @lleva_plazo         NUMERIC ( 01, 00 ),
                                     @tasa_nominal        FLOAT      ,
                                     @tasa_uf             FLOAT      ,
                                     @precio_nominal      FLOAT      ,
                                     @punto_fwd           FLOAT             ,
                                     @desviacion_estandar FLOAT             ,
                                     @tasa_var            FLOAT      ,
                                     @desviacion1         FLOAT             ,
                                     @desviacion2         FLOAT             ,
                                     @desviacion3         FLOAT             ,
                                     @desviacion_total    FLOAT             ,
                                     @media1              FLOAT             ,
                                     @media2              FLOAT             ,
                                     @media3              FLOAT             ,
                                     @media_total         FLOAT             ,
                                     @fecha               DATETIME          ,
                                     @tasa_efectiva       FLOAT             ,
                                     @elimina             NUMERIC ( 01, 00 )
                                   )
AS
BEGIN
   SET NOCOUNT ON
   IF @elimina = 0
   BEGIN
      IF EXISTS ( SELECT * 
                  FROM   view_tasa_fwd
                  WHERE  codigo = @codigo AND
                         plazo  = @plazo  AND
                         fecha  = @fecha
                )
      BEGIN
         UPDATE view_tasa_fwd
         SET    codigo              = @codigo             ,
                plazo               = @plazo              ,
                tasa_compra         = @tasa_compra        ,
                tasa_venta          = @tasa_venta         ,
                lleva_plazo         = @lleva_plazo        ,
                tasa_nominal        = ROUND(@tasa_nominal,4)       ,
                tasa_uf             = ROUND(@tasa_uf,4)            ,
                precio_nominal      = @precio_nominal     ,
                punto_fwd           = @punto_fwd          ,
                desviacion_estandar = @desviacion_estandar,
                tasa_var            = ROUND(@tasa_var,4)           ,
                desviacion1         = @desviacion1        ,
                desviacion2         = @desviacion2        ,
                desviacion3         = @desviacion3        ,
                desviacion_total    = @desviacion_total   ,
                media1              = @media1             ,
                media2              = @media2             ,
                media3              = @media3             ,
                media_total         = @media_total        ,
                fecha               = @fecha              ,
                tasa_efectiva       = @tasa_efectiva
         WHERE  codigo = @codigo AND
                plazo  = @plazo  AND
                fecha  = @fecha
      END
      ELSE
      BEGIN
         INSERT view_tasa_fwd ( codigo             ,
                                plazo              ,
                                tasa_compra        ,
                                tasa_venta         ,
                                lleva_plazo        ,
                                tasa_nominal       ,
                                tasa_uf            ,
                                precio_nominal     ,
                                punto_fwd          ,
                                desviacion_estandar,
                                tasa_var           ,
                                desviacion1        ,
                                desviacion2        ,
                                desviacion3        ,
                                desviacion_total   ,
                                media1             ,
                                media2             ,
                                media3             ,
                                media_total        ,
                                fecha              ,
                                tasa_efectiva
                              )
         VALUES               ( @codigo             ,
                                @plazo              ,
                                @tasa_compra        ,
                                @tasa_venta         ,
                                @lleva_plazo        ,
                                @tasa_nominal       ,
                                @tasa_uf            ,
                                @precio_nominal     ,
                                @punto_fwd          ,
                                @desviacion_estandar,
                                @tasa_var           ,
                                @desviacion1        ,
                                @desviacion2        ,
                                @desviacion3        ,
                                @desviacion_total   ,
                                @media1             ,
                                @media2             ,
                                @media3             ,
                                @media_total        ,
                                @fecha              ,
                                @tasa_efectiva
                              )
      END
   END
   ELSE
   BEGIN
      DELETE
      FROM   view_tasa_fwd
      WHERE  fecha = @fecha
   END
   SET NOCOUNT OFF
END

GO
