USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_CLIENTES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_CLIENTES]
   (   @nRut      NUMERIC(10)   = 0
   ,   @nCodigo	  INT			= 0
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT clrut
   ,      cldv
   ,      clcodigo
   ,      clnombre
   ,      clswift
   FROM   BacParamSuda.dbo.CLIENTE with(nolock)
   WHERE  cltipcli   = 1 
     AND  bloqueado <> 'S'
     AND ( (clrut    = @nRut    OR @nRut    = 0)
       AND (clcodigo = @nCodigo OR @nCodigo = 0)
         )
   ORDER BY clnombre

END
GO
