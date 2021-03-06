USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_MONEDAP]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Monedap    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Monedap    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_MONEDAP](  @codmon  INTEGER ,
                                     @codprod INTEGER,
         @codfor  integer )
AS
BEGIN
 
     SET NOCOUNT ON
     IF EXISTS (SELECT 1 FROM MONEDA_FORMA_DE_PAGO WHERE (mfmonpag = @codprod or mfmonpag = 0) AND mfcodmon = @codmon and mfcodfor = @codfor)
     BEGIN
 
     DELETE FROM MONEDA_FORMA_DE_PAGO WHERE (mfmonpag = @codprod or mfmonpag = 0) AND mfcodmon = @codmon and mfcodfor = @codfor
     IF @@ERROR <> 0  
        SELECT -1, 'ERROR no se puede eliminar esta Relacion Moneda/Producto'
     END  -- IF
END
GO
