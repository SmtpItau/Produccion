USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_PLAZO_CONTRAPARTE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BORRA_PLAZO_CONTRAPARTE]( @xRutCliente  NUMERIC(10)  ,
      @xTipoOperacion  CHAR(1)   )
AS
BEGIN
 DELETE MD_CONTRAPARTE WHERE  rut = @xRutCliente AND
         PRODUCTO=@xTipoOperacion
END


GO
