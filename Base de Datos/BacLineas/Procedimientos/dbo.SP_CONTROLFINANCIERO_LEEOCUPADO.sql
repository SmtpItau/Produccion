USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLFINANCIERO_LEEOCUPADO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_ControlFinanciero_LeeOcupado    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
CREATE PROCEDURE [dbo].[SP_CONTROLFINANCIERO_LEEOCUPADO]
AS BEGIN
 SET NOCOUNT ON
  IF EXISTS(SELECT invextocupado FROM CONTROL_FINANCIERO)
     BEGIN
   SELECT invextocupado, 'ESNULO'='NO', invexttotal FROM CONTROL_FINANCIERO
     RETURN
  END
  SELECT 'INVEXTOCUPADO'=.0000 , 'ESNULO'='SI', 'INVEXTTOTAL'=.0000
 SET NOCOUNT OFF
END

GO
