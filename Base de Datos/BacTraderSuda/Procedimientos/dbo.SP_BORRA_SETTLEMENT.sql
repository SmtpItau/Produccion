USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_SETTLEMENT]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BORRA_SETTLEMENT]( @Rut          NUMERIC(10) ,
                                 @Codigo       NUMERIC(5)  )
AS
BEGIN
DELETE MD_SETTLEMENT
 WHERE rut         = @Rut
   AND codigo      = @Codigo
END   /* FIN PROCEDIMIENTO */


GO
