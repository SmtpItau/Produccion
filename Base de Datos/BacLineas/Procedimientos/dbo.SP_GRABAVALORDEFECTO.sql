USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAVALORDEFECTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAVALORDEFECTO]
     ( @Sistema   CHAR(3),
       @Producto  CHAR(4),
       @Area      CHAR(4),
       @Moneda    NUMERIC(3),
       @Monto     NUMERIC(25),
       @cOMA      NUMERIC(3),
       @cComercio CHAR(6),
       @cConcepto CHAR(6),
       @Fprecom   NUMERIC(3),
       @Fpencom   NUMERIC(3),
       @vOMA      NUMERIC(3),
       @vComercio CHAR(6),
       @vConcepto CHAR(6),
       @Fpreven   NUMERIC(3),
       @Fpenven   NUMERIC(3),
         @Contabiliza CHAR(1) = 'S' )
AS
BEGIN
SET NOCOUNT ON
BEGIN TRANSACTION
IF EXISTS (SELECT * FROM valor_defecto WHERE id_sistema      = @Sistema
                                         AND codigo_producto = @Producto
                                         AND codigo_area     = @Area)  BEGIN
   DELETE valor_defecto 
    WHERE id_sistema      = @Sistema
      AND codigo_producto = @Producto
      AND codigo_area     = @Area
END
INSERT valor_defecto 
VALUES( @sistema 
      , @producto 
      , @area
      , @fpencom
      , @fprecom
      , @cOMA
      , @cComercio
      , @cConcepto
      , @fpreven
      , @fpenven
      , @vOMA
      , @vComercio
      , @vConcepto
      , @contabiliza 
      , @monto
      , @moneda )
IF @@error <> 0  BEGIN
   ROLLBACK TRANSACTION
   RETURN
END
   
COMMIT TRANSACTION
END
GO
