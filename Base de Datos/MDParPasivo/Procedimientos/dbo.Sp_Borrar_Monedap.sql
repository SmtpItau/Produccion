USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Monedap]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Borrar_Monedap](  @codmon  INTEGER ,
                                     @codprod INTEGER,
				     @codfor  INTEGER,
                                     @iSistema CHAR(3) )
AS
BEGIN
 
     SET NOCOUNT ON
     SET DATEFORMAT dmy
      
     IF EXISTS (SELECT 1 FROM MONEDA_FORMA_DE_PAGO WHERE (mfmonpag = @codprod or mfmonpag = 0) AND mfcodmon = @codmon and mfcodfor = @codfor
                                                   AND    mfsistema = @iSistema )

     BEGIN
	
     DELETE FROM MONEDA_FORMA_DE_PAGO WHERE (mfmonpag = @codprod or mfmonpag = 0) AND mfcodmon = @codmon and mfcodfor = @codfor
                                      AND    mfsistema = @iSistema 

     IF @@ERROR <> 0  

        SELECT -1, 'ERROR no se puede eliminar esta Relacion Moneda/Producto'

     END  -- IF

END






GO
