USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_MonedaProducto]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_MonedaProducto    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
CREATE PROCEDURE [dbo].[Sp_Leer_MonedaProducto]( @CodProd   INTEGER =  0 ,
                                         @CodMoneda INTEGER =  0 ,
      @SISTEMA   CHAR (4)     ,
                                         @Activo    CHAR(1) = '1')
AS
BEGIN
     SET NOCOUNT ON 
     SELECT mpproducto           ,
            ISNULL(a.tbglosa,'') ,
            mpcodigo             , -- Moneda
            ISNULL(b.mnglosa,'') ,
            mpestado
       FROM PRODUCTO_MONEDA,          --mdmp  ,
            TABLA_GENERAL_DETALLE a,  --mdtc a,  -- Productos
            MONEDA b                  --mdmn b   -- Monedas
      WHERE (mpproducto = @CodProd   OR @CodProd   =  0)
        AND (mpcodigo   = @CodMoneda OR @CodMoneda =  0)
        AND (mpestado   = @Activo    OR @Activo    = '')
        AND (a.tbcateg  = 1050 AND a.tbcodigo1 =* mpproducto AND PRODUCTO_MONEDA.mpsistema =@SISTEMA )
        AND (b.mncodmon = mpcodigo )                           -- Glosa de Moneda
           SET NOCOUNT OFF
END






GO
