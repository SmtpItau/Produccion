USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_GRABAPARAMETROS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_GRABAPARAMETROS](@xMercado       char(5)
                                           ,@xpreini    Numeric(10,4)  --ACPREINI
                                           ,@xposinic   Numeric(15,2)  --ACPOSINI
                                           ,@xposic     Numeric(15,2)  --ACPOSIC
                                           ,@xpmeco     Numeric(10,4)  --ACPMECO
                                           ,@xpmeve     Numeric(10,4)  --ACPMEVE
                                           ,@xtotco     Numeric(15,2)  --ACTOTCO
                                           ,@xtotve     Numeric(15,2)  --actotve
                                           ,@xtotcop    Numeric(15,2)  --ACTOTCOPO
        ,@xtotvep    Numeric(15,2)  --ACTOTVEPO
                                           ,@xpmecore   Numeric(19,4)  --AC_PMECORE
               ,@xpmevere   Numeric(19,4)  --AC_PMEVERE
               ,@xtotcore   Numeric(19,4)  --AC_TOTCORE
               ,@xtotvere   Numeric(19,4)  --AC_TOTVERE
               ,@xtotcopre  Numeric(19,4)  --ACTOTCOPRE
                     ,@xtotvepre  Numeric(19,4)  --ACTOTVEPRE
               ,@xutili     Numeric(15,2)  --ACUTILI
               ,@xprecie    Numeric(10,4)  --ACPRECIE
               ,@xPoHeFui    Numeric(15,4) --ACHEDGEPRECIOINICIAL
               ,@xPoHeSpi    Numeric(19,4) --ACHEDGEINICIALSPOT
               ,@xPoHeFut    Numeric(19,4) --ACHEDGEACTUALFUTURO
               ,@xPoHeSpt    Numeric(19,4) --ACHEDGEACTUALSPOT
               ,@xuhedge     Numeric(19,2) --ACHEDGEUTILIDAD
               ,@xtotcocp    Numeric(19,4) --CP_TOTCO
               ,@xtotvecp    Numeric(19,4) --CP_TOTVE
               ,@xtotcopcp   Numeric(19,2) --CP_TOTCOP
               ,@xtotvepcp   Numeric(19,2) --CP_TOTVEP
               ,@xutilicp    Numeric(9,2)  --CP_UTILI
               ,@xpmecocp    Numeric(15,4) --CP_PMECO
               ,@xpmevecp    Numeric(15,4) --CP_PMEVE
               ,@xpmecocpci  Numeric(15,4) --CP_PMECOCI
               ,@xpmevecpci  Numeric(15,4) --CP_PMEVECI
               ,@xuticocp    Numeric(15,2) --CP_UTICO
               ,@xutivecp    Numeric(15,2) --CP_UTIVE
                                   )
AS
BEGIN
set nocount on
 Update meac set acpreini     =  @xpreini
               ,acposini      =  @xposinic
               ,acposic       =  @xposic 
        ,acpmeco       =  @xpmeco 
               ,acpmeve       =  @xpmeve
        ,actotco       =  @xtotco
        ,actotve       =  @xtotve
        ,ac_totcop     =  @xtotcop
        ,ac_totvep     =  @xtotvep
        ,ac_pmecore    =  @xpmecore
        ,ac_pmevere    =  @xpmevere 
        ,ac_totcore    =  @xtotcore
        ,ac_totvere    =  @xtotvere
        ,actotcopre    =  @xtotcopre 
        ,actotvepre    =  @xtotvepre
        ,acutili       =  @xutili
        ,acprecie      =  @xprecie 
        ,achedgeinicialfuturo  =  @xPoHeFui
        ,achedgeinicialspot    =  @xPoHeSpi
        ,achedgeactualfuturo   =  @xPoHeFut
        ,achedgeactualspot     =  @xPoHeSpt
--        ,ac_Posich             =  @xPoHedge 
               ,achedgeprecioinicial  =  @xpreini 
        ,achedgeutilidad       =  @xuhedge  
        ,acfindia              = 'F'
     
          If @xMercado = 'EMPRE' or @xMercado = 'MONE' Begin 
              Update meac set cp_totco   = @xtotcocp
               ,cp_totve   = @xtotvecp
               ,cp_totcop  = @xtotcopcp 
               ,cp_totvep  = @xtotvepcp
               ,cp_utili   = @xutilicp 
               ,cp_pmeco   = @xpmecocp
               ,cp_pmeve   = @xpmevecp
               ,cp_pmecoci = @xpmecocpci
               ,cp_pmeveci = @xpmevecpci
               ,cp_utico   = @xuticocp
               ,cp_utive   = @xutivecp
          End
END

GO
