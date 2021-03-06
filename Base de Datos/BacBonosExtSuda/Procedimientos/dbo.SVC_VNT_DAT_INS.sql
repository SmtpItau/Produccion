USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_VNT_DAT_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SVC_VNT_DAT_INS]  
(   
    @RutCart    NUMERIC(09) ,  
 @Cadena_Familias  CHAR(255)= '' ,  
 @Cadena_Monedas   CHAR(255)= '' ,  
 @Cadena_Series   CHAR(255)= '' ,  
 @Id_Cartera_Normativa CHAR(10) = '' ,  
 @Id_Cartera_Financiera CHAR(10) = '' ,  
 @Id_Libro    CHAR(10) = ''   
)  
AS  
BEGIN  
  
 SET NOCOUNT ON  
  
 DECLARE @FECHA_PROCESO  DATETIME
 DECLARE @FECHA_ANTERIOR  DATETIME
  
 SELECT @FECHA_PROCESO		= CONVERT(CHAR(8),acfecproc,112) 
		,@FECHA_ANTERIOR	= CONVERT(CHAR(8),acfecante,112) 
 FROM text_arc_ctl_dri   
	--+++jcamposd COP
 	CREATE TABLE #CARTERA(
			cprutcart	NUMERIC(9)	NULL
			,cpnumdocu	CHAR(12)	NULL
			,cprutcli	NUMERIC(9)	NULL
			,cpcodcli	NUMERIC(9)	NULL
			,id_instrum CHAR(20)	NULL
			,cpbasemi	NUMERIC(3) NULL
			,cptircomp	NUMERIC(19,7) NULL
			,cpnominal	NUMERIC(19,4) NULL
			,cpvalvenc	NUMERIC(19,4) NULL
			,cppvpcomp  NUMERIC(19,7) NULL
			,cptircomp2  NUMERIC(19,7) NULL
			,valorizacion NUMERIC(19,7) NULL		
			,cpfecpago	DATETIME NULL
			,cpfeccomp	DATETIME NULL
			,cpvalcomu	FLOAT	 NULL 
			,cpfecemi	DATETIME NULL
			,cpfecven	DATETIME NULL
			,cprutemi	NUMERIC(9)	NULL
			,cpmonemi	NUMERIC(3)	NULL
			,basilea	NUMERIC(1)	NULL	
			,tipo_tasa	NUMERIC(3)	NULL
			,encaje		CHAR(1)		NULL
			,codigo_carterasuper	CHAR(1)
			,sucursal		INTEGER
			,tipo_riesgo	CHAR(10)	NULL
			,grado_riesgo	CHAR(10)	NULL
			,codigo_riesgo	CHAR(10)	NULL
			,cod_familia	NUMERIC(4)	NULL
			,cpmonpag		NUMERIC(3)	NULL  
			,confirmacion	NUMERIC(1)	NULL
			,forma_pago		NUMERIC(3)	NULL  
			,cpcodemi		NUMERIC(1)	NULL   
			,base_tasa		CHAR(20)	NULL	  
			,cusip			CHAR(12)	NULL    
			,Nom_Familia	CHAR(20)	NULL
			,datoX			CHAR(10)	NULL
			,MNNEMO			CHAR(8)		NULL
			,mostatreg		CHAR(1)		NULL
			,moint_compra	NUMERIC(19,4) NULL
			,Interes_compra	NUMERIC(19,4) NULL
		)
   -----jcamposd COP
   
    INSERT #CARTERA
	SELECT A.cprutcart   , --1  
		A.cpnumdocu   , --2  
		A.cprutcli   , --3  
		A.cpcodcli   , --4  
		A.id_instrum   , --5  
		A.cpbasemi   , --6  
		CASE WHEN a.cod_familia = 2006 THEN  A.cptircomp ELSE A.cptasemi END  , --7  
		A.cpnominal - A.cpnomi_vta , --8  
		A.cpvalvenc * ISNULL(1 - (cpnomi_vta / cpnominal),1) , --9  
		A.cppvpcomp   , --10  
		A.cptircomp   , --11  
		CASE WHEN a.cod_familia <> 2006 THEN -->jcamposd para instrumentos CDTCOP debe mostrar la valorización
				A.cpvptirc * ISNULL(1 - (cpnomi_vta / cpnominal),1)  --12  -->jcamposd linea original
		ELSE	
			 ISNULL((SELECT CASE WHEN RSVALMERC <> 0 THEN RSVALMERC ELSE rsvppresen END FROM  TEXT_RSU rsu  
					WHERE  rsu.rsnumoper = A.cpnumdocu
						AND rsu.rscartera  = '333'  
						AND rsu.rstipoper  = 'DEV'  
						AND rsu.rsfecpro  = @FECHA_ANTERIOR
						AND rsu.cod_familia = 2006),a.cpvalvenc)	
		END,
		A.cpfecpago   , --13  
		A.cpfeccomp   , --14  
		A.cpvalcomu * ISNULL(1 - (cpnomi_vta / cpnominal),1) , --15  
		A.cpfecemi   , --16  
		A.cpfecven   , --17  
		A.cprutemi   , --18  
		A.cpmonemi   , --19  
		A.basilea   , --20  
		A.tipo_tasa   , --21  
		A.encaje   , --22  
		A.codigo_carterasuper  , --23  
		A.sucursal   , --24  
		' '    , --tipo_riesgo  , --25  
		' '    , --grado_riesgo , --26  
		' '    , --codigo_riesgo , --27  
		A.cod_familia   , --28  
		A.cpmonpag   , --29  
		A.confirmacion   , --30  
		A.forma_pago   , --31  
		A.cpcodemi   , --32  
		A.base_tasa   , --33  
		A.cusip    , --34  
		B.Nom_Familia     , --35  
		' '    , --36  
		c.MNNEMO   , --37  
		ISNULL(d.mostatreg,''),     --38
		0,  
		--+++jcamposd se suma intereses necesarios para valorizar la venta de los COP
		CASE WHEN a.cod_familia = 2006 THEN ISNULL(moint_compra,0) ELSE 0 END --39
		-----jcamposd se suma intereses necesarios para valorizar la venta de los COP
	FROM text_ctr_inv A  
	   LEFT  JOIN view_moneda c  ON A.cpmonemi  = c.MNCODMON  
	   RIGHT JOIN text_mvt_dri D ON  D.monumoper  = A.cpnumdocu  AND D.mocorrelativo = A.cpcorrelativo  
	   INNER JOIN text_fml_inm B  ON A.Cod_familia = B.cod_familia  
	WHERE A.cprutcart = @rutcart  
	 AND A.cpnominal			> 0    
	 AND A.cpnomi_vta			< A.cpnominal 
	 AND   CHARINDEX(RTRIM(LTRIM(b.Nom_Familia)),@Cadena_Familias) > 0   --jcamposd 20161026 depositos colombianos
	 AND   CHARINDEX(RTRIM(LTRIM(c.MNNEMO)),@Cadena_Monedas) > 0   --jcamposd 20161026 depositos colombianos
	 AND   CHARINDEX(RTRIM(LTRIM(a.id_instrum)),@Cadena_Series) > 0   --jcamposd 20161026 depositos colombianos
	 AND A.codigo_carterasuper  = @Id_Cartera_Normativa   
	-- AND A.tipo_inversion     = @Id_Cartera_Financiera  
	 AND A.tipo_cartera_financiera   = @Id_Cartera_Financiera  
	 AND A.Id_Libro				= @Id_Libro  
		AND D.mofecpro          <= D.mofecpago   
	 AND CONVERT(CHAR(8),A.cpfeccomp,112)<= @FECHA_PROCESO  
	 AND  d.moDigitador <> ''
	 
 
	 --+++jcamposd 20170130 no debe mostrar un COP a venta el día del vencimiento
	 DELETE #CARTERA
	 WHERE cod_familia = 2006
	 AND cpfecven = @FECHA_PROCESO
	-----jcamposd 20170130 no debe mostrar un COP a venta el día del vencimiento
	
	--+++jcamposd COP
	DECLARE @numeroOpe	CHAR(12) 
	DECLARE @cpfeccomp	DATETIME
	DECLARE @DIFDIAS	NUMERIC(3)
	DECLARE @tirCompra	NUMERIC(19,7)
	DECLARE @cpfecven	DATETIME
	DECLARE @cpnominal	NUMERIC(19,4)
	DECLARE @TasaNomina NUMERIC(19,7)
	DECLARE	@interesDev	NUMERIC(19,7)

	DECLARE calculaDevengoalDia_COP CURSOR FOR   
    SELECT cpnumdocu
			,cpfeccomp
			,cptircomp
			,cpfecven
			,cpnominal  
    FROM #CARTERA
    WHERE cod_familia = 2006  
  
    OPEN calculaDevengoalDia_COP  
    FETCH NEXT FROM calculaDevengoalDia_COP INTO @numeroOpe, @cpfeccomp,@tirCompra,@cpfecven,@cpnominal  
  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
  
		--para tasa nominal calculo dias base 30 desde inicio a fin
		EXECUTE Svc_fmu_dif_d30 @cpfeccomp, @cpfecven, @DIFDIAS OUTPUT  
		
		
		SELECT @TasaNomina = (ROUND((POWER((1+(@tirCompra/100)),(@DIFDIAS/360))-1)*(360/@DIFDIAS),6))
		
		--ROUND(  ROUND( ((((POWER((1+ (@TE/100)),(@V001/360))-1)*(360/@V001))*@V001)/360),6)   *@nom , 0 )'
		
		EXECUTE Svc_fmu_dif_d30 @cpfeccomp, @FECHA_PROCESO, @DIFDIAS OUTPUT  
		IF @DIFDIAS = 0
		BEGIN
			SELECT @interesDev = 0
		END
		ELSE
		BEGIN
			SELECT @interesDev = ROUND(@TasaNomina*@DIFDIAS/360,6)*@cpnominal
			
        END
        
		UPDATE #CARTERA
		SET moint_compra = @interesDev
		WHERE cpnumdocu = @numeroOpe 

        
        FETCH NEXT FROM calculaDevengoalDia_COP INTO @numeroOpe, @cpfeccomp,@tirCompra,@cpfecven,@cpnominal   
        END      
  
    CLOSE calculaDevengoalDia_COP  
    DEALLOCATE calculaDevengoalDia_COP  


		SELECT cprutcart
			,cpnumdocu
			,cprutcli
			,cpcodcli
			,id_instrum
			,cpbasemi
			,cptircomp
			,cpnominal
			,cpvalvenc
			,cppvpcomp
			,cptircomp2
			,valorizacion
			,cpfecpago
			,cpfeccomp
			,cpvalcomu
			,cpfecemi
			,cpfecven
			,cprutemi
			,cpmonemi
			,basilea
			,tipo_tasa
			,encaje
			,codigo_carterasuper
			,sucursal
			,tipo_riesgo
			,grado_riesgo
			,codigo_riesgo
			,cod_familia
			,cpmonpag
			,confirmacion
			,forma_pago
			,cpcodemi
			,base_tasa
			,cusip
			,Nom_Familia
			,datoX
			,MNNEMO
			,mostatreg
			,moint_compra
			,Interes_compra
	 FROM #CARTERA

	-----jcamposd

  
 SET NOCOUNT OFF  
  
END  
GO
