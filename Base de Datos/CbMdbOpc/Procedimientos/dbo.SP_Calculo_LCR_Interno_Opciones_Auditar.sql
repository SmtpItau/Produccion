USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_Calculo_LCR_Interno_Opciones_Auditar]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- select * from caResEnccontrato where CaEncFechaRespaldo = '20100930' 
-- SP_Calculo_LCR_Interno_Opciones_Auditar 43, 'S', 0, 0, 0, 0
/*
select * from LnkBac.BacparamSuda.dbo.VALOR_MONEDA_CONTABLE 
 where Codigo_Moneda = 994 and fecha = '20100929'
*/
CREATE PROCEDURE [dbo].[SP_Calculo_LCR_Interno_Opciones_Auditar]
       (
         @NumOper                NUMERIC(08) 
       , @Retorno                CHAR(1)  -- Para que retorne una tabla como resultado de debe enviar un a 'S' como parametro sino una 'N'  
       , @MtoImputar             FLOAT  = 0.0 OUTPUT     -- 24 Sept. 2009   Monto a Imputar en USD
       , @MtoAvr                 FLOAT  = 0.0 OUTPUT   
       , @MtoAddOn               FLOAT  = 0.0 OUTPUT
       , @PrcAddOn               FLOAT  = 0.0 OUTPUT   
       )
AS
BEGIN

-- SP_Calculo_LCR_Interno_Opciones 841, '', 0, 0 ,0,0  
-- sp_helptext SP_Calculo_LCR_Interno_Opciones 
-- MAP 07 Octubre
-- Se corrige logica de tratamiento de LCR para Forward Asiatiacos

-- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente

-- MAP 10 Nov. Depuracion del Delta, Plazos y conversión

    SET NOCOUNT ON

    declare @ProcesoAud             DATETIME
    select  @ProcesoAud             = '20100930'

    DECLARE @nTotregs               INTEGER
    DECLARE @nCont                  INTEGER
    DECLARE @dFecPro                DATETIME
    DECLARE @dFecAnt                DATETIME

    DECLARE @NumContrato            NUMERIC(10)
    DECLARE @NumEstruct             NUMERIC(06)
    DECLARE @NumRegs                INTEGER

    DECLARE @rut                    NUMERIC(9)
    DECLARE @CodCli                 NUMERIC(09)
    DECLARE @cSistema               CHAR(08)
    DECLARE @cProducto              CHAR(05)
    DECLARE @Tipo_Oper              CHAR(01)
    DECLARE @Capital_A              NUMERIC(21,04)
    DECLARE @Capital_P              NUMERIC(21,04)
    DECLARE @Plazo_A                NUMERIC(05) --NUMERIC(18,6) 

    DECLARE @Plazo_P                NUMERIC(05) --NUMERIC(18,6) 
    DECLARE @Moneda_A               NUMERIC(05) 
    DECLARE @Moneda_P               NUMERIC(05) 
    DECLARE @Duration_A             FLOAT 
    DECLARE @Duration_P             FLOAT
    DECLARE @SubTotal               FLOAT
    DECLARE @Prc                    FLOAT
    DECLARE @SumNocional            FLOAT
    DECLARE @PromNocional           FLOAT
    DECLARE @MonNocional            NUMERIC(05)  
    DECLARE @DeltaFwd               FLOAT
    DECLARE @SumDeltaFwdXPrcRiesgo  FLOAT
    DECLARE @MdaDelta               NUMERIC(05)   
    DECLARE @Avr                    FLOAT
    DECLARE @MdaAvr                 NUMERIC(05)   
    DECLARE @NocCLPCont             FLOAT   -- 24 Sept. 2009   Monto a Imputar en USD

    declare @CaVinculacion varchar(15) 
    declare @CompraVenta   varchar(1)
    declare @CaTipoPayOff  varchar(2)       


    CREATE TABLE #ESTRUCTURAOPCIONES
    (
      Numero_Contrato             NUMERIC(10)
    , Numero_Estructura           NUMERIC(06)
    , Numero_Registro             INTEGER
    , Rut_Cliente                 NUMERIC(09)
    , Codigo_Cliente              NUMERIC(09)
    , Sistema                     CHAR(08)
    , Producto                    CHAR(08)
    , Tipo_Operacion              CHAR(01)
    , MtoRiesgoPotFuturo          FLOAT
    , PromPrc                     FLOAT
    , DeltaFwd                    FLOAT
    , DeltaFwdXPrcRiesgo          FLOAT
    )

    CREATE TABLE #TMP_MONEDA
    (
      fecha            DATETIME 
    , codigo           NUMERIC(05)
    , valor            FLOAT
    )

    SELECT @dFecPro = fechaproc
         , @dFecAnt = fechaant
      FROM OpcionesResGeneral -- select * from OpcionesResGeneral
      where fechaproc = @ProcesoAud

    INSERT INTO #TMP_MONEDA
           SELECT ISNULL(vmfecha,@dFecPro)
                , ISNULL(vmcodigo,0)
                , ISNULL( CASE WHEN vmvalor = 0 THEN 1 ELSE VMVALOR END , 1 )
             FROM LnkBac.BacparamSuda.dbo.VALOR_MONEDA
            WHERE vmFecha    = @dFecPro
              AND vmcodigo   IN(995,997,998)

    INSERT INTO #TMP_MONEDA
           SELECT @dFecPro, 999, 1.0

    INSERT INTO #TMP_MONEDA
           SELECT @dFecPro, codigo_moneda , tipo_cambio
             FROM LnkBac.BacparamSuda.dbo.VALOR_MONEDA_CONTABLE 
            WHERE fecha          = @dFecAnt
              AND codigo_moneda  NOT IN(13,994,995,997,998,999)
              AND tipo_cambio   <> 0.0

    INSERT INTO #TMP_MONEDA
           SELECT @dFecPro, 13, tipo_cambio
             FROM LnkBac.BacparamSuda.dbo.VALOR_MONEDA_CONTABLE   
            WHERE fecha         = @dFecAnt
              AND codigo_moneda = 994

    SET @CaVinculacion = ''
    SET @CompraVenta   = ''
    SET @CaTipoPayOff  = ''

    select @CaVinculacion = CaVinculacion 
         , @CompraVenta   = CaCVOpc  
         , @CaTipoPayOff  = CaTipoPayOff
      from caDetcontrato
     where CaNumcontrato  = @NumOper

    SELECT 'Numero_Contrato'     = A.CaNumContrato
         , 'Numero_Estructura'   = B.CaNumEstructura
         , 'NumeroRegistro'      = Identity(INT) 
         , 'rut_cliente'         = A.CaRutCliente
         , 'codigo_cliente'      = A.CaCodigo 
         , 'CompraoVenta'        = B.CaCVOpc  
         , 'MontoMon1'           = B.CaMontoMon1
         , 'MontoMon2'           = B.CaMontoMon2
         , 'fecha_Cierre'        = A.CaFechaContrato
         , 'fecha_inicio'        = B.CaFechaInicioOpc
         , 'Tir'                 = CONVERT(FLOAT,0.0)
         , 'Moneda1'             = CONVERT(NUMERIC(05),B.CaCodMon1)
         , 'Moneda2'             = CONVERT(NUMERIC(05),B.CaCodMon2)
         , 'Producto'            = CONVERT(CHAR(05),B.CaSubyacente)
         , 'Valor_Razonable'     = ISNULL(CONVERT(FLOAT,A.CaVr),0.0)
         , 'Valor_Razonable_Det' = ISNULL(CONVERT(FLOAT,B.CaVrDet),0.0)
         , 'Moneda_Valor_Raz'    = A.CaMon_vr
         , 'Fecha_Vcto'          = B.CaFechaVcto   
         , 'Fecha'               = @dFecPro 
         , 'Subyacente'          = B.CaSubyacente
         , 'Vinculacion'         = B.CaVinculacion
         , 'TipoPayOff'          = B.CaTipoPayOff
         , 'Moneda_Delta'        = A.CaMondelta
         -- Cambios solicitados por Raul Muñoz (DMV 25-11-2009)
         -- , 'DeltaFwd'            = case when CaVinculacion = 'Individual' then B.CaMontoMon1   -- MAP 10 Nov. 2009
         --                           else CASE WHEN B.CaDelta_fwd <> 0 THEN B.CaDelta_fwd ELSE B.CaDelta_fwd_num END 
         --                           end
         , 'DeltaFwd'            = CASE WHEN B.CaDelta_spot <> 0.0 THEN B.CaDelta_spot ELSE B.CaDelta_spot_num END
         , 'CodEstructura'       = A.CaCodEstructura 
         , 'SistemaAsociado'     = B.CaIteAsoSis
         , 'ContratoAsociado'    = B.CaIteAsoCon
      INTO #CARTERAOPCIONES
      FROM CaResEncContrato A with(nolock) 
         , CaResDetContrato B with(nolock) 
     WHERE CaEncFechaRespaldo = @ProcesoAud   -- select * from CaResEncContrato
       AND CaDetFechaRespaldo = CaEncFechaRespaldo
       AND A.CaNumContrato = B.CaNumContrato
       AND B.CaNumContrato = @NumOper

-- if @NumOper = 974
--     select * from #CARTERAOPCIONES

    SET @nTotregs    = (SELECT MAX(NumeroRegistro) FROM #CARTERAOPCIONES)
    SET @nCont       = (SELECT MIN(NumeroRegistro) FROM #CARTERAOPCIONES)
    SET @SumNocional = 0.0 

    WHILE @nTotregs >= @nCont
    BEGIN    --  WHILE
        SELECT @NumContrato    = Numero_Contrato
             , @NumEstruct     = Numero_Estructura
             , @NumRegs        = NumeroRegistro   
             , @rut            = rut_cliente
             , @CodCli         = codigo_cliente
             , @cSistema       = id_sistema
             , @cProducto      = codigo_producto 
             , @Tipo_Oper      = CompraoVenta
             , @Capital_A      = (CASE CompraoVenta WHEN 'C' THEN MontoMon1 ELSE MontoMon2 END )
             , @Capital_P      = (CASE CompraoVenta WHEN 'C' THEN MontoMon2 ELSE MontoMon1 END )
             , @Plazo_A        = (CASE WHEN DATEDIFF(dd,@dFecPro,Fecha_Vcto) < 0 THEN 0 ELSE DATEDIFF(dd,@dFecPro,Fecha_Vcto) END )
             , @Plazo_P        = (CASE WHEN DATEDIFF(dd,@dFecPro,Fecha_Vcto) < 0 THEN 0 ELSE DATEDIFF(dd,@dFecPro,Fecha_Vcto) END )
             , @Moneda_A       = (CASE CompraoVenta WHEN 'C' THEN Moneda1 ELSE Moneda2 END )     
             , @Moneda_P       = (CASE CompraoVenta WHEN 'C' THEN Moneda2 ELSE Moneda1 END )
             , @Duration_A     = (CASE WHEN DATEDIFF(dd,@dFecPro,Fecha_Vcto) < 0 THEN 0 ELSE ROUND( DATEDIFF(dd,@dFecPro,Fecha_Vcto) / 365.0, 4 ) END  )
             , @Duration_P     = (CASE WHEN DATEDIFF(dd,@dFecPro,Fecha_Vcto) < 0 THEN 0 ELSE ROUND( DATEDIFF(dd,@dFecPro,Fecha_Vcto) / 365.0, 4 ) END  ) 
             , @SubTotal       = 0 
             , @Prc            = 0
             , @SumNocional    = @SumNocional + MontoMon1  
             , @MonNocional    = Moneda1
             , @DeltaFwd       = DeltaFwd --* ISNULL(A.valor,1.0)
             , @MdaDelta       = Moneda_Delta
             , @Avr            = Valor_Razonable --* ISNULL( B.valor , 1.0)
             , @MdaAvr         = Moneda_Valor_Raz
          FROM #CARTERAOPCIONES     
               INNER JOIN LnkBac.BacParamSuda.dbo.PRODUCTO P            ON Codigo_producto = 'OPT'  
               INNER JOIN LnkBac.BacParamSuda.dbo.VIEW_CLIENTEParaOpc   ON rut_cliente     = clrut
                                                                       AND codigo_cliente  = clcodigo
--                INNER JOIN #TMP_MONEDA A                                 ON A.fecha         = @dFecPro
--                                                                        AND A.codigo        = 13 -- Moneda_Delta MAP 10 Nov. 2009, en este contexto del delta esta en USD
--                INNER JOIN #TMP_MONEDA B                                 ON B.fecha         = @dFecPro
--                                                                        AND B.codigo        = Moneda_Valor_Raz
         WHERE NumeroRegistro      = @ncont


        --if ( @CaTipoPayOff <> '02' or @CaVinculacion <> 'Individual' )   -- MAP 07 Octubre -- modificado por DMV: 27/11/2009, solicitado por Juan Pablo Freire
        if @CaTipoPayOff = '01'
        begin
            EXEC LNKBAC.BacLineas.dbo.SP_Riesgo_Potencial_Futuro @NumContrato
                                                               , @cSistema
                                                               , @cProducto
                                                               , @Tipo_Oper
                                                               , @Capital_A
                                                               , @Capital_P
                                                               , @Plazo_A
                                                               , @Plazo_P
                                                               , @Moneda_A
                                                               , @Moneda_P
                                                               , @Duration_A
                                                               , @Duration_P
                                                               , @dFecPro
                                                               , @SubTotal output
                                                               , @Prc      output
            select '@Prc', @Prc

        end
        else  begin  -- ( @CaTipoPayOff == '02' and @CaVinculacion = 'Individual' )
            -- Se debe calcular la suma de los Factores de LCR por los Pesos
            select  'IdFix' = Identity(INT), *
              into #CarFixing
              from CaFixing
             where CaNumContrato   = @NumOper
               and CaNumEstructura = @NumEstruct -- modificado por DMV: 27/11/2009, solicitado por Juan Pablo Freire

            declare  @nTotregFix        integer
            declare  @nContFix         integer
            declare  @SumPesoPorFactor float
            declare  @SumPeso          float
            declare  @PesoPorFactor    float
            declare  @Peso             float
            declare  @Duration         float
            declare  @plazo            integer

            SET @nTotregFix       = (SELECT MAX(IdFix) FROM #CarFixing )
            SET @nContFix         = (SELECT MIN(IdFix) FROM #CarFixing )
            SET @SumPesoPorFactor = 0.0 
            SET @SumPeso          = 0
      
            while @nTotregFix >= @nContFix begin  
                select @Peso     = CaPesoFij  
                     , @Plazo    = (CASE WHEN DATEDIFF(D,@dFecPro,CaFixFecha) < 0 
                                              THEN 0 
                                              ELSE ROUND( DATEDIFF(D,@dFecPro,CaFixFecha), 4 )   -- <= MAP 10 NOv. Plazo es en Dias !!
                                    END )
                     , @Duration = @Plazo / 365.0
                  from #CarFixing
                 where IdFix = @nContFix

                EXEC LNKBAC.BacLineas.dbo.SP_Riesgo_Potencial_Futuro @NumContrato
                                                                   , @cSistema
                                                                   , @cProducto
                                                                   , @Tipo_Oper
                                                                   , @Capital_A
                                                                   , @Capital_P
                                                                   , @Plazo           -- Asiaticas
                                                                   , @Plazo           -- Asiaticas
                                                                   , @Moneda_A
                                                                   , @Moneda_P
                                                                   , @Duration        -- Asiaticas
                                                                   , @Duration        -- Asiaticas
                                                                   , @dFecPro
                                                                   , @SubTotal output
                                                                   , @Prc      output
                set @SumPesoPorFactor = @SumPesoPorFactor + ( @Peso / 100.0 ) * @Prc 
                set @SumPeso = @SumPeso + CASE WHEN @Plazo = 0 THEN 0.0 ELSE ( @Peso / 100.0 ) END
                set @nContFix = @nContFix + 1

            end -- While fixing
            IF (@SumPeso = 0)
            BEGIN
                SET @Prc = 0

            END ELSE
            BEGIN
                select @Prc = @SumPesoPorFactor / @SumPeso -- Prc para Asiáticas

            END

            drop table #CarFixing
        end

        INSERT #ESTRUCTURAOPCIONES
        SELECT @NumContrato    
             , @NumEstruct     
             , @NumRegs        
             , @rut            
             , @CodCli         
             , @cSistema           
             , @cProducto       
             , @Tipo_Oper
             , @SubTotal
             , @Prc
             , @DeltaFwd
             , (@DeltaFwd  *  @Prc / 100.0 )            -- MAP 10 Nov. prc hay que dividir por 100 para aplicar

           select '@DeltaFwd', @DeltaFwd, '@Prc', @Prc

        SET @ncont   = @ncont + 1

    END      --  WHILE  

    SET @PromNocional = @SumNocional / (@ncont - 1)

    select '@PromNocional', @PromNocional

    SET @NocCLPCont = @PromNocional * ISNULL( ( SELECT valor
                                                  FROM #TMP_MONEDA 
                                                 WHERE fecha  = @dFecPro
                                                   AND codigo = @MonNocional ), 1.0 )
    select '@NocCLPCont', @NocCLPCont

    select 'Valor Converitr', ISNULL( ( SELECT valor
                                                  FROM #TMP_MONEDA 
                                                 WHERE fecha  = @dFecPro
                                                   AND codigo = @MonNocional ), 1.0 )

    -- 24 Sept. 2009   Monto a Imputar en USD
    -- Esto esta amarrado a lo del Oper, ojo 
    SET @MtoImputar = @NocCLPCont / ISNULL( ( SELECT valor
                                                FROM #TMP_MONEDA   
                                               WHERE fecha  = @dFecPro
                                                 AND codigo = 13 ), 1.0 )

    DECLARE @DolarContable FLOAT

    -- Se recupera el Valor del Dolar Contable para multiplicarlo por el Delta Spot
    SELECT @DolarContable = Tipo_Cambio
      FROM lnkbac.BacParamSuda.dbo.valor_moneda_contable
     WHERE Fecha         = @dFecAnt -- @dFecPro  30/11/2009
   AND Codigo_Moneda = 994

     select '@DolarContable', @DolarContable

    SELECT @SumDeltaFwdXPrcRiesgo = ABS(SUM(DeltaFwdXPrcRiesgo)) * @DolarContable
      FROM #ESTRUCTURAOPCIONES

--     if @NumContrato = 974
--         select * from #ESTRUCTURAOPCIONES

    IF @CaVinculacion = 'Individual' AND @CompraVenta = 'V' -- Venta no imputa 
    BEGIN
        SET @MtoAvr   = 0.0
        SET @MtoAddOn = 0.0
        SET @PrcAddOn = 0.0

    END ELSE
    BEGIN
        SET @MtoAvr   = @Avr
        SET @MtoAddOn = @SumDeltaFwdXPrcRiesgo
        SET @PrcAddOn = (@SumDeltaFwdXPrcRiesgo * 100.0) / @NocCLPCont

        IF (@MtoAvr+@MtoAddOn) < 0
        BEGIN
            SET @MtoAvr   = 0
            SET @MtoAddOn = 0

        END

    END

    IF  NOT EXISTS(SELECT 1 FROM #CARTERAOPCIONES WHERE Numero_Contrato = @NumOper)
    BEGIN
        IF @Retorno = 'S'   
            SELECT 'Numero_Contrato'    = 0
                 , 'Numero_Estructura'  = 0
                 , 'Producto'           = ''
                 , 'Tipo_Operacion'     = ''
                 , 'Capital_Activo'     = 0.0
                 , 'Capital_Pasivo'     = 0.0
                 , 'Plazo_Activo'       = 0
                 , 'Plazo_Pasivo'       = 0
                 , 'Moneda_Activa'      = 0
                 , 'Moneda_Pasiva'      = 0
                 , 'Duration_Activa'    = 0.0
                 , 'Duration_Pasiva'    = 0.0
                 , 'NocionalCLP'        = 0.0
                 , 'Avr'                = 0.0
                 , 'Monto_AddOn'        = 0.0
                 , 'Porcentaje_AddOn'   = 0.0
                 , 'Monto_Imputacion'   = 0.0  -- 24 Sept. 2009   Monto a Imputar en USD

    END 
    ELSE BEGIN 
        IF @Retorno = 'S' 
            SELECT 'Numero_Contrato'    = @NumContrato
                 , 'Numero_Estructura'  = @NumEstruct
                 , 'Producto'           = @cProducto  
                 , 'Tipo_Operacion'     = @Tipo_Oper
                 , 'Capital_Activo'     = @Capital_A
                 , 'Capital_Pasivo'     = @Capital_P
                 , 'Plazo_Activo'       = @Plazo_A 
                 , 'Plazo_Pasivo'       = @Plazo_P
                 , 'Moneda_Activa'      = @Moneda_A
                 , 'Moneda_Pasiva'      = @Moneda_P
                 , 'Duration_Activa'    = @Duration_A
                 , 'Duration_Pasiva'    = @Duration_P 
                 , 'NocionalCLP'        = @NocCLPCont 
                 , 'Avr'                = @MtoAvr
                 , 'Monto_AddOn'        = @MtoAddOn 
                 , 'Porcentaje_AddOn'   = @PrcAddOn
                 , 'Monto_Imputacion'   = @MtoImputar   -- 24 Sept. 2009   Monto a Imputar en USD

    END  

    SET NOCOUNT OFF

END

GO
