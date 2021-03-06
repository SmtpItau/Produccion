USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLIENTES]
   (   @xMercado     CHAR(4)   
   ,   @RutCliente   NUMERIC(9) = 0
   ,   @CodCliente   SMALLINT   = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @xMercado = 'PTAS' 
   BEGIN

      SELECT clrut, cldv, clcodigo, clnombre = rtrim(ltrim(clnombre))
        FROM BacParamSuda.dbo.CLIENTE with(nolock)
       WHERE (clrut      = @RutCliente or @RutCliente = 0)
         AND (clcodigo   = @CodCliente or @CodCliente = 0)
	 AND (clvigente  = 'S') AND (cltipcli <= 4)
         AND (bloqueado <> 'S')
    ORDER BY ltrim(rtrim( clnombre ))

   END ELSE
   BEGIN

      SELECT clrut, cldv, clcodigo, clnombre = rtrim(ltrim(clnombre))
        FROM BacParamSuda.dbo.CLIENTE with(nolock)
       WHERE (clrut      = @RutCliente or @RutCliente = 0)
	 AND (clcodigo   = @CodCliente or @CodCliente = 0)
	 AND (clvigente  = 'S') 
         AND (Bloqueado <> 'S')
         AND (cltipcli >= 4 OR clgeneric IN('BCCH', 'CORPB') ) 
    ORDER BY ltrim(rtrim( clnombre ))

/*
   SELECT clrut, cldv, clcodigo, clnombre = rtrim(ltrim(clnombre))
     FROM BacParamSuda.dbo.CLIENTE with(nolock) where clgeneric = 'bcch'
*/

   END
END
GO
