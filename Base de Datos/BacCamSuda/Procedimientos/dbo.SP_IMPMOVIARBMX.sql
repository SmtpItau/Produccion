USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPMOVIARBMX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_IMPMOVIARBMX] 
           (
           @entidad    NUMERIC(10)
          ,@usuario    CHAR(40)  
          ,@DESDE      CHAR(8)  
          ,@HASTA      CHAR(8)  
           )
AS BEGIN
SET NOCOUNT ON

   DECLARE @iTipoUsuario   INTEGER
       SET @iTipoUsuario   = (SELECT CASE WHEN tipo_usuario = 'TRADER' THEN 1 ELSE 0 END
                                FROM BacParamSuda..USUARIO WHERE usuario = @usuario)
   
   IF @iTipoUsuario = 0
      SET @usuario = ''


DECLARE @xnomprop    CHAR(50)
DECLARE @xrutprop    NUMERIC(09)
DECLARE @xdigprop    CHAR(01)
DECLARE @XFECPROC    DATETIME
DECLARE @acfecproc   CHAR(10),
        @acfecprox   CHAR(10),
        @uf_hoy      FLOAT,
        @uf_man      FLOAT,
        @ivp_hoy     FLOAT,
        @ivp_man     FLOAT,
        @do_hoy      FLOAT,
        @do_man      FLOAT,
        @da_hoy      FLOAT,
        @da_man      FLOAT,
        @acnomprop   CHAR(40),
        @rut_empresa CHAR(12),
        @hora        CHAR(8),
        @oma         CHAR(3)

   SELECT @xnomprop = acnomprop,
          @xrutprop = acrutprop,
          @xdigprop = acdigprop,
          @xfecproc = acfecproc
   FROM VIEW_MDAC

   EXECUTE Sp_Base_Del_Informe
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
           @oma

         SELECT   'moneda cnv'                    = mocodcnv
                 ,'tipo de oper'                  = motipope
                 ,'numero op'                     = monumope
                 ,'nombre cliente'                = clnombre
                 ,'tacfechpro'                    = MOFECH             --CONVERT( CHAR(10), mofech, 103 )
                 ,'moneda op'                     = mocodmon
                 ,'monto moneda op'               = momonmo
                 ,'paridad mensual'               = moparme
                 ,'monto en usd'                  =  moussme 
                 ,'paridad de transferencia'      = mopartr
                 ,'mto usd por par transferencia' = mousstr
                 ,'utilidad dolares'              = CASE motipope WHEN 'C' THEN ROUND(((CASE mopartr WHEN 0 THEN 0
                                                                                                     ELSE 1/mopartr
                                                                                        END)-(CASE moparme WHEN 0 THEN 0
                                                                                                           ELSE 1/moparme
                                                                                              END))*momonmo,4)
                                                                  ELSE ROUND(((CASE moparme WHEN 0 THEN 0
                                                                                            ELSE  1/moparme
                                                                               END)-(CASE mopartr WHEN 0 THEN 0
                                                                                                  ELSE 1/mopartr
                                                                                     END))*momonmo,4)
                                                    END
                 ,'tc cambio'            = moticam
                 ,'precio'               = moprecio
                 ,'tc transfrencia'      = motctra
                 ,'precio transferencia' = mopretra
                 ,'utilidad en pesos'    = CASE motipope WHEN 'C' THEN ROUND((motctra-moticam)*moussme,0)
                                                         ELSE ROUND((moticam-motctra)*moussme,0)
                                           END
                 ,'hoyfecha'             = mofech           --CONVERT( CHAR(10), mofech, 103 )
                 ,'hora'                 = mohora
                 ,'rut propietario'      = @xrutprop
                 ,'digito pro'           = @xdigprop
                 ,'nombre propietario'   = @xnomprop
                 ,'entidad'              = rcnombre
                 ,'usuario'              = mooper
                 ,'MERCADO'              = motipmer
                 ,'OPERACION'            = motipope
                 ,'MONEDAOPERACION'      = mocodmon
                 ,'UsuarioS'             = @usuario
                 ,'Entregamos'           = (SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = moentre)
                 ,'Recibimos'            = (SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = morecib)
                 ,'fecha_SERV'           = CONVERT( CHAR(10) , GETDATE(), 103) 
                 ,'Desde'                = SUBSTRING(@DESDE ,7,2) + '/' +SUBSTRING(@DESDE ,5,2) + '/' +SUBSTRING(@DESDE ,1,4)
                 ,'Hasta'                = SUBSTRING(@HASTA ,7,2) + '/' +SUBSTRING(@HASTA ,5,2) + '/' +SUBSTRING(@HASTA ,1,4)
                 ,'MoFech'               = CONVERT(CHAR(10),MOFECH,103)      --CONVERT( CHAR(10), mofech, 103 )
                 ,'acfecproc'            = @acfecproc
                 ,'acfecprox'            = @acfecprox
                 ,'uf_hoy'               = @uf_hoy
                 ,'uf_man'               = @uf_man
                 ,'ivp_hoy'              = @ivp_hoy
                 ,'ivp_man'              = @ivp_man
                 ,'do_hoy'               = @do_hoy
                 ,'do_man'               = @do_man
                 ,'da_hoy'               = @da_hoy
                 ,'da_man'               = @da_man
                 ,'pmnomprop'            = @acnomprop
                 ,'rut_empresa'          = @rut_empresa
         INTO   #TEMPORAL
         FROM   MEMO         ,
                VIEW_CLIENTE ,
                VIEW_ENTIDAD
         WHERE  morutcli  =  clrut           AND
                mocodcli  =  clcodigo        AND
               (@entidad  =  0               OR
                @entidad  =  moentidad)      AND
                motipmer   LIKE'%ARB%'       AND
                moentidad =  rccodcar        AND
                motipope  <> 'A'             AND
                mofech    >= @DESDE          AND
                mofech    <= @HASTA          AND
                @HASTA    <= @XFECPROC       AND
               (MOOPER    =  @USUARIO  OR @USUARIO = '')      AND
               (MOESTATUS =  ' '             OR
                MOESTATUS = 'M') 

         UNION
         SELECT   'moneda cnv'                    = mocodcnv
                 ,'tipo de oper'                  = motipope
                 ,'numero op'                     = monumope
                 ,'nombre cliente'                = clnombre
                 ,'tacfechpro'                    = MOFECH             --CONVERT( CHAR(10), mofech, 103 )
                 ,'moneda op'                     = mocodmon
                 ,'monto moneda op'               = momonmo
                 ,'paridad mensual'               = moparme
                 ,'monto en usd'                  = moussme 
                 ,'paridad de transferencia'      = mopartr
                 ,'mto usd por par transferencia' = mousstr
                 ,'utilidad dolares'              = CASE motipope WHEN 'C' THEN ROUND(((CASE mopartr WHEN 0 THEN 0
                                                                                                     ELSE 1/mopartr
                                                                                        END)-(CASE moparme WHEN 0 THEN 0
                                                                                                           ELSE 1/moparme
                                                                          END))*momonmo,4)
                                                                  ELSE ROUND(((CASE moparme WHEN 0 THEN 0
   ELSE  1/moparme
         END)-(CASE mopartr WHEN 0 THEN 0
                                                                                                  ELSE 1/mopartr
                                                                                     END))*momonmo,4)
                                                    END
                 ,'tc cambio'            = moticam
                 ,'precio'               = moprecio
                 ,'tc transfrencia'      = motctra
                 ,'precio transferencia' = mopretra
                 ,'utilidad en pesos'    = CASE motipope WHEN 'C' THEN ROUND((motctra-moticam)*moussme,0)
                                                         ELSE ROUND((moticam-motctra)*moussme,0)
                                           END
                 ,'hoyfecha'             = mofech           --CONVERT( CHAR(10), mofech, 103 )
                 ,'hora'                 = mohora
                 ,'rut propietario'      = @xrutprop
                 ,'digito pro'           = @xdigprop
                 ,'nombre propietario'   = @xnomprop
                 ,'entidad'              = rcnombre
                 ,'usuario'              = mooper
                 ,'MERCADO'              = motipmer
                 ,'OPERACION'            = motipope
                 ,'MONEDAOPERACION'      = mocodmon
                 ,'UsuarioS'             = @usuario
                 ,'Entregamos'           = (SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = moentre)
                 ,'Recibimos'            = (SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = morecib)
                 ,'fecha_SERV'           = CONVERT( CHAR(10) , GETDATE(), 103) 
                 ,'Desde'                = SUBSTRING(@DESDE ,7,2) + '/' +SUBSTRING(@DESDE ,5,2) + '/' +SUBSTRING(@DESDE ,1,4)
                 ,'Hasta'                = SUBSTRING(@HASTA ,7,2) + '/' +SUBSTRING(@HASTA ,5,2) + '/' +SUBSTRING(@HASTA ,1,4)
                 ,'MoFech'               = CONVERT(CHAR(10),MOFECH,103)      --CONVERT( CHAR(10), mofech, 103 )
                 ,'acfecproc'            = @acfecproc
                 ,'acfecprox'            = @acfecprox
                 ,'uf_hoy'               = @uf_hoy
                 ,'uf_man'               = @uf_man
                 ,'ivp_hoy'              = @ivp_hoy
                 ,'ivp_man'              = @ivp_man
                 ,'do_hoy'               = @do_hoy
                 ,'do_man'               = @do_man
                 ,'da_hoy'               = @da_hoy
                 ,'da_man'               = @da_man
                 ,'pmnomprop'            = @acnomprop
                 ,'rut_empresa'          = @rut_empresa
         FROM   MEMOH         ,
                VIEW_CLIENTE ,
                VIEW_ENTIDAD
         WHERE  morutcli  =  clrut           AND
                mocodcli  =  clcodigo        AND
               (@entidad  =  0               OR
                @entidad  =  moentidad)      AND
                motipmer   LIKE'%ARB%'       AND
                moentidad =  rccodcar        AND
                motipope  <> 'A'             AND
                mofech    >= @DESDE          AND
                mofech    <= @HASTA          AND
                @HASTA    <= @XFECPROC       AND
                (MOOPER    =  @USUARIO OR @USUARIO = '')       AND
               (MOESTATUS =  ' '             OR
                MOESTATUS = 'M') 


   IF EXISTS(SELECT 1 FROM #TEMPORAL) BEGIN
            SELECT *,
			'RazonSocial'                    = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
			 FROM #TEMPORAL ORDER BY OPERACION
   END ELSE BEGIN
         SELECT   'moneda cnv'                     = ''
                 ,'tipo de oper'                   = ''
                 ,'numero op'                      = ''
                 ,'nombre cliente'                 = ''
                 ,'tacfechpro'                     = CONVERT ( CHAR(10), @XFECPROC ,103 )   --CONVERT( CHAR(10), GETDATE(), 103 )
                 ,'moneda op'                      = ''
                 ,'monto moneda op'                = 0.0
                 ,'paridad mensual'                = 0.0
                 ,'monto en usd'                   = 0.0
                 ,'paridad de transferencia'       = 0.0
                 ,'mto usd por par transferencia'  = 0.0
                 ,'utilidad dolares'               = 0.0
                 ,'tc cambio'                      = 0.0
                 ,'precio'                         = 0.0
                 ,'tc transfrencia'                = 0.0
                 ,'precio transferencia'           = 0.0
                 ,'utilidad en pesos'              = 0.0
                 ,'hoyfecha'                       = CONVERT( CHAR(10), GETDATE(), 103 )
                 ,'hora'                           = CONVERT( CHAR(10), GETDATE(), 108 ) 
                 ,'rut propietario'                = ''
                 ,'digito pro'                     = ''
                 ,'nombre propietario'             = ''
                 ,'entidad'                        = ''
                 ,'usuario'                        = @usuario
                 ,'MERCADO'                        = ''
                 ,'OPERACION'                      = ''
                 ,'MONEDAOPERACION'                = ''
                 ,'UsuarioS'                       = @usuario
                 ,'Entregamos'                     = ''
                 ,'Recibimos'                      = ''
                 ,'fecha_SERV'                     = CONVERT( CHAR(10) , GETDATE(), 103) 
                 ,'Desde'                          = SUBSTRING(@DESDE ,7,2) + '/' +SUBSTRING(@DESDE ,5,2) + '/' +SUBSTRING(@DESDE ,1,4)   --32--CONVERT ( CHAR(10), @DESDE    ,103 )
                 ,'Hasta'                          = SUBSTRING(@HASTA ,7,2) + '/' +SUBSTRING(@HASTA ,5,2) + '/' +SUBSTRING(@HASTA ,1,4)   --CONVERT ( CHAR(10), @HASTA  ,103 )
                 ,'MoFech'                         = CONVERT( CHAR(10), GETDATE(), 103 )
                 ,'acfecproc'                      = @acfecproc
                 ,'acfecprox'                      = @acfecprox
                 ,'uf_hoy'                         = @uf_hoy
                 ,'uf_man'                         = @uf_man
                 ,'ivp_hoy'                        = @ivp_hoy
                 ,'ivp_man'                        = @ivp_man
                 ,'do_hoy'                         = @do_hoy
                 ,'do_man'                         = @do_man
                 ,'da_hoy'                         = @da_hoy
                 ,'da_man'                         = @da_man
                 ,'pmnomprop'                      = @acnomprop
                 ,'rut_empresa'                    = @rut_empresa
				 ,'RazonSocial'                    = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   END
   SET NOCOUNT OFF

END

GO
