USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BFORP]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BForp    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_BForp    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BFORP] (@codigo  NUMERIC(2))
AS
BEGIN
 SELECT codigo,glosa,perfil,codgen,glosa2,cc2756,afectacorr,
               diasvalor,numcheque,ctacte 
       
        FROM FORMA_DE_PAGO
        WHERE codigo = @codigo
END
GO
