USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOLINEA_BUSCA_TODOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LINEACREDITOLINEA_BUSCA_TODOS]
 @RUTCLIENTE NUMERIC(9),
 @CODCLIENTE NUMERIC(9)
AS BEGIN
SET NOCOUNT ON
 SELECT  rut_cliente,
  codigo_cliente,
  id_sistema,
  plazodesde,
  plazohasta,
  porcentaje,
  totalasignado,
  totalocupado,
         totaldisponible,
  totalexceso,
         totaltraspaso,
         totalrecibido         
  FROM LINEA_POR_PLAZO
   WHERE rut_cliente=@RUTCLIENTE 
    AND codigo_cliente=@CODCLIENTE
   ORDER BY id_sistema
 SET NOCOUNT OFF
END

GO
