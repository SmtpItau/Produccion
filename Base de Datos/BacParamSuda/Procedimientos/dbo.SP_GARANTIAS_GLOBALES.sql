USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GARANTIAS_GLOBALES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GARANTIAS_GLOBALES]
   (   @rut_cli   NUMERIC(9)
   ,   @cod_cli   NUMERIC(9)
   )

AS 
BEGIN

 SET NOCOUNT ON
/*
SP_GARANTIAS_GLOBALES_8800_MAP 97004000 ,1
SP_GARANTIAS_GLOBALES_8800_MAP 98000600  ,1
SP_GARANTIAS_GLOBALES_8800_MAP 98000600  ,2
*/
 DECLARE @GarantAsoc  FLOAT
 DECLARE @GarantEfect FLOAT
 
 CREATE TABLE #GARANTIAS_GLOBALES
   (   rut_cliente        NUMERIC(9)
   ,   codigo_cliente     NUMERIC(9)   
   ,   garantia_Const     FLOAT
   ,   garantia_Asoc      FLOAT
   ,   garantia_Efect     FLOAT
   )

  declare @GarConstituida numeric(12)

 INSERT INTO #GARANTIAS_GLOBALES
   select @rut_cli
        , @Cod_cli
        , 0.0
          , 0.0
          , 0.0  
 

  set @GarConstituida = 0
  SELECT  @GarConstituida =  round( SUM(c.ValorPresente + c.FactorMultiplicativo + b.FactorAditivo), 0 )
  FROM	tbl_mov_garantia b,
		tbl_mov_garantia_detalle c
        
  WHERE 	c.NumeroOperacion = b.NumeroOperacion and
        b.RutCliente = @rut_cli and
        b.CodCliente = @Cod_cli
   
  if @GarConstituida <> 0
	Update #GARANTIAS_GLOBALES
      set garantia_Const = @GarConstituida

  -- Garantias Asociadas a Operaciones (buscar por familia)
  set @GarantAsoc = 0
    SELECT @GarantAsoc = SUM(c.ValorPresente + c.FactorMultiplicativo + b.FactorAditivo)
	FROM  tbl_gar_asociaciongtia a,
		  tbl_mov_garantia b,
		  tbl_mov_garantia_detalle c

   WHERE  b.NumeroOperacion = a.NumeroGarantia
   AND	  b.RutCliente = a.RutCliente
   AND	  b.CodCliente = a.CodCliente
    AND a.RutCliente = @rut_cli
    AND a.CodCliente = @Cod_cli
   AND	  c.NumeroOperacion = b.NumeroOperacion
   GROUP BY b.RutCliente, b.CodCliente

  if @GarantAsoc <> 0
    UPDATE #GARANTIAS_GLOBALES  SET  garantia_Asoc =  ISNULL(@GarantAsoc,0.0)      

  Set @GarantEfect = 0
    SElECT  @GarantEfect = garantiaefectiva
    FROM  cliente 
    WHERE garantiaefectiva <> 0
    AND   Cliente.Clrut = @rut_cli 
    AND   Cliente.Clcodigo = @Cod_cli
   
  if @GarantEfect <> 0
    UPDATE #GARANTIAS_GLOBALES  SET  garantia_Efect = ISNULL(@GarantEfect,0.0)    

  SELECT *  FROM #GARANTIAS_GLOBALES  


END
GO
