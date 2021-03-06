USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CERTI_REPOS]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CERTI_REPOS]
             (@xfecha           CHAR(10)
             ,@NumeroOperacion  NUMERIC(10) = 0
	     ,@napoderadoder	NUMERIC(10) = 0
	     ,@napoderadoizq	NUMERIC(10) = 0
             )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE   @FECHA      DATETIME 
            ,@DIA        NUMERIC(1)
            ,@MES        NUMERIC(2)
            ,@NAMEMES    CHAR(10)
            ,@NAMEDIA    CHAR(3)
            ,@NUMDIA     NUMERIC(2)
            ,@NUMAÑO     NUMERIC(4)
            ,@RUT_BCCH   NUMERIC(09)
            ,@DO         FLOAT
            ,@area_defecto CHAR(5)
    SET @RUT_BCCH = ISNULL((SELECT rut_bcch FROM VIEW_DATOS_GENERALES),0)
            
   SELECT    @FECHA      = CONVERT(DATETIME,@xfecha,112)
   SELECT    @MES        = DATEPART(MONTH,(SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES))
   SELECT    @DIA        = DATEPART(WEEKDAY,(SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES))
   SELECT    @NUMDIA     = DATENAME(DAY, (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)) 
   SELECT    @NUMAÑO     = DATENAME(YEAR, (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)) 

    
    SELECT  @do = vmvalor FROM VIEW_VALOR_MONEDA        
    WHERE vmfecha = @fecha and vmcodigo =994
    SELECT  @area_defecto = 'PTAS'

    SELECT  @area_defecto = codigo_area
    FROM VIEW_AREA_PRODUCTO
    WHERE posicion_cambio = 1

   IF @MES=1  SELECT @NAMEMES = 'Enero '  
   IF @MES=2  SELECT @NAMEMES = 'Febrero '    
   IF @MES=3  SELECT @NAMEMES = 'Marzo '   
   IF @MES=4  SELECT @NAMEMES = 'Abril '
   IF @MES=5  SELECT @NAMEMES = 'Mayo '   
   IF @MES=6  SELECT @NAMEMES = 'Junio '  
   IF @MES=7  SELECT @NAMEMES = 'Julio ' 
   IF @MES=8  SELECT @NAMEMES = 'Agosto '  
   IF @MES=9  SELECT @NAMEMES = 'Septiembre '  
   IF @MES=10 SELECT @NAMEMES = 'Octubre '  
   IF @MES=11 SELECT @NAMEMES = 'Noviembre '  
   IF @MES=12 SELECT @NAMEMES = 'Diciembre '   
   
   IF @DIA=1 SELECT @NAMEDIA = 'Dom '  
   IF @DIA=2 SELECT @NAMEDIA = 'Lun '    
   IF @DIA=3 SELECT @NAMEDIA = 'Mar '   
   IF @DIA=4 SELECT @NAMEDIA = 'Mie '
   IF @DIA=5 SELECT @NAMEDIA = 'Jue '   
   IF @DIA=6 SELECT @NAMEDIA = 'Vie '  
   IF @DIA=7 SELECT @NAMEDIA = 'Sab '   




  SET NOCOUNT ON
       IF EXISTS(SELECT 1 FROM  MOVIMIENTO_TRADER
                            WHERE motipoper = 'RP'
                            and morutcli  = @RUT_BCCH
                            and (monumoper = @NumeroOperacion OR @NumeroOperacion  = 0)
     		       	    and mofecpro= @fecha
                )BEGIN
    
            SELECT 
                'Titulo'        = 'ANEXO Nº 1'
               ,'Titulo1'       = 'CERTIFICADO DE CUSTODIA'
               ,'Instrumento'   = CASE WHEN SUBSTRING(moinstser,1,4) = 'PDBC' OR SUBSTRING(moinstser,1,4) = 'PRBC' 
                                       THEN SUBSTRING(moinstser,1,4) + SUBSTRING(moinstser,9,2) + SUBSTRING(moinstser,7,2) + SUBSTRING(moinstser,5,2)
                                       ELSE ISNULL(moinstser,'') END
               ,'ValorVenta'    = ISNULL((CASE WHEN mnextranj <> "0" THEN movalinip ELSE (CASE WHEN mnrrda ='D' THEN (movalinip / 
                                                                                                                     (SELECT vmparidad 
                                                                                                                     FROM  VIEW_POSICION
                                                                                                                     WHERE vmcodigo = mnnemo
                                                                                                                     AND   codigo_area = @area_defecto
                                                                                                                     AND   vmfecha = @fecha)) * @do 
                                                                                                                    ELSE (movalinip * 
                                                                                                                     (SELECT vmparidad 
                                                                                                                     FROM  VIEW_POSICION
                                                                                                                     WHERE vmcodigo = mnnemo
                                                                                                                     AND   codigo_area = @area_defecto
                                                                                                                     AND   vmfecha = @fecha)) * @do END ) END),0)
               ,'ValorNominal'  = ISNULL(monominal,0)
               ,'Hora'          = CONVERT(char(10),getdate(),108)
               ,'FechaProceso'  = (SELECT convert(char(10),Fecha_proceso,103) FROM VIEW_DATOS_GENERALES WHERE Rut_entidad=morutcart)
               ,'Dia'           = 'Santiago' + ', '+ CONVERT(CHAR(2),@NUMDIA) + ' de ' + LTRIM(RTRIM(@NAMEMES)) + ' de ' + CONVERT(CHAR(4),@NUMAÑO)
               ,'NomiUf'        = ISNULL(monominal,0) ---CASE WHEN momonemi IN (998,999) THEN ISNULL(monominal,0) ELSE 0 END 
               ,'NomiPes'       = 0--CASE WHEN momonemi IN (998,999)THEN ISNULL(monominal,0) ELSE 0 END 
	       ,'nombre_1'	= a.apnombre
	       ,'rut_1'		= a.aprutapo
	       ,'dv_1'		= a.apdvapo
	       ,'nombre_2'	= b.apnombre
	       ,'rut_2'		= b.aprutapo
	       ,'dv_2'		= b.apdvapo
	       ,'moneda'        = momonemi       
               , moinstser
               ,morutcart
               ,momonemi
               ,mofecven          
             INTO #PASO_INFORME
             FROM
                MOVIMIENTO_TRADER , 
		VIEW_CLIENTE_APODERADO a ,
		VIEW_CLIENTE_APODERADO b ,
                VIEW_MONEDA                
            WHERE motipoper = 'RP'
            and morutcli  = @RUT_BCCH
            and mostatreg = ''
            and (monumoper = @NumeroOperacion OR @NumeroOperacion  = 0)
            and CONVERT(CHAR(10),mofecpro,103)= CONVERT(CHAR(10),@fecha,103)
	    and a.aprutcli = 97032000
	    and b.aprutcli = 97032000
	    and a.aprutapo = @napoderadoder
            and b.aprutapo = @napoderadoizq
            and mncodmon   = momonpact    

            SELECT 
                Titulo
               ,Titulo1
               ,Instrumento
               ,'ValorVenta' = ISNULL(SUM(valorventa),0)
               ,'ValorNominal'  = ISNULL(SUM(ValorNominal),0)
               ,Hora          
               ,FechaProceso
               ,Dia
               ,'NomiUf'        = SUM(Nomiuf)--CASE WHEN momonemi IN (998,999) THEN ISNULL(SUM(NomiUf),0) ELSE 0 END 
               ,'NomiPes'       = SUM(Nomipes)--CASE WHEN momonemi IN (998,999)THEN ISNULL(SUM(Nomipes),0) ELSE 0 END 
	       ,nombre_1
	       ,rut_1
	       ,dv_1
	       ,nombre_2
	       ,rut_2
	       ,dv_2
	       ,moneda
            FROM #PASO_INFORME 
            GROUP BY moinstser
                    ,morutcart
                    ,momonemi
                    ,mofecven          
	            ,nombre_1
	             ,rut_1
	             ,dv_1
	             ,nombre_2
	             ,rut_2
                     ,dv_2 
                     ,Titulo
                    ,Titulo1
                    ,Instrumento
                    ,Hora          
                    ,FechaProceso
                    ,Dia
    	            ,moneda
                                                          
            ORDER BY mofecven 


       END ELSE
            SELECT 
                'Titulo'        = 'ANEXO Nº 1'
               ,'Titulo1'       = 'CERTIFICADO DE CUSTODIA'
               ,'Instrumento'   = ' '
               ,'ValorVenta'    = CONVERT(FLOAT,0)
               ,'ValorNominal'  = CONVERT(FLOAT,0)
               ,'Hora'          = CONVERT(char(10),getdate(),108)
               ,'FechaProceso'  = (SELECT convert(char(10),Fecha_proceso,103) FROM VIEW_DATOS_GENERALES)
               ,'Dia'           = 'Santiago' + ', ' + CONVERT(CHAR(2),@NUMDIA) + ' de ' + LTRIM(RTRIM(@NAMEMES)) + ' de ' + CONVERT(CHAR(4),@NUMAÑO)
               ,'NomiUf'        = CONVERT(FLOAT,0)
               ,'NomiPes'       = CONVERT(FLOAT,0)
	       ,'nombre_1'	= ISNULL((SELECT apnombre FROM VIEW_CLIENTE_APODERADO WHERE  aprutapo = @napoderadoder),' ')
	       ,'rut_1'		= ISNULL((SELECT aprutapo FROM VIEW_CLIENTE_APODERADO WHERE  aprutapo = @napoderadoder),0)
	       ,'dv_1'		= ISNULL((SELECT apdvapo FROM VIEW_CLIENTE_APODERADO WHERE  aprutapo = @napoderadoder),' ')
	       ,'nombre_2'	= ISNULL((SELECT apnombre FROM VIEW_CLIENTE_APODERADO WHERE aprutapo = @napoderadoizq),' ')
	       ,'rut_2'		= ISNULL((SELECT aprutapo FROM VIEW_CLIENTE_APODERADO WHERE aprutapo = @napoderadoizq),0 )
	       ,'dv_2'		= ISNULL((SELECT apdvapo FROM VIEW_CLIENTE_APODERADO WHERE  aprutapo = @napoderadoizq),' ')
	       ,'moneda'        = convert(numeric(3),0)

END

GO
