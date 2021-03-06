USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC_LINEAS_SISTEMA_CLIENTE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RECALC_LINEAS_SISTEMA_CLIENTE]
   (   @cSistema   CHAR(3)
   ,   @nCliente   NUMERIC(10)
   ,   @nCodigo    INT
   ,   @iRecGrl    INT = 0
   )
AS 
BEGIN

   SET NOCOUNT ON

   RETURN

   CREATE TABLE #TMP_RESULTADO
   (   Rut      NUMERIC(9)
   ,   Codigo   INT
   ,   Id       INT identity(1,1)
   )

   UPDATE BacLineas..LINEA_SISTEMA 
   SET	  TotalOcupado 	  = 0
   ,	  TotalExceso 	  = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = @cSistema
      AND TotalOcupado    > 0

   UPDATE BacLineas..LINEA_PRODUCTO_POR_PLAZO
   SET	  TotalOcupado 	  = 0
   ,	  TotalExceso 	  = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = @cSistema
      AND TotalOcupado    > 0

   INSERT INTO #TMP_RESULTADO
   SELECT DISTINCT
          cacodigo
   ,      cacodcli
   FROM   BacfwdSuda..MFCA
   ORDER BY cacodigo, cacodcli

   DECLARE @iReg   NUMERIC(9)
       SET @iReg   = ( SELECT MAX( id ) FROM #TMP_RESULTADO )
   DECLARE @Cont   NUMERIC(9)
       SET @Cont   = ( SELECT MIN( id ) FROM #TMP_RESULTADO )
   DECLARE @iRec   INT
       SET @iRec   = 0

   DECLARE @iRut   NUMERIC(9)
   DECLARE @iCod   INT
   
   WHILE @iReg >= @Cont
   BEGIN
      SELECT @iRut = Rut
      ,      @iCod = Codigo
      ,      @iRec = CASE WHEN @iReg = @Cont THEN 1 ELSE 0 END
      FROM   #TMP_RESULTADO
      WHERE  Id    = @Cont

      EXECUTE dbo.SP_NUEVO_RECALCULO_LINEAS 'BFW', @iRut, @iCod, @iRec

      SELECT @iRut, @iCod, @iRec

      SET @Cont = @Cont + 1
   END

   DROP TABLE #TMP_RESULTADO

END

GO
