USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOMDASPRODUCTOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADOMDASPRODUCTOS]
AS
BEGIN
SET NOCOUNT ON
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM VIEW_MDAC                
 SELECT 'producto'  = mpproducto         ,
  'nombre' = descripcion         ,
  'codigoC' = ISNULL( (SELECT mnnemo FROM MONEDA WHERE mpcodigo = mncodmon ) , 'N/E' ) , 
  'codigoL' = ISNULL( (SELECT mnglosa FROM MONEDA WHERE mpcodigo = mncodmon) , 'N/E' ) ,
  'estado' = mpestado         ,  
  'sistema' = mpsistema         , 
  'hora'  = CONVERT(varchar(10), GETDATE(), 108)               ,
  'BANCO'  = @ACNOMPROP
        FROM  PRODUCTO_MONEDA ,
  PRODUCTO
 WHERE  mpproducto <> 0  AND
  codigo_producto = mpproducto
 ORDER BY producto,sistema
END
-- SELECT * FROM PRODUCTO_MONEDA where mpproducto = 30 and mpsistema = 'BFW'
-- SELECT * FROM PRODUCTO
-- DELETE PRODUCTO_MONEDA where mpproducto = 30 and mpsistema = 'BFW'
 
GO
