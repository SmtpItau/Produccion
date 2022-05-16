USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_plan_cuentas]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_plan_cuentas]
AS
BEGIN
  SET NOCOUNT ON 
  SELECT cuenta,
   descripcion,
   glosa,
   tipo_cuenta,
   'hora'  		= CONVERT(VARCHAR(10),GETDATE(),108),
   'nombreentidad' 	= (Select rcnombre from entidad)
  FROM PLAN_DE_CUENTA
  SET NOCOUNT OFF
END
---SELECT * FROM PLAN_DE_CUENTA







GO
