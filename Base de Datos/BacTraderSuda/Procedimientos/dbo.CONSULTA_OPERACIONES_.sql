USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[CONSULTA_OPERACIONES_]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CONSULTA_OPERACIONES_]  
   (   @dFechaProceso   DATETIME   )  
AS  
BEGIN  
  
 SET NOCOUNT ON ;  
  
 DECLARE @dFecha_Hoy  DATETIME   ;  
  
 SET @dFecha_Hoy=( SELECT acfecproc FROM MDAC ) ;  
  
 IF @dFechaProceso = @dFecha_Hoy  
 BEGIN  
  SELECT DISTINCT  
		monumoper  = monumoper  
		,motipoper  = motipoper  
		,morutcart  = morutcart  
		,nombre     = isnull(clnombre, '')  
		,monto      = CASE    
		WHEN motipoper  = 'IB'                   THEN SUM(movalinip)  
		WHEN motipoper IN('CP')                  THEN SUM(movalcomp)  
		WHEN motipoper IN('RC','RCA')            THEN SUM(movalvenp)  
		WHEN motipoper IN('VP','RV','RVA','ST')  THEN SUM(movalven)  
		WHEN motipoper IN('CI','VI','FLI')       THEN SUM(movalinip)  
		WHEN motipoper IN('IC','RIC')            THEN SUM(movpresen)  
		END  
		,mohora     = CONVERT(CHAR(8),MAX(mohora),103)  
		,mousuario  = nombre  
		,mostatreg  = mostatreg  
		,morutcli   = morutcli  
	INTO #operaciones_dia  
    FROM mdmo  
		LEFT JOIN BacParamSuda..CLIENTE   ON 
			clrut		= CASE WHEN motipoper = 'RIC' THEN morutContraparte ELSE morutcli END
			AND clcodigo= CASE WHEN motipoper = 'RIC' THEN mocodContraparte ELSE mocodcli END
		LEFT JOIN BacParamSuda..USUARIO U ON 
			U.usuario = mousuario  
	WHERE motipoper IN('CP','RCA','VP','RVA','ST','CI','VI','IC','RIC')    
	GROUP   
	BY monumoper ,  
         motipoper ,   
         morutcart ,   
         morutcli  ,   
         clnombre  ,  
         nombre    ,  
         mostatreg  
  UNION  
  SELECT DISTINCT  
         monumoper  = monumoper  
  ,      motipoper  = CASE  WHEN mocodigo = 992 THEN 'ICOL'   
      ELSE                     'ICAP'  
        END  
  ,      morutcart  = morutcart  
  ,      nombre     = isnull(clnombre, '')  
  ,      monto      = SUM(movalinip)  
  ,      mohora     = CONVERT(CHAR(8),MAX(mohora),103)  
  ,      mousuario  = nombre  
  ,      mostatreg  = mostatreg  
  ,      morutcli   = morutcli  
    FROM mdmo  
		LEFT JOIN BacParamSuda..CLIENTE ON 
			clrut=morutcli   
			AND clcodigo=mocodcli  
		LEFT JOIN BacParamSuda..USUARIO U ON 
			u.usuario = mousuario  
   WHERE motipoper IN('IB')  
          GROUP   
      BY monumoper  ,  
         motipoper  ,  
         mocodigo  ,  
         morutcart  ,  
         morutcli  ,  
         clnombre  ,  
         nombre  ,  
         mostatreg  
  
  INSERT INTO #OPERACIONES_DIA  
  SELECT  Numero_Operacion     
		, Tipo_operacion   
		, acrutprop     
		, isnull(clnombre, '')    
		, Total_Operacion  
		, hora      
		, a.Usuario     
		, ''      
		, 97029000  
  FROM Resumen_Operaciones_Fli a  ,  
        mdac,   
		BacParamSuda..CLIENTE  
  WHERE a.fecha_operacion = @dFechaProceso     
		AND clrut=97029000  
		AND clcodigo=1  
  
  SELECT DISTINCT *   
    FROM #OPERACIONES_DIA   
    ORDER   
      BY monumoper ASC  
  
 END   
 ELSE  
 BEGIN  
  SELECT DISTINCT  
         monumoper  = monumoper  
  ,      motipoper  = motipoper  
  ,      morutcart  = morutcart  
  ,      nombre     = isnull(clnombre, '')  
  ,      monto      = CASE  WHEN motipoper  = 'IB'                   THEN SUM(movalinip)  
      WHEN motipoper IN('CP')                  THEN SUM(movalcomp)  
      WHEN motipoper IN('RC','RCA')            THEN SUM(movalvenp)  
      WHEN motipoper IN('VP','RV','RVA','ST')  THEN SUM(movalven)  
      WHEN motipoper IN('CI','VI','FLI')       THEN SUM(movalinip)  
      WHEN motipoper IN('IC','RIC')            THEN SUM(movpresen)  
        END  
  ,      mohora     = CONVERT(CHAR(8),MAX(mohora),103)  
  ,      mousuario  = nombre  
  ,      mostatreg  = mostatreg  
  ,      morutcli   = morutcli  
   INTO #OPERACIONES_HIS  
   FROM mdmh  
   LEFT   
   JOIN BacParamSuda..CLIENTE     
     ON clrut = morutcli   
       AND clcodigo = mocodcli  
   LEFT   
   JOIN BacParamSuda..USUARIO U   
     ON U.usuario = mousuario  
     WHERE mofecpro   = @dFechaProceso  
    AND motipoper IN('CP','RCA','VP','RVA','ST','CI','VI','IC','RIC') -- > VB 01/03/2010  
  GROUP   
     BY monumoper  ,  
        motipoper  ,  
        morutcart  ,  
        morutcli   ,  
        clnombre   ,  
        nombre   ,  
        mostatreg  
  UNION  
  SELECT DISTINCT  
         monumoper  = monumoper  
  ,      motipoper  = CASE  WHEN mocodigo = 992 THEN 'ICOL'  
                                  ELSE                     'ICAP'  
        END  
  ,      morutcart  = morutcart  
  ,      nombre     = isnull(clnombre, '')  
  ,      monto      = SUM(movalinip)  
  ,      mohora     = CONVERT(CHAR(8),MAX(mohora),103)  
  ,      mousuario  = nombre  
  ,      mostatreg  = mostatreg  
  ,      morutcli   = morutcli  
           FROM mdmh  
    LEFT   
    JOIN BacParamSuda..CLIENTE     
      ON clrut = morutcli   
     AND clcodigo = mocodcli  
    LEFT   
    JOIN BacParamSuda..USUARIO U   
      ON u.usuario = mousuario  
   WHERE mofecpro   = @dFechaProceso  
     AND motipoper IN('IB')  
   GROUP   
      BY monumoper  ,  
         motipoper  ,  
         mocodigo  ,  
         morutcart  ,  
         morutcli  ,  
         clnombre  ,  
         nombre   ,  
         mostatreg  
  
  INSERT INTO #OPERACIONES_HIS  
  SELECT  Numero_Operacion     
  , Tipo_operacion   
  , acrutprop     
  , clnombre    
  , Total_Operacion  
  , hora      
  , a.Usuario     
  , ''      
  , 97029000  
  FROM Resumen_Operaciones_Fli a  ,  
       mdac   ,   
       BacParamSuda..CLIENTE  
  WHERE a.fecha_operacion = @dFechaProceso     
    AND clrut=97029000  
           AND clcodigo=1  
  
  SELECT DISTINCT *   
    FROM #OPERACIONES_HIS   
    ORDER   
      BY monumoper ASC  
 END   
  
  
END  
GO
