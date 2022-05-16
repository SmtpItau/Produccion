USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_PFE_CCE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BORRA_PFE_CCE]( @Rut          NUMERIC(10) ,
                              @Codigo       NUMERIC(5)  ,
                              @Tipo_Limite  CHAR(1)     )
AS
BEGIN
DELETE MD_PFE_CCE
 WHERE rut         = @Rut
   AND codigo      = @Codigo
   AND tipo_limite = @Tipo_Limite
END   /* FIN PROCEDIMIENTO */


GO
