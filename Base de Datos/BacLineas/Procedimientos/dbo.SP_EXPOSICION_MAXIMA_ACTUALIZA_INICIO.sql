USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXPOSICION_MAXIMA_ACTUALIZA_INICIO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EXPOSICION_MAXIMA_ACTUALIZA_INICIO]
                       ( @cSistema	CHAR 	(03) 	
                        ) 
AS
BEGIN

	SET NOCOUNT ON
		DECLARE     @nMtoGrp 		NUMERIC (19,4)  ,
		            @nCodigo_grupo	VARCHAR(5)      ,
                            @nValorUF           FLOAT           ,
                            @cFecProc           DATETIME        ,
                            @cFecAnte           DATETIME        ,
                            @cFecProcBEX        DATETIME        ,                            
                            @cod_grupo          VARCHAR(5)      ,
	                    @sistema            CHAR(3)         , 
                            @rut_emisor         NUMERIC(9)      ,
                            @tipo_emisor        CHAR(3)         ,  
                            @codigo_instrumento NUMERIC(5)      ,
                            @codigo_moneda      NUMERIC(4)      , 
                            @descripcion        VARCHAR(50)     ,
                            @Glosa_Tipo_Emisor  CHAR(50)        , 
                            @COndicion          CHAR(20)        ,
                            @DiasPlazo          CHAR(10)        ,
                            @nValorDO           FLOAT           ,
                            @Cmd_Sql            VARCHAR(500)


     

      CREATE TABLE #Temp1
   (
       ExpOper    NUMERIC(19,4)
      ,NumDocu    NUMERIC(10)
       ,Correla    NUMERIC(3)                                                
      ,Numdocuo   NUMERIC(10)
      ,Correalao  NUMERIC(3)
      ,RutCli     NUMERIC(9)
      ,CodigoInst NUMERIC(5)
      ,Instser    CHAR(20) 
      ,Nominal    NUMERIC(19,4)
      ,VpTirc     NUMERIC(19,4)  
      ,RutEmi     NUMERIC(9)   
      ,MonEmi     NUMERIC(3)
      ,CodGrupo   CHAR(5) 
      ,Sist       CHAR(3) 
      ,TipoEmi    CHAR(3)      
      ,PlazoResi  NUMERIC(10)
   )

    CREATE TABLE #Temp3
   (
       ExpOper    NUMERIC(19,4)
      ,NumDocu    NUMERIC(10)                                              
      ,Correla    NUMERIC(3)                                                
      ,Numdocuo   NUMERIC(10)
      ,Correalao  NUMERIC(3)
      ,RutCli     NUMERIC(9)
      ,CodigoInst NUMERIC(5)
      ,Instser    CHAR(20) 
      ,Nominal    NUMERIC(19,4)
      ,VpTirc     NUMERIC(19,4)  
      ,RutEmi     NUMERIC(9)   
      ,MonEmi     NUMERIC(3)
      ,CodGrupo   CHAR(5) 
      ,Sist       CHAR(3) 
      ,TipoEmi    CHAR(3)      
      ,PlazoResi  NUMERIC(10)
   )

               IF @cSistema='BTR' OR @cSistema='BEX' BEGIN	
                              				
						SELECT 	@nMtoGrp  = 0
						SELECT  @nCodigo_grupo =''
			IF @cSistema='BTR' 
                           BEGIN
                                                   SELECT  @cFecProc = acfecproc  FROM  VIEW_MDAC   
                                                   SELECT  @cFecAnte = acfecante  FROM  VIEW_MDAC   
                                                   SELECT  @nValorUF = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo =998 and vmfecha = @cFecProc
                                                   SELECT  @nValorDO = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo =994 and vmfecha = @cFecProc 
                                                   
                                                   insert into #Temp1
                                                   select case when (semonemi = 13)  then (cpvptirc/1000)  
                                                               when (semonemi = 994) then (cpvptirc/@nValorDO)/1000  
                                                               else  (cpvptirc/@nValorUF)end ,
                                                          cpnumdocu  ,
                                                          cpcorrela  ,
                                                          cpnumdocuo ,
                                        cpcorrelao , 
                                                          cprutcli   ,
                                                          cpcodigo   ,   
                                                          cpinstser  , 
                                                          cpnominal  ,
                                                          cpvptirc   , 
                                                          emrut      ,
                                                          semonemi   ,
                                                          ''         ,
                                                          'BTR'      ,
                                                          emtipo     ,  
                                                          Datediff(day,@cFecProc,cpfecven)

                                                  from  Bactradersuda.dbo.mdcp,Bacparamsuda.dbo.serie ,Bacparamsuda.dbo.emisor  

                                                   where cpnominal <> 0
                                                   and   cpcodigo = secodigo
                                                   and   cpmascara = seserie
                                                   and   serutemi = emrut 



                                                   insert into #temp1
                                                   select case when (nsmonemi = 13) then (cpvptirc/1000)      
                                                               when (nsmonemi = 994) then (cpvptirc/@nValorDO)/1000  
                                                               else (cpvptirc/@nValorUF)end ,
                                                          cpnumdocu  ,
                                                          cpcorrela  ,
                                                          cpnumdocuo ,
                                                          cpcorrelao , 
                                                          cprutcli   ,
                                                          cpcodigo   ,   
                                                          cpinstser  , 
                                                          cpnominal  ,
                                                          cpvptirc   , 
                                                          emrut      ,
                                                          nsmonemi   ,
                                                          ''         ,
                                                          'BTR'      ,
                                                          emtipo     ,
                                                          Datediff(day,@cFecProc, cpfecven)                                       

                                                   from Bactradersuda.dbo.mdcp ,Bacparamsuda.dbo.noserie ,Bacparamsuda.dbo.emisor                                                      

                                                   where cpnominal <> 0
                                                   and   cpcodigo = nscodigo
                                                   and   cpnumdocu = nsnumdocu
                                                   and   cpcorrela = nscorrela
                                                   and   nsrutemi = emrut 



--**************************************************************************************
                  insert into #Temp1
                  select  case when (semonemi = 13)  then (vivptirc/1000)  
                           when (semonemi = 994) then (vivptirc/@nValorDO)/1000  
                           else  (vivptirc/@nValorUF)end ,
                  vinumoper  ,
                  vicorrela  ,
                  vinumdocu ,
                  vicorrela , 
                  virutcli   ,
                  vicodigo   ,   
                  viinstser  , 
                  vinominal  ,
                  vivptirc   , 
                  emrut      ,
                  semonemi   ,
                  ''         ,
                  'BTR'      ,
                  emtipo    ,  
                  Datediff(day,@cFecProc,vifecven)

                  from  Bactradersuda.dbo.mdvi,Bacparamsuda.dbo.serie ,Bacparamsuda.dbo.emisor  
                  where vinominal <> 0
                  and   vicodigo = secodigo
                  and   vimascara = seserie
                  and   serutemi = emrut 
                  and   vitipoper ='CP'   



                  insert into #Temp1
                  select case when (nsmonemi = 13) then (vivptirc/1000)      
                  when (nsmonemi = 994) then (vivptirc/@nValorDO)/1000  
                  else (vivptirc/@nValorUF)end ,
                  vinumoper  ,
                  vicorrela  ,
                  vinumdocu ,
                  vicorrela , 
                  virutcli   ,
                  vicodigo   ,   
                  viinstser  , 
                  vinominal  ,
                  vivptirc   , 
                  emrut      ,
                  nsmonemi   ,
                  ''         ,
                 'BTR'      ,
                 emtipo     ,
                 Datediff(day,@cFecProc,vifecven)                                       

            
          from Bactradersuda.dbo.mdvi ,Bacparamsuda.dbo.noserie ,Bacparamsuda.dbo.emisor                                                      

          where vinominal <> 0
          and   vicodigo = nscodigo
          and   vinumdocu = nsnumdocu
          and   vicorrela = nscorrela
          and   nsrutemi = emrut          
          and   vitipoper ='CP'



--**************************************************************************************


                           END

                           ELSE 
                           BEGIN 

                              
                                     SELECT  @cFecProcBEX =  acfecproc  FROM  Bacbonosextsuda.dbo.text_arc_ctl_dri
                                                   insert into #Temp1
                                                   
                                                   select (cpvptirc/1000),
                                                          cpnumdocu   ,
                                                          cpcorrelativo ,
                                                          cpnumdocu   ,
                                                          cpcorrelativo , 
                                                          cprutcli    ,
                                                          cod_familia ,   
                                                          cod_nemo    , 
                                                          cpnominal   ,
                                                          cpvptirc    , 
                                                          cprutemi    ,
                                                          cpmonemi    ,
                                                          ''          ,
                                                          'BEX'       ,
                                                          emtipo      ,   
                                                          0
                                                  from  Bacbonosextsuda.dbo.text_ctr_inv,Bacparamsuda.dbo.emisor
                                                   where cpnominal <> 0     
                                                   and cprutemi  = emrut    
                                                   and cpfecven  >=@cFecProcBEX
                                                                                                


                           END  
                                             	







declare cursor1 cursor 
for select codigo_grupo        ,
	   sistema             , 
	   rut_emisor          ,
	   tipo_emisor         , 
	   codigo_instrumento  , 
	   codigo_moneda       , 
	   descripcion         , 
	   Glosa_Tipo_Emisor   , 
	   Condicion 

    from    GRUPO_POSICION_DETALLE 


 open cursor1
 fetch next from cursor1 into    @cod_grupo        ,
	                         @sistema             , 
                                 @rut_emisor          ,
                                 @tipo_emisor         , 
                                 @codigo_instrumento  , 
	                         @codigo_moneda       , 
         @descripcion         , 
            @Glosa_Tipo_Emisor   , 
                                 @Condicion  


while ( @@fetch_status <> -1 )
 begin


   IF   @Condicion <>''         
      begin

         IF  @cSistema = 'BTR'

               
         begin

          IF  EXISTS(select 1  from GRUPO_POSICION_DETALLE  where rut_emisor =@rut_emisor
                                                                AND tipo_emisor = @tipo_emisor
                                                                AND codigo_instrumento = @codigo_instrumento 
                                                                AND codigo_moneda =  @codigo_moneda 
                                                                AND Condicion     = @Condicion)  
           begin


            SELECT @Cmd_Sql = 'INSERT INTO #temp3 SELECT  ExpOper ,NumDocu,Correla,Numdocuo'    
            SELECT @Cmd_Sql = @Cmd_Sql + ',Correalao,RutCli,CodigoInst ,Instser,Nominal'    
            SELECT @Cmd_Sql = @Cmd_Sql + ',VpTirc,RutEmi,MonEmi,' + RTRIM(@cod_grupo) + ',Sist,TipoEmi,PlazoResi'     --
            SELECT @Cmd_Sql = @Cmd_Sql + ' FROM #temp1 '
            SELECT @Cmd_Sql = @Cmd_Sql + ' WHERE CodigoInst = ' + RTRIM(@codigo_instrumento) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'MonEmi = ' + RTRIM(@codigo_moneda) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'TipoEmi = ' + RTRIM(@tipo_emisor) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'PlazoResi ' +  RTRIM(@Condicion)

--            select @Cmd_Sql



           end
           
           ELSE  
           begin  



            SELECT @Cmd_Sql = 'UPDATE #temp1 SET CodGrupo = ' + RTRIM(@cod_grupo)
            SELECT @Cmd_Sql = @Cmd_Sql + ' WHERE CodigoInst = ' + RTRIM(@codigo_instrumento) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'MonEmi = ' + RTRIM(@codigo_moneda) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'TipoEmi = ' + RTRIM(@tipo_emisor) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'PlazoResi ' +  RTRIM(@Condicion)

           end
         end   
         ELSE 

           IF  EXISTS(select 1  from GRUPO_POSICION_DETALLE  where rut_emisor =@rut_emisor
                                                                AND tipo_emisor = @tipo_emisor
                                                                AND codigo_instrumento = @codigo_instrumento 
                                                                AND codigo_moneda =  @codigo_moneda 
                                                                AND Condicion     = @Condicion)  
            begin
               

            SELECT @Cmd_Sql = 'INSERT INTO #temp3 SELECT  ExpOper, NumDocu, Correla, Numdocuo'    
            SELECT @Cmd_Sql = @Cmd_Sql + ',Correalao, RutCli, CodigoInst, Instser, Nominal'    
            SELECT @Cmd_Sql = @Cmd_Sql + ', VpTirc, RutEmi, MonEmi,' + RTRIM(@cod_grupo) + ', Sist, TipoEmi, PlazoResi'    
            SELECT @Cmd_Sql = @Cmd_Sql + ' FROM #temp1 '
            SELECT @Cmd_Sql = @Cmd_Sql + ' WHERE CodigoInst = ' + RTRIM(@codigo_instrumento) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'MonEmi = ' + RTRIM(@codigo_moneda) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'TipoEmi = ' + RTRIM(@tipo_emisor) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'RutEmi ' +  RTRIM(@Condicion)

          end
           ELSE 
           begin


            SELECT @Cmd_Sql = 'UPDATE #temp1 SET CodGrupo = ' + RTRIM(@cod_grupo)
            SELECT @Cmd_Sql = @Cmd_Sql + ' WHERE CodigoInst = ' + RTRIM(@codigo_instrumento) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'MonEmi = ' + RTRIM(@codigo_moneda) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'TipoEmi = ' + RTRIM(@tipo_emisor) + ' AND '
            SELECT @Cmd_Sql = @Cmd_Sql + 'RutEmi ' +  RTRIM(@Condicion)
            
           end 

            EXECUTE (@Cmd_Sql)



      end   



   ELSE   
      IF    @codigo_instrumento =20 

          
         IF    @rut_emisor =  97023000

                    UPDATE 	 #temp1     SET CodGrupo = @cod_grupo 
                    WHERE   CodigoInst      = @codigo_instrumento                           
                        AND MonEmi         = @codigo_moneda  
                        AND TipoEmi        = @tipo_emisor    
                        AND RutEmi         = 97023000                     

         ELSE

                    UPDATE 	 #temp1     SET CodGrupo = @cod_grupo 
                    WHERE   CodigoInst      = @codigo_instrumento                           
                    AND MonEmi         = @codigo_moneda  
                    AND TipoEmi        = @tipo_emisor 
                    AND RutEmi <> 97023000                      

       ELSE                                        

            IF  EXISTS(select 1  from GRUPO_POSICION_DETALLE  where rut_emisor =@rut_emisor
                                                                AND tipo_emisor = @tipo_emisor
                                                                AND codigo_instrumento = @codigo_instrumento 
                                                                AND codigo_moneda =  @codigo_moneda 
                                                                AND Condicion     = @Condicion)  
 
                  begin

                     SELECT @Cmd_Sql = 'INSERT INTO #temp3 SELECT  ExpOper, NumDocu, Correla, Numdocuo'    
                     SELECT @Cmd_Sql = @Cmd_Sql + ', Correalao, RutCli, CodigoInst, Instser, Nominal'    
                     SELECT @Cmd_Sql = @Cmd_Sql + ', VpTirc, RutEmi, MonEmi,' + RTRIM(@cod_grupo) + ', Sist, TipoEmi, PlazoResi'    
                     SELECT @Cmd_Sql = @Cmd_Sql + ' FROM #temp1 '
                     SELECT @Cmd_Sql = @Cmd_Sql + ' WHERE CodigoInst = ' + RTRIM(@codigo_instrumento) + ' AND '
                     SELECT @Cmd_Sql = @Cmd_Sql + 'MonEmi = ' + RTRIM(@codigo_moneda) + ' AND '
                     SELECT @Cmd_Sql = @Cmd_Sql + 'TipoEmi = ' + RTRIM(@tipo_emisor) 

                    
                     EXECUTE (@Cmd_Sql)
                  end
            ELSE

                       UPDATE 	 #temp1     SET CodGrupo = @cod_grupo 
                       WHERE   CodigoInst      = @codigo_instrumento                           
                           AND MonEmi         = @codigo_moneda  
                           AND TipoEmi        = @tipo_emisor  



  fetch next from cursor1 into 	 @cod_grupo           ,
	                         @sistema             , 
                                 @rut_emisor          ,
                                 @tipo_emisor    , 
                                 @codigo_instrumento  , 
	                         @codigo_moneda       , 
                                 @descripcion         , 
                                 @Glosa_Tipo_Emisor   , 
                                 @COndicion         

 end
 close cursor1
 deallocate cursor1

                                   
                                             



                  select  'TotCod'=sum(ExpOper)
                         ,CodGrupo 
                         ,Sist

                  into #Temp2 
                  from #Temp1  
                   GROUP BY  CodGrupo ,Sist 




                  INSERT INTO  #Temp2  
                  select  'TotCod'=sum(ExpOper)
                         ,CodGrupo 
                         ,Sist
                  from #Temp3  
                   GROUP BY  CodGrupo ,Sist 










                                             UPDATE 	POSICION_GRUPO
                                        	SET 	Totalocupado = 0,
                                                        totaldisponible = A.totalposicion,
                                                        totalexcedido =0 
                                                FROM    POSICION_GRUPO  A , #Temp2 B
                                                WHERE   B.CodGrupo= A.codigo_grupo
                                                    AND B.Sist    =  @cSistema
                              





						UPDATE POSICION_GRUPO
						SET    Totalocupado =  totalocupado + TotCod 
                                                FROM   #Temp2                                                
						WHERE	Codigo_Grupo = CodGrupo

                                                   





                                        	UPDATE 	POSICION_GRUPO
                                        	SET 	totaldisponible = totalposicion - totalocupado
                                        	WHERE 	totalposicion > totalocupado



                                           	UPDATE 	POSICION_GRUPO
                                        	SET 	totalexcedido = (totalposicion - totalocupado) * -1
                	WHERE 	totalposicion < totalocupado



                                        	UPDATE 	POSICION_GRUPO
                                        	SET 	porcentaje = (totalocupado/totalposicion)* 100
                                           	WHERE 	totalposicion > 0 







					END





	SET NOCOUNT OFF

END
GO
