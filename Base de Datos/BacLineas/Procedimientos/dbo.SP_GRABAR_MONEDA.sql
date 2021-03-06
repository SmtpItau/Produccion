USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_MONEDA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GRABAR_MONEDA    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_GRABAR_MONEDA    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_GRABAR_MONEDA]( @sistema  CHAR(3) , -- Sistema MDTC = 49
                                   @codmon   INTEGER , -- Codigo Moneda
                                   @codmonpag  INTEGER , -- Codigo Moneda a Pagar
       @codfor   integer , -- codigo forma 
                                   @estado   CHAR(1) ) -- Estado de la relacion
AS
BEGIN
     SET NOCOUNT ON
     IF EXISTS (SELECT 1 FROM MONEDA_FORMA_DE_PAGO WHERE mfcodmon = @codmon AND mfcodfor = @codfor and mfmonpag = @codmonpag)
     BEGIN
          UPDATE MONEDA_FORMA_DE_PAGO 
             SET mfestado   = @estado
           WHERE mfsistema  = @sistema
             AND mfmonpag   = @codmonpag
             AND mfcodmon   = @codmon
          IF @@ERROR <> 0   BEGIN
             SELECT -1, 'ERROR no se puede Actualizar Relacion Moneda Producto'
          END 
     END ELSE BEGIN
          INSERT INTO MONEDA_FORMA_DE_PAGO(mfsistema,
      mfcodmon ,
                           mfmonpag ,
                           mfcodfor ,
                    mfestado  )
                    VALUES( @sistema ,
                            @codmon  ,
                            @codmonpag,
       @codfor,
       @estado  )
          IF @@ERROR <> 0   BEGIN
             SELECT -1, 'ERROR no se puede Agregar Relacion Moneda Producto'
          END 
     END
END  -- PROCEDURE
--select * from Moneda_Forma_De_Pago
GO
