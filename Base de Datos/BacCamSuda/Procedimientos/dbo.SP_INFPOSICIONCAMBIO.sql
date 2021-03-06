USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFPOSICIONCAMBIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFPOSICIONCAMBIO]( @Fecha CHAR(8) = '' )
AS
BEGIN
     DECLARE @NumOpe   NUMERIC(10), 
             @Total    FLOAT,
             @Tot      INTEGER,
             @Reg      INTEGER

  DECLARE  @acfecproc   char(10),
           @acfecprox   char(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(40),
           @rut_empresa char(12),
           @hora        char(8),
	   @oma		char(3)

   execute Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
	   @oma		OUTPUT

	SET NOCOUNT ON
     --<< Control de Fecha 
     IF @Fecha = ''
        SELECT @Fecha = CONVERT(CHAR(8),acfecpro,112) FROM meac


     --<< Operaciones del Dia  spot - empresa 

     SELECT  'NumOpe'   = CONVERT(NUMERIC(10),monumope), 
            'TipOpe'   	= CONVERT(CHAR(1),motipope), 
            'NomCli'   	= clnombre,
            'CodMon'   	= mocodmon, 
            'Monto'    	= momonmo, 
            'TCcierre' 	= moticam, 

            --<< Entidad            
            'NomEmi'   	= SPACE(70),
            'RutEmi'   	= CONVERT(NUMERIC(9),0),
            'DigEmi'   	= SPACE(1),
            'CodEmi'   	= CONVERT(NUMERIC(9),0),
--          'FechaPro' 	= CONVERT(CHAR(10), CONVERT(DATETIME,@Fecha) ,103),
	    'FechaPro' 	= CONVERT(CHAR(10), mofech ,103),	
            'Hora'     	= RIGHT(CONVERT(CHAR(20),GETDATE()),8),

            --<< Posicion
            'PosIni'   	= CONVERT(FLOAT,0.0),
            'TCIni'    	= CONVERT(FLOAT,0.0),
            'Total'    	= CONVERT(FLOAT,0.0),
            'fecha_SERV'= CONVERT( CHAR(10) , GETDATE(), 103),
	    'acfecproc'	=@acfecproc,
	    'acfecprox' =@acfecprox,
	    'uf_hoy'	=@uf_hoy,
	    'uf_man'	=@uf_man,
	    'ivp_hoy'	=@ivp_hoy,
	    'ivp_man'	=@ivp_man,
	    'do_hoy'	=@do_hoy,
	    'do_man'	=@do_man,
	    'da_hoy'	=@da_hoy,
	    'da_man'	=@da_man,
	    'pmnomprop'	=@acnomprop,
	    'rut_empresa'=@rut_empresa
 


       INTO #Posicion

   FROM memo ,TBAFECTOAPOSICION, BacParamsuda..cliente

      WHERE motipope IN ('C','V') AND mocodmon = 'USD'
        AND mofech   = @Fecha
        AND morutcli = clrut
	AND mocodcli = clcodigo
	AND motipmer = nemo
	AND posicion = 'V'  
	AND cltipcli  IN(1,2,3,4)
        and motipmer <> 'ccbb'
      ORDER BY monumope


     --<< Canjes del Dia
     INSERT INTO #Posicion
     SELECT  'NumOpe'   = CONVERT(NUMERIC(10),monumope), 
            'TipOpe'   	= 'V', 
            'NomCli'   	= clnombre,
            'CodMon'   	= mocodmon, 
            'Monto'    	= momonmo, 
            'TCcierre' 	= moticam, 

            --<< Entidad            
            'NomEmi'   	= SPACE(70),
            'RutEmi'   	= CONVERT(NUMERIC(9),0),
            'DigEmi'   	= SPACE(1),
            'CodEmi'   	= CONVERT(NUMERIC(9),0),
--          'FechaPro' 	= CONVERT(CHAR(10), CONVERT(DATETIME,@Fecha) ,103),
	    'FechaPro' 	= CONVERT(CHAR(10), mofech ,103),	
            'Hora'     	= RIGHT(CONVERT(CHAR(20),GETDATE()),8),

            --<< Posicion
            'PosIni'   	= CONVERT(FLOAT,0.0),
            'TCIni'    	= CONVERT(FLOAT,0.0),
            'Total'    	= CONVERT(FLOAT,0.0),
            'fecha_SERV'= CONVERT( CHAR(10) , GETDATE(), 103),
	    'acfecproc'	=@acfecproc,
	    'acfecprox' =@acfecprox,
	    'uf_hoy'	=@uf_hoy,
	    'uf_man'	=@uf_man,
	    'ivp_hoy'	=@ivp_hoy,
	    'ivp_man'	=@ivp_man,
	    'do_hoy'	=@do_hoy,
	    'do_man'	=@do_man,
	    'da_hoy'	=@da_hoy,
	    'da_man'	=@da_man,
	    'pmnomprop'	=@acnomprop,
	    'rut_empresa'=@rut_empresa

   FROM memo ,TBAFECTOAPOSICION, BacParamsuda..cliente

      WHERE motipope IN ('C','V') AND mocodmon = 'USD'
        AND mofech   = @Fecha
        AND morutcli = clrut
	AND mocodcli = clcodigo
	AND motipmer = nemo
	AND posicion = 'V'  
        AND motipmer = 'CANJ'
	AND cltipcli  IN(1,2,3,4)
      ORDER BY monumope
-- arbitrajes internacionales
-- arbitrajes de mesa

-- SELECT MOTIPMER,MONUMOPE FROM MEMO,TBAFECTOAPOSICION WHERE MOTIPMER = NEMO AND POSICION = 'V' AND MOCODMON = 'USD'
-- select moussme,mouss30,motipope,mocodmon,* from memo where motipmer='empr'
     --<< Operaciones Historicas
     /*INSERT INTO #Posicion
          SELECT  monumope, 
                  motipope, 
                  clnombre,
                  mocodmon, 
                  momonmo, 
                  moticam, 

                  --<< Entidad            
                  SPACE(70),
                  CONVERT(NUMERIC(9),0),
                  SPACE(1),
                  CONVERT(NUMERIC(9),0),
                  CONVERT(CHAR(10), CONVERT(DATETIME,@Fecha) ,103),
                  RIGHT(CONVERT(CHAR(20),GETDATE()),8),

                  --<< Posicion
                  0.0,
                  0.0,
                  0.0,
		  CONVERT( CHAR(10) , GETDATE(), 103),
	    	  @acfecproc,
	    	  @acfecprox,
	    	  @uf_hoy,
	    	  @uf_man,
	    	  @ivp_hoy,
	    	  @ivp_man,
	    	  @do_hoy,
	    	  @do_man,
	    	  @da_hoy,
	    	  @da_man,
	    	  @acnomprop,
	    	  @rut_empresa

             FROM memoh, BacParamSuda..cliente      

            WHERE motipope IN ('C','V') AND mocodmon = 'USD'
              AND mofech = @Fecha
              AND morutcli = clrut
	      AND mocodigo = clcodigo

            ORDER BY monumope*/


     --<< Posicion & Precio Inicial
     UPDATE #Posicion SET posini = vmposini, 
 			  tcini  = vmpreini,
                          total  = vmposini
                     FROM view_posicion_spt 
                    WHERE vmfecha = @Fecha AND vmcodigo = 'USD'


     --<< Entidad
     UPDATE #Posicion SET NomEmi = rcnombre,
                          RutEmi = rcrut,
                          DigEmi = rcdv,
                          CodEmi = rccodcar,
			  PosIni = acposini,
			  TCini	 = acpreini

                    FROM meac,  view_entidad
                    WHERE accodigo = CONVERT(NUMERIC(10),rccodcar)

     --<< Actualiza Saldo Posicion
     SELECT @Reg = 1, 
            @Tot = COUNT(*)
       FROM #Posicion

     SELECT @Total = 0


     WHILE (@Reg <= @Tot) BEGIN

	  --<< Rescata Operacion
          SET ROWCOUNT @Reg
          SELECT @NumOpe = NumOpe FROM #Posicion ORDER BY NumOpe

          SELECT @Total = @Total + (CASE TipOpe WHEN 'C' THEN monto ELSE -monto END)
            FROM #Posicion
           WHERE numope = @NumOpe

          --<< Actualiza Saldo 
          UPDATE #Posicion SET Total = @Total  WHERE numope = @NumOpe
     
          SELECT @Reg = @Reg + 1

     END -- WHILE

     SET ROWCOUNT 0

     --<< Retorna Datos
     SELECT * FROM #Posicion

     SET NOCOUNT OFF	

END

GO
