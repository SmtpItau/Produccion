USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNC_GRABAPARAM2]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
------------------------------------------------------------------------------------------------------
-- Afecta la Posicion Actual Spot Con las Operaciones de FWD, en SPOT el procedimiento se llama igual
------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[SP_FUNC_GRABAPARAM2]( @xMercado    CHAR(5)
     ,@xpreini    NUMERIC(10,4)  --ACPREINI
     ,@xposinic   NUMERIC(15,2)  --ACPOSINI
     ,@xposic     NUMERIC(15,2)  --ACPOSIC
     ,@xpmeco     NUMERIC(10,4)  --ACPMECO
     ,@xpmeve     NUMERIC(10,4)  --ACPMEVE
     ,@xtotco     NUMERIC(15,2)  --ACTOTCO
     ,@xtotve     NUMERIC(15,2)  --actotve
     ,@xtotcop    NUMERIC(15,2)  --ACTOTCOPO
     ,@xtotvep    NUMERIC(15,2)  --ACTOTVEPO
     ,@xpmecore   NUMERIC(19,4)  --AC_PMECORE
     ,@xpmevere   NUMERIC(19,4)  --AC_PMEVERE
     ,@xtotcore   NUMERIC(19,4)  --AC_TOTCORE
     ,@xtotvere   NUMERIC(19,4)  --AC_TOTVERE
     ,@xtotcopre  NUMERIC(19,4)  --ACTOTCOPRE
     ,@xtotvepre  NUMERIC(19,4)  --ACTOTVEPRE
     ,@xutili     NUMERIC(15,2)  --ACUTILI
     ,@xprecie    NUMERIC(10,4)  --ACPRECIE
     ,@xPoHeFui   NUMERIC(15,4) --ACHEDGEPRECIOINICIAL
     ,@xPoHeSpi   NUMERIC(19,4) --ACHEDGEINICIALSPOT
     ,@xPoHeFut   NUMERIC(19,4) --ACHEDGEACTUALFUTURO
     ,@xPoHeSpt   NUMERIC(19,4) --ACHEDGEACTUALSPOT
     ,@xuhedge    NUMERIC(19,2) --ACHEDGEUTILIDAD
     ,@xPoHeVenFut NUMERIC(19,4)--ACHEDGEVCTOFUTURO 
     ,@xAcumDia   NUMERIC(19,2) --ACACUMDIA
     ,@xAcumMes   NUMERIC(19,2) --ACACUMMES
     ,@xtotcopo   NUMERIC(15,2) --ACTOTCOPO
     ,@xtotvepo   NUMERIC(15,2) --ACTOTVEPO 
     )
AS
BEGIN
SET NOCOUNT ON
 UPDATE  view_meac_spot 
 SET     acpreini  =  @xpreini
        ,acposic   =  @xposic 
        ,acpmeco   =  @xpmeco 
        ,acpmeve   =  @xpmeve
        ,actotco   =  @xtotco
        ,actotve   =  @xtotve
        ,ac_totcop  =  @xtotcop
        ,ac_totvep  =  @xtotvep
        ,ac_pmecore  =  @xpmecore
        ,ac_pmevere  =  @xpmevere 
        ,ac_totcore  =  @xtotcore
        ,ac_totvere  =  @xtotvere
        ,actotcopre  =  @xtotcopre 
        ,actotvepre  =  @xtotvepre
        ,acutili   =  @xutili
        ,acprecie  =  @xprecie 
        ,achedgeactualfuturo    =  @xPoHeFut
        ,achedgeactualspot      =  @xPoHeSpt
        ,achedgeutilidad        =  @xuhedge  
	,achedgevctofuturo	=  @xPoHeVenFut
        ,acacumdia	        = @xAcumDia
	,acacummes	        = @xAcumMes
        ,actotcopo              = @xtotcopo
        ,actotvepo              = @xtotvepo 
    
END

GO
