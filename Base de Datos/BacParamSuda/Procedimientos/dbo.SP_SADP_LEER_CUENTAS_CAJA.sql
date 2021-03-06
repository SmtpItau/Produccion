USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_CUENTAS_CAJA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_CUENTAS_CAJA]
	(	@dFecha DATETIME	)
AS 
BEGIN
	
		SELECT iRutCliente
		,	   dbo.fxcliente(irutcliente,icodcliente, 'CDB' ) AS Nombre
		,	   fMontoSaldo
	    ,  CASE bEstado WHEN 1 THEN 'X' ELSE ' ' END AS bEstado
		  FROM dbo.SADP_CUENTA_CAJA
		 WHERE dFechaSaldo = @dFecha	
		   --AND bEstado = 0

END
GO
