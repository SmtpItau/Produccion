USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACLINCREGEN_BUSCA_TODOS_CASAMATRIZ]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACLINCREGEN_BUSCA_TODOS_CASAMATRIZ] 
AS
BEGIN
 DECLARE
  @nombre CHAR(70) 
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM LINEA_GENERAL )
 BEGIN
  SET @nombre = ''--(SELECT clnombre FROM CLIENTE WHERE clrut = @rut_cliente) 
  SELECT  
                        clnombre 
   ,rut_cliente
   ,codigo_cliente
   ,fechaasignacion
   ,fechavencimiento
   ,fechafincontrato
   ,LINEA_GENERAL.Bloqueado
   ,totalasignado
   ,totalocupado
   ,totaldisponible
   ,totalexceso
   ,totaltraspaso
   ,totalrecibido
   ,rutcasamatriz
   ,codigocasamatriz
  FROM LINEA_GENERAL,
   CLIENTE
  WHERE clrut = rut_cliente
  AND clcodigo = codigo_cliente
 END
 ELSE BEGIN
  SELECT  
    'nombre'  = ''
   ,'rut_cliente'  = 0
   ,'codigo_cliente' = 0
   ,'fechaasignacion' = ''
   ,'fechavencimiento' = ''
   ,'fechafincontrato' = ''
   ,'bloqueado'  = ''
   ,'totalasignado' = 0
   ,'totalocupado'  = 0
   ,'totaldisponible' = 0
   ,'totalexceso'  = 0
   ,'totaltraspaso' = 0
   ,'totalrecibido' = 0
   ,'rutcasamatriz' = 0
   ,'codigocasamatriz' = 0
 END
 SET NOCOUNT OFF
END
GO
