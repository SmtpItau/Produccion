USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GMOVTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


------------------------------------------------------------------------------------------------------
-- Afecta la Posicion Actual Spot Con las Operaciones de FWD, en SPOT el procedimiento se llama igual
------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[SP_GMOVTO]

               (
                        @tipmer           CHAR(4) ,
                        @tipope           CHAR(1) ,
                        @ticam            NUMERIC(19,4) ,
                        @ussme            NUMERIC(19,4) ,
			@vcto             NUMERIC(1) = 0                           
                      )
AS
BEGIN
SET NOCOUNT ON
DECLARE @xpreini     NUMERIC(10,4) ,--ACPREINI
        @xposinic    NUMERIC(15,2) ,--ACPOSINI
        @xposic      NUMERIC(15,2) ,--ACPOSIC
        @xpmeco      NUMERIC(10,4) ,--ACPMECO
        @xpmeve      NUMERIC(10,4) ,--ACPMEVE
        @xtotco      NUMERIC(15,2) ,--ACTOTCO
        @xtotve      NUMERIC(15,2) ,--actotve
        @xtotcop     NUMERIC(15,2) ,--ACTOTCOPO
        @xtotvep     NUMERIC(15,2) ,--ACTOTVEPO
        @xpmecore    NUMERIC(19,4) ,--AC_PMECORE
        @xpmevere    NUMERIC(19,4) ,--AC_PMEVERE
        @xtotcore    NUMERIC(19,4) ,--AC_TOTCORE
        @xtotvere    NUMERIC(19,4) ,--AC_TOTVERE
        @xtotcopre   NUMERIC(19,4) ,--ACTOTCOPRE
        @xtotvepre   NUMERIC(19,4) ,--ACTOTVEPRE
        @xutili      NUMERIC(15,2) ,--ACUTILI
        @xprecie     NUMERIC(10,4) ,--ACPRECIE
        @xPrHeIni    NUMERIC(15,4) ,--ACHEDGEPRECIOINICIAL
        @xPoHeFui    NUMERIC(15,4) ,--ACHEDGEINICIALFUTURO
        @xPoHeSpi    NUMERIC(19,4) ,--ACHEDGEINICIALSPOT
        @xPoHeFut    NUMERIC(19,4) ,--ACHEDGEACTUALFUTURO
        @xPoHeSpt    NUMERIC(19,4) ,--ACHEDGEACTUALSPOT
        @xuhedge     NUMERIC(19,2) ,--ACHEDGEUTILIDAD
        @xtotcocp    NUMERIC(19,4) ,--CP_TOTCO
        @xtotvecp    NUMERIC(19,4) ,--CP_TOTVE
        @xtotcopcp   NUMERIC(19,2) ,--CP_TOTCOP
        @xtotvepcp   NUMERIC(19,2) ,--CP_TOTVEP
        @xutilicp    NUMERIC(9,2)  ,--CP_UTILI
        @xpmecocp    NUMERIC(15,4) ,--CP_PMECO
        @xpmevecp    NUMERIC(15,4) ,--CP_PMEVE
        @xpmecocpci  NUMERIC(15,4) ,--CP_PMECOCI
        @xpmevecpci  NUMERIC(15,4) ,--CP_PMEVECI
        @xuticocp    NUMERIC(15,2) ,--CP_UTICO
        @xutivecp    NUMERIC(15,2) ,--CP_UTIVE 
        @xpohedge    NUMERIC(19,2) ,
        @xPosini     NUMERIC(15,2) ,
        @xPoHeVenFut NUMERIC(19,4)  --ACHEDGEVCTOFUTURO 

   DECLARE @xAcumDia    NUMERIC(19,4) --ACACUMDIA
   DECLARE @xAcumMes    NUMERIC(19,4) --ACACUMMES
   DECLARE @xFecAnt	CHAR(08)
   DECLARE @xFecHoy	CHAR(08)
   DECLARE @xAcumAnt    NUMERIC(19,4)
   DECLARE @xtotcopo    NUMERIC(15,2) --ACTOTCOPO
   DECLARE @xtotvepo    NUMERIC(15,2) --ACTOTVEPO


SELECT  @xpmeco        = 0 ,
        @xpmeve        = 0 ,
        @xtotco        = 0 ,
        @xtotve        = 0 ,
        @xtotcop       = 0 ,
        @xtotvep       = 0 ,
        @xpmecore      = 0 ,
        @xpmevere      = 0 ,
        @xtotcore      = 0 ,
        @xtotvere      = 0 ,
        @xtotcopre     = 0 ,
        @xtotvepre     = 0 ,
        @xutili        = 0 ,
        @xprecie       = 0 ,
        @xuhedge       = 0 ,
        @xtotcocp      = 0 ,
        @xtotvecp      = 0 ,
        @xtotcopcp     = 0 ,
        @xtotvepcp     = 0 ,
        @xutilicp      = 0 ,
        @xpmecocp      = 0 ,
        @xpmevecp      = 0 ,
        @xpmecocpci    = 0 ,
        @xpmevecpci    = 0 ,
        @xuticocp      = 0 ,
        @xutivecp      = 0 ,
        @xpreini       = 0 ,
        @xposini       = 0 ,
        @xposic        = 0 ,
        @xPrHeIni      = 0 ,
        @xPoHeFui      = 0 ,
        @xPoHeSpi      = 0 ,
        @xPoHeFut      = 0 ,
        @xPoHeSpt      = 0 ,
	@xPoHeVenFut   = 0 ,
        @xtotcopo      = 0 ,
        @xtotvepo      = 0 


   SELECT @xAcumDia     = 0
   SELECT @xAcumMes     = 0
   SELECT @xAcumAnt     = 0

   SELECT @xFecAnt  = CONVERT(CHAR(8),acfecant,112)  
         ,@xFecHoy  = CONVERT(CHAR(8),acfecpro,112)  
   FROM BacCamSuda..meac

   IF MONTH(@xFecHoy) = MONTH(@xFecAnt) BEGIN 
      SELECT  @xAcumAnt	= acacummes 
      FROM    BacCamSuda..meach 
      WHERE   acfecpro = @xFecAnt
   END
  
 EXECUTE Sp_Parametros_Actuales  @tipmer   ,
          @xpreini     OUT ,--ACPREINI
          @xposini     OUT ,--ACPOSINI
          @xposic      OUT ,--ACPOSIC
          @xpmeco      OUT ,--ACPMECO
          @xpmeve      OUT ,--ACPMEVE
          @xtotco      OUT ,--ACTOTCO
          @xtotve      OUT ,--actotve
          @xtotcop     OUT ,--AC_TOTCOPO
          @xtotvep     OUT ,--AC_TOTVEPO
          @xpmecore    OUT ,--AC_PMECORE
          @xpmevere    OUT ,--AC_PMEVERE
          @xtotcore    OUT ,--AC_TOTCORE
          @xtotvere    OUT ,--AC_TOTVERE
          @xtotcopre   OUT ,--ACTOTCOPRE
          @xtotvepre   OUT ,--ACTOTVEPRE
          @xutili      OUT ,--ACUTILI
          @xprecie     OUT ,--ACPRECIE
          @xPrHeIni    OUT ,--ACHEDGEPRECIOINICIAL
          @xPoHeFui    OUT ,--ACHEDGEINICIALFUTURO
          @xPoHeSpi    OUT ,--ACHEDGEINICIALSPOT
          @xPoHeFut    OUT ,--ACHEDGEACTUALFUTURO
          @xPoHeSpt    OUT ,--ACHEDGEACTUALSPOT
          @xuhedge     OUT ,--ACHEDGEUTILIDAD
          @xtotcocp    OUT ,--CP_TOTCO
          @xtotvecp    OUT ,--CP_TOTVE
          @xtotcopcp   OUT ,--CP_TOTCOP
          @xtotvepcp   OUT ,--CP_TOTVEP
          @xutilicp    OUT ,--CP_UTILI
          @xpmecocp    OUT ,--CP_PMECO
          @xpmevecp    OUT ,--CP_PMEVE
          @xpmecocpci  OUT ,--CP_PMECOCI
          @xpmevecpci  OUT ,--CP_PMEVECI
          @xuticocp    OUT ,--CP_UTICO
          @xutivecp    OUT ,--CP_UTIVE
          @xPoHeVenFut OUT ,--ACHEDGEVCTOFUTURO           
          @xtotcopo    OUT ,--ACTOTCOPO
          @xtotvepo    OUT --ACTOTVEPO  

 SELECT @xpohedge = @xPoHeFut + @xPoHeSpt + @xPoHeVenFut

-- SELECT @xpohedge = @xPoHeFut + @xPoHeSpt

 EXECUTE Sp_Func_MxRecalcPr  @tipmer  ,
        @tipope  ,
        @ticam   ,
        @ussme   ,
        @vcto	 , 
        @xPoHeFut,
        @xPoHeSpt,       
        @xtotco     OUT ,
        @xtotcop    OUT ,
        @xpmeco     OUT ,
        @xtotve     OUT ,
        @xtotvep    OUT ,
        @xpmeve     OUT ,
        @xtotcore   OUT ,
        @xtotcopre  OUT ,
        @xpmecore   OUT ,
        @xposic     OUT ,
        @xpohedge   OUT ,
        @xpohefut   OUT ,
        @xpohespt   OUT ,
        @xtotvere   OUT ,
        @xtotvepre  OUT ,
        @xpreini    OUT ,
        @xPosini    OUT ,
        @xprecie    OUT ,
        @xutili     OUT ,
        @xprheini   OUT ,
        @xPoHeVenFut OUT,
        @xuhedge    OUT ,
        @xtotcopo   OUT ,
        @xtotvepo   OUT     
--select @xutili , @xuhedge 
      SELECT @xAcumDia     = @xutili + @xuhedge --+ @xFicAcumDia

--select @xAcumAnt , @xAcumDia
      SELECT @xAcumMes     = @xAcumAnt + @xAcumDia




 EXECUTE sp_Func_GrabaParam2  @tipmer     ,
         @xpreini     ,
         @xposinic    ,
         @xposic      ,
         @xpmeco      ,
         @xpmeve      ,
         @xtotco      ,
         @xtotve      ,
         @xtotcop     ,
         @xtotvep     ,
         @xpmecore    ,
         @xpmevere    ,
         @xtotcore    ,
         @xtotvere    ,
         @xtotcopre   ,
         @xtotvepre   ,
         @xutili      ,
         @xprecie     ,
         @xPoHeFui    ,
         @xPoHeSpi    ,
         @xPoHeFut    ,
         @xPoHeSpt    ,
         @xuhedge     ,
	 @xPoHeVenFut ,
         @xAcumDia    ,
	 @xAcumMes    ,
         @xtotcopo    ,
         @xtotvepo     


 SET NOCOUNT OFF
END

GO
