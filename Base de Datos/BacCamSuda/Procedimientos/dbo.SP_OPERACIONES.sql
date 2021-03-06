USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_OPERACIONES] --1,'PTAS','C',1,'20010419','20010419'
              ( 
                @entidad NUMERIC(3)      ,
                @tipmerc CHAR(4)         ,
                @tipoper CHAR(4)         ,
                @orden   NUMERIC(1) = 1  ,
                @numoper NUMERIC(7) = 0  ,
                @desde   CHAR(8)    = '' ,
                @hasta   CHAR(8)    = ''
              )
as
begin
set nocount on
select @tipoper = case when @tipoper = '' then 'CVA' else @tipoper end
--<< control de fechas
if @desde = ''
   select @desde = convert(char(8),acfecpro,112) from MEAC
if @hasta = ''
   select @hasta = convert(char(8),acfecpro,112) from MEAC
--<< memo
select 'm01'  = moentidad,
       'm02'  = motipmer,
       'm03'  = monumope,
       'm04'  = a.clrut,
       'm05'  = a.cldv,
       'm06'  = a.clcodigo,
       'm07'  = a.clnombre,
       'm08'  = motipope,
       'm09'  = mocodmon,
       'm10'  = mocodcnv,
       'q11'  = momonmo,
       'q12'  = moticam,
       'q13'  = motctra,
       'q14'  = moparme,
       'q15'  = mopartr,
       'q16'  = moprecio,
       'q17'  = mopretra,
       'q18'  = moussme,
       'q19'  = momonpe,
       'q20'  = moentre,
       'f21'  = b.glosa,
       'f22'  = convert(char(10),movaluta1,103), -- entregamos
       'f23'  = morecib,
       'f24'  = c.glosa,
       'f25'  = convert(char(10),movaluta2,103), -- recibimos
       'f26'  = mooper,
       'f27'  = convert(char(10),mofech,103),
       'f28'  = mohora,
       'f29'  = d.mnglosa,   -- glosa de mocodmon
       'a30'  = e.mnglosa,   -- glosa de mocodcnv
       'a31'  = movamos,
       'a32'  = moterm,
       'a33'  = mocodoma,
       'a34'  = moestatus,
       'a35'  = morentab,
       'a36'  = moalinea,
       'a37'  = motipcar,
       'a38'  = monumfut,
       'a39'  = mofecini,
       'a40'  = moaprob,       -- indica c/v si la operacion fue anulada
       'a41'  = d.mncodbanco,  -- codigo bcch de mocodmon
       'a42'  = e.mncodbanco,   -- codigo bcch de mocodcnv
       'entidad' = ( select f.rcnombre from  VIEW_ENTIDAD where  f.rccodcar = moentidad ), --bactrader..mdrc  
       'nomcli'  = ( select acnombre from  MEAC ),
       'fechap'  = ( select acfecpro from  MEAC ),
       'hora'    = convert(char(08),getdate(),108 )
  into #TEMP
  from MEMO  ,
       VIEW_CLIENTE A,
       VIEW_FORMA_DE_PAGO B,
       VIEW_FORMA_DE_PAGO C,
       VIEW_MONEDA D,
       VIEW_MONEDA E,
       VIEW_ENTIDAD F, -- BACTRADER..MDRC F, TABLA ENTIDADES 
       MEAC G--MEAC G -- TABLA PARAMETROS
 where   morutcli                           = a.clrut  
   and   mocodcli                           =  a.clcodigo
   and ( @tipmerc                           = ''           or  motipmer   =  @tipmerc)
   and   charindex(motipope,@tipoper)       > 0 
   and ( @entidad                           = 0            or  moentidad  =  @entidad)
   and   moentre                            = b.codigo 
   and   morecib                            = c.codigo
   and   mocodmon                           = substring(d.mnsimbol,1,3   )
   and   mocodcnv                           = substring(e.mnsimbol,1,3   )
   and ( @numoper                           = 0            or monumope  = @numoper   )
   and ( mofech                            >= @desde 
   and   mofech                            <= @hasta  )
--<< memoh
select 'm01'  = moentidad,
       'm02'  = motipmer,
       'm03'  = monumope,
       'm04'  = a.clrut,
       'm05'  = a.cldv,
       'm06'  = a.clcodigo,
       'm07'  = a.clnombre,
       'm08'  = motipope,
       'm09'  = mocodmon,
       'm10'  = mocodcnv,
       'q11'  = momonmo,
       'q12'  = moticam,
       'q13'  = motctra,
       'q14'  = moparme,
       'q15'  = mopartr,
       'q16'  = moprecio,
       'q17'  = mopretra,
       'q18'  = moussme,
       'q19'  = momonpe,
       'q20'  = moentre,
       'f21'  = b.glosa,
       'f22'  = convert(char(10),movaluta1,103), -- entregamos
       'f23'  = morecib,
       'f24'  = c.glosa,
       'f25'  = convert(char(10),movaluta2,103), -- recibimos
       'f26'  = mooper,
       'f27'  = convert(char(10),mofech,103),
       'f28'  = mohora,
       'f29'  = d.mnglosa,   -- glosa de mocodmon
       'a30' = e.mnglosa,   -- glosa de mocodcnv
       'a31'  = movamos,
       'a32'  = moterm,
       'a33'  = mocodoma,
       'a34'  = moestatus,
       'a35'  = morentab,
       'a36'  = moalinea,
       'a37'  = motipcar,
       'a38'  = monumfut,
       'a39'  = mofecini,
       'a40'  = moaprob,       -- indica c/v si la operacion fue anulada
       'a41'  = d.mncodbanco,  -- codigo bcch de mocodmon
       'a42'  = e.mncodbanco,   -- codigo bcch de mocodcnv
       'entidad' = (select f.rcnombre from  VIEW_ENTIDAD where  f.rccodcar = moentidad),--bactrader..mdrc  
       'nomcli'  = (select acnombre from  MEAC),
       'fechap'  =(select acfecpro from  MEAC),
       'hora'    = convert(char(08),getdate(),108)
  into #TEMPH
  FROM MEMOH  ,
       VIEW_CLIENTE A,
       VIEW_FORMA_DE_PAGO B,
       VIEW_FORMA_DE_PAGO C,
       VIEW_MONEDA D,
       VIEW_MONEDA E,
       VIEW_ENTIDAD F, --BACTRADER..MDRC F, --TABLA ENTIDADES 
       MEAC G            --MEAC G -- TABLA PARAMETROS
 where   morutcli                     = a.clrut  
   and   mocodcli                     = a.clcodigo
   and ( @tipmerc                     = ''             or  motipmer   =  @tipmerc )
   and charindex(motipope,@tipoper)   > 0 
   and ( @entidad                     = 0              or  moentidad  =  @entidad )
   and   moentre                      = b.codigo 
   and   morecib                      = c.codigo
   and   mocodmon                     = substring(d.mnsimbol,1,3)
   and   mocodcnv                     = substring(e.mnsimbol,1,3)
   and ( @numoper                     = 0             or monumope  = @numoper )
   and ( mofech                      >= @desde 
   and   mofech                      <= @hasta )
--<< fusion
select * into #tempfin from #TEMP
insert into #TEMPFIN select * from #TEMPH
--<< select final
if @orden <= 0 or @orden > 4      -- nro operacion
   select * from #TEMPFIN order by m01,m03
if @orden = 1                     -- tipo operacion
   select * from #TEMPFIN order by m01,m08
if @orden = 2                     -- cliente
   select * from #TEMPFIN order by m01,m08
if @orden = 3                     -- operador
   select * from #TEMPFIN order by m01,f26
if @orden = 4                     -- tipo de mercado
   select * from #TEMP order by m01,m02,m03
set nocount off
end

GO
