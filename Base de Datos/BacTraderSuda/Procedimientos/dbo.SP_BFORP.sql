USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BFORP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BFORP] 
            (@codigo  numeric(2))
AS
BEGIN
 SELECT codigo,glosa,perfil,codgen,glosa2,cc2756,afectacorr,
               diasvalor,numcheque,ctacte 
       
        FROM VIEW_FORMA_DE_PAGO
        WHERE codigo = @codigo
END
 
--select * from METB01


GO
