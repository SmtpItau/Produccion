USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTINICIODIA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTINICIODIA]
              ( 
  @entidad    char(2),
  @fechaprop  datetime,
  @fechaprx   datetime
        )
AS
BEGIN
SET NOCOUNT ON
declare @npos    numeric(7),
 @nposaux   numeric(7),
 @tipope    char(1),
 @gcodoma   char(4),
 @rutcli    numeric(9),
 @codcli    numeric(9),
 @nomcli    char(35),
 @mtousd    numeric(17,4),
 @tipcam    numeric(10,4),
 @fpmxi    numeric(2),
 @fpmni    numeric(2),
 @fpmxv    numeric(2),
 @fpmnv    numeric(2),
 @fecvto    datetime,
 @fechab    datetime,
 @fechac    datetime,
 @user    char(10),
 @entre    numeric(7),
 @recib    numeric(7),
 @codoma    numeric(3),
 @valuta1   datetime,
 @valuta2   datetime,
 @monpe    numeric(19,4),
 @numope    numeric(7),
 @fecant    char(8)
begin transaction
    select @fecant = convert(char(8),acfecpro,112) from MEAC
    update MEAC
       set acposini     = acposic    ,
    acpmeco      = 0       ,
    acpmeve      = 0       ,
    acpmecopo    = 0       ,
    acpmevepo    = 0       ,
    acutilipo    = 0       ,
    acutili      = 0       ,
    acutiltot    = 0       ,
    actotco      = 0       ,
    actotve      = 0       ,
    actotcopo    = 0       ,
    actotvepo    = 0       ,
    acpmecofi    = 0       ,
    acpmevefi    = 0       ,
    actotalpe    = 0       ,
    acultpta     = ''         ,
    acultmon     = 0       ,
    acultpre     = 0       ,
    acpcierre    = ''         ,
    acfecpro     = @fechaprop ,
    acfecprx     = @fechaprx  ,
    acfecant     = @fecant    ,
           cp_totco     = 0          ,
           cp_totve     = 0          ,
           cp_totcop    = 0          ,
           cp_totvep    = 0          ,
           cp_utili     = 0          ,
           cp_pmeco     = 0          ,
           cp_pmeve     = 0          ,
           cp_utico     = 0          ,
           cp_utive     = 0          ,
           cp_pmecoci   = 0          ,
           cp_pmeveci   = 0          ,
           ac_totcop    = 0          ,
           ac_totvep    = 0          ,
           ac_pmecore   = 0          ,
           ac_pmevere   = 0          ,
           ac_totcore   = 0          ,
           ac_totvere   = 0          ,
           actotcopre   = 0          ,
           actotvepre   = 0          ,
           acultempr    = ''         ,
           acultmonempr = 0          ,
           acultpreempr = 0          ,
           accorempr    = 0
    if @@error <> 0 begin
       rollback transaction
       select -1,'ERROR: NO SE PUDO ACTUALIZAR PARAMETROS DE CONTROL'
       set nocount off
       return -1
    end
    update VIEW_VALOR_MONEDA set
    vmposini = vmposic    ,
    vmpmeco  = 0   ,
    vmpmeve  = 0   ,
    vmtotco  = 0   ,
    vmtotve  = 0   ,
    vmutili  = 0   ,
    vmprecoc = 0   ,
    vmparidc = 0   ,
    vmpreco  = 0
    if @@error <> 0 begin
       rollback transaction
       select -1, 'ERROR: NO SE PUDO ACTUALIZAR VALORES DE MONEDAS'
              set nocount off
       return -1
    end
    --------------------- limpia movimientos
    DELETE MEMO
    --DELETE MEARB
    DELETE MEMOC
    --DELETE MEPOC
    DELETE MEATA
    --DELETE MEARBC
    --DELETE MECUPO
    --DELETE MEVB2
    --DELETE MECI
    --DELETE MEAJ
    --DELETE MECINV
    --DELETE MEAO
    --DELETE MEARBM
    DELETE MESMO
    DELETE MESCX
    DELETE MEUS
    DELETE MECX
    update MEMR set
    mrposini = mrposic,
    mrpmeco  = 0,
    mrpmeve  = 0,
    mrtotco  = 0,
    mrtotve  = 0,
    mrutili  = 0,
    mrposic  = 0
    -------------------<< actualiza mepos
    delete from VIEW_POSICION_SPT where convert(char(8),vmfecha,112) = convert(char(8),@fechaprop,112)
    if not exists (select vmfecha from VIEW_POSICION_SPT where convert(char(8),vmfecha,112) = @fecant)
       begin
            insert into VIEW_POSICION_SPT( VMCODIGO, VMFECHA )
          select substring(mnsimbol,1,3),convert(char(8),@fechaprop,112)
     from VIEW_MONEDA where mnmx = 'C'
            if @@error <> 0
            begin
                 rollback transaction
                 select -1,'ERROR: NO SE PUEDEN INICIALIZAR POSICIONES DE MONEDAS'
   set nocount off
                 return -1
            end
       end
    else
       begin
            insert into VIEW_POSICION_SPT( vmcodigo, vmfecha, vmposini, vmpreini, vmposic, vmparidad, vmparmes )
   select   vmcodigo, @fechaprop, vmposic , vmpreini, vmposic, vmparidad, vmparmes
     from VIEW_POSICION_SPT
    where convert(char(8),vmfecha,112) = @fecant
            if @@error <> 0
            begin
                 rollback transaction
                 select -1,'ERROR: NO SE PUEDEN ACTUALIZAR POSICIONES DE MONEDAS PARA HOY'
   set nocount off
                 return -1
            end
       end
    -- observado como precio inicial de usd
    declare @observado float
    select  @observado = 0
    select  @observado = vmvalor 
      from  VIEW_VALOR_MONEDA  
  where  vmcodigo = 994 and convert(char(8),vmfecha,112) = convert(char(8),@fechaprop,112)
    if @observado = 0
    begin
         rollback transaction
         select -1,'ERROR: VALOR DEL OBSERVADO PARA EL ' + convert(char(10),@fechaprop,103) + ' esta en cero.'
 set nocount off
         return -1
    end
    UPDATE VIEW_POSICION_SPT
       SET VIEW_POSICION_SPT.vmpreini   = VIEW_VALOR_MONEDA.vmvalor, 
           VIEW_POSICION_SPT.vmparidad  = 1
      FROM VIEW_VALOR_MONEDA  
     WHERE VIEW_POSICION_SPT.vmcodigo  = 'USD'
       and convert(char(8), VIEW_POSICION_SPT.vmfecha,112) = convert(char(8),@fechaprop,112)
       and VIEW_VALOR_MONEDA.vmcodigo       = 994   
       and convert(char(8),VIEW_VALOR_MONEDA.vmfecha,112)  = convert(char(8),@fechaprop,112) -- observado
--------------------realiza vencimientos
UPDATE TRANSFERENCIA_PENDIENTE
   SET Estado_transferencia = 'V'
 WHERE fecha_vencimiento <= ( SELECT acfecpro FROM MEAC )
COMMIT TRANSACTION
SELECT 0, 'OK'
SET NOCOUNT OFF
END
GO
