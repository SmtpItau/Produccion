USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTES_ASOCIADOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTES_ASOCIADOS]
   (   @nRutcli   NUMERIC(9)
   ,   @nCodigo	  NUMERIC(9)
   )
AS
BEGIN

	SET NOCOUNT ON

   		IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE (@nRutcli = clrut_padre  AND @nCodigo = clcodigo_padre OR 
					@nRutcli = clrut_hijo  AND @nCodigo = clcodigo_hijo))
   			BEGIN
     				SELECT   'SI'
   		END ELSE
   			BEGIN
      				SELECT   'NO'
  		 	END

		END
GO
