USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacLinCreGen_Busca_Nombre]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BacLinCreGen_Busca_Nombre]
   (	@rut_cliente	NUMERIC(9)
        ,@clcodigo      NUMERIC(9)  )

AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   DECLARE @nombre CHAR(70)	


	   SELECT clnombre,clrut,cldv  
           FROM   CLIENTE WITH (NOLOCK)
           WHERE  clrut    = @rut_cliente
           AND    clcodigo = @clcodigo

END







GO
