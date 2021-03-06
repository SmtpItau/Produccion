USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_GARANTIA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[SP_RIEFIN_GARANTIA]  
(
     @nRutcli NUMERIC(13) 
   , @nCodigo NUMERIC(5)
   , @nMetodologia NUMERIC(5) 
   , @cSistema     CHAR(03)  = ''
   , @nNumoper 	 NUMERIC(10,0) = 0
)
As 
Begin
-- exec dbo.SP_RIEFIN_GARANTIA 97004000, 1,4  -- 
    SET NOCOUNT ON
    DECLARE @Constituida FLOAT
    DECLARE @Efectivo    FLOAT
    DECLARE @Operaciones FLOAT
    DECLARE @Resultado FLOAT
    DECLARE @Gasignada INT


    declare @FechaConv datetime                               -- Fecha de conversión.
    declare @TCRC      float                                  -- Tipo de Cambio de representación contable.

    set    @TCRC = 1                                          -- Para por lo menos inputar el monto tal cual 
                                                              -- si es que no hay valor para convertir.

    select @fechaConv = AcFecAnte from bactradersuda..mdac
    select @TCRC = Tipo_Cambio                                -- Para convertir las garantias a CLP
      from bacParamsuda..Valor_moneda_contable
      where Fecha = @FechaConv and Codigo_Moneda = 994
    
    SET @Constituida =0
    SET @Efectivo  = 0  
    SET @Operaciones = 0
    SET @Resultado = 0
    SET @Gasignada =0

    declare @RutAux numeric(13) 
    declare @CodigoAux numeric(5)

    set @RutAux = @nRutCli
    set @CodigoAux = @nCodigo

    -- Las garantias a rescatar son las del padre. 
    select @nRutCli = clrut_padre, @nCodigo = clcodigo_padre  from BacLineas..CLIENTE_RELACIONADO 
    where clrut_hijo = @RutAux and  clcodigo_hijo = @CodigoAux


    IF @nMetodologia = 5
    BEGIN


    	
		SELECT @Constituida = ISNULL((	SELECT		'Garantias Constituidas' = SUM(c.ValorPresente + c.FactorMultiplicativo + b.FactorAditivo)
										FROM		tbl_mov_garantia b,
													tbl_mov_garantia_detalle c
										WHERE		c.NumeroOperacion = b.NumeroOperacion
										AND			b.RutCliente = @nRutCli
										AND			b.CodCliente = @nCodigo
										GROUP BY	b.RutCliente, b.CodCliente),0)
								
		SELECT @Efectivo =ISNULL((		SELECT		garantiaefectiva 
		                   				FROM		cliente 
		                   				WHERE		Clrut = @nRutCli	
										AND			ClCodigo = @nCodigo
										AND			garantiaefectiva <> 0),0)
									
		
		SELECT @Resultado = isnull(@Constituida+ round( @Efectivo * @TCRC , 0 ),0)   -- Conversión de las garantias de USD a CLP
    END
    IF @nMetodologia = 4
	BEGIN
		-- Verificar que las todas las Garantías del cliente esten asociadas
        -- uno a uno con los contratos, se revisa las operaciones de toda la 
        -- familia por si acaso.
        -- esta validación permanecerá hasta que se haya implementado una 
        -- estructura de dato que indique qué monto de cierta garantia
        -- esta aociada a una operación.

		SELECT @Gasignada =(select	count(1)
		from	BacParamsuda.dbo.tbl_gar_AsociacionOper T01 
		,		BacParamsuda.dbo.tbl_gar_AsociacionOper T02 
		where	T01.FolioAsocia = T02.FolioAsocia and T01.numeroOperacion <> T02.numeroOperacion
        and		T01.RutCliente = T02.RutCliente 
        and		T01.CodCliente = T02.CodCliente   
        and		T01. RutCliente = @nRutCli		
        and		T01.CodCliente   = @nCodigo)		
		
		-- Garantias Asociadas a Operaciones
		IF @Gasignada <> 0 -- MAP Si el query arrojaba resultados quiere decir que 
                           -- cliente tiene una garantias repartidas, por lo 
                           -- tanto no se aplica garantías en las LCR
		BEGIN 
			SELECT 	@Resultado =0
		END		
		ELSE
		BEGIN
		      -- MAP Faltaba aplicar página 44 documento analisis, el 
              -- query de garantias por operación.
   	          SELECT  @Operaciones = isnull( 	  SUM(GarDet.ValorPresente * GarDet.FactorMultiplicativo ) +  Gar.FactorAditivo , 0 )
   	          	from	BacParamsuda.dbo.tbl_gar_AsociacionOper RelOpe,  
   	                    BacParamsuda.dbo.tbl_gar_asociaciongtia RelGar,  
   	          	    	BacParamsuda.dbo.tbl_mov_garantia Gar,             
   	          		    BacParamsuda.dbo.tbl_mov_garantia_detalle GarDet   
	   	          WHERE 	  RelOpe.Sistema         = @cSistema
   	                  AND     RelOpe.numeroOperacion = @nNumoper
           	          AND     RelOpe.FolioAsocia = RelGar.FolioAsocia
           	          AND     RelGar.NumeroGarantia = Gar.NumeroOperacion
	   	              AND 	  Gar.NumeroOperacion = GarDet.NumeroOperacion
             --         AND     Gar.RutCliente = @nRutCli  -- no se busca por rut, solo por operación 
             --         AND     Gar.CodCliente = @nCodigo  -- no se busca por rut, solo por operación 
             group by Gar.FactorAditivo	
		END 
		
		SELECT @Resultado = @Operaciones
	END 
    SELECT Resultado = @Resultado
END 
GO
