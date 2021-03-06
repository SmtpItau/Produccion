USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_COSTO_FONDO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_COSTO_FONDO](
                                       @Centro NUMERIC(5,4)
                                      ,@Codigo NUMERIC(3)
                                     )
AS
BEGIN
   UPDATE view_forma_de_pago 
      SET costo_de_fondo = @Centro 
    WHERE codigo = @Codigo
END

GO
