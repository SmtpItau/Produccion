USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTA_PERFILES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE proc [dbo].[SP_LISTA_PERFILES]
               ( @sistema char(3) )
as
begin
declare @contador        integer,
        @regs            integer,
        @contador2       integer,
        @regs2           integer,
        @contador3       integer,
        @regs3           integer,
        @cmd             varchar(255)
declare @glosa           char(70)   ,
        @instrumento     char(10)   ,
        @folio           numeric(10),
        @id_sistema      char(3)    ,
        @tipo_movimiento char(3)    ,
        @tipo_operacion  char(5)    ,
        @descripcion1    char(50)   ,
        @tipo_mov        char(1)    ,
        @cuenta1         char(12)   ,
        @descripcion2    char(50)   ,
        @cuenta2         char(12)   ,
        @desc_cuenta     char(50)   ,
        @valor_dato      varchar(30),
        @campo_variab    integer    ,
        @categoria       integer    ,
        @perfil_fijo     char(1)    ,
        @tabla_campo     char(20)
select @regs = count(*) from VIEW_PERFIL_CNT where id_sistema = @sistema
select @contador = 1
while @contador <= @regs
begin
   set rowcount @contador
   select @folio           = VIEW_PERFIL_CNT.folio_perfil,
          @glosa           = VIEW_PERFIL_CNT.glosa_perfil,
          @id_sistema      = VIEW_PERFIL_CNT.id_sistema,
          @tipo_movimiento = VIEW_PERFIL_CNT.tipo_movimiento,
          @tipo_operacion  = VIEW_PERFIL_CNT.tipo_operacion,
          @instrumento     = (case VIEW_PERFIL_CNT.id_sistema 
                              when 'btr' then VIEW_PERFIL_CNT.codigo_instrumento
                              else            (select VIEW_MONEDA.mnnemo  from VIEW_MONEDA  where VIEW_PERFIL_CNT.codigo_instrumento = convert(char(6), VIEW_MONEDA .mncodmon))
                             end)
     from VIEW_PERFIL_CNT
    where VIEW_PERFIL_CNT.id_sistema = @sistema
    order by VIEW_PERFIL_CNT.folio_perfil
   set rowcount 0
   select @contador = @contador + 1
   select @cmd = substring(@glosa,1,30) + space(5) + @instrumento
   print ''
   print '------------------------------------------------------------------------------------'
   print 'PERFIL'
   print '------------------------------------------------------------------------------------'
   print @cmd
   select @regs2 = count(*) from VIEW_PERFIL_DETALLE_CNT where folio_perfil = @folio
   select @contador2 = 1
   print ''
   print 'DETALLE PERFIL'
   print '--------------'
   while @contador2 <= @regs2
   begin
      set rowcount @contador2
      select @descripcion1 = VIEW_CAMPO_CNT.descripcion_campo,
             @tipo_mov     = VIEW_PERFIL_DETALLE_CNT.tipo_movimiento_cuenta,
             @cuenta1      = VIEW_PERFIL_DETALLE_CNT.codigo_cuenta,
             @desc_cuenta  = isnull((select descripcion from VIEW_PLAN_DE_CUENTAS where VIEW_PLAN_DE_CUENTAS.cuenta = VIEW_PERFIL_DETALLE_CNT.codigo_cuenta),''),
             @perfil_fijo  = VIEW_PERFIL_DETALLE_CNT.perfil_fijo,
             @campo_variab = VIEW_PERFIL_DETALLE_CNT.codigo_campo_variable
        from VIEW_PERFIL_DETALLE_CNT,
             VIEW_CAMPO_CNT
       where VIEW_PERFIL_DETALLE_CNT.folio_perfil       = @folio
         and VIEW_PERFIL_DETALLE_CNT.correlativo_perfil = @contador2
         and VIEW_PERFIL_DETALLE_CNT.codigo_campo       = VIEW_CAMPO_CNT.codigo_campo
         and VIEW_CAMPO_CNT.id_sistema                 = @id_sistema
         and VIEW_CAMPO_CNT.tipo_movimiento            = @tipo_movimiento
         and VIEW_CAMPO_CNT.tipo_operacion             = @tipo_operacion
       order by VIEW_PERFIL_DETALLE_CNT.correlativo_perfil
      set rowcount 0
      select @cmd = substring(@descripcion1,1,20) + space(1) + @tipo_mov + space(1) + @cuenta1 + space(1) + @desc_cuenta
      print @cmd
      /* perfil variable ...... */
      select @regs3 = count(*) from VIEW_PERFIL_VARIABLE_CNT where VIEW_PERFIL_VARIABLE_CNT.folio_perfil       = @folio
                                                              and VIEW_PERFIL_VARIABLE_CNT.correlativo_perfil = @contador2
      select @contador3 = 1
      while @contador3 <= @regs3 and @perfil_fijo = 'N'
      begin
         set rowcount @contador3
         select @valor_dato   = VIEW_PERFIL_VARIABLE_CNT.valor_dato_campo,
                @cuenta2      = VIEW_PERFIL_VARIABLE_CNT.codigo_cuenta,
                @desc_cuenta  = VIEW_PLAN_DE_CUENTAS.descripcion
           from VIEW_PERFIL_VARIABLE_CNT,
                VIEW_PLAN_DE_CUENTAS
          where VIEW_PERFIL_VARIABLE_CNT.folio_perfil       = @folio
            and VIEW_PERFIL_VARIABLE_CNT.correlativo_perfil = @contador2
            and VIEW_PERFIL_VARIABLE_CNT.codigo_cuenta      = VIEW_PLAN_DE_CUENTAS.cuenta
         set rowcount 0
         if @id_sistema = 'btr'
         begin
            select @tabla_campo = VIEW_CAMPO_CNT.tabla_campo,
                   @categoria   = (case upper( VIEW_CAMPO_CNT.tabla_campo)
                                   when 'MDTC' then convert(integer,right(rtrim( VIEW_CAMPO_CNT.campo_tabla), 3))
                                   else 0
                                  end)
              from VIEW_CAMPO_CNT 
             where id_sistema      = @id_sistema
               and tipo_movimiento = @tipo_movimiento
               and tipo_operacion  = @tipo_operacion
               and codigo_campo    = @campo_variab
            if @tabla_campo = 'MDFP'
               select @descripcion2 = glosa from VIEW_FORMA_DE_PAGO where @valor_dato = convert(char(5), codigo)
            else
               select @descripcion2 = VIEW_TABLA_GENERAL_DETALLE.tbglosa from  VIEW_TABLA_GENERAL_DETALLE where @valor_dato = tbcodigo1 and tbcateg = @categoria
         end
         else
            select @descripcion2 = glosa from VIEW_FORMA_DE_PAGO where @valor_dato = convert(char(5), codigo)
         select @contador3 = @contador3 + 1
         select @cmd = space(2) + substring(@descripcion2,1,30) + space(1) + @cuenta2 + space(1) + @desc_cuenta
         print @cmd
      end
      select @contador2 = @contador2 + 1
   end
end
end   /* fin procedimiento */
--sp_lista_perfiles 'btr'


GO
