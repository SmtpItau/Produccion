USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_BANCOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BUSCA_BANCOS]( @Moneda VARCHAR(3) )
AS
BEGIN
SELECT cclctacorta,
       cclbanco
  FROM MECC
 WHERE (@Moneda = '' OR @Moneda = cclmoneda)
END   /* FIN PROCEDIMIENTO */
--SELECT * FROM MECC
--SP_BUSCA_BANCOS
--SP_HELP MECC


GO
