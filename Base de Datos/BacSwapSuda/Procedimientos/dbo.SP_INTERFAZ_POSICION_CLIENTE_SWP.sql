USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_POSICION_CLIENTE_SWP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_POSICION_CLIENTE_SWP]    
AS
BEGIN

   set nocount on
-- Swap: Guardar Como
DECLARE 

             @cod_bco                       CHAR(2)                                                    --1
            ,@cod_suc                       CHAR(4)                                                    --2
            ,@cod_mda                       NUMERIC(4)                                                 --3
            ,@cod_cta                       NUMERIC(12)                                                --4
            ,@t_producto                    CHAR(4)                                                    --5
            ,@t_proceso                     CHAR(2)                                                    --6     
            ,@cod_prod                      CHAR(4)                                                    --7 
            ,@cls_cbtle                     char(2)                                                 --8
            ,@cod_pais                      CHAR( 2)                                                   --9
            ,@act_eco                       NUMERIC(4)                                                 --10
            ,@tip_prod                      CHAR(1)                                                    --11
            ,@F_Infor                       CHAR(3)                                                    --12
            ,@descrip                       VARCHAR(35)                                                --13
            ,@mes_proc                      NUMERIC(2)                                                 --14
            ,@dia_proc                      NUMERIC(2)                                                 --15
            ,@ano_proc                      NUMERIC(4)                                                 --16
            ,@cod_mda2                      NUMERIC(3)                                                 --17
            ,@n_operac                      NUMERIC(9)                                                 --18
            ,@rut                           NUMERIC(9)                                                 --19
            ,@dig                           CHAR(1)                                                    --20
            ,@est_deuda                     CHAR(1)                                                    --21
            ,@mes_inic                      NUMERIC(2)                                                 --22
            ,@dia_inic                      NUMERIC(2)                                                 --23
            ,@ano_inic                      NUMERIC(4)                                                 --24
            ,@mes_vcto                      NUMERIC(2)                                                 --25
            ,@dia_vcto                      NUMERIC(2)                                                 --26
            ,@ano_vcto                      NUMERIC(4)                                                 --27
            ,@plazo                         NUMERIC(5)                                                 --28
            ,@tip_plazo                     CHAR(2)                                                    --29
            ,@mto_orig                      float --NUMERIC(13,2)                                              --30
            ,@mto_cap                       float --NUMERIC(13,2)                                              --31
            ,@sdo_orig                      float --NUMERIC(13,2)                                              --32
            ,@sdo_cap                       float --NUMERIC(13,2)                                              --33
            ,@int_dev_orig                  float --NUMERIC(13,2)                                              --34
            ,@int_dev_nac                   float --NUMERIC(13,2)                                              --35
            ,@reajuste   float --NUMERIC(13,2)          				       --36
            ,@cod_proc                      CHAR(2)				                       --37
            ,@estatus                       CHAR(1)                                                    --39
            ,@maximo                        INTEGER						       --40
            ,@tasa                          NUMERIC(11,6)                                              --41
            ,@saldo                         NUMERIC(18,2)                                              --42
            ,@signo                         CHAR(1)                                                    --43
            ,@valor                         NUMERIC(18,2)					       --44
            ,@x                             INTEGER						       --45
            ,@observado                     NUMERIC(18,4)					       --46
            ,@tipo                          NUMERIC(18,4)                                              --47
            ,@FuetoDebi                     NUMERIC(1)                                                 --48
	    ,@tasaint		            NUMERIC(18,2)					       --49
	    ,@fechainicio  		    DATETIME                                                   --50
	    ,@tasa_interes		    NUMERIC(9,6)
	    ,@plazo_base		    NUMERIC(4)
	    ,@tasa_operacion                NUMERIC(9,6)
	    ,@numero_armado		    CHAR(20)





DECLARE @fecha DATETIME
SELECT 	@fecha = fechaproc FROM SwapGeneral

   SELECT @valor   = 0
   SELECT @tasa   = 0
   SELECT @tasaint = 0

select vmcodigo, VmValor , VmFecha into #VALOR from VIew_Valor_moneda where VMFecha = @fecha
insert into #Valor select 999, 1.0, @fecha


CREATE TABLE #INTERFAZ
   (
            cod_bco                         CHAR(2)                                                     --1
            ,cod_suc                        CHAR(4)                                                     --2
            ,cod_mda                        NUMERIC(4)                                                  --3
            ,cod_cta                        NUMERIC(12)                                                 --4
            ,t_producto                     CHAR(4)                                                     --5
            ,t_proceso                      CHAR(2)                                                     --6     
            ,cod_prod                       CHAR(4)                                                     --7 
            ,cls_cbtle                      char(2)                                                  --8
            ,cod_pais                       CHAR( 2)                                                    --9
            ,act_eco                        NUMERIC(4)                                                  --10
            ,tip_prod                       CHAR(1)                                                     --11
            ,F_Infor                        CHAR(3)                                                     --12
            ,descrip                        VARCHAR(35)                                                 --13
            ,mes_proc                       NUMERIC(2)                                                  --14
            ,dia_proc                       NUMERIC(2)                                                  --15
            ,ano_proc                       NUMERIC(4)                                                  --16
            ,cod_mda2                       NUMERIC(3)                                                  --17
            ,n_operac                       NUMERIC(9)                                                  --18
            ,rut                            NUMERIC(9)                                                  --19
            ,dig                            CHAR(1)                                                     --20
            ,est_deuda                      CHAR(1)               --21
,mes_inic                       NUMERIC(2)                                                  --22
            ,dia_inic                       NUMERIC(2)       --23
            ,ano_inic                       NUMERIC(4)                                                  --24
            ,mes_vcto                       NUMERIC(2)                                                  --25
            ,dia_vcto                       NUMERIC(2)                                                  --26
            ,ano_vcto                       NUMERIC(4)                                                  --27
            ,plazo                     	    NUMERIC(5)                                                  --28
            ,tip_plazo                      CHAR(2)                                                     --29
	    ,tasa_interes		    NUMERIC(9,6)
	    ,plazo_base			    NUMERIC(4)
	    ,tasa_operacion                 NUMERIC(9,6)
            ,mto_orig                       float --NUMERIC(13,2)                                          --30
            ,mto_cap                        float --NUMERIC(13,2)                                          --31
            ,sdo_orig                       float --NUMERIC(13,2)                                          --32
            ,sdo_cap                        float --NUMERIC(13,2)                                          --33
            ,int_dev_orig                   float --NUMERIC(13,2)                                          --34
            ,int_dev_nac                    float --NUMERIC(13,2)                                          --35
            ,reajuste                       float --NUMERIC(13,2)                                          --36
            ,cod_proc                       CHAR(2)                                                --37
            ,estatus                        CHAR(1)                                                --39
            ,maximo                         INTEGER						   --40
            ,tasa                           NUMERIC(11,6)                                          --41
            ,saldo                          NUMERIC(18,2)                                          --42
            ,signo                          CHAR(1)                                                --43
    	    ,numero_armado          	    NUMERIC(20)

      )


SET NOCOUNT ON

SELECT  DISTINCT 
          'cod_bco'   = '01'                                                      --1 EXPBNK
         ,'cod_suc'   = '001'                                                     --2 EXPBRN
         ,'cod_mda'   = mncodfox                                                  --3 EXPCCY 
         ,'cod_cta'   = '94334'                                                   --4 EXPGLN                                      --4
         ,'t_producto'= 'MDIR'                                                    --5 EXPATY
         ,'t_proceso' = '70' 				                          --6 EXPACD
         ,'cod_prod'  = 'MD01'							  --7 EXPPRO
         ,'cls_cbtle' = '01' 							  --8 EXPCLS
         ,'cod_pais'  = 'CL'                                                      --9 EXPGER
         ,'act_eco'   = clactivida 						  --10 EXPIND
         ,'tip_prod'  = 'M'                                                       --11 EXPUC1
         ,'F_Infor'   = 'PCS'                                                     --12 EXPSST
         ,'descrip'   = ISNULL((select descripcion FROM VIEW_PRODUCTO where codigo_producto = tipo_swap AND id_sistema = 'PCS'),0)   --13 EXPDSC
         ,'mes_proc'  = CONVERT(NUMERIC(2),MONTH(@FECHA))                          --14 EXPRDM
         ,'dia_proc'  = CONVERT(NUMERIC(2),DAY(@FECHA))                           --15 EXPRDD
         ,'ano_proc'  = CONVERT(NUMERIC(4),YEAR(@FECHA))                          --16 EXPRDY
         ,'cod_mda2'  = compra_moneda      --17 EXPPRC

         ,'n_operac'  = numero_operacion 				   --18 EXPNRF
         ,'rut'       = Clrut                                                      --19 EXPNID
         ,'dig'       = Cldv     						   
         ,'est_deuda' = '1'                                     --20 EXPSDU                                     --21
         ,'mes_inic'  = CONVERT(NUMERIC(2),MONTH(fecha_inicio))                    --21 EXPFAM 
         ,'dia_inic'  = CONVERT(NUMERIC(2),DAY(fecha_inicio))                      --22 EXPFAD
         ,'ano_inic'  = CONVERT(NUMERIC(4),YEAR(fecha_inicio))                     --23 EXPFAY
         ,'mes_vcto'  = CONVERT(NUMERIC(2),MONTH(fecha_termino))                   --24 EXPFVM
         ,'dia_vcto'  = CONVERT(NUMERIC(2),DAY(fecha_termino))                     --25 EXPFVD
         ,'ano_vcto'  = CONVERT(NUMERIC(4),YEAR(fecha_termino))                    --26 EXPFVY
         ,'plazo'     = DATEDIFF(DAY,fecha_inicio,fecha_termino)		   --27 EXPPLZ
 	 ,'tip_plazo' = '2'             		                           --28 EXPTPZ
	 ,'tasa_interes'   = compra_valor_tasa							   --29 EXPTBS
	 ,'plazo_base'	   = ISNULL((SELECT dias FROM VIEW_PERIODO_AMORTIZACION WHERE tabla =1044 and sistema = 'PCS' and codigo = compra_codamo_interes),0)							   --30 EXPPTB
	 ,'tasa_operacion' = compra_valor_tasa					   --31 EXPTOP
         ,'mto_orig'  	   = compra_capital                                        --32   SELECT * FROM CARTERA
         ,'mto_cap'   	   = ISNULL( compra_capital * ( select vmvalor from #VALOR where vmcodigo = compra_moneda and vmfecha = @FECHA ) , 0)                                                                                --31
         ,'sdo_orig'       = compra_capital                                                                                 --32
         ,'sdo_cap'        = ISNULL(compra_capital * (select vmvalor from #VALOR where vmcodigo = compra_moneda and vmfecha = @FECHA),0)                                                                                		--33
         ,'int_dev_orig' = 0                                               						--34
         ,'int_dev_nac'  = 0 							                                            --35
         ,'reajuste'     = 0                                                                                   --36
         ,'cod_proc'     = '13'                                                                                             --37
         ,'estatus'      = 'A'                                                                                                --39
         ,'tasa'         = 0                      
         ,'saldo'        = 0 
         ,'signo'        ='+'
         ,'valor'        = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = compra_moneda and vmfecha = fecha_inicio),0.0)
         ,'observado'    = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = fecha_inicio),0.0)
         ,'tipo'         = 0
         ,'FuetoDebi'    = mnrefusd
	 ,'fecha_inicio' = fecha_inicio
	,'numero_armado' = numero_operacion--CONVERT(VARCHAR(10),numero_operacion)+ CONVERT(VARCHAR(5),numero_flujo) + CONVERT(VARCHAR(1), tipo_flujo)
	INTO #TEMPORAL
	FROM    CARTERA	
	,	VIEW_CLIENTE b
	,	view_moneda 
	WHERE   rut_cliente    = clrut
	AND     codigo_cliente = clcodigo	
	AND     tipo_flujo = 1
        AND     @Fecha   > fecha_inicio_flujo
        AND     @Fecha   <= fecha_vence_flujo
	and     mncodmon  = compra_moneda
        and     estado   <> 'C'
        AND     fecha_termino  > @Fecha 



  SELECT @maximo = count(1) from #TEMPORAL

      SELECT @x = 1
      WHILE @x <= @maximo
         BEGIN
         SET ROWCOUNT @x
          

         SELECT          
             @cod_bco       = cod_bco                                                                                      --1
            ,@cod_suc       = cod_suc                                                                                      --2
            ,@cod_mda       = cod_mda                                                                                     --3
            ,@cod_cta       = cod_cta                                                                                       --4
            ,@t_producto    = t_producto                                                                                    --5
            ,@t_proceso     = t_proceso                                                                                     --6     
            ,@cod_prod      = cod_prod                                      --7 
            ,@cls_cbtle     = cls_cbtle                                                                                       --8
            ,@cod_pais      = cod_pais                                                                                      --9
            ,@act_eco       = act_eco                                                                                      --10
            ,@tip_prod      = tip_prod                                                                                       --11
            ,@F_Infor       = F_Infor                                                                                         --12
            ,@descrip       = descrip                                                                                         --13
            ,@mes_proc      = mes_proc                                                                                      --14
            ,@dia_proc      = dia_proc                                                                                        --15
            ,@ano_proc      = ano_proc                                                                                        --16
            ,@cod_mda2      = cod_mda2                                                                                      --17
            ,@n_operac      = n_operac                                                                                        --18
            ,@rut           = rut                                                                                                 --19
            ,@dig           = dig                                                                                                --20
            ,@est_deuda     = est_deuda                                                                                        --21
            ,@mes_inic      = mes_inic                                                                                        --22
            ,@dia_inic      = dia_inic                                                                                          --23
            ,@ano_inic      = ano_inic                                                                                          --24
            ,@mes_vcto      = mes_vcto                                                            --25
            ,@dia_vcto      = dia_vcto                                                    --26
            ,@ano_vcto      = ano_vcto                                                             --27
            ,@plazo      = plazo                                 --28
            ,@tip_plazo     = tip_plazo       
	    ,@tasa_interes  = tasa_interes                                                                                  --29
	    ,@plazo_base    = plazo_base
	    ,@tasa_operacion = tasa_operacion
            ,@mto_orig      = mto_orig                                                                                       --30
            ,@mto_cap       = mto_cap                                                                                       --31
            ,@sdo_orig      = sdo_orig                                                                                       --32
            ,@sdo_cap       = sdo_cap                                                                                       --33
            ,@int_dev_orig  = int_dev_orig                                                                                 --34
            ,@int_dev_nac   = int_dev_nac                                                                                 --35
            ,@reajuste      = reajuste                                                                                         --36
            ,@cod_proc      = cod_proc                                                                                        --37
            ,@estatus       = estatus                                           --39
            ,@tasa          = tasa                                                                                                --41
            ,@saldo         = saldo 
            ,@signo         = signo
            ,@valor         = valor
            ,@observado     = observado
            ,@tipo          = tipo
            ,@FuetoDebi     = FuetoDebi
	    ,@fechainicio   = fecha_inicio
	    ,@numero_armado = numero_armado

         FROM #TEMPORAL
         SELECT @x = @x + 1

   SELECT @valor = case when @cod_mda = 999 then 1.0 
                   else ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@cod_mda and vmfecha = @fechainicio),0.0) end


   IF @valor = 0 
      SET @tasa =  @mto_cap/@mto_orig
  ELSE
      SET @tasa =  @valor


      SELECT @mto_orig  =  @mto_cap  
      SELECT @sdo_orig = @sdo_cap     

   IF @cod_mda <> 999
   BEGIN
         IF @valor <>  0
            BEGIN
               SET @int_dev_orig = @int_dev_nac/@valor
         END ELSE BEGIN
               SET @int_dev_orig =  @int_dev_nac 
            END
   END ELSE
      SET @int_dev_orig =  @int_dev_nac



       SELECT @maximo = count(1) from #TEMPORAL


INSERT INTO #INTERFAZ
            VALUES
                   (
             @cod_bco  --1
            ,@cod_suc  --2
            ,@cod_mda  --3
            ,@cod_cta  --4
            ,@t_producto  --5
            ,@t_proceso  --6     
            ,@cod_prod   --7 
            ,@cls_cbtle  --8
            ,@cod_pais   --9
            ,@act_eco    --10
            ,@tip_prod   --11
            ,@F_Infor    --12
            ,@descrip    --13
            ,@mes_proc   --14
            ,@dia_proc   --15
            ,@ano_proc   --16
            ,@cod_mda2   --17
            ,@n_operac   --18
            ,@rut        --19
            ,@dig        --20
            ,@est_deuda  --21
            ,@mes_inic   --22
            ,@dia_inic   --23
            ,@ano_inic  --24
            ,@mes_vcto  --25
            ,@dia_vcto  --26
            ,@ano_vcto  --27
            ,@plazo     --28
            ,@tip_plazo  --29
	    ,@tasa_interes --30	
	    ,@plazo_base   --31	
	    ,@tasa_operacion   --32 
            ,@mto_orig        --33
            ,@mto_cap         --34
            ,@sdo_orig        --35
   ,@sdo_cap      --36
            ,@int_dev_orig    --37
            ,@int_dev_nac     --38
            ,@reajuste        --39
            ,@cod_proc        --40
            ,@estatus         --41
            ,@maximo	      --42
            ,@tasa            --43                                                    --41
            ,@sdo_cap+@int_dev_nac+@reajuste--,@saldo           --44
            ,@signo           --45
	    ,@numero_armado   --46
                 )
END

SET ROWCOUNT 0

END
SET NOCOUNT OFF         -- OJO NO BORRAR ESTE CODIGO (DAVID MATAMALA, 13/05/2008)
SELECT * FROM #INTERFAZ -- OJO NO BORRAR ESTE CODIGO (DAVID MATAMALA, 13/05/2008)
GO
