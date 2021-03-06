USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_EJECUTIVO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_EJECUTIVO]
 (
 @Codigo  NUMERIC(2) ,
 @Nombre  CHAR(30) ,
 @Sucursal  NUMERIC(4) ,
 @Monto_Linea NUMERIC(9) 
 )
AS
BEGIN
SET NOCOUNT ON
IF EXISTS(SELECT Codigo FROM Ejecutivo where Codigo=@Codigo)
 UPDATE EJECUTIVO SET  Codigo    = @Codigo ,
    Nombre    = @Nombre ,
    Sucursal  = @Sucursal ,
    Monto_Linea = @Monto_Linea 
 WHERE Codigo = @Codigo
ELSE
 INSERT  INTO EJECUTIVO
  (
   codigo ,
  nombre ,
  sucursal,
  monto_linea
  )
 VALUES (
  @Codigo  ,
  @Nombre  ,
  @Sucursal,
  @Monto_Linea
  )
 
IF @@error <> 0 BEGIN
 SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END
SET NoCount OFF
SELECT 'SI'
END
GO
