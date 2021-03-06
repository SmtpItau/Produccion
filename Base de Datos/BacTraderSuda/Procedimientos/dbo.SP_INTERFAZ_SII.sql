USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_SII]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_SII]
                (
                 @Ano        CHAR(04)
		,@Ejecucion  CHAR(25)
                 )
 AS BEGIN

 SET NOCOUNT ON

 DECLARE @FecProcI   CHAR(10)	 ,
	 @FecProcF   CHAR(10) 	 ,
	 @FecProcIni DATETIME	 ,
	 @FecProcFec DATETIME	 

 SET @FecProcI = LTRIM(RTRIM(@Ano)) + '0101'
 SET @FecProcF = LTRIM(RTRIM(@Ano+1)) + '0101'
 SET @FecProcIni  =  @FecProcI
 SET @FecProcFec  =  @FecProcF

 IF @Ejecucion = 'INT_SII'
 BEGIN

   SELECT 
         'Entv_Rut_Num' = morutcli
        ,'Entv_Rut_Dve' = cldv
        ,'Entv_Num_Ope' = monumoper
        ,'Entv_Moneda'  = ISNULL((SELECT mncodfox FROM view_moneda where mncodmon = momonpact),0)
        ,'Entv_Fec_Ope' = mofecinip
        ,'Entv_Fec_Ven' = mofecvenP
        ,'Entv_Mon_Ope' = SUM(movalinip)
        ,'Entv_Mon_Rec' = SUM(movalvenp)
        ,'Entv_Int_Pag' =  CONVERT(NUMERIC(18,2),0)
        ,'Entv_Int_Rea'  = CONVERT(NUMERIC(18,2),0)
        ,'Entv_Int_Fil'  = SPACE(46)
        ,'moneda_inicial'= CASE WHEN momonpact = 999 THEN CONVERT(NUMERIC(19,2),ISNULL((select vmvalor from view_valor_moneda where vmfecha=mofecinip and vmcodigo = 998),0))
				ELSE                      CONVERT(NUMERIC(19,2),ISNULL((select vmvalor from view_valor_moneda where vmfecha=mofecinip and vmcodigo=momonpact),0)) 
			   END
	,'moneda_final'  = CASE WHEN momonpact = 999 THEN CONVERT(NUMERIC(19,2),ISNULL((select vmvalor from view_valor_moneda where vmfecha=mofecvenp and vmcodigo = 998),0))
				ELSE                      CONVERT(NUMERIC(19,2),ISNULL((select vmvalor from view_valor_moneda where vmfecha=mofecvenp and vmcodigo=momonpact),0))
			   END
	,'moneda_pacto'  = momonpact
	,'montov'        = SUM(movalinip)

     INTO #TEMPORAL
     FROM MDMH
         ,VIEW_CLIENTE
    WHERE morutcli  = clrut
      AND mocodcli  = clcodigo
      and mofecvenp > @FecProcIni and mofecvenp  < @FecProcFec
      AND motipoper IN('RC','RCA')
      AND mostatreg <> 'A'
    GROUP BY
          morutcli
	 ,cldv
         ,monumoper
	 ,momonpact
	 ,mofecinip
	 ,mofecvenP

  UPDATE #TEMPORAL 
	SET Entv_Int_Pag = CASE WHEN  moneda_pacto = 999                THEN  ROUND(Entv_Mon_Rec - montov,0)
			        WHEN  moneda_pacto in ( 994,998,995 )   THEN       (Entv_Mon_Rec * moneda_final) -  montov 
			        ELSE  0
			   END

  UPDATE #TEMPORAL 
	SET Entv_Int_Rea = CASE WHEN moneda_pacto = 999              THEN ROUND((Entv_Mon_Ope + Entv_Int_Pag) -( (  moneda_final/moneda_inicial) * Entv_Mon_Ope ),0)
                                WHEN moneda_pacto in ( 998,994,995 ) THEN round((Entv_Mon_Ope + Entv_Int_Pag) - ( (  moneda_final/moneda_inicial) * Entv_Mon_Ope ),0)
                                ELSE 0
                           END
 
  SELECT * FROM #TEMPORAL

  END

IF @Ejecucion = 'INT_CLI'
  BEGIN
   SELECT 
         'Cliv_Rut_Num' = morutcli
        ,'Cliv_Rut_Dve' = cldv
        ,'Cliv_Nom_Cli' = CONVERT(CHAR(35),clnombre)
        ,'Cliv_Dir_Cli' = CONVERT(CHAR(29),Cldirecc)
        ,'Cliv_Ciu_Cli' = CONVERT(CHAR(20),VIEW_CIUDAD.nombre)
        ,'Cliv_Ind_Cli' = 1
        ,'Cliv_Tot_Int' = 0
        ,'Cliv_Fec_Emi' = 0
        ,'Cliv_Fol_Cli' = 0
        ,'Cliv_Fil_Cli' = SPACE(09)
     FROM MDMH
         ,VIEW_CLIENTE
         ,VIEW_CIUDAD
    WHERE 
          morutcli   = clrut
      AND mocodcli   = clcodigo
      AND Clciudad   = codigo_ciudad
      AND motipoper  IN('RC','RCA')
      and mofecvenp  > @FecProcIni and mofecvenp  < @FecProcFec
      AND mostatreg <> 'A'
    GROUP BY
          morutcli
	 ,cldv
         ,clnombre
	 ,Cldirecc
	 ,VIEW_CIUDAD.nombre
    ORDER BY
         morutcli

  END

SET NOCOUNT OFF

END


GO
