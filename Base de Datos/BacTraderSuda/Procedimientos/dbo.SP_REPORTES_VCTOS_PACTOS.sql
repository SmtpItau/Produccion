USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_VCTOS_PACTOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_REPORTES_VCTOS_PACTOS] --'2001123','20011125'
       (
        @cFechaDesde   CHAR(8),
        @cFechaHasta   CHAR(8)
       )
AS
BEGIN
   SET NOCOUNT ON
  --DECLARE @dFechaDesde        DATETIME
  --DECLARE @dFechaHasta        DATETIME
--   SELECT @dFechaDesde = convert(datetime,@cFechaDesde)
--   SELECT @dFechaHasta = convert(datetime,@cFechaHasta)
  
   SELECT       'Rut_Cartera'        = virutcart,  --1  
                'Nro_Documento'      = vinumdocu,  --2
                'Nro_Operacion'      = vinumoper,  --3
                'Correlativo'        = vicorrela,  --4
                'Seriado'            = viseriado,  --5
                'Numero_Operación'   = CONVERT( VARCHAR(10), vinumdocu ) + '-' + CONVERT( VARCHAR(10), vinumoper ) + '-' + RIGHT( '000' + CONVERT( VARCHAR(03), vicorrela ), 3 ),--6
                'Serie'              = viinstser, --7
                'Mascara'            = vimascara, --8
                'Fecha_Emision'      = CONVERT( CHAR(10), vifecinip, 103 ), --9
                'Fecha_Vencimiento'  = CONVERT( CHAR(10), vifecvenp, 103 ), --10
                'C_Moneda_Pacto'     = vimonpact,--11
                'Moneda_Pacto'       = mnnemo,--12
                'C_Moneda_Emision'   = vimonpact, --13        -- Despues se cambia
                'Moneda_Emision'     = mnnemo,     --14       -- Despues se cambia
                'Nominal'            = vinominal,--15
                'Valor_Vcto_$$'      = vivalvenp,--16
                'Tipo_de_Vcto'       = 'VENTAS CON PACTOS ',--17
                'Cliente_del_Pacto'  =  CASE viforpagi WHEN 6 THEN Clctacte   
             WHEN 7 THEN Clctacte 
             ELSE clnombre END,--18
    
                'Codigo_Sucursal'    = 0, --19
                'Nombre_Propietario' = acnomprop, --20,
                'Fecha_Proceso'      = CONVERT( CHAR(10), acfecproc, 103     ), --21
                'Fecha_Desde'        = CONVERT( CHAR(10),convert(datetime, @cFechaDesde), 103 ), --22
                'Fecha_Hasta'        = CONVERT( CHAR(10),convert(datetime, @cFechaHasta), 103 ), --23
                'Hora'               = CONVERT( CHAR(08),    GETDATE(), 108 ), --24
                'Fecha_Vcto'        = CONVERT( CHAR(10), vifecvenp,103 ),   --25
                'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
        
  INTO  #tmp_pactos
         
   FROM  mdvi , mdac , VIEW_MONEDA , VIEW_CLIENTE
  
          WHERE vimonpact     = mncodmon      AND
                virutcli      = clrut         AND
                vicodcli      = clcodigo      AND
                vifecvenp between @cFechaDesde and @cFechaHasta
 
   UPDATE       #tmp_pactos
          SET   C_Moneda_Emision    = nsmonemi
          FROM  VIEW_NOSERIE
          WHERE Rut_Cartera         = nsrutcart   AND
                Nro_Documento       = nsnumdocu   AND
                Correlativo         = nscorrela   AND
                Seriado             = 'N'
   UPDATE       #tmp_pactos
          SET   C_Moneda_Emision    = semonemi
          FROM  VIEW_SERIE
          WHERE Seriado             = 'S'         AND
                Mascara             = semascara
   UPDATE       #tmp_pactos
          SET   Moneda_Emision      = mnnemo
          FROM  VIEW_MONEDA
          WHERE C_Moneda_Emision    = mncodmon
   IF ( SELECT COUNT(*) FROM #tmp_pactos) = 0
   BEGIN
      INSERT INTO #tmp_pactos
      SELECT    0, --1
                0, --2
                0, --3
                0, --4
                '', --5
                '', --6
                '', --7
                '', --8
                '', --9
                '', --10
                0, --11
                '', --12
                0,      --13   -- Despues se cambia
                '',     --14      -- Despues se cambia
  0, --15
                0, --16
                '', --17
                '', --18
                0, --19
  'Nombre_Propietario' = acnomprop, --20
                'Fecha_Proceso'      = CONVERT( CHAR(10), acfecproc, 103 ),--21
                'Fecha_Desde'        = CONVERT( CHAR(10), convert(datetime,@cFechaDesde), 103 ),--22
                'Fecha_Hasta'        = CONVERT( CHAR(10), convert(datetime,@cFechaHasta), 103 ),--23
                'Hora'               = CONVERT( CHAR(08),    GETDATE(), 108 ),--24
  '',        --25      
   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
       FROM  mdac
 END
   SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #tmp_pactos ORDER BY Fecha_Vcto, Moneda_Pacto ASC
END
-- sp_reportes_vctos_pactos '20011228' , '20020328'
-- sp_autoriza_ejecutar 'BACUSER'
--  select CONVERT( CHAR(10), '20011112', 103 )
--select  CONVERT( CHAR(10), vifecvenp ) from  mdvi
 
-- select CONVERT( CHAR(10), acfecproc, 103     ) from mdac
-- select  CONVERT( CHAR(08),    GETDATE(), 108 )
-- select convert(char(10),convert(datetime,'20011101'),101)

GO
