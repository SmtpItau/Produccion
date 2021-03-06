USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROS_ACTUALES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


----------------------------------------------------------------------------------------------
-- Lee la Posicion Actual Spot Antes de Ser Afectada por las Operaciones de FWD, 
-- en SPOT el procedimiento se llama igual
----------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[SP_PARAMETROS_ACTUALES]( @xMercado    Char(4)
                                        ,@xpreini     Numeric(10,4)  out --ACPREINI
                                        ,@xposinic    Numeric(15,2)  out --ACPOSINI
                                        ,@xposic      Numeric(15,2)  out --ACPOSIC
                                        ,@xpmeco      Numeric(10,4)  out --ACPMECO
                                        ,@xpmeve      Numeric(10,4)  out --ACPMEVE
                                        ,@xtotco      Numeric(15,2)  out --ACTOTCO
                                        ,@xtotve      Numeric(15,2)  out --actotve
                                        ,@xtotcop     Numeric(15,2)  out --AC_TOTCOP
                                        ,@xtotvep     Numeric(15,2)  out --AC_TOTVEP
                                        ,@xpmecore    Numeric(19,4)  out --AC_PMECORE
                                        ,@xpmevere    Numeric(19,4)  out --AC_PMEVERE
                                        ,@xtotcore    Numeric(19,4)  out --AC_TOTCORE
                                        ,@xtotvere    Numeric(19,4)  out --AC_TOTVERE
                                        ,@xtotcopre   Numeric(19,4)  out --ACTOTCOPRE
                                        ,@xtotvepre   Numeric(19,4)  out --ACTOTVEPRE
                                        ,@xutili      Numeric(15,2)  out --ACUTILI
                                        ,@xprecie     Numeric(10,4)  out --ACPRECIE
                                        ,@xPrHeIni    Numeric(15,4)  out --ACHEDGEPRECIOINICIAL
                                        ,@xPoHeFui    Numeric(15,4)  out --ACHEDGEINICIALFUTURO
                                        ,@xPoHeSpi    Numeric(19,4)  out --ACHEDGEINICIALSPOT
                                        ,@xPoHeFut    Numeric(19,4)  out --ACHEDGEACTUALFUTURO
                                        ,@xPoHeSpt    Numeric(19,4)  out --ACHEDGEACTUALSPOT
                                        ,@xuhedge     Numeric(19,2)  out --ACHEDGEUTILIDAD
                                        ,@xtotcocp    Numeric(19,4)  out --CP_TOTCO
                                        ,@xtotvecp    Numeric(19,4)  out --CP_TOTVE
                                        ,@xtotcopcp   Numeric(19,2)  out --CP_TOTCOP
                                        ,@xtotvepcp   Numeric(19,2)  out --CP_TOTVEP
                                        ,@xutilicp    Numeric(9,2)   out --CP_UTILI
                                        ,@xpmecocp    Numeric(15,4)  out --CP_PMECO
                                        ,@xpmevecp    Numeric(15,4)  out --CP_PMEVE
                                        ,@xpmecocpci  Numeric(15,4)  out --CP_PMECOCI
                                        ,@xpmevecpci  Numeric(15,4)  out --CP_PMEVECI
                                        ,@xuticocp    Numeric(15,2)  out --CP_UTICO
                                        ,@xutivecp    Numeric(15,2)  out --CP_UTIVE
					,@xPoHeVenFut Numeric(19,4)  out --ACHEDGEVCTOFUTURO 
                                        ,@xtotcopo    NUMERIC(15,2)  OUT --ACTOTCOPO
                                        ,@xtotvepo    NUMERIC(15,2)  OUT --ACTOTVEPO
  

                                       )
AS
BEGIN
 SET NOCOUNT ON
 SELECT  @xpreini    = acpreini 
  ,@xposinic  = acposini  
  ,@xposic    = acposic     
  ,@xpmeco    = acpmeco      
  ,@xpmeve    = acpmeve         
  ,@xtotco    = actotco     
  ,@xtotve    = actotve     
  ,@xtotcop   = ac_totcop  
  ,@xtotvep   = ac_totvep  
  ,@xpmecore  = ac_pmecore
  ,@xpmevere  = ac_pmevere  
  ,@xtotcore  = ac_totcore 
  ,@xtotvere  = ac_totvere   
  ,@xtotcopre = actotcopre 
  ,@xtotvepre = actotvepre  
  ,@xutili    = acutili       
  ,@xprecie   = acprecie  
  ,@xPrHeIni  = achedgeprecioinicial
  ,@xPoHeFui  = achedgeinicialfuturo 
  ,@xPoHeSpi  = achedgeinicialspot   
  ,@xPoHeFut  = achedgeactualfuturo  
  ,@xPoHeSpt  = achedgeactualspot    
  ,@xuhedge   = achedgeutilidad      
  ,@xPoHeVenFut	= achedgevctofuturo
  ,@xtotcopo    = actotcopo 
  ,@xtotvepo    = actotvepo
 

 FROM view_meac_spot
END

GO
