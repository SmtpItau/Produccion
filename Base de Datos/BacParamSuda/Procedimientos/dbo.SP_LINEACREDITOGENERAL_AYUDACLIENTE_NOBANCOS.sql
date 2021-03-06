USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE_NOBANCOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE_NOBANCOS]( @nRutcli NUMERIC (09,0) ,
        @nCodigo NUMERIC (09,0) )
AS BEGIN
 SET NOCOUNT ON
 SELECT 'RUT'=STR(clrut) + '-' + cldv, clcodigo,clnombre,STR(clrut),cldv 
 FROM CLIENTE
 WHERE cltipcli <> 1
 AND clrut    = @nRutcli
 AND clcodigo  = @nCodigo
 SET NOCOUNT OFF
END

GO
