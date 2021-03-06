USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_DISPONIBLETRASPASO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_DISPONIBLETRASPASO] ( @cSistema CHAR (03) ,
      @nRutcli NUMERIC (09,0) ,
      @nCodigo NUMERIC (09,0) ,
      @nMonto  NUMERIC (19,04) )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nDisponible NUMERIC (19,4)
 DECLARE @nSaldo  NUMERIC (19,4)
 DECLARE @cSist  CHAR (03)
 DECLARE @nMtoOcup NUMERIC (19,4)
 DECLARE @nMto  NUMERIC (19,4)
 SELECT 'Sistema'  = id_sistema  ,
  'Dispo'  = totaldisponible ,
  'Monto'  = CONVERT(NUMERIC(19,4),0)
 INTO #temp1
        FROM LINEA_SISTEMA
 WHERE rut_cliente = @nRutcli 
 AND codigo_cliente = @nCodigo
 AND id_sistema <>@cSistema
 AND realizatraspaso = 'S'
 AND bloqueado = 'N'
 ORDER
 BY totaldisponible DESC
 SELECT  @nDisponible = 0
 SELECT  @nDisponible = SUM(Dispo)
 FROM #temp1
 IF (SELECT COUNT(*) FROM #temp1) = 0 
 BEGIN
  SELECT 'NO', 'No Existen Lineas para Traspasar'
  RETURN
 END
 IF @nDisponible < @nMonto
 BEGIN
  SELECT 'NO', 'Monto a Traspasar Excede el Disponible'
  RETURN
 END
 SELECT @nSaldo = @nMonto
 DECLARE cursor_mto SCROLL CURSOR FOR
 SELECT  Sistema ,
  Dispo
 FROM #temp1
 OPEN cursor_mto
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_mto
  INTO @cSist   ,
   @nDisponible
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nMtoOcup = 0
  IF @nSaldo > 0
  BEGIN
   IF @nDisponible > @nSaldo  SELECT @nMtoOcup = @nSaldo
   ELSE    SELECT @nMtoOcup = @nDisponible
   SELECT @nSaldo = @nSaldo - @nMtoOcup
  END
  UPDATE  #temp1 
  SET Monto = @nMtoOcup
  WHERE Sistema = @cSist
 END
 CLOSE cursor_mto
 DEALLOCATE cursor_mto
 SELECT * FROM #temp1
 SET NOCOUNT OFF
END
--  SELECT * FROM LINEA_SISTEMA where rut_cliente = 97004000
--  SELECT * FROM LINEA_POR_PLAZO where rut_cliente = 97004000
-- EXECUTE Sp_Lineas_DisponibleTraspaso 'BTR', 97004000, 1, 27890000
-- EXECUTE Sp_Lineas_DisponibleTraspaso 'BTR', 97004000, 1, 77890000
-- EXECUTE Sp_Lineas_DisponibleTraspaso 'BTR', 97004000, 1, 87890000

GO
