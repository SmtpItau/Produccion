USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIST_C477]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIST_C477] (
                                    @fecha_proceso   DATETIME ,
                                    @cap_prop        CHAR(20) ,
                                    @email           CHAR(60) ,
                                    @apoderado1      CHAR(50) ,
                                    @apoderado2      CHAR(50) 
                                  )
AS
BEGIN
 DECLARE @acfecproc CHAR (10)     ,
         @acfecprox CHAR (10)     ,
         @fec_prox  DATETIME      ,
         @uf_hoy  FLOAT           ,
         @uf_man  FLOAT           ,
         @ivp_hoy FLOAT           ,
         @ivp_man FLOAT           ,
         @do_hoy  FLOAT           ,
         @do_man  FLOAT           ,
         @da_hoy  FLOAT           ,
         @da_man  FLOAT           ,
         @acnomprop   CHAR (40)   ,
         @rut_empresa CHAR (12)   ,
         @dir_prop    CHAR (60)   ,
         @com_prop    CHAR (20)   ,
         @ciu_prop    CHAR (20)   ,
         @reg_prop    CHAR (20)   ,
         @fon_prop    CHAR (10)   ,
         @fax_prop    CHAR (10)   ,
         @cod_banco   CHAR (10)   ,
         @hora        CHAR (8)	  ,
         @rutbcch NUMERIC(9,0)


 EXECUTE SP_BASE_DEL_INFORME
              @acfecproc   OUTPUT    ,
              @acfecprox   OUTPUT    ,
              @uf_hoy      OUTPUT    ,
              @uf_man      OUTPUT    ,
              @ivp_hoy     OUTPUT    ,
              @ivp_man     OUTPUT    ,
              @do_hoy      OUTPUT    ,
              @do_man      OUTPUT    ,
              @da_hoy      OUTPUT    ,
              @da_man      OUTPUT    ,
              @acnomprop   OUTPUT    ,
              @rut_empresa OUTPUT    ,
              @hora  OUTPUT

 SELECT  @dir_prop = Cldirecc     ,
         @com_prop = accomprop    ,
         @ciu_prop = tbglosa      ,  
         @reg_prop = 'METROPOLITANA' ,
         @fon_prop = Clfono       ,
         @fax_prop = Clfax        ,
         @cod_banco= '027'
 FROM MDAC,VIEW_CLIENTE,VIEW_TABLA_GENERAL_DETALLE
 WHERE acrutprop=clrut AND clcodigo=1 
       AND tbcodigo1 = CONVERT(CHAR(5),clcomuna)

 SELECT @rutbcch = 97029000

 SET NOCOUNT ON 

 IF @fecha_proceso >= CONVERT(DATETIME,@acfecproc,103)  BEGIN 

    IF EXISTS(SELECT * FROM MDMO,VIEW_CLIENTE WHERE motipoper IN('IB','CI','VI')
                              AND mofecvenp =  convert(datetime,@acfecprox,103)
                              AND mofecpro  =  @fecha_proceso
                              AND moforpagv IN(128,129,130)
                              AND morutcli=clrut AND mocodcli=clcodigo
                              AND cltipcli IN(1,2,3,4)
                              AND morutcli <> @rutbcch
                              AND mostatreg <> 'A')
    BEGIN
       SELECT 'numoper'      = ISNULL(RTRIM(CONVERT(CHAR(7),monumoper))+'-'+RTRIM(CONVERT(CHAR(7),monumdocu))+'-'+CONVERT(CHAR(3),mocorrela),'')  ,
         'tipo_Oper'    = CASE WHEN moinstser IN('ICOL','ICAP') THEN 'I.- OPERACIONES DE CREDITO (sin garantía)'
                               ELSE 'II.- OPERACIONES CON PACTO (con garantía)' END,
         'tipo_prod'    = CASE WHEN moinstser ='ICOL' OR motipoper = 'VI' THEN '1.- COLOCACIONES'
                               ELSE '2.- CAPTACIONES' END,         
         'clnombre'     = ISNULL(clnombre,' ')                                ,
         'rutcli'       = ISNULL(CONVERT(CHAR(9),clrut)   ,' ')+'-'+ISNULL(cldv    ,' ')        ,
         'cod_svs'      = ' '                                                , 
         'moinstser'    = ISNULL(moinstser,' ')                               ,
         'tasa_interes' = CASE WHEN mobasemi=30 THEN ISNULL(ROUND(motaspact*12,2),0)
                               ELSE ISNULL(motaspact,0) END ,                               
         'monto_tran'   = CASE WHEN motipoper ='IB' THEN ISNULL(movalcomp/1000000,0)                        
                               ELSE ISNULL(movalinip/1000000,0) END                       
       INTO #TEMP
       FROM MDMO,VIEW_CLIENTE 
       WHERE motipoper IN('IB','CI','VI') 
           AND mofecvenp = convert(datetime,@acfecprox,103)
           AND mofecpro  = @fecha_proceso
           AND moforpagv IN(128,129,130) 
           AND morutcli=clrut AND mocodcli=clcodigo
           AND cltipcli IN(1,2,3,4)
           AND morutcli <> @rutbcch
           AND mostatreg <> 'A'
        ORDER BY numoper

       IF NOT EXISTS(SELECT * FROM #TEMP WHERE SUBSTRING(tipo_Oper,1,2)='I.' AND SUBSTRING(tipo_prod,1,1)='1' )

         INSERT INTO #TEMP
         SELECT  num_oper= '             ',
         tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             


       IF NOT EXISTS(SELECT * FROM #TEMP WHERE SUBSTRING(tipo_Oper,1,2)='I.' AND SUBSTRING(tipo_prod,1,1)='2' )

         INSERT INTO #TEMP
         SELECT  num_oper= '             ',
         tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

       IF NOT EXISTS(SELECT * FROM #TEMP WHERE SUBSTRING(tipo_Oper,1,2)='II' AND SUBSTRING(tipo_prod,1,1)='1' )

         INSERT INTO #TEMP
         SELECT  num_oper= '             ',
         tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

       IF NOT EXISTS(SELECT * FROM #TEMP WHERE SUBSTRING(tipo_Oper,1,2)='II' AND SUBSTRING(tipo_prod,1,1)='2' )

         INSERT INTO #TEMP
         SELECT  num_oper= '             ',
         tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

       SELECT tipo_Oper    ,
         tipo_prod    ,
         clnombre     ,
         rutcli       ,
         cod_svs      ,
         moinstser    ,
         tasa_interes ,
         monto_tran   ,
         'acfecproc' = @acfecproc     ,
         'acfecprox' = @acfecprox     ,
         'uf_hoy'    = @uf_hoy        ,
         'uf_man'    = @uf_man        ,
         'ivp_hoy'   = @ivp_hoy       ,
         'ivp_man'   = @ivp_man       ,
         'do_hoy'    = @do_hoy        ,
         'do_man'    = @do_man        ,
         'da_hoy'    = @da_hoy        ,
         'da_man'    = @da_man        ,
         'acnomprop' = @acnomprop     ,
         'rut_empresa' = @rut_empresa ,
         'hora'      = @hora          ,
         'dir_prop'  = @dir_prop      ,
         'com_prop'  = @com_prop      ,
         'ciu_prop'  = @ciu_prop      ,  
         'reg_prop'  = @reg_prop      ,
         'fon_prop'  = @fon_prop      ,
         'cap_prop'  = @cap_prop      , 
         'fax_prop'  = @fax_prop      ,  
         'email'     = @email         ,
         'apoderado1'= @apoderado1    ,
         'apoderado2'= @apoderado2    ,
         'cod_banco' = @cod_banco
         FROM #TEMP
         ORDER BY tipo_Oper,tipo_prod,clnombre

    END ELSE BEGIN

      SELECT tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             
        INTO #TEMP1        

      INSERT #TEMP1 
      SELECT tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

      INSERT #TEMP1 
      SELECT tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

      INSERT #TEMP1 
      SELECT tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

      SELECT  tipo_Oper    ,
         tipo_prod    ,
         clnombre     ,
         rutcli       ,
         cod_svs      ,
         moinstser    ,
         tasa_interes ,
         monto_tran   ,
         'acfecproc' = @acfecproc     ,
         'acfecprox' = @acfecprox     ,
         'uf_hoy'    = @uf_hoy        ,
         'uf_man'    = @uf_man        ,
         'ivp_hoy'   = @ivp_hoy       ,
         'ivp_man'   = @ivp_man       ,
         'do_hoy'    = @do_hoy        ,
         'do_man'    = @do_man        ,
         'da_hoy'    = @da_hoy        ,
         'da_man'    = @da_man        ,
         'acnomprop' = @acnomprop     ,
         'rut_empresa' = @rut_empresa ,
         'hora'      = @hora          ,
         'dir_prop'  = @dir_prop      ,
         'com_prop'  = @com_prop      ,
         'ciu_prop'  = @ciu_prop      ,  
         'reg_prop'  = @reg_prop      ,
         'fon_prop'  = @fon_prop      ,
         'cap_prop'  = @cap_prop      , 
         'fax_prop'  = @fax_prop      ,  
         'email'     = @email         ,
         'apoderado1'= @apoderado1    ,
         'apoderado2'= @apoderado2    ,
         'cod_banco' = @cod_banco
         FROM #TEMP1 ORDER BY tipo_Oper,tipo_prod
     END
 END ELSE BEGIN

   EXECUTE SP_BUSCA_FECHA_HABIL @fecha_proceso,1,@fec_prox output

   IF EXISTS(SELECT * FROM MDMH,VIEW_CLIENTE WHERE motipoper IN('IB','CI','VI')
                              AND mofecvenp = @fec_prox
                              AND mofecpro  = @fecha_proceso
                              AND moforpagv IN(128,129,130)
                              AND morutcli=clrut AND mocodcli=clcodigo
                              AND cltipcli IN(1,2,3,4)
                              AND morutcli <> @rutbcch
                              AND mostatreg <> 'A')
     BEGIN
     SELECT 'numoper'      = ISNULL(RTRIM(CONVERT(CHAR(7),monumoper))+'-'+RTRIM(CONVERT(CHAR(7),monumdocu))+'-'+CONVERT(CHAR(3),mocorrela),'')  ,
         'tipo_Oper'    = CASE WHEN moinstser IN('ICOL','ICAP') THEN 'I.- OPERACIONES DE CREDITO (sin garantía)'
                               ELSE 'II.- OPERACIONES CON PACTO (con garantía)' END,
         'tipo_prod'    = CASE WHEN moinstser ='ICOL' OR motipoper = 'VI' THEN '1.- COLOCACIONES'
                               ELSE '2.- CAPTACIONES' END,         
         'clnombre'     = ISNULL(clnombre,' ')                                ,
         'rutcli'       = ISNULL(CONVERT(CHAR(9),clrut)   ,' ')+'-'+ISNULL(cldv    ,' ')        ,
         'cod_svs'      = ' '                                                , 
         'moinstser'    = ISNULL(moinstser,' ')                               ,
         'tasa_interes' = CASE WHEN mobasemi=30 THEN ISNULL(ROUND(motaspact*12,2),0)
                               ELSE ISNULL(motaspact,0) END ,                               
         'monto_tran'   = CASE WHEN motipoper ='IB' THEN ISNULL(movalcomp/1000000,0)                        
                               ELSE ISNULL(movalinip/1000000,0)   END

      INTO #TEMPH
      FROM MDMH,VIEW_CLIENTE 
      WHERE motipoper IN('IB','CI','VI') 
           AND mofecvenp = @fec_prox
           AND mofecpro  = @fecha_proceso
           AND moforpagv IN(128,129,130) 
           AND morutcli=clrut AND mocodcli=clcodigo
           AND cltipcli IN(1,2,3,4)
           AND morutcli <> @rutbcch
           AND mostatreg <> 'A'
           ORDER BY numoper


      IF NOT EXISTS(SELECT * FROM #TEMPH WHERE SUBSTRING(tipo_Oper,1,2)='I.' AND SUBSTRING(tipo_prod,1,1)='1' )

       INSERT #TEMPH
       SELECT num_oper= '             ',
         tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0              


      IF NOT EXISTS(SELECT * FROM #TEMPH WHERE SUBSTRING(tipo_Oper,1,2)='I.' AND SUBSTRING(tipo_prod,1,1)='2' )

       INSERT #TEMPH
       SELECT  num_oper= '             ',
         tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

      IF NOT EXISTS(SELECT * FROM #TEMPH WHERE SUBSTRING(tipo_Oper,1,2)='II' AND SUBSTRING(tipo_prod,1,1)='1' )

       INSERT #TEMPH
       SELECT  num_oper= '             ',
         tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

      IF NOT EXISTS(SELECT * FROM #TEMPH WHERE SUBSTRING(tipo_Oper,1,2)='II' AND SUBSTRING(tipo_prod,1,1)='2' )
         INSERT #TEMPH
         SELECT  num_oper= '             ',
         tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran = 0.0                             

       SELECT tipo_Oper    ,
         tipo_prod    ,
         clnombre     ,
         rutcli       ,
         cod_svs      ,
         moinstser    ,
         tasa_interes ,
         monto_tran   ,
         'acfecproc' = @acfecproc     ,
         'acfecprox' = @acfecprox     ,
         'uf_hoy'    = @uf_hoy        ,
         'uf_man'    = @uf_man        ,
         'ivp_hoy'   = @ivp_hoy       ,
         'ivp_man'   = @ivp_man       ,
         'do_hoy'    = @do_hoy        ,
         'do_man'    = @do_man        ,
         'da_hoy'    = @da_hoy        ,
         'da_man'    = @da_man        ,
         'acnomprop' = @acnomprop     ,
         'rut_empresa' = @rut_empresa ,
         'hora'      = @hora          ,
         'dir_prop'  = @dir_prop      ,
         'com_prop'  = @com_prop      ,
         'ciu_prop'  = @ciu_prop      ,  
         'reg_prop'  = @reg_prop      ,
         'fon_prop'  = @fon_prop      ,
         'cap_prop'  = @cap_prop      , 
         'fax_prop'  = @fax_prop      ,  
         'email'     = @email         ,
         'apoderado1'= @apoderado1    ,
         'apoderado2'= @apoderado2    ,
         'cod_banco' = @cod_banco
         FROM #TEMPH
         ORDER BY tipo_Oper,tipo_prod,clnombre
   END ELSE BEGIN 
    
       SELECT tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             
        INTO #TEMPH1        

       INSERT #TEMPH1 
       SELECT tipo_Oper    = 'I.- OPERACIONES DE CREDITO (sin garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

       INSERT #TEMPH1 
       SELECT tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '1.- COLOCACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

       INSERT #TEMPH1 
       SELECT tipo_Oper    = 'II.- OPERACIONES CON PACTO (con garantía)' ,
         tipo_prod    = '2.- CAPTACIONES' ,
         clnombre     = '                             ' ,
         rutcli       = '                 '             ,
         cod_svs      = '                 '             ,
         moinstser    = '                 '             ,
         tasa_interes = 0.0                             ,
         monto_tran   = 0.0                             

       SELECT tipo_Oper  ,
         tipo_prod   , 
         clnombre     ,
         rutcli       ,
         cod_svs      ,
         moinstser    ,
         tasa_interes ,
         monto_tran   ,
         'acfecproc' = @acfecproc     ,
         'acfecprox' = @acfecprox     ,
         'uf_hoy'    = @uf_hoy        ,
         'uf_man'    = @uf_man        ,
         'ivp_hoy'   = @ivp_hoy       ,
         'ivp_man'   = @ivp_man       ,
         'do_hoy'    = @do_hoy        ,
         'do_man'    = @do_man        ,
         'da_hoy'    = @da_hoy        ,
         'da_man'    = @da_man        ,
         'acnomprop' = @acnomprop     ,
      'rut_empresa' = @rut_empresa ,
         'hora'      = @hora          ,
         'dir_prop'  = @dir_prop      ,
         'com_prop'  = @com_prop      ,
         'ciu_prop'  = @ciu_prop      ,  
         'reg_prop'  = @reg_prop      ,
         'fon_prop'  = @fon_prop      ,
         'cap_prop'  = @cap_prop      , 
         'fax_prop'  = @fax_prop      ,  
         'email'     = @email         ,
         'apoderado1'= @apoderado1    ,
         'apoderado2'= @apoderado2    ,
         'cod_banco' = @cod_banco
         FROM #TEMPH1 ORDER BY tipo_Oper,tipo_prod
       END
 END
 SET NOCOUNT OFF 
END

  

GO
