USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_Busca_Cliente_Rut]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Busca_Cliente_Rut]
   (   @rut_cliente     NUMERIC(9)
   ,   @codigo_cliente  NUMERIC(9) = 1
   )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


   SELECT clrut
      ,   cldv
      ,   clcodigo
      ,   clnombre
      ,   clfax

   FROM   CLIENTE

   WHERE  clrut    = @rut_cliente
   AND    clcodigo = @codigo_cliente

END



GO
