USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_FORMAPAGO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAR_FORMAPAGO]
    (
    @nCodigo NUMERIC (2)
    )
AS 
BEGIN
 SELECT glosa, codigo FROM view_forma_de_pago WHERE codigo=@nCodigo
END


GO
