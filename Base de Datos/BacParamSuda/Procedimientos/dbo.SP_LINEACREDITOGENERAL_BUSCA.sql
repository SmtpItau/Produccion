USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_BUSCA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_BUSCA]
 (@rut_cli NUMERIC(9),
  @cod_cli NUMERIC(6))
  
AS BEGIN
SET NOCOUNT ON
SELECT  
 'SUPERRUT'=STR(c.clrut)+'-'+c.cldv,
 c.clnombre,
 a.rut_cliente,
 a.codigo_cliente,
 b.fechaasignacion,             
 b.fechavencimiento,
 b.fechafincontrato,
 b.bloqueado,
 b.totalasignado,
 b.totalocupado,
 b.totaldisponible,
 b.totalexceso,
 b.totaltraspaso,
  b.totalrecibido,
 b.rutcasamatriz,
 b.codigocasamatriz,
 a.id_sistema,
 a.fechaasignacion,
 a.fechavencimiento,
 a.fechafincontrato,
 a.realizatraspaso,
 a.bloqueado,
 a.compartido,
 a.controlaplazo,
 a.totalasignado,
 a.totalocupado,
 a.totaldisponible,
 a.totalexceso,
 a.totaltraspaso,
 a.totalrecibido,
 a.sinriesgoasignado,
 a.sinriesgoocupado,
 a.sinriesgodisponible,
 a.sinriesgoexceso,
 a.conriesgoasignado,
 a.conriesgoocupado,
 a.conriesgodisponible,
 a.conriesgoexceso
 FROM LINEA_SISTEMA a,
  LINEA_GENERAL b,
  CLIENTE c
 WHERE a.rut_cliente   = b.rut_cliente
 AND a.Codigo_Cliente= b.Codigo_Cliente
 and a.rut_cliente   = @rut_cli
 AND a.Codigo_Cliente= @cod_cli
 and c.clrut  = @rut_cli
 AND c.clcodigo = @cod_cli
 
SET NOCOUNT OFF
END
--Sp_LineaCreditoGeneral_Busca  10512216
--select * from LINEA_SISTEMA

GO
