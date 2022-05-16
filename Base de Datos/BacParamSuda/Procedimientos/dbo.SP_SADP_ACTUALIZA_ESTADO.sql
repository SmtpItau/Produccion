USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_ACTUALIZA_ESTADO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_ACTUALIZA_ESTADO](@dFecha DATETIME,@iRut INT)
AS 
BEGIN
	
		--> SELECT  * FROM SADP_CUENTA_CAJA scc
		UPDATE SADP_CUENTA_CAJA 
		   SET bEstado =1 
		 WHERE iRutCliente =  @iRut
		   AND dFechaSaldo =  @dFecha
	
END 
GO
