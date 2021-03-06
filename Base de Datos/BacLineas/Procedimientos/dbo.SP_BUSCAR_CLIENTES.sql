USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_CLIENTES]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_CLIENTES]( @rutcliente CHAR(08))
AS
BEGIN
-- Swap: Guardar Como
 DECLARE @nCont INT
 DECLARE @fecha CHAR(10)
 SELECT @fecha  = CONVERT(CHAR(10),DATEADD(DD,-365,GETDATE()),103)
-- PRINT @FECHA
 SELECT @nCont = 0
 SET NOCOUNT ON
----+++++++++++++++ TRADER +++++++++++++++-------------------
-------- CARTERA MDCP ---------
IF EXISTS(SELECT * FROM BACTRADERSUDA..MDCP WHERE cprutcli = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM BACTRADERSUDA..MDCP
 WHERE BACTRADERSUDA..MDCP.cprutcli = @rutcliente
END
-------- CARTERA MDCI ---------
IF EXISTS(SELECT * FROM BACTRADERSUDA..MDCI WHERE cirutcli = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM BACTRADERSUDA..MDCI
 WHERE BACTRADERSUDA..MDCI.cirutcli = @rutcliente
END
-------- CARTERA MDVI ---------
IF EXISTS(SELECT * FROM BACTRADERSUDA..MDVI WHERE virutcli = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM BACTRADERSUDA..MDVI
 WHERE BACTRADERSUDA..MDVI.virutcli = @rutcliente
END
------- CARTERA historica-------
IF EXISTS(SELECT * FROM BACTRADERSUDA..MDMH WHERE morutcli = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACTRADERSUDA..MDMH
 WHERE  BACTRADERSUDA..MDMH.morutcli = @rutcliente AND
  BACTRADERSUDA..MDMH.mofecpro  < @fecha
  
END
----+++++++++++++++ FIN TRADER +++++++++++++++-------------------
----+++++++++++++++ FORWARD +++++++++++++++-------------------
-------- CARTERA MFCA-------  
IF EXISTS(SELECT * FROM BACFWDSUDA..MFCA WHERE cacodigo = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACFWDSUDA..MFCA
 WHERE  BACFWDSUDA..MFCA.cacodigo = @rutcliente 
END
------ CARTERA HISTORICA MFCAH ------
IF EXISTS(SELECT * FROM BACFWDSUDA..MFCAH WHERE cacodigo = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACFWDSUDA..MFCAH
 WHERE  BACFWDSUDA..MFCAH.cacodigo = @rutcliente AND
  BACFWDSUDA..MFCAH.cafecha  < @fecha
END
 SET NOCOUNT OFF
----+++++++++++++++ FIN FORWARD +++++++++++++++-------------------
----+++++++++++++++ SWAP +++++++++++++++-------------------
--------- CARTERA------------------
IF EXISTS(SELECT * FROM BACSWAPSUDA..CARTERA WHERE rut_cliente = @rutcliente and Estado <> 'C' )
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACSWAPSUDA..CARTERA
 WHERE  BACSWAPSUDA..CARTERA.rut_cliente = @rutcliente and Estado <> 'C' 
END
--------- CARTERA HISTORICA ------------------
IF EXISTS(SELECT * FROM BACSWAPSUDA..CARTERAHIS WHERE rut_cliente = @rutcliente and Estado <> 'C' )
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACSWAPSUDA..CARTERAHIS
 WHERE  BACSWAPSUDA..CARTERAHIS.rut_cliente = @rutcliente AND
  BACSWAPSUDA..CARTERAHIS.fecha_cierre  < @fecha AND
  Estado <> 'C'
END
----+++++++++++++++ CAMBIO +++++++++++++++-------------------
--------- CARTERA MEMO------------------
IF EXISTS(SELECT * FROM BACCAMSUDA..MEMO WHERE morutcli = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACCAMSUDA..MEMO
 WHERE  BACCAMSUDA..MEMO.morutcli = @rutcliente 
END
--------- CARTERA MEMO HISTORICA ------------------
IF EXISTS(SELECT * FROM BACCAMSUDA..MEMOH WHERE morutcli = @rutcliente)
BEGIN
 SELECT 
  @nCont =@nCont+1
 FROM  BACCAMSUDA..MEMOH
 WHERE  BACCAMSUDA..MEMOH.morutcli = @rutcliente AND
  BACCAMSUDA..MEMOH.mofech  < @fecha
END
----+++++++++++++++ FIN CAMBIO +++++++++++++++-------------------
 SELECT @nCont
END
GO
