USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Moneda]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Grabar_Moneda]( @sistema  CHAR(3) , -- Sistema MDTC = 49
                                   @codmon   INTEGER , -- Codigo Moneda
                                   @codmonpag  INTEGER , -- Codigo Moneda a Pagar
				   @codfor   integer , -- codigo forma	
                                   @estado   CHAR(1) ) -- Estado de la relacion
AS
BEGIN

     SET NOCOUNT ON
     SET DATEFORMAT dmy

     IF EXISTS (SELECT 1 FROM MONEDA_FORMA_DE_PAGO WHERE mfcodmon = @codmon AND mfcodfor = @codfor and mfmonpag = @codmonpag 
                                                   AND   mfsistema = @sistema    )
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




GO
