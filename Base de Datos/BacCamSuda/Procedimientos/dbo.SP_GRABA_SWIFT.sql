USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_SWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_SWIFT]
   (   @rut_cliente   NUMERIC(9)
   ,   @Tipo_Mercado  CHAR(10)
   ,   @Codigo_Moneda CHAR(3)
   ,   @Valuta1       CHAR(8)
   ,   @Monto         FLOAT
   ,   @Tipo_Cambio   FLOAT
   ,   @Observa       CHAR(250)
   ,   @Codigo_Swift  CHAR(10)
   ,   @Op_Futuro     NUMERIC(9)
   ,   @Op_Numero     NUMERIC(7)
   )
AS
BEGIN


--   SET NOCOUNT ON

   DECLARE   @Mercado           CHAR    (  4)
            ,@NomEntidad        CHAR    ( 34)
            ,@numero            NUMERIC ( 10)
            ,@FECH_O            DATETIME
            ,@CodNumMon         NUMERIC (  3)
            ,@receptor          CHAR    ( 50)
            ,@mt_20             CHAR    ( 16)
            ,@mt_72             CHAR    (250)
            ,@mt_58_direccion   CHAR    (150)
            ,@mt_57_sucursal    CHAR    ( 35)
            ,@mt_58_cuenta      CHAR    ( 35)
            ,@mt_57_swift       CHAR    ( 11)  -- CÃ³digo Swift Banco
            ,@mt_58_swift       CHAR    ( 11)  -- CÃ³digo Swift Sucursal
            ,@CodSwt            NUMERIC (  5)
            ,@Tipo              CHAR    (  1)     
            ,@moneda            CHAR    (  3)
            ,@monto2            NUMERIC(19,4)
            ,@Paridad           CHAR    ( 20)
            ,@mt_32a_fecha      CHAR    ( 20)
            ,@Rut_Corresponsal  NUMERIC (  9)
            ,@Nom_Corresponsal  CHAR    ( 50)
            ,@Fecha_Hoy         CHAR    ( 08)
            ,@swift2            CHAR    ( 10)
            ,@estado            CHAR    (  1)
            ,@actualiza         VARCHAR (255)
            ,@Codigo            NUMERIC (  3)
   
     SELECT @estado = 'P'    
     
     CREATE TABLE #detalle_swift (
                 [MONEDA]   [char]   (    3) NULL DEFAULT('')
                ,[MONTO]    [numeric](19, 4) NULL DEFAULT(0)
                ,[PARIDAD]  [numeric](19, 8) NULL DEFAULT(0))
     -------------------------------------
     SELECT  @Mercado          = ''
            ,@NomEntidad       = ''
            ,@CodNumMon        = 0
            ,@Numero           = 0
            ,@receptor         = ''
            ,@mt_20            = ''
            ,@mt_72            = ''
            ,@mt_58_direccion  = ''
            ,@mt_57_sucursal   = ''
            ,@mt_58_cuenta     = ''
            ,@mt_57_swift      = ''
            ,@mt_58_swift      = ''           
            ,@CodSwt           = 0
            ,@Tipo             = ''
            ,@mt_32a_fecha     = ''
            ,@Rut_Corresponsal = 0
            ,@Nom_Corresponsal = ''
            ,@swift2           = ''

     SELECT @Mercado    = CASE @Tipo_Mercado 
                               WHEN 'SPOT'      THEN 'PTAS' 
                               WHEN 'ARBITRAJE' THEN 'ARBI'
                               WHEN 'CANJE'     THEN 'CANJ'
                               ELSE ' '
                          END

     SELECT @CodSwt     = CASE @Tipo_Mercado WHEN 'ARBITRAJE' THEN CONVERT(INTEGER,@Codigo_Swift) ELSE 0 END

     SELECT @FECH_O     = (SELECT acfecpro FROM MEAC)
     SELECT @CodNumMon  = (SELECT mncodmon FROM VIEW_MONEDA WHERE mnnemo = @Codigo_Moneda)
     SELECT @NomEntidad = (SELECT acnombre FROM MEAC)
     SELECT @Fecha_Hoy  = (CONVERT(CHAR(08),@FECH_O,112))

     SET ROWCOUNT 1

     IF @Tipo_Mercado = 'ARBITRAJE' 
     BEGIN 
        IF @Codigo_Moneda = 'USD' 
        BEGIN
           SELECT  @Numero                        = monumope 
             FROM  MEMO
            WHERE  morutcli                       = @rut_cliente 
               AND motipmer                       = @Mercado
	       AND mocodcnv                       = @Codigo_Moneda 
               AND CONVERT(CHAR(8),movaluta1,112) = @Valuta1
               AND motipope                       = 'C'
               AND moestatus                      IN( '' ,'M')
               AND moimpreso                      = ''
   ORDER BY  monumope
/*REQ.7619
            SELECT @actualiza = "UPDATE MEMO SET NumeroInterfaz = "        + CONVERT(CHAR(10),@Numero)     +
                             "WHERE morutcli = "                        + CONVERT(CHAR(9),@rut_cliente) + 
                             " AND motipmer  =  '"                      + @Mercado                      + 
                             "' AND mocodcnv  = '"                      + @Codigo_Moneda                + 
                             "' AND CONVERT(CHAR(8),movaluta1,112) = '" + @Valuta1                      + 
                             "' AND motipope  = 'C' AND moestatus IN( '' ,'M') AND moimpreso = ''"
*/

           SELECT @actualiza = 'UPDATE MEMO SET NumeroInterfaz = '        + CONVERT(CHAR(10),@Numero)     +
                             ' WHERE morutcli = '                        + CONVERT(CHAR(9),@rut_cliente) + 
                             ' AND motipmer  =  '''                      + @Mercado      + ''' '                + 
                             ' AND mocodcnv  = '''                     + @Codigo_Moneda   + ''' '             + 
                             ' AND CONVERT(CHAR(8),movaluta1,112) = ''' + @Valuta1        + ''' '              + 
                             ' AND motipope  = ''C'' AND moestatus IN( '''' ,''M'') AND moimpreso = '''''


        END ELSE 
        BEGIN
             SELECT  @Numero=monumope ,
                     @swift2=Swift_Recibimos
               FROM  memo 
              WHERE  morutcli      = @rut_cliente 
                 AND motipmer  = @Mercado
                 AND mocodmon  = @Codigo_Moneda 
                 AND CONVERT(CHAR(8),movaluta2,112) = @Valuta1     
                 AND motipope  = 'V'
                 AND moestatus IN( '' ,'M')
                 AND moimpreso = ''
           ORDER BY monumope

/*			 REQ.7619
              SELECT  @actualiza = "UPDATE MEMO SET NumeroInterfaz = "        + CONVERT(CHAR(10),@Numero)     + 
                                  "WHERE morutcli = "                        + CONVERT(CHAR(9),@rut_cliente) + 
                                  " AND motipmer  =  '"                      + @Mercado                      + 
                                  "' AND mocodmon  = '"                      + @Codigo_Moneda                + 
                                  "' AND CONVERT(CHAR(8),movaluta2,112) = '" + @Valuta1                      + 
                                  "' AND motipope  = 'V' AND moestatus IN( '' ,'M') AND moimpreso = ''"
*/

			SELECT @actualiza =   ' UPDATE MEMO SET NumeroInterfaz = '		  + CONVERT(CHAR(10),@Numero) + 
                                  ' WHERE morutcli = '                        + CONVERT(CHAR(9),@rut_cliente)  + 
                                  ' AND motipmer  =  '''                      + @Mercado			+ ''' '  + 
                                  ' AND mocodmon  = '''                       + @Codigo_Moneda		+ ''' '  + 
                                  ' AND CONVERT(CHAR(8),movaluta2,112) = '''  + @Valuta1			+ ''' '  + 
                                  ' AND motipope  = ''V'' AND moestatus IN( '''' ,''M'') AND moimpreso = '''' '  

        END
		
        SELECT  DISTINCT @Nom_Corresponsal = nombre 
               ,@mt_58_swift      = codigo_swift
          FROM  view_corresponsal 
         WHERE  cod_corresponsal = @CodSwt

        SELECT  DISTINCT @Rut_Corresponsal = rut_corresponsal FROM view_corresponsal WHERE cod_corresponsal = @CodSwt
        SELECT  @mt_57_sucursal            = ISNULL((SELECT DISTINCT nombre           FROM view_corresponsal WHERE rut_cliente = @Rut_Corresponsal AND codigo_moneda = @CodNumMon),' ')
        SELECT  @mt_57_swift               = ISNULL((SELECT DISTINCT codigo_swift     FROM view_corresponsal WHERE rut_cliente = @Rut_Corresponsal AND codigo_moneda = @CodNumMon),' ')
        SELECT  @mt_58_cuenta              = ISNULL((SELECT DISTINCT cuenta_corriente FROM view_corresponsal WHERE rut_cliente = @Rut_Corresponsal AND codigo_moneda = @CodNumMon ),' ')
        SELECT  @mt_58_direccion           = @Nom_Corresponsal           
     END ELSE
         IF @Tipo_Mercado = 'CANJE' BEGIN 
            SELECT  @Numero=monumope 
              FROM  memo 
             WHERE  morutcli  = @rut_cliente 
                AND motipmer  = @Mercado
                AND mocodmon  = @Codigo_Moneda 
                AND CONVERT(CHAR(8),Valuta_Cli_Ext,112) = @Valuta1
                AND moimpreso = ''
                AND moestatus IN( '' ,'M')
          ORDER BY monumope


/*		  REQ.7619	
          SELECT  @actualiza = "UPDATE MEMO SET NumeroInterfaz = " + CONVERT(CHAR(10),@Numero)     + 
                               "WHERE morutcli = "                 + CONVERT(CHAR(9),@rut_cliente) + 
                               " AND motipmer  =  '"               + @Mercado                      + 
                               "' AND mocodmon  = '"               + @Codigo_Moneda                + 
                               "' AND CONVERT(CHAR(8),Valuta_Cli_Ext,112) = '" + @Valuta1 + "' AND moestatus IN( '' ,'M') AND moimpreso = ''"
*/
          SELECT  @actualiza = 'UPDATE MEMO SET NumeroInterfaz = ' + CONVERT(CHAR(10),@Numero)     + 
                               'WHERE morutcli = '                 + CONVERT(CHAR(9),@rut_cliente) + 
                               ' AND motipmer  =  '''               + @Mercado +''' '                     + 
                               ' AND mocodmon  = '''              + @Codigo_Moneda   +''' '                + 
                               ' AND CONVERT(CHAR(8),Valuta_Cli_Ext,112) = ''' + @Valuta1 + ''' AND moestatus IN( '''' ,''M'') AND moimpreso = '''''


          SELECT @mt_57_sucursal  = ISNULL((select nombre_corresponsal from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
          SELECT @mt_57_swift     = ISNULL((select codigo_swift  from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
          SELECT @mt_58_cuenta    = ISNULL((select cuenta_corresponsal from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
          SELECT @mt_58_swift     = ISNULL((SELECT Clswift             FROM view_cliente              WHERE clrut = @rut_cliente AND clcodigo = 1 ),' ')
          SELECT @mt_58_direccion = ISNULL((SELECT RTRIM(clnombre)+' ' FROM view_cliente              WHERE clrut = @rut_cliente AND clcodigo = 1 ),' ')+ISNULL((SELECT RTRIM(a.nom_ciu) FROM view_cliente,view_ciudad_comuna a WHERE (clrut = @rut_cliente AND clcodigo = 1) and (clpais = a.cod_pai AND clciudad = a.cod_ciu AND clcomuna = a.cod_com) ),' ')
		END ELSE
        BEGIN 

                  SELECT  @Numero=monumope 
                    FROM  memo 
                   WHERE morutcli  = @rut_cliente 
                     AND motipmer  = @Mercado
                     AND mocodmon  = @Codigo_Moneda 
                     AND CONVERT(CHAR(8),movaluta1,112) = @Valuta1 
                     AND moimpreso = ''
                     AND moestatus IN('','M')
                ORDER BY monumope

/*				REQ.7619
                SELECT  @actualiza = "UPDATE MEMO SET NumeroInterfaz = "        + CONVERT(CHAR(10),@Numero)     + 
                                     "WHERE morutcli = "                        + CONVERT(CHAR(9),@rut_cliente) + 
                                     " AND motipmer  =  '"                      + @Mercado                      + 
                                     "' AND mocodmon  = '"                      + @Codigo_Moneda                + 
                                     "' AND CONVERT(CHAR(8),movaluta1,112) = '" + @Valuta1 + "' AND moestatus IN( '' ,'M') AND moimpreso = ''"
               
*/

				SELECT  @actualiza = 'UPDATE MEMO SET NumeroInterfaz = '        + CONVERT(CHAR(10),@Numero)   + 
                                     'WHERE morutcli = '   + CONVERT(CHAR(9),@rut_cliente)	+ 
             ' AND motipmer  =  '''                     + @Mercado				+''' '             + 
                                     ' AND mocodmon  = '''                      + @Codigo_Moneda		+''' '             + 
                                     ' AND CONVERT(CHAR(8),movaluta1,112) = ''' + @Valuta1				+ ''' AND moestatus IN( '''' ,''M'') AND moimpreso = '''' '

	--			SELECT '@actualiza',@actualiza

                SELECT @mt_57_sucursal  = ISNULL((select DISTINCT nombre_corresponsal from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
                SELECT @mt_57_swift     = ISNULL((select DISTINCT codigo_swift        from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
                SELECT @mt_58_swift     = ISNULL((SELECT Clswift  FROM view_cliente WHERE clrut = @rut_cliente AND clcodigo = 1 ),' ')
                SELECT @mt_58_cuenta    = ISNULL((select DISTINCT cuenta_corresponsal from view_cliente_corresponsal where rut_cliente = @rut_cliente ),' ')
                SELECT @mt_58_direccion = ISNULL((SELECT RTRIM(clnombre)+' ' FROM view_cliente WHERE clrut = @rut_cliente AND clcodigo = 1 ),' ')+ISNULL((SELECT RTRIM(a.nom_ciu) FROM view_cliente,view_ciudad_comuna a WHERE (clrut = @rut_cliente AND clcodigo = 1) and  (clpais = a.cod_pai AND clciudad = a.cod_ciu AND clcomuna = a.cod_com) ),' ')

         END
         SET ROWCOUNT 0
         SET NOCOUNT ON
         SELECT @Tipo     = CASE @Tipo_Mercado WHEN 'ARBITRAJE' THEN 'A' ELSE ' ' END
         SELECT @Numero   = ISNULL(@Numero,0)

         DECLARE @nCodMon   INTEGER
             SET @nCodMon   = (SELECT mncodmon FROM BacparamSuda..MONEDA WHERE mnnemo = @Codigo_Moneda)


         SELECT @receptor = (CASE WHEN @Tipo_Mercado = 'ARBITRAJE' AND  @Codigo_Moneda  = 'USD' THEN ISNULL((SELECT Nombre_Corresponsal from view_cliente_corresponsal WHERE rut_cliente = @rut_cliente),' ') -- swift_movimiento
                                  WHEN @Tipo_Mercado = 'ARBITRAJE' AND  @Codigo_Moneda <> 'USD' THEN ISNULL( @mt_57_sucursal ,' ')
                                  ELSE                                                               ISNULL(( SELECT DISTINCT nombre FROM VIEW_CORRESPONSAL , MEAC      WHERE rut_cliente=acrut AND accorres = codigo_corres AND codigo_swift = 'PNBPUS3NNYC' and codigo_moneda = @nCodMon),' ')
                             END)



         SELECT @mt_20           = '01019' + SUBSTRING(CONVERT(CHAR(04),YEAR(GETDATE())),4,1)+RIGHT(@Op_Numero,4)
         SELECT @codigo          = CASE WHEN (@Valuta1 - @FECH_O) = 0 THEN 1 ELSE 2 END
         SELECT @mt_32a_fecha    = SUBSTRING(@Valuta1,3,2)+' '+SUBSTRING(@Valuta1,5,2)+' '+SUBSTRING(@Valuta1,7,2)
         SELECT @mt_72           = CASE WHEN @Tipo_Mercado = 'ARBITRAJE' AND @Codigo_Moneda = 'USD' THEN '//ATTN: FOREING EXCHANGE' ELSE ' ' END



--				SELECT '---',
--				@Op_Numero
--                                ,@Tipo
--                                ,0 
--                                ,@Codigo     
--                                ,' '   
--                                ,@receptor
--                                ,@mt_20
--                                ,''     
--                                ,@mt_32a_fecha
--                                ,ISNULL(@Monto,0)
--                                ,ISNULL(@Codigo_Moneda,'')
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--                                ,''
--         ,''
--                             ,''
--                                ,''
--                                ,''
--                     ,@mt_57_swift
--                                ,@mt_57_sucursal 
--                                ,''
--                                ,@mt_58_cuenta 
--                                ,@mt_58_swift
--                                ,@mt_58_direccion
--                                ,''
--                                ,''
--                                ,''
--                                ,@mt_72
--                                ,CONVERT(CHAR(8),@FECH_O,112)
--                                ,''    
--                                ,''
--                                ,@estado
--                                ,@NomEntidad

         INSERT INTO TBTRANSFERENCIA
                               ( numero_operacion
                                ,tipo  
                                ,correlativo 
                                ,codigo 
                                ,swift  
                                ,receptor 
                                ,mt_20  
                                ,mt_21  
                                ,mt_32a_fecha 
                                ,mt_32a_monto 
                                ,mt_32a_moneda 
                                ,mt_50  
                                ,mt_52_cuenta 
                                ,mt_52_swift 
                                ,mt_52_direccion
                                ,mt_53_cuenta 
                                ,mt_53_swift 
                                ,mt_53_sucursal 
                                ,mt_53_direccion
                                ,mt_54_cuenta 
                                ,mt_54_swift 
                                ,mt_54_sucursal 
                                ,mt_54_direccion
                                ,mt_56_cuenta  
                                ,mt_56_swift  
                                ,mt_56_direccion 
                                ,mt_57_cuenta  
                                ,mt_57_swift  
                                ,mt_57_sucursal  
                                ,mt_57_direccion 
                                ,mt_58_cuenta  
                                ,mt_58_swift  
                                ,mt_58_direccion 
                                ,mt_59   
                                ,mt_70   
                                ,mt_71a   
                                ,mt_72   
                                ,fecha   
                                ,usuario  
                                ,usuario1
                                ,estado  
                                ,entidad
                                )
 
                         VALUES( @Op_Numero
                                ,@Tipo
                                ,0 
                                ,@Codigo     
                                ,' '   
                                ,@receptor
                                ,@mt_20
                                ,''     
                                ,@mt_32a_fecha
                                ,ISNULL(@Monto,0)
                                ,ISNULL(@Codigo_Moneda,'')
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,''
                                ,@mt_57_swift
     ,@mt_57_sucursal 
                                ,''
                                ,@mt_58_cuenta 
                                ,@mt_58_swift
                                ,@mt_58_direccion
                                ,''
                                ,''
                                ,''
                                ,@mt_72
                                ,CONVERT(CHAR(8),@FECH_O,112)
                                ,''    
                                ,''
                                ,@estado
                                ,@NomEntidad
                               )           
         IF @@ERROR<>0   BEGIN
            SELECT -1, 'No se pudo Agregar Transferencia a operacion'
            RETURN
         END 
         
         IF @Tipo_Mercado = 'ARBITRAJE' 
		 BEGIN
            IF @Codigo_Moneda = 'USD' BEGIN
               INSERT  INTO tbtransferencia_detalle
               SELECT  @Numero    
                      ,mocodmon   
                      ,momonmo    
                      ,CONVERT(CHAR(20),moparme)
                 FROM	MEMO 
                WHERE	swift_recibimos                = CONVERT(VARCHAR(10), @CodSwt)        
				AND		CONVERT(CHAR(8),movaluta1,112) = @Valuta1       
				AND		mocodcnv                       = @Codigo_Moneda 
				AND		morutcli                       = @rut_cliente   
				AND		motipope                       = 'C'            
				AND		moimpreso                      = ''
            END ELSE
            BEGIN
               INSERT  INTO tbtransferencia_detalle
               SELECT  @Numero    
                      ,mocodcnv   
                      ,moussme    
                      ,CONVERT(CHAR(20),moparme)
                 FROM	MEMO 
                WHERE   swift_recibimos                       = CONVERT(VARCHAR(10),@CodSwt)        
                AND		CONVERT( CHAR(8) , movaluta2 , 112 )  = @Valuta1       
                AND		mocodmon                              = @Codigo_Moneda 
                AND		morutcli                              = @rut_cliente   
                AND		motipope                              = 'V'            
				AND		moimpreso                             = ''
            END
     
         END
   --EXECUTE (@actualiza)
   SET NOCOUNT OFF      
END
GO
