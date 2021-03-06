USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SIMULACION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SIMULACION] 
 (
        @tipope CHAR(1)         ,
        @ussme NUMERIC(19,4)   ,
        @ticam NUMERIC(15,04)  ,
 @tipmer CHAR(4)  ,
 @RutCli NUMERIC(10) ,
 @CodCli NUMERIC(10)
        )
AS BEGIN
SET NOCOUNT ON
DECLARE  @posic       FLOAT
DECLARE  @posclp      FLOAT
DECLARE  @totcous     FLOAT
DECLARE  @totveus     FLOAT
DECLARE  @totcous1    FLOAT
DECLARE  @totveus1    FLOAT
DECLARE  @totcope     FLOAT
DECLARE  @totvepe     FLOAT
DECLARE  @totcope1    FLOAT
DECLARE  @totvepe1    FLOAT
DECLARE  @pmeco       FLOAT
DECLARE  @pmeve       FLOAT
DECLARE  @pcierre     FLOAT
DECLARE  @utili       NUMERIC(19)
DECLARE  @fecha       CHAR(8)
DECLARE  @pcosto      FLOAT
DECLARE  @positiON    NUMERIC(19)
DECLARE  @costo_compra FLOAT
DECLARE  @costo_venta FLOAT
DECLARE  @linea_disponible NUMERIC(21,04)
DECLARE  @xpreini     Numeric(10,4) --ACPREINI
 ,@xposinic    Numeric(15,2) --ACPOSINI
        ,@xposic      Numeric(15,2) --ACPOSIC
        ,@xpmeco      Numeric(10,4) --ACPMECO
        ,@xpmeve      Numeric(10,4) --ACPMEVE
        ,@xtotco      Numeric(15,2) --ACTOTCO
        ,@xtotve      Numeric(15,2) --actotve
        ,@xtotcop     Numeric(15,2) --ACTOTCOPO
        ,@xtotvep     Numeric(15,2) --ACTOTVEPO
        ,@xpmecore    Numeric(19,4) --AC_PMECORE
        ,@xpmevere    Numeric(19,4) --AC_PMEVERE
        ,@xtotcore    Numeric(19,4) --AC_TOTCORE
        ,@xtotvere    Numeric(19,4) --AC_TOTVERE
        ,@xtotcopre   Numeric(19,4) --ACTOTCOPRE
        ,@xtotvepre   Numeric(19,4) --ACTOTVEPRE
        ,@xutili      Numeric(15,2) --ACUTILI
        ,@xprecie     Numeric(10,4) --ACPRECIE
        ,@xPrHeIni    Numeric(15,4) --ACHEDGEPRECIOINICIAL
        ,@xPoHeFui    Numeric(15,4) --ACHEDGEINICIALFUTURO
        ,@xPoHeSpi    Numeric(19,4) --ACHEDGEINICIALSPOT
        ,@xPoHeFut    Numeric(19,4) --ACHEDGEACTUALFUTURO
        ,@xPoHeSpt    Numeric(19,4) --ACHEDGEACTUALSPOT
        ,@xuhedge     Numeric(19,2) --ACHEDGEUTILIDAD
        ,@xtotcocp    Numeric(19,4) --CP_TOTCO
        ,@xtotvecp    Numeric(19,4) --CP_TOTVE
        ,@xtotcopcp   Numeric(19,2) --CP_TOTCOP
        ,@xtotvepcp   Numeric(19,2) --CP_TOTVEP
        ,@xutilicp    Numeric(19,2)  --CP_UTILI
        ,@xpmecocp    Numeric(15,4) --CP_PMECO
        ,@xpmevecp    Numeric(15,4) --CP_PMEVE
        ,@xpmecocpci  Numeric(15,4) --CP_PMECOCI
        ,@xpmevecpci  Numeric(15,4) --CP_PMEVECI
        ,@xuticocp    Numeric(15,2) --CP_UTICO
        ,@xutivecp    Numeric(15,2) --CP_UTIVE 
        ,@xpohedge    Numeric(19,2)
        ,@xPosini     Numeric(15,2) 
---- Lee MEAC
EXECUTE Sp_Parametros_Actuales  @tipmer
    ,@xpreini     out --ACPREINI
    ,@xposini     out --ACPOSINI
    ,@xposic      out --ACPOSIC
    ,@xpmeco      out --ACPMECO
    ,@xpmeve      out --ACPMEVE
    ,@xtotco      out --ACTOTCO
    ,@xtotve      out --actotve
    ,@xtotcop     out --ACTOTCOPO
    ,@xtotvep     out --ACTOTVEPO
    ,@xpmecore    out --AC_PMECORE
    ,@xpmevere    out --AC_PMEVERE
    ,@xtotcore    out --AC_TOTCORE
    ,@xtotvere    out --AC_TOTVERE
    ,@xtotcopre   out --ACTOTCOPRE
    ,@xtotvepre   out --ACTOTVEPRE
    ,@xutili      out --ACUTILI
    ,@xprecie     out --ACPRECIE
    ,@xPrHeIni    out --ACHEDGEPRECIOINICIAL
    ,@xPoHeFui    out --ACHEDGEINICIALFUTURO
    ,@xPoHeSpi    out --ACHEDGEINICIALSPOT
    ,@xPoHeFut    out --ACHEDGEACTUALFUTURO
    ,@xPoHeSpt    out --ACHEDGEACTUALSPOT
    ,@xuhedge     out --ACHEDGEUTILIDAD
    ,@xtotcocp    out --CP_TOTCO
    ,@xtotvecp    out --CP_TOTVE
    ,@xtotcopcp   out --CP_TOTCOP
    ,@xtotvepcp   out --CP_TOTVEP
    ,@xutilicp    out --CP_UTILI
    ,@xpmecocp    out --CP_PMECO
    ,@xpmevecp    out --CP_PMEVE
    ,@xpmecocpci  out --CP_PMECOCI
    ,@xpmevecpci  out --CP_PMEVECI
    ,@xuticocp    out --CP_UTICO
    ,@xutivecp    out --CP_UTIVE
-- Se Rescatan los Costos de Fondo
SELECT  @costo_compra = accoscomp  ,
@costo_venta  = accosvent
FROM  meac
-- Rescata LÃ­nea del Cliente
SELECT  @linea_disponible = TotalDisponible
FROM  view_linea_sistema
WHERE  ( @rutcli = rut_cliente   AND
   @codcli   = Codigo_Cliente ) AND
 'BCC'     =Id_Sistema
---- Recalcula Posicion Real
EXECUTE Sp_Func_MxRecalcPr   @tipmer
    ,@tipope
    ,@ticam
    ,@ussme
    ,@xPoHeFui
    ,@xPoHeSpi    
    ,@xtotco     Out
    ,@xtotcop    Out
    ,@xpmeco     Out
    ,@xtotve     Out
    ,@xtotvep    Out
    ,@xpmeve     Out
    ,@xtotcore   Out
    ,@xtotcopre  Out
    ,@xpmecore   Out
    ,@xposic     Out
    ,@xpohedge   Out
    ,@xpohefut   Out
    ,@xpohespt   Out
    ,@xtotvere   Out
    ,@xtotvepre  Out
    ,@xpreini    Out
    ,@xPosini    Out
    ,@xprecie    Out
    ,@xutili     out
    ,@xprheini   out
           ,@xuhedge    OUT
---- Despliegue
SELECT 
 'totcous' = ISNULL(@xtotco,0),
        'totcope' = @xtotco * @xpmeco ,
        'pmeco'   = ISNULL(@xpmeco,0),
        'totveus' = ISNULL(@xtotve,0),
        'totvepe' = @xtotve * @xpmeve,
        'pmeve'   = ISNULL(@xpmeve,0),
        'posic'   = ISNULL(@xposic,0),
        'pcierre' = ISNULL(@xprecie,0),
        'utili'   = ISNULL(@xutili,0),
        'posit'   = ISNULL(@xuhedge,0),
 'CostoCom' = ISNULL(@Costo_Compra,0),
 'CostoVen' = ISNULL(@Costo_Venta,0),
 'Linea_Dis' = ISNULL( @linea_disponible ,0 )
END



GO
