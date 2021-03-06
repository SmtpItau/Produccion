USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_POSICION_CLIENTE_FWD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_POSICION_CLIENTE_FWD]
AS
BEGIN
/* Cambio solicitado en e-mail:
De:	Patricio Rojas Vargas 
Enviado el:	Lunes, 12 de Septiembre de 2005 8:55
Para:	María Paz Navarro Genta
Asunto:	RE: SOLICITUD DE VALIDACIONES DE Interfaces para ver como llegan las operaciones BFT
TAG MPNG20050912
Se infiere que al vencimiento ningún producto forwards debe aparecer en las interfaces.
*/

DECLARE 

             @cod_bco                       CHAR(2)                                                        --1
            ,@cod_suc                       CHAR(4)                                                       --2
            ,@cod_mda                       NUMERIC(4)                                                  --3
            ,@cod_cta                       NUMERIC(16)                                                 --4
            ,@t_producto                    CHAR(4)                                                       --5
            ,@t_proceso                     CHAR(2)                                                       --6     
            ,@cod_prod                      CHAR(4)                                                       --7 
            ,@cls_cbtle                     NUMERIC(1)                                                  --8
            ,@cod_pais                      CHAR( 2)                                                       --9
            ,@act_eco                       NUMERIC(4)                                                  --10
            ,@tip_prod                      CHAR(1)                                                        --11
            ,@F_Infor                       CHAR(3)                                                        --12
            ,@descrip                       VARCHAR(35)                                               --13
            ,@mes_proc                      NUMERIC(2)                                                  --14
            ,@dia_proc                      NUMERIC(2)                                                  --15
            ,@ano_proc                      NUMERIC(4)                                                  --16
            ,@cod_mda2                      NUMERIC(3)                                                  --17
            ,@n_operac                      NUMERIC(9)                                                 --18
            ,@rut                           NUMERIC(9)                                                 --19
            ,@dig                           CHAR(1)                                                       --20
            ,@est_deuda                     CHAR(1)                                                       --21
            ,@mes_inic                      NUMERIC(2)                                                 --22
            ,@dia_inic                      NUMERIC(2)                                                 --23
            ,@ano_inic                      NUMERIC(4)                                                 --24
            ,@mes_vcto                      NUMERIC(2)                                                --25
            ,@dia_vcto                      NUMERIC(2)                                                --26
            ,@ano_vcto                      NUMERIC(4)                                                --27
            ,@plazo                         NUMERIC(5)                                                --28
            ,@tip_plazo                     CHAR(2)                                                     --29

            ,@mto_orig                      NUMERIC(14,2)                                          --30
            ,@mto_cap                       NUMERIC(14,2)                                          --31
            ,@sdo_orig                      NUMERIC(14,2)                                          --32
            ,@sdo_cap                       NUMERIC(14,2)                                       --33
            ,@int_dev_orig                  NUMERIC(14,2)                                          --34
            ,@int_dev_nac                   NUMERIC(14,2)                                          --35
            ,@reajuste                      NUMERIC(14,2)          --36

            ,@cod_proc                      CHAR(2)                                                    --37
            ,@estatus                       CHAR(1)                                                    --39
            ,@maximo                        INT
            ,@tasa                          NUMERIC(21,6)                                           --41
            ,@saldo                         NUMERIC(18,2)                                          --42
            ,@signo                         CHAR(1)                                                    --43
            ,@valor                         NUMERIC(18,2)
            ,@x                             INT
            ,@observado                     NUMERIC(18,4)
            ,@tipo                          NUMERIC(18,4)
            ,@FuetoDebi                     NUMERIC(1)


DECLARE @FECHA DATETIME
SELECT @FECHA = (SELECT acfecproc FROM MFAC)

CREATE TABLE #INTERFAZ
   (
            cod_bco                         CHAR(2)                --1
            ,cod_suc                        CHAR(4)                --2
            ,cod_mda                        NUMERIC(4)             --3
            ,cod_cta                        NUMERIC(16)            --4
            ,t_producto                     CHAR(4)                --5
            ,t_proceso                      CHAR(2)                --6     
            ,cod_prod                       CHAR(4)                --7 
            ,cls_cbtle                      NUMERIC(1)             --8
            ,cod_pais                       CHAR( 2)               --9
            ,act_eco                        NUMERIC(4)             --10
            ,tip_prod                       CHAR(1)                --11
            ,F_Infor                        CHAR(3)                --12
            ,descrip                        VARCHAR(35)            --13
            ,mes_proc                       NUMERIC(2)             --14
            ,dia_proc                       NUMERIC(2)             --15
            ,ano_proc                       NUMERIC(4)             --16
            ,cod_mda2                       NUMERIC(3)             --17
            ,n_operac                       NUMERIC(9)             --18
            ,rut                            NUMERIC(9)             --19
            ,dig                            CHAR(1)                --20
            ,est_deuda                      CHAR(1)                --21
            ,mes_inic                       NUMERIC(2)             --22
            ,dia_inic                       NUMERIC(2)             --23
            ,ano_inic                       NUMERIC(4)             --24
            ,mes_vcto						NUMERIC(2)             --25
            ,dia_vcto                       NUMERIC(2)             --26
            ,ano_vcto                       NUMERIC(4)             --27
            ,plazo							NUMERIC(5)             --28
            ,tip_plazo                      CHAR(2)                --29
            ,mto_orig                       NUMERIC(14,2)          --30
            ,mto_cap                        NUMERIC(14,2)          --31
            ,sdo_orig                       NUMERIC(14,2)          --32
            ,sdo_cap                        NUMERIC(14,2)          --33
            ,int_dev_orig                   NUMERIC(14,2)          --34
            ,int_dev_nac                    NUMERIC(14,2)          --35
            ,reajuste                       NUMERIC(14,2)          --36
            ,cod_proc                       CHAR(2)                --37
            ,estatus            CHAR(1)                --39
            ,maximo                         INT
            ,tasa                           NUMERIC(21,6)          --41
            ,saldo                          NUMERIC(18,2)          --42
            ,signo                          CHAR(1)                --43
      )

	SET NOCOUNT ON

	SELECT  
          'cod_bco'    = '01'                                                                                          ---1
         ,'cod_suc'   = '001'                                                                                          --2
         ,'cod_mda'   = cacodmon1                                                                              ---3
         ,'cod_cta'   = CASE WHEN cacodpos1 = 1 AND cacodmon2 = 998 AND catipoper = 'C' THEN 68452
                             WHEN cacodpos1 = 1 AND cacodmon2 = 999 AND catipoper = 'C' THEN 68627  
                             WHEN cacodpos1 = 1 AND cacodmon2 = 998 AND catipoper = 'V' THEN 27722
                             WHEN cacodpos1 = 1 AND cacodmon2 = 999 AND catipoper = 'V' THEN 28829
                             WHEN cacodpos1 = 2 AND catipoper = 'C' and clpais =  acpais THEN 30486  
                             WHEN cacodpos1 = 2 AND catipoper = 'C' and clpais <> acpais THEN 27540
                             WHEN cacodpos1 = 2 AND catipoper = 'V' and clpais =  acpais THEN 68890
                             WHEN cacodpos1 = 2 AND catipoper = 'V' and clpais <>  acpais THEN 68148
                         ELSE 0
                         END                                
         ,'t_producto'= 'MDIR'                                                                                       --5
         ,'t_proceso' = case when catipoper = 'C' then '70' else '71' end                           --6     
         ,'cod_prod'  = 'MD01'
         ,'cls_cbtle' = CASE WHEN catipoper = 'C' THEN '01' ElSE '02'   END                  --8
         ,'cod_pais'  = 'CL'                                                                                            --9
         ,'act_eco'   = ISNULL((select clactivida FROM VIEW_CLIENTE where Clrut = cacodigo AND Clcodigo= cacodcli),0)   --10
         ,'tip_prod'  = 'M'                                                                                             --11
         ,'F_Infor'   = 'BFW'                                                                                           --12
		 ,'descrip'   = ISNULL((select descripcion FROM VIEW_PRODUCTO where codigo_producto = cacodpos1 AND id_sistema = 'BFW'),0)   --13
         ,'mes_proc'  = CONVERT(NUMERIC(2),MONTH(@FECHA))                              --14
         ,'dia_proc'   = CONVERT(NUMERIC(2),DAY(@FECHA))                                    --15
         ,'ano_proc'   = CONVERT(NUMERIC(4),YEAR(@FECHA))                                --16
         ,'cod_mda2'  = cacodmon1                                                                             --17
         ,'n_operac'  = canumoper            --18
         ,'rut'       = cacodigo                                                                                       --19
         ,'dig'       = ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = cacodigo AND Clcodigo= cacodcli),' ')         --20
         ,'est_deuda' = '1'                                                                                             --21
         ,'mes_inic'  = CONVERT(NUMERIC(2),MONTH(cafecha))                                  --22
         ,'dia_inic'  = CONVERT(NUMERIC(2),DAY(cafecha))                                         --23
         ,'ano_inic'  = CONVERT(NUMERIC(4),YEAR(cafecha))                                      --24
         ,'mes_vcto'  = CONVERT(NUMERIC(2),MONTH(cafecvcto))                              --25
         ,'dia_vcto'  = CONVERT(NUMERIC(2),DAY(cafecvcto))                                     --26
         ,'ano_vcto'  = CONVERT(NUMERIC(4),YEAR(cafecvcto))                                  --27
         ,'plazo'     = caplazo                                                                                        --28
         ,'tip_plazo' = '2'                                                                                               --29
         ,'mto_orig'  = camtomon1                                                                                 --30
         ,'mto_cap'   = caequmon1                                                                                --31
         ,'sdo_orig'  = camtomon1                                                                                 --32
         ,'sdo_cap'   = caequmon1                                                                                --33
         ,'int_dev_orig' = 0 --caperdevenga+ cautildevenga                                              --34
         ,'int_dev_nac'  = 0 --caperdevenga+ cautildevenga                                             --35
         ,'reajuste'  = carevuf                                                                                         --36
         ,'cod_proc'  = '13'                                                                                             --37
         ,'estatus'   = 'A'                                                                                                --39
         ,'tasa'      = 0                      
         ,'saldo'     = caequmon1 + carevuf 
         ,'signo'     = CASE WHEN carevuf <  0 THEN  '-'  ELSE  '+' END
         ,'valor'     = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = cacodmon1 and vmfecha = cafecha),0.0)
         ,'observado' = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = cafecha),0.0)
         ,'tipo'      = caparmon1
         ,'FuetoDebi' = ISNULL((select mnrefusd from view_moneda where mncodmon = cacodmon1),0)
		 ,Id		  = identity(numeric(9))
         INTO #TEMPORAL
         FROM MFCA,VIEW_CLIENTE,MFAC
         WHERE cacodigo = clrut AND cacodcli = clcodigo 
         AND cafecvcto > @FECHA -- TAG MPNG20050912

       -- OPCIONES, x COMPONENTE, MAP 20091005 
	INSERT INTO #TEMPORAL
	SELECT  
          'cod_bco'    = '01'                                                                                          ---1
         ,'cod_suc'   = '001'                                                                                          --2
         ,'cod_mda'   = cacodmon1   ---3
         ,'cod_cta'   = CASE WHEN CaCVOpc = 'C' and 1=2 THEN 68627    -- Desactivar por mientras
                             WHEN CaCVOpc = 'V' and 1=2 THEN 28829    -- Desactivar por mientras
                         ELSE 0
                         END                                
         ,'t_producto'= 'MDIR'                                                                                       --5
         ,'t_proceso' = case when CaCVOpc = 'C' then '70' else '71' end                           --6     
         ,'cod_prod'  = 'MD01'
         ,'cls_cbtle' = CASE WHEN CaCVOpc = 'C' THEN '01' ElSE '02'   END                  --8
         ,'cod_pais'  = 'CL'                                                                                            --9
         ,'act_eco'   = ISNULL((select clactivida FROM VIEW_CLIENTE where Clrut = CaRutCliente AND Clcodigo= CaCodigo ),0)   --10
         ,'tip_prod'  = 'M'                                                                                             --11
         ,'F_Infor'   = 'BFW'                                                                                           --12
         ,'descrip'   = 'OPCIONES MX'                                                  --13
         ,'mes_proc'  = CONVERT(NUMERIC(2),MONTH(@FECHA))                              --14
         ,'dia_proc'   = CONVERT(NUMERIC(2),DAY(@FECHA))                               --15
         ,'ano_proc'   = CONVERT(NUMERIC(4),YEAR(@FECHA))                              --16
         ,'cod_mda2'  = cacodmon1                                                      --17
         ,'n_operac'  = Enc.CaNumContrato                                                  --18
         ,'rut'       = CaRutCliente                                                   --19
         ,'dig'       = ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = CaRutCliente AND Clcodigo= CaCodigo),' ')   --20
         ,'est_deuda' = '1'                                                                                             --21
         ,'mes_inic'  = CONVERT(NUMERIC(2),MONTH(CaFechaInicioOpc))                                                     --22
         ,'dia_inic'  = CONVERT(NUMERIC(2),DAY(CaFechaInicioOpc))                                                       --23
         ,'ano_inic'  = CONVERT(NUMERIC(4),YEAR(CaFechaInicioOpc))                                                      --24
         ,'mes_vcto'  = CONVERT(NUMERIC(2),MONTH(CaFechaPagoEjer))                                                      --25
         ,'dia_vcto'  = CONVERT(NUMERIC(2),DAY(CaFechaPagoEjer))                                                        --26
         ,'ano_vcto'  = CONVERT(NUMERIC(4),YEAR(CaFechaPagoEjer))                                                       --27
         ,'plazo'     = datediff( dd, @FECHA, CaFechaPagoEjer )                                                         --28
         ,'tip_plazo' = '2'                                                                                             --29
         ,'mto_orig'  = CaMontoMon1 -- camtomon1                                                                        --30
         ,'mto_cap'   = CaMontoMon1 * (select vmvalor from view_valor_moneda 
                                       where vmcodigo = 994 and vmfecha = CaFechaInicioOpc) --caequmon1           --31
         ,'sdo_orig'  = CaMontoMon1 -- camtomon1                                                                        --32
         ,'sdo_cap'   = CaMontoMon1 * (select vmvalor from view_valor_moneda 
                                       where vmcodigo = 994 and vmfecha = CaFechaInicioOpc) -- caequmon1          --33
         ,'int_dev_orig' = 0 --caperdevenga+ cautildevenga                                                              --34
         ,'int_dev_nac'  = 0 --caperdevenga+ cautildevenga                         --35
         ,'reajuste'  = 0    -- carevuf                                                                          --36
         ,'cod_proc'  = '13'                                                                                             --37
         ,'estatus'   = 'A'                                                                                                --39
         ,'tasa'      = 0                      
         ,'saldo'     = CaMontoMon2 
         ,'signo'     = '+'  -- CASE WHEN carevuf <  0 THEN  '-'  ELSE  '+' END
         ,'valor'     = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = CaFechaInicioOpc),0.0)
         ,'observado' = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = CaFechaInicioOpc),0.0)
         ,'tipo'      = 1.0 -- caparmon1
         ,'FuetoDebi' = ISNULL((select mnrefusd from view_moneda where mncodmon = cacodmon1),0)
         FROM  LNKOPC.CbMdbOpc.dbo.CaDetContrato Det
             , LNKOPC.CbMdbOpc.dbo.CaEncContrato Enc
             , VIEW_CLIENTE ,MFAC
         WHERE CaRutCliente = clrut AND CaCodigo = clcodigo 
         AND Det.CanumContrato = Enc.CanumContrato
         AND CaFechaPagoEjer > @FECHA -- TAG MPNG20050912       

-->	SELECT @maximo = count(*)	from #TEMPORAL
	SET @maximo	= (SELECT Max( Id ) FROM #TEMPORAL )
	SET @x = 1

	WHILE @x <= @maximo
	BEGIN

--		SET ROWCOUNT @x

		SELECT	@cod_bco       = cod_bco                     --1
			,	@cod_suc       = cod_suc                     --2
			,	@cod_mda       = cod_mda                     --3
			,	@cod_cta       = cod_cta                     --4
			,	@t_producto    = t_producto                  --5
			,	@t_proceso     = t_proceso                   --6     
			,	@cod_prod      = cod_prod                    --7 
			,	@cls_cbtle     = cls_cbtle                   --8
			,	@cod_pais      = cod_pais                    --9
			,	@act_eco       = act_eco                     --10
			,	@tip_prod      = tip_prod                    --11
			,	@F_Infor       = F_Infor                     --12
			,	@descrip       = descrip                     --13
			,	@mes_proc      = mes_proc                    --14
			,	@dia_proc      = dia_proc                    --15
			,	@ano_proc      = ano_proc                    --16
			,	@cod_mda2      = cod_mda2                    --17
			,	@n_operac      = n_operac                    --18
			,	@rut           = rut                         --19
			,	@dig           = dig                         --20
			,	@est_deuda     = est_deuda                   --21
			,	@mes_inic      = mes_inic                    --22
			,	@dia_inic      = dia_inic                    --23
			,	@ano_inic      = ano_inic                    --24
			,	@mes_vcto      = mes_vcto                    --25
			,	@dia_vcto      = dia_vcto                    --26
			,	@ano_vcto      = ano_vcto                    --27
			,	@plazo         = plazo                       --28
			,	@tip_plazo     = tip_plazo                   --29
			,	@mto_orig      = mto_orig                    --30
			,	@mto_cap       = mto_cap                     --31
			,	@sdo_orig      = sdo_orig                    --32
			,	@sdo_cap       = sdo_cap                     --33
			,	@int_dev_orig  = int_dev_orig                --34
			,	@int_dev_nac   = int_dev_nac                 --35
			,	@reajuste      = reajuste                    --36
			,	@cod_proc      = cod_proc                    --37
			,	@estatus       = estatus                     --39
			,	@tasa          = tasa                        --41
			,	@saldo         = saldo 
			,	@signo         = signo
			,	@valor         = valor
			,	@observado     = observado
			,	@tipo          = tipo
			,	@FuetoDebi     = FuetoDebi
		FROM	#TEMPORAL
		WHERE	Id			   = @x

		SET @x	  = @x + 1
		SET @tasa = 0

		IF @cod_mda = 994 or @cod_mda = 13  
        BEGIN
			SET @tasa = @observado 
		END ELSE 
		IF @cod_mda = 998 or @cod_mda = 999
		BEGIN
			SET @tasa = @valor
		END ELSE
		BEGIN
			IF @FuetoDebi = 1
				SET @tasa = ROUND(@observado  * @tipo,4)
            ELSE
				SET @tasa = ROUND(@observado  / @tipo,4)
		END

		INSERT INTO #INTERFAZ
        VALUES
		(		@cod_bco           --1
		,		@cod_suc           --2
		,		@cod_mda           --3
		,		@cod_cta           --4
		,		@t_producto        --5
		,		@t_proceso         --6     
		,		@cod_prod          --7 
		,		@cls_cbtle         --8
		,		@cod_pais          --9
		,		@act_eco           --10
		,		@tip_prod          --11
		,		@F_Infor           --12
		,		@descrip           --13
		,		@mes_proc          --14
		,		@dia_proc          --15
		,		@ano_proc          --16
		,		@cod_mda2          --17
		,		@n_operac          --18
		,		@rut               --19
		,		@dig               --20
		,		@est_deuda         --21
		,		@mes_inic          --22
		,		@dia_inic          --23
		,		@ano_inic          --24
		,		@mes_vcto          --25
		,		@dia_vcto          --26
		,		@ano_vcto          --27
		,		@plazo             --28
		,		@tip_plazo         --29
		,		@mto_orig          --30
		,		@mto_cap           --31
		,		@sdo_orig          --32
		,		@sdo_cap           --33
		,		@int_dev_orig      --34
		,		@int_dev_nac       --35
		,		@reajuste          --36
		,		@cod_proc          --37
		,		@estatus           --39
		,		@maximo				
		,		@tasa			   --41
		,		@saldo          
		,		@signo         
		)
	END

	SET ROWCOUNT 0 

	SET NOCOUNT OFF

	SELECT * FROM #INTERFAZ

END
GO
