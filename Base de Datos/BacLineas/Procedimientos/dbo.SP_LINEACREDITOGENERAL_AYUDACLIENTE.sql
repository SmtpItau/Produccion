USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE]
               (
               @RutCliente      NUMERIC(10) = 0
               )
AS
BEGIN
 SET NOCOUNT ON
    SELECT 'RUT'= STR(clrut) + '-' + cldv
    ,       clcodigo
    ,       clnombre
    ,       STR(clrut)
    ,       cldv  
       FROM VIEW_CLIENTE
      WHERE clrut = @RutCliente OR @RutCliente = 0
 SET NOCOUNT OFF
END
GO
