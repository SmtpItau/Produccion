USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacLinCreGen_Busca_xCasaMatriz]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_BacLinCreGen_Busca_xCasaMatriz] 
    (
    @rutcasamatriz NUMERIC(9),
    @codcasamatriz NUMERIC(6)
    )
AS
BEGIN
 DECLARE
  @nombre CHAR(70) 
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM LINEA_GENERAL WHERE rutcasamatriz = @rutcasamatriz AND CodigoCasaMatriz = @codcasamatriz)
 BEGIN
  SELECT  
                        clnombre
   ,rut_cliente
   ,codigo_cliente
   ,fechaasignacion
   ,fechavencimiento
   ,fechafincontrato
   ,LINEA_GENERAL.bloqueado
   ,totalasignado
   ,totalocupado
   ,totaldisponible
   ,totalexceso
   ,totaltraspaso
   ,totalrecibido
   ,rutcasamatriz
   ,codigocasamatriz
  FROM LINEA_GENERAL, cliente
  WHERE rutcasamatriz = @rutcasamatriz 
  AND CodigoCasaMatriz = @codcasamatriz
  AND clrut = rut_cliente
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
-- select * from  LINEA_GENERAL
GO
