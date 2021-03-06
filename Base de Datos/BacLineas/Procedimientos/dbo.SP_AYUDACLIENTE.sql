USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDACLIENTE]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AYUDACLIENTE]
   (   @RutCliente   NUMERIC(10) = 0
   ,   @CodCliente   NUMERIC(10) = 0
   )
AS 
BEGIN

   SET NOCOUNT ON

   IF @RutCliente = 0 
   BEGIN
   SELECT 'RUT'	= STR(clrut) + '-' + cldv
   ,      clcodigo
   ,      clnombre
   ,      STR(clrut)
   ,      cldv
   ,      cltipcli
   FROM   VIEW_CLIENTE
   WHERE (clrut    = @RutCliente or @RutCliente = 0)
   and   (clcodigo = @CodCliente or @CodCliente = 0)
   ORDER BY clnombre
   END ELSE
   BEGIN
   SELECT 'RUT'	= STR(clrut) + '-' + cldv
   ,      clcodigo
   ,      clnombre
   ,      STR(clrut)
   ,      cldv
   ,      cltipcli
   FROM   VIEW_CLIENTE
   WHERE (clrut    = @RutCliente or @RutCliente = 0)
   and   (clcodigo = (case when @RutCliente = 0 then 0 else @CodCliente end))
   ORDER BY clnombre
   END
END
GO
