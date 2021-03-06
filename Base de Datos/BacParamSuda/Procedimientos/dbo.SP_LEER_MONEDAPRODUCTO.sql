USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDAPRODUCTO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_MonedaProducto    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
CREATE PROCEDURE [dbo].[SP_LEER_MONEDAPRODUCTO]( @CodProd   INTEGER =  0 ,
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
       FROM PRODUCTO_MONEDA          --mdmp  ,
            LEFT JOIN TABLA_GENERAL_DETALLE a ON mpproducto = a.tbcodigo1  AND a.tbcateg  = 1050 AND PRODUCTO_MONEDA.mpsistema =@SISTEMA,  --mdtc a,  -- Productos
            MONEDA b                  --mdmn b   -- Monedas
      WHERE (mpproducto = @CodProd   OR @CodProd   =  0)
        AND (mpcodigo   = @CodMoneda OR @CodMoneda =  0)
        AND (mpestado   = @Activo    OR @Activo    = '')
        AND (b.mncodmon = mpcodigo )                           -- Glosa de Moneda
           SET NOCOUNT OFF
END

GO
