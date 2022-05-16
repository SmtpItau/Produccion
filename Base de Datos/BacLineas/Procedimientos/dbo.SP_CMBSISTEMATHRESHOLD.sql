USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBSISTEMATHRESHOLD]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CMBSISTEMATHRESHOLD]
AS 
BEGIN

   SET NOCOUNT ON

   SELECT id_sistema, nombre_sistema
   FROM   bacparamsuda.dbo.SISTEMA_CNT
   WHERE  id_sistema in ('BFW','PCS')
   ORDER BY  nombre_sistema

END
GO
