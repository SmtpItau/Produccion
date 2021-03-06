USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_OPERACIONES_FORWARD_ALE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_OPERACIONES_FORWARD_ALE] --  DBO.Sp_Interfaz_operaciones_forward_ALE  '20031128','20031130'
		( @FECHAFINMESHabil  CHAR(8),
		  @FECHAFINMES       CHAR(8))

AS
BEGIN
	SET NOCOUNT ON	

	DECLARE @FECHA 		    DATETIME
		,@vDolar_obsFinMes  FLOAT
	        ,@vUF_FinMes        FLOAT

	SELECT @FECHA =(SELECT acfecproc FROM MFAC)
	DECLARE @max integer
	SELECT @max = (SELECT count(*) FROM mfca WHERE cafecha = @FECHA)

	SELECT @vDolar_obsFinMes = isnull((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @FECHAFINMESHabil),0)
	SELECT @vUF_FinMes       = isnull((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 998 and vmfecha = @FECHAFINMES),0)

         SELECT vmptacmp ,mnrefusd  ,mncodmon ,vmvalor
           INTO #tipocambio 
           FROM view_valor_moneda, view_moneda
          WHERE vmcodigo = mncodmon and vmfecha = @FECHAFINMESHabil



	SELECT   'fecha_contable' = @fecha                                                                                                        --1
        	 ,'status'        = 'A'                                                                                                                           --2 
	         ,'cod_producto'  = 'MD01'
        	 ,'T_producto'    = 'MDIR'
	         ,'rut'           = CONVERT(CHAR(9),cacodigo)                                                                                     --7
	         ,'dig'           = ISNULL((SELECT Cldv FROM VIEW_CLIENTE WHERE Clrut = cacodigo AND Clcodigo= cacodcli),0)    --8
	         ,'costo'         = 0									--9
	         ,'n_operacion'   = CAST(canumoper  AS  VARCHAR(5))                                                                           --10
	         ,'fecha_inic'    = convert(char(8),cafecha,112)                                                                                --11
	         ,'fecha_vcto'    = cafecvcto                                                                                                     --12
	         ,'cod_inter_mda' = cacodmon1                                                                                                     --13 
	         ,'s_mto_cap_ori' = CASE WHEN camtomon1 > 0 THEN '+' ELSE '-' END -- CASE WHEN catipmoda = 'C' THEN '+' ELSE '-' END                                                               --14
	         ,'mto_cap_origen'= camtomon1                                                                                                     --15
	         ,'s_mto_cap_loc' = CASE WHEN camtomon1 > 0 THEN '+' ELSE '-' END -- CASE WHEN catipmoda = 'C' THEN '+' ELSE '-' END                                                               --16
	         ,'mto_cap_local' = CASE cacodmon1 WHEN 999 THEN camtomon1
						   WHEN 998 THEN ROUND (camtomon1 * @vUF_FinMes	,0)	
						   WHEN 13  THEN ROUND (camtomon1 * @vDolar_obsFinMes,0)	
						   ELSE	ROUND (camtomon1 * ( SELECT ISNULL( VMVALOR, 0 ) FROM #tipocambio WHERE MNCODMON = cacodmon1 ),0)	
				    END
					--caequmon1                                                                                                     --17
	         ,'s_reaj_mda_loc'= CASE WHEN cadiftipcam < 0 THEN '-' ELSE '+' END                                                               --16   
	         ,'mto_reaj_loc'  = cadiftipcam                                                                                                   -- 17
	         ,'s_int_mda_loc' = SPACE(1)    -- CASE WHEN cautildiferir + caperddiferir < 0 THEN '+' ELSE '-' END                              -- 18
	         ,'mto_int_mda_loc'=0    -- cautildiferir + caperddiferir                                                                         -- 19
	         ,'tasa_f_v'      = 'F'                                                                                                           -- 20
	         ,'spread'        = 0                                                                                                             -- 21
	         ,'valor_en_pesos'= 0--CASE WHEN cacodmon1 = 999 THEN caequmon1 ELSE 0 END                                                        --22
	         ,'nomin_en_pesos'= 0--CASE WHEN cacodmon1 = 999 THEN caequmon1 ELSE 0 END                                                        --23
	         ,'t_cartera'     = '2'                                                                                                           -- 24
	         ,'mto_op_compra' = CASE WHEN catipmoda = 'C' THEN camtomon1 ELSE 0 END                                                           --25
	         ,'registros' 	  = @max                                                                                                          --26
	         ,'indicador'     = CASE WHEN catipmoda = 'C' THEN 'A' ELSE 'P' END                                                               --27
	         ,'colocacion'    = CASE WHEN cafecha = @FECHA --28
	                                 THEN caequmon1 ELSE 0 
	                           END
	         ,'destino'       = CASE  WHEN cacodigo = 97029000 THEN 211 
        	                          WHEN cacodigo = 97030000 THEN 212
                	            ELSE
                                             221 
                        	    END
                 , 'TasaInteres'  = 0.0 --  CONVERT(NUMERIC(16,8) ,catipcam ) -- Para los forward se solicita informar para USD/$ tipo de cambio, USD/UF factor poderado etc... 
        FROM 	mfca
        WHERE 	cafecvcto > @FECHA
        ORDER BY 
		canumoper

	SET NOCOUNT OFF
END

GO
