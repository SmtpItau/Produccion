USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_SUCURSAL]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_SUCURSAL] 
  (
  @Codigo_Sucursal  NUMERIC(2), 
  @Nombre    CHAR(30)
  )
AS
BEGIN
SET NOCOUNT ON
IF EXISTS (SELECT Codigo_Sucursal FROM Sucursal WHERE Codigo_Sucursal = @Codigo_Sucursal)
           UPDATE SUCURSAL 
           SET Codigo_Sucursal  = @Codigo_Sucursal ,
               Nombre  = @Nombre  
    WHERE Codigo_Sucursal = @Codigo_Sucursal
ELSE
    INSERT INTO  SUCURSAL  ( 
    Codigo_Sucursal ,
    Nombre 
    )
     VALUES (
       @Codigo_Sucursal,
       @Nombre
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
