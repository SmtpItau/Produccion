USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDOPLEERRUT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDOPLEERRUT]
       (
        @nrutcli     NUMERIC(9,0)   ,     -- RUT Cliente
        @nCodCli     NUMERIC(9,0) 
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   SELECT       oprutope          ,
                opdvope           ,
                opnombre
          FROM  VIEW_CLIENTE_OPERADOR
          WHERE oprutcli = @nrutcli and opcodcli = @ncodcli
   /*=======================================================================*/
   
SET NOCOUNT OFF
END

GO
