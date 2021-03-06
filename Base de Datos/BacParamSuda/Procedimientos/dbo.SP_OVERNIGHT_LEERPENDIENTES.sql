USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OVERNIGHT_LEERPENDIENTES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OVERNIGHT_LEERPENDIENTES](
      @sistema CHAR(3)
     )
AS
BEGIN
 SET NOCOUNT ON
 SELECT  sistema    ,
  nombre_sistema   ,
  Usuario    ,
  Monto_Operacion   ,
  ISNULL(acmaxovernight,0) ,
  ISNULL(acminovernight,0)
 FROM aprobacion_hedge ,
  sistema_cnt  ,
  view_meac 
 WHERE ( sistema = @sistema  OR
  @sistema = ' ' ) AND
  Aprobado = 0  AND
  sistema = sistema_cnt.id_sistema AND
  mercado = 'SPOT'
 SET NOCOUNT OFF
END
-- Sp_Hedge_LeerPendientes ''
-- select * from aprobacion_hedge

GO
