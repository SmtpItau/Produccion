USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_MonedaProducto]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Leer_MonedaProducto]( @CodProd   INTEGER =  0 ,
                                         @CodMoneda INTEGER =  0 ,
					 @SISTEMA   CHAR (4)     ,
                                         @Activo    CHAR(1) = '1')

AS
BEGIN

     SET NOCOUNT ON 
     SET DATEFORMAT dmy

     SELECT mpproducto           ,
            ISNULL(a.descripcion,'') ,
            mpcodigo             , -- Moneda
            ISNULL(b.mnglosa,'') ,
            mpestado

       FROM PRODUCTO_MONEDA,          --mdmp  ,
            PRODUCTO a,  --mdtc a,  -- Productos
            MONEDA b                  --mdmn b   -- Monedas


      WHERE (mpproducto = @CodProd   OR @CodProd   =  0)
        AND (mpcodigo   = @CodMoneda OR @CodMoneda =  0)
        AND (mpestado   = @Activo    OR @Activo    = '')
        AND (a.Codigo_producto =* mpproducto AND PRODUCTO_MONEDA.mpsistema =@SISTEMA )
        AND (b.mncodmon = mpcodigo )                           -- Glosa de Moneda

           SET NOCOUNT OFF
END



GO
