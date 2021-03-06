USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAESISTEMASTHRESHOLD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAESISTEMASTHRESHOLD]
AS
BEGIN

   SET NOCOUNT ON

   SELECT nombre_sistema, id_sistema 
     FROM SISTEMA_CNT
    WHERE id_sistema IN('BFW','PCS')
      AND operativo   = 'S'
      AND gestion     = 'N'
 ORDER BY nombre_sistema

END
GO
