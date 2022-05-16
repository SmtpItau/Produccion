USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LETRAS_HIPOTECARIA_ELIMINAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LETRAS_HIPOTECARIA_ELIMINAR]
(
                 @clrut   NUMERIC(9,0) ,
                 @CLCODIGO numeric(9,0)
                                 )
AS
  BEGIN
       DELETE  FROM LETRA_HIPOTECARIA_CLIENTE WHERE rut_cliente = @clrut and codigo_cliente = @clcodigo
  END

GO
